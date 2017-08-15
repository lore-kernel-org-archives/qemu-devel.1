Received: from eggs.gnu.org ([2001:4830:134:3::10]:49291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVFg-0001Eu-Vo
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVFc-0004sF-20
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:22:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dhVFb-0004s1-Rb
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:22:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCDAFCA360
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:17:20 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 15 Aug 2017 14:17:02 +0800
Message-Id: <1502777827-18874-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1502777827-18874-1-git-send-email-peterx@redhat.com>
References: <1502777827-18874-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 1/6] migration: free SocketAddress where allocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Freeing the SocketAddress struct in socket_start_incoming_migration is
slightly confusing. Let's free the address in the same context where we
allocated it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 757d382..9fc6cb3 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -168,7 +168,6 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
 
     if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
         object_unref(OBJECT(listen_ioc));
-        qapi_free_SocketAddress(saddr);
         return;
     }
 
@@ -177,7 +176,6 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                           socket_accept_incoming_migration,
                           listen_ioc,
                           (GDestroyNotify)object_unref);
-    qapi_free_SocketAddress(saddr);
 }
 
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
@@ -188,10 +186,12 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
         socket_start_incoming_migration(saddr, &err);
     }
     error_propagate(errp, err);
+    qapi_free_SocketAddress(saddr);
 }
 
 void unix_start_incoming_migration(const char *path, Error **errp)
 {
     SocketAddress *saddr = unix_build_address(path);
     socket_start_incoming_migration(saddr, errp);
+    qapi_free_SocketAddress(saddr);
 }
-- 
2.7.4
