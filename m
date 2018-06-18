Received: from eggs.gnu.org ([2001:4830:134:3::10]:37743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq3-0000zw-W8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq2-0000UL-NR
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUuq2-0000Te-GJ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB038401B3A0
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:08:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Jun 2018 16:08:49 +0200
Message-Id: <20180618140854.17824-3-armbru@redhat.com>
In-Reply-To: <20180618140854.17824-1-armbru@redhat.com>
References: <20180618140854.17824-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] monitor: protect mon->fds with mon_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

mon->fds were protected by BQL.  Now protect it by mon_lock so that it
can even be used in monitor iothread.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180608035511.7439-3-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 5bc9b2dcd0..0fba3ccc20 100644
--- a/monitor.c
+++ b/monitor.c
@@ -212,7 +212,6 @@ struct Monitor {
     BlockCompletionFunc *password_completion_cb;
     void *password_opaque;
     mon_cmd_t *cmd_table;
-    QLIST_HEAD(,mon_fd_t) fds;
     QTAILQ_ENTRY(Monitor) entry;
 
     /*
@@ -224,6 +223,7 @@ struct Monitor {
     /*
      * Fields that are protected by the per-monitor lock.
      */
+    QLIST_HEAD(, mon_fd_t) fds;
     QString *outbuf;
     guint out_watch;
     /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
@@ -2187,7 +2187,7 @@ static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
 void qmp_getfd(const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
-    int fd;
+    int fd, tmp_fd;
 
     fd = qemu_chr_fe_get_msgfd(&cur_mon->chr);
     if (fd == -1) {
@@ -2202,13 +2202,17 @@ void qmp_getfd(const char *fdname, Error **errp)
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
 
@@ -2217,24 +2221,31 @@ void qmp_getfd(const char *fdname, Error **errp)
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
 
@@ -2242,6 +2253,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
 
+    qemu_mutex_lock(&mon->mon_lock);
     QLIST_FOREACH(monfd, &mon->fds, next) {
         int fd;
 
@@ -2255,10 +2267,12 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
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
2.17.1
