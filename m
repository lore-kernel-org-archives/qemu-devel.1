Received: from eggs.gnu.org ([2001:4830:134:3::10]:34848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fGGY7-0006y9-2b
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fGGY6-0002ly-3Q
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:17:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fGGY5-0002lH-Uk
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:17:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9357F40200B2
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 04:17:53 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  9 May 2018 12:17:32 +0800
Message-Id: <20180509041734.14135-3-peterx@redhat.com>
In-Reply-To: <20180509041734.14135-1-peterx@redhat.com>
References: <20180509041734.14135-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/4] monitor: protect mon->fds with mon_lock
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

mon->fds were protected by BQL.  Now protect it by mon_lock so that it
can even be used in monitor iothread.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 14c681dc8a..d6c3c08932 100644
--- a/monitor.c
+++ b/monitor.c
@@ -213,7 +213,6 @@ struct Monitor {
     BlockCompletionFunc *password_completion_cb;
     void *password_opaque;
     mon_cmd_t *cmd_table;
-    QLIST_HEAD(,mon_fd_t) fds;
     QTAILQ_ENTRY(Monitor) entry;
 
     /*
@@ -225,6 +224,7 @@ struct Monitor {
     /*
      * Fields that are protected by the per-monitor lock.
      */
+    QLIST_HEAD(, mon_fd_t) fds;
     QString *outbuf;
     guint out_watch;
     /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
@@ -2189,7 +2189,7 @@ static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
 void qmp_getfd(const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
-    int fd;
+    int fd, tmp_fd;
 
     fd = qemu_chr_fe_get_msgfd(&cur_mon->chr);
     if (fd == -1) {
@@ -2204,13 +2204,17 @@ void qmp_getfd(const char *fdname, Error **errp)
         return;
     }
 
+    qemu_mutex_lock(&cur_mon->mon_lock);
     QLIST_FOREACH(monfd, &cur_mon->fds, next) {
         if (strcmp(monfd->name, fdname) != 0) {
             continue;
         }
 
-        close(monfd->fd);
+        tmp_fd = monfd->fd;
         monfd->fd = fd;
+        qemu_mutex_unlock(&cur_mon->mon_lock);
+        /* Make sure close() is out of critical section */
+        close(tmp_fd);
         return;
     }
 
@@ -2219,24 +2223,31 @@ void qmp_getfd(const char *fdname, Error **errp)
     monfd->fd = fd;
 
     QLIST_INSERT_HEAD(&cur_mon->fds, monfd, next);
+    qemu_mutex_unlock(&cur_mon->mon_lock);
 }
 
 void qmp_closefd(const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
+    int tmp_fd;
 
+    qemu_mutex_lock(&cur_mon->mon_lock);
     QLIST_FOREACH(monfd, &cur_mon->fds, next) {
         if (strcmp(monfd->name, fdname) != 0) {
             continue;
         }
 
         QLIST_REMOVE(monfd, next);
-        close(monfd->fd);
+        tmp_fd = monfd->fd;
         g_free(monfd->name);
         g_free(monfd);
+        qemu_mutex_unlock(&cur_mon->mon_lock);
+        /* Make sure close() is out of critical section */
+        close(tmp_fd);
         return;
     }
 
+    qemu_mutex_unlock(&cur_mon->mon_lock);
     error_setg(errp, QERR_FD_NOT_FOUND, fdname);
 }
 
@@ -2244,6 +2255,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
 
+    qemu_mutex_lock(&mon->mon_lock);
     QLIST_FOREACH(monfd, &mon->fds, next) {
         int fd;
 
@@ -2257,10 +2269,12 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
         QLIST_REMOVE(monfd, next);
         g_free(monfd->name);
         g_free(monfd);
+        qemu_mutex_unlock(&mon->mon_lock);
 
         return fd;
     }
 
+    qemu_mutex_unlock(&mon->mon_lock);
     error_setg(errp, "File descriptor named '%s' has not been found", fdname);
     return -1;
 }
-- 
2.17.0
