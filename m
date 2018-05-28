Received: from eggs.gnu.org ([2001:4830:134:3::10]:35560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNCS7-0001LT-Re
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNCS6-0003f0-8q
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:20:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNCS5-0003eg-Pn
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:20:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DF86818BAF3
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 07:20:21 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 28 May 2018 15:19:58 +0800
Message-Id: <20180528071958.17053-6-peterx@redhat.com>
In-Reply-To: <20180528071958.17053-1-peterx@redhat.com>
References: <20180528071958.17053-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 5/5] monitor: add lock to protect mon_fdsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Introduce a new global big lock for mon_fdsets.  Take it where needed.

The monitor_fdset_get_fd() handling is a bit tricky: now we need to call
qemu_mutex_unlock() which might pollute errno, so we need to make sure
the correct errno be passed up to the callers.  To make things simpler,
we let monitor_fdset_get_fd() return the -errno directly when error
happens, then in qemu_open() we move it back into errno.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c     | 61 ++++++++++++++++++++++++++++++++++++++++++---------
 stubs/fdset.c |  2 +-
 util/osdep.c  |  3 ++-
 3 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/monitor.c b/monitor.c
index 2504696d76..8709d136bd 100644
--- a/monitor.c
+++ b/monitor.c
@@ -272,7 +272,10 @@ static QemuMutex monitor_lock;
 static GHashTable *monitor_qapi_event_state;
 static QTAILQ_HEAD(mon_list, Monitor) mon_list;
 
+/* Protects mon_fdsets */
+static QemuMutex mon_fdsets_lock;
 static QLIST_HEAD(mon_fdsets, MonFdset) mon_fdsets;
+
 static int mon_refcount;
 
 static mon_cmd_t mon_cmds[];
@@ -287,6 +290,16 @@ static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque);
 
+/*
+ * This lock can be used very early, even during CLI parsing.
+ * Meanwhile it can also be used even at the end of main.  Let's keep
+ * it initialized for the whole lifecycle of QEMU.
+ */
+static void __attribute__((constructor)) mon_fdsets_lock_init(void)
+{
+    qemu_mutex_init(&mon_fdsets_lock);
+}
+
 /**
  * Is @mon a QMP monitor?
  */
@@ -2314,9 +2327,11 @@ static void monitor_fdsets_cleanup(void)
     MonFdset *mon_fdset;
     MonFdset *mon_fdset_next;
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
         monitor_fdset_cleanup(mon_fdset);
     }
+    qemu_mutex_unlock(&mon_fdsets_lock);
 }
 
 AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fdset_id, bool has_opaque,
@@ -2351,6 +2366,7 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
     MonFdsetFd *mon_fdset_fd;
     char fd_str[60];
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         if (mon_fdset->id != fdset_id) {
             continue;
@@ -2370,10 +2386,12 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
             goto error;
         }
         monitor_fdset_cleanup(mon_fdset);
+        qemu_mutex_unlock(&mon_fdsets_lock);
         return;
     }
 
 error:
+    qemu_mutex_unlock(&mon_fdsets_lock);
     if (has_fd) {
         snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64 ", fd:%" PRId64,
                  fdset_id, fd);
@@ -2389,6 +2407,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
     MonFdsetFd *mon_fdset_fd;
     FdsetInfoList *fdset_list = NULL;
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         FdsetInfoList *fdset_info = g_malloc0(sizeof(*fdset_info));
         FdsetFdInfoList *fdsetfd_list = NULL;
@@ -2418,6 +2437,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
         fdset_info->next = fdset_list;
         fdset_list = fdset_info;
     }
+    qemu_mutex_unlock(&mon_fdsets_lock);
 
     return fdset_list;
 }
@@ -2430,6 +2450,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
     MonFdsetFd *mon_fdset_fd;
     AddfdInfo *fdinfo;
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     if (has_fdset_id) {
         QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
             /* Break if match found or match impossible due to ordering by ID */
@@ -2450,6 +2471,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
             if (fdset_id < 0) {
                 error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "fdset-id",
                            "a non-negative value");
+                qemu_mutex_unlock(&mon_fdsets_lock);
                 return NULL;
             }
             /* Use specified fdset ID */
@@ -2500,16 +2522,21 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
     fdinfo->fdset_id = mon_fdset->id;
     fdinfo->fd = mon_fdset_fd->fd;
 
+    qemu_mutex_unlock(&mon_fdsets_lock);
     return fdinfo;
 }
 
 int monitor_fdset_get_fd(int64_t fdset_id, int flags)
 {
-#ifndef _WIN32
+#ifdef _WIN32
+    return -ENOENT;
+#else
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd;
     int mon_fd_flags;
+    int ret;
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         if (mon_fdset->id != fdset_id) {
             continue;
@@ -2517,20 +2544,24 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags)
         QLIST_FOREACH(mon_fdset_fd, &mon_fdset->fds, next) {
             mon_fd_flags = fcntl(mon_fdset_fd->fd, F_GETFL);
             if (mon_fd_flags == -1) {
-                return -1;
+                ret = -errno;
+                goto out;
             }
 
             if ((flags & O_ACCMODE) == (mon_fd_flags & O_ACCMODE)) {
-                return mon_fdset_fd->fd;
+                ret = mon_fdset_fd->fd;
+                goto out;
             }
         }
-        errno = EACCES;
-        return -1;
+        ret = -EACCES;
+        goto out;
     }
-#endif
+    ret = -ENOENT;
 
-    errno = ENOENT;
-    return -1;
+out:
+    qemu_mutex_unlock(&mon_fdsets_lock);
+    return ret;
+#endif
 }
 
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
@@ -2538,20 +2569,25 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         if (mon_fdset->id != fdset_id) {
             continue;
         }
         QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
             if (mon_fdset_fd_dup->fd == dup_fd) {
-                return -1;
+                goto err;
             }
         }
         mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
         mon_fdset_fd_dup->fd = dup_fd;
         QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);
+        qemu_mutex_unlock(&mon_fdsets_lock);
         return 0;
     }
+
+err:
+    qemu_mutex_unlock(&mon_fdsets_lock);
     return -1;
 }
 
@@ -2560,6 +2596,7 @@ static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
             if (mon_fdset_fd_dup->fd == dup_fd) {
@@ -2568,13 +2605,17 @@ static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
                     if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
                         monitor_fdset_cleanup(mon_fdset);
                     }
-                    return -1;
+                    goto err;
                 } else {
+                    qemu_mutex_unlock(&mon_fdsets_lock);
                     return mon_fdset->id;
                 }
             }
         }
     }
+
+err:
+    qemu_mutex_unlock(&mon_fdsets_lock);
     return -1;
 }
 
diff --git a/stubs/fdset.c b/stubs/fdset.c
index 6020cf28c8..4f3edf2ea4 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -14,7 +14,7 @@ int monitor_fdset_dup_fd_find(int dup_fd)
 
 int monitor_fdset_get_fd(int64_t fdset_id, int flags)
 {
-    return -1;
+    return -ENOENT;
 }
 
 void monitor_fdset_dup_fd_remove(int dupfd)
diff --git a/util/osdep.c b/util/osdep.c
index a73de0e1ba..ea51d500b6 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -302,7 +302,8 @@ int qemu_open(const char *name, int flags, ...)
         }
 
         fd = monitor_fdset_get_fd(fdset_id, flags);
-        if (fd == -1) {
+        if (fd < 0) {
+            errno = -fd;
             return -1;
         }
 
-- 
2.17.0
