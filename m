Received: from eggs.gnu.org ([2001:4830:134:3::10]:34580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVX-0006ri-3P
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVW-0006xT-9Z
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWfVW-0006ws-3c
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48C59693CC
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:38:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Jan 2018 10:38:23 +0100
Message-Id: <20180103093834.20879-4-quintela@redhat.com>
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
References: <20180103093834.20879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] migration: free addr in the same function
 that we created it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Otherwise, we can't use it after calling socket_start_incoming_migration

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index dee869044a..3a8232dd2d 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -172,7 +172,6 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
 
     if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
         object_unref(OBJECT(listen_ioc));
-        qapi_free_SocketAddress(saddr);
         return;
     }
 
@@ -181,7 +180,6 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                           socket_accept_incoming_migration,
                           listen_ioc,
                           (GDestroyNotify)object_unref);
-    qapi_free_SocketAddress(saddr);
 }
 
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
@@ -191,6 +189,7 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
     if (!err) {
         socket_start_incoming_migration(saddr, &err);
     }
+    qapi_free_SocketAddress(saddr);
     error_propagate(errp, err);
 }
 
@@ -198,4 +197,5 @@ void unix_start_incoming_migration(const char *path, Error **errp)
 {
     SocketAddress *saddr = unix_build_address(path);
     socket_start_incoming_migration(saddr, errp);
+    qapi_free_SocketAddress(saddr);
 }
-- 
2.14.3
