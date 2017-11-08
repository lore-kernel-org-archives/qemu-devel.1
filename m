Received: from eggs.gnu.org ([2001:4830:134:3::10]:36224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJSA-0000RQ-8F
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJS9-00076M-F7
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJS9-00074v-A0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:09 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:21 +0800
Message-Id: <20171108060130.3772-24-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 23/32] migration: free SocketAddress where
 allocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Freeing the SocketAddress struct in socket_start_incoming_migration is
slightly confusing. Let's free the address in the same context where we
allocated it.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index dee869044a..4879f11e0f 100644
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
@@ -192,10 +190,12 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
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
2.13.6
