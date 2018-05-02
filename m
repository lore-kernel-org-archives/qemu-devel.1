Received: from eggs.gnu.org ([2001:4830:134:3::10]:50205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDmRI-0002YH-Lm
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDmRH-00085x-Ov
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDmRH-00085j-Jk
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F4ED7CBBA
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 07:44:35 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 15:44:19 +0800
Message-Id: <20180502074421.3762-3-peterx@redhat.com>
In-Reply-To: <20180502074421.3762-1-peterx@redhat.com>
References: <20180502074421.3762-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/4] monitor: protect mon->fds with mon_lock
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
 monitor.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 48882d28ae..176d3ecc04 100644
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
@@ -2207,6 +2207,7 @@ void qmp_getfd(const char *fdname, Error **errp)
         return;
     }
 
+    qemu_mutex_lock(&cur_mon->mon_lock);
     QLIST_FOREACH(monfd, &cur_mon->fds, next) {
         if (strcmp(monfd->name, fdname) != 0) {
             continue;
@@ -2214,6 +2215,7 @@ void qmp_getfd(const char *fdname, Error **errp)
 
         close(monfd->fd);
         monfd->fd = fd;
+        qemu_mutex_unlock(&cur_mon->mon_lock);
         return;
     }
 
@@ -2222,12 +2224,14 @@ void qmp_getfd(const char *fdname, Error **errp)
     monfd->fd = fd;
 
     QLIST_INSERT_HEAD(&cur_mon->fds, monfd, next);
+    qemu_mutex_unlock(&cur_mon->mon_lock);
 }
 
 void qmp_closefd(const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
 
+    qemu_mutex_lock(&cur_mon->mon_lock);
     QLIST_FOREACH(monfd, &cur_mon->fds, next) {
         if (strcmp(monfd->name, fdname) != 0) {
             continue;
@@ -2237,9 +2241,11 @@ void qmp_closefd(const char *fdname, Error **errp)
         close(monfd->fd);
         g_free(monfd->name);
         g_free(monfd);
+        qemu_mutex_unlock(&cur_mon->mon_lock);
         return;
     }
 
+    qemu_mutex_unlock(&cur_mon->mon_lock);
     error_setg(errp, QERR_FD_NOT_FOUND, fdname);
 }
 
@@ -2247,6 +2253,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
 
+    qemu_mutex_lock(&cur_mon->mon_lock);
     QLIST_FOREACH(monfd, &mon->fds, next) {
         int fd;
 
@@ -2260,10 +2267,12 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
         QLIST_REMOVE(monfd, next);
         g_free(monfd->name);
         g_free(monfd);
+        qemu_mutex_unlock(&cur_mon->mon_lock);
 
         return fd;
     }
 
+    qemu_mutex_unlock(&cur_mon->mon_lock);
     error_setg(errp, "File descriptor named '%s' has not been found", fdname);
     return -1;
 }
-- 
2.14.3
