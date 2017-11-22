Received: from eggs.gnu.org ([2001:4830:134:3::10]:39109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHUMQ-0004lR-Cy
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHUMO-0007Cb-Gw
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:42:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHUMO-0007Bz-7p
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:42:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6610549025
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 12:42:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Nov 2017 13:42:19 +0100
Message-Id: <20171122124219.12954-7-quintela@redhat.com>
In-Reply-To: <20171122124219.12954-1-quintela@redhat.com>
References: <20171122124219.12954-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] migration: Set the new port/address in
 the uri parameter
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

We can set the port parameter as zero.  This patch lets us know what
port the system was choosen for us.  Now we can migrate to this place.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/socket.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 3a8232dd2d..5f9cbaf54a 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -162,17 +162,24 @@ out:
 }
 
 
-static void socket_start_incoming_migration(SocketAddress *saddr,
-                                            Error **errp)
+static SocketAddress *socket_start_incoming_migration(SocketAddress *saddr,
+                                                      Error **errp)
 {
     QIOChannelSocket *listen_ioc = qio_channel_socket_new();
+    SocketAddress *address;
 
     qio_channel_set_name(QIO_CHANNEL(listen_ioc),
                          "migration-socket-listener");
 
     if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
         object_unref(OBJECT(listen_ioc));
-        return;
+        return NULL;
+    }
+
+    address = qio_channel_socket_get_local_address(listen_ioc, errp);
+    if (address < 0) {
+        object_unref(OBJECT(listen_ioc));
+        return NULL;
     }
 
     qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
@@ -180,14 +187,31 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                           socket_accept_incoming_migration,
                           listen_ioc,
                           (GDestroyNotify)object_unref);
+    return address;
 }
 
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
 {
     Error *err = NULL;
     SocketAddress *saddr = tcp_build_address(host_port, &err);
+
     if (!err) {
-        socket_start_incoming_migration(saddr, &err);
+        SocketAddress *address = socket_start_incoming_migration(saddr, &err);
+
+        if (address &&
+            (strcmp(address->u.inet.port, saddr->u.inet.port) ||
+             strcmp(address->u.inet.host, saddr->u.inet.host))) {
+            char *new_uri;
+            InetSocketAddress *iaddr = &saddr->u.inet;
+
+            new_uri = g_strdup_printf("tcp:%s:%s%s%s", address->u.inet.host,
+                                      address->u.inet.port,
+                                      iaddr->has_ipv4 ? ",ipv4" : "",
+                                      iaddr->has_ipv6 ? ",ipv6" : "");
+            migrate_set_uri(new_uri, errp);
+            g_free(new_uri);
+            qapi_free_SocketAddress(address);
+        }
     }
     qapi_free_SocketAddress(saddr);
     error_propagate(errp, err);
@@ -196,6 +220,9 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
 void unix_start_incoming_migration(const char *path, Error **errp)
 {
     SocketAddress *saddr = unix_build_address(path);
-    socket_start_incoming_migration(saddr, errp);
+    SocketAddress *address;
+
+    address = socket_start_incoming_migration(saddr, errp);
+    qapi_free_SocketAddress(address);
     qapi_free_SocketAddress(saddr);
 }
-- 
2.13.6
