Received: from eggs.gnu.org ([2001:4830:134:3::10]:47228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0JT-0001HC-II
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0JS-0001Sd-Nw
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0JS-0001S0-Gx
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:58 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:28 +0800
Message-Id: <1501229198-30588-20-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 19/29] migration: let dst listen on port always
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/exec.c   | 2 +-
 migration/fd.c     | 2 +-
 migration/socket.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 08b599e..b4412db 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -49,7 +49,7 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
-    return FALSE; /* unregister */
+    return TRUE; /* keep it registered */
 }
 
 void exec_start_incoming_migration(const char *command, Error **errp)
diff --git a/migration/fd.c b/migration/fd.c
index 30f5258..865277a 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,7 +49,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
-    return FALSE; /* unregister */
+    return TRUE; /* keep it registered */
 }
 
 void fd_start_incoming_migration(const char *infd, Error **errp)
diff --git a/migration/socket.c b/migration/socket.c
index 757d382..f2c2d01 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -153,8 +153,8 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
 
 out:
     /* Close listening socket as its no longer needed */
-    qio_channel_close(ioc, NULL);
-    return FALSE; /* unregister */
+    // qio_channel_close(ioc, NULL);
+    return TRUE; /* keep it registered */
 }
 
 
-- 
2.7.4
