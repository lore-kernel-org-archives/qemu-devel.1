Received: from eggs.gnu.org ([2001:4830:134:3::10]:59968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJdEK-0006Vx-4C
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJdEI-0005gB-T2
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:07:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJdEI-0005fx-Ne
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:07:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AF9581FE159
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 11:07:22 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 18 May 2018 19:07:04 +0800
Message-Id: <20180518110704.10849-5-peterx@redhat.com>
In-Reply-To: <20180518110704.10849-1-peterx@redhat.com>
References: <20180518110704.10849-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 4/4] monitor: add lock to protect mon_fdsets
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

Similar to previous patch, but introduce a new global big lock for
mon_fdsets.  Take it where needed.

The monitor_fdset_get_fd() handling is a bit tricky: now we need to call
qemu_mutex_unlock() which might pollute errno, so we need to make sure
the correct errno be passed up to the callers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 79 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 14 deletions(-)

diff --git a/monitor.c b/monitor.c
index 696109acb4..84064a0b89 100644
--- a/monitor.c
+++ b/monitor.c
@@ -269,6 +269,9 @@ typedef struct QMPRequest QMPRequest;
 /* Protects mon_list, monitor_event_state.  */
 static QemuMutex monitor_lock;
 
+/* Protects mon_fdsets */
+static QemuMutex mon_fdsets_lock;
+
 static QTAILQ_HEAD(mon_list, Monitor) mon_list;
 static QLIST_HEAD(mon_fdsets, MonFdset) mon_fdsets;
 static int mon_refcount;
@@ -285,6 +288,16 @@ static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque);
 
+/*
+ * This lock can be used very early, even during param parsing.
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
@@ -2500,16 +2522,22 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
     fdinfo->fdset_id = mon_fdset->id;
     fdinfo->fd = mon_fdset_fd->fd;
 
+    qemu_mutex_unlock(&mon_fdsets_lock);
     return fdinfo;
 }
 
 int monitor_fdset_get_fd(int64_t fdset_id, int flags)
 {
-#ifndef _WIN32
+#ifdef _WIN32
+    errno = ENOENT;
+    return -1;
+#else
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd;
     int mon_fd_flags;
+    int ret = -ENOENT;
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         if (mon_fdset->id != fdset_id) {
             continue;
@@ -2517,49 +2545,68 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags)
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
+        break;
+    }
+out:
+    qemu_mutex_unlock(&mon_fdsets_lock);
+    /*
+     * qemu_mutex_unlock might pollute errno, so we translate the
+     * "ret" value into errno if error happened.
+     */
+    if (ret < 0) {
+        errno = -ret;
+        ret = -1;
     }
+    return ret;
 #endif
-
-    errno = ENOENT;
-    return -1;
 }
 
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
 {
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;
+    int ret = -1;
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         if (mon_fdset->id != fdset_id) {
             continue;
         }
         QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
             if (mon_fdset_fd_dup->fd == dup_fd) {
-                return -1;
+                ret = -1;
+                goto out;
             }
         }
         mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
         mon_fdset_fd_dup->fd = dup_fd;
         QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);
-        return 0;
+        ret = 0;
+        break;
     }
-    return -1;
+
+out:
+    qemu_mutex_unlock(&mon_fdsets_lock);
+    return ret;
 }
 
 static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
 {
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;
+    int ret = -1;
 
+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
             if (mon_fdset_fd_dup->fd == dup_fd) {
@@ -2568,14 +2615,18 @@ static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
                     if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
                         monitor_fdset_cleanup(mon_fdset);
                     }
-                    return -1;
+                    ret = -1;
+                    goto out;
                 } else {
-                    return mon_fdset->id;
+                    ret = mon_fdset->id;
+                    goto out;
                 }
             }
         }
     }
-    return -1;
+out:
+    qemu_mutex_unlock(&mon_fdsets_lock);
+    return ret;
 }
 
 int monitor_fdset_dup_fd_find(int dup_fd)
-- 
2.17.0
