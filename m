Received: from eggs.gnu.org ([209.51.188.92]:51506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gookr-0006LA-1T
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gookp-0006ZG-Ri
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gookp-0006Y4-Jz
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:14:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DC76285B3
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 12:07:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 30 Jan 2019 13:06:14 +0100
Message-Id: <20190130120616.5260-3-quintela@redhat.com>
In-Reply-To: <20190130120616.5260-1-quintela@redhat.com>
References: <20190130120616.5260-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 2/4] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

It will be used to store the uri parameters. We want this only for
tcp, so we don't set it for other uris.  We need it to know what port
is migration running.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

This used to be uri parameter, but it has so many troubles to
reproduce that it don't just make sense.

This used to be a port parameter.  I was asked to move to
SocketAddress, done.
I also merged the setting of the migration tcp port in this one
because now I need to free the address, and this makes it easier.
This used to be x-socket-address with a single direction, now it is a
list of addresses.
Move SocketAddress_to_str here.  I used to try to generalize the one
in chardev/char-socket.c, but it is not worth it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                 | 31 +++++++++++++++++++++++++++++++
 migration/migration.c | 24 ++++++++++++++++++++++++
 migration/migration.h |  4 ++++
 migration/socket.c    | 11 +++++++++++
 qapi/migration.json   |  6 +++++-
 qapi/sockets.json     | 13 +++++++++++++
 6 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index b2a2b1f84e..95d5063e5d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -166,6 +166,26 @@ void hmp_info_mice(Monitor *mon, const QDict *qdict)
     qapi_free_MouseInfoList(mice_list);
 }
=20
+static char *SocketAddress_to_str(SocketAddress *addr)
+{
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        return g_strdup_printf("tcp:%s:%s",
+                               addr->u.inet.host,
+                               addr->u.inet.port);
+        break;
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        return g_strdup_printf("unix:%s",
+                               addr->u.q_unix.path);
+        break;
+    case SOCKET_ADDRESS_TYPE_FD:
+        return g_strdup_printf("fd:%s", addr->u.fd.str);
+        break;
+    default:
+        abort();
+    }
+}
+
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 {
     MigrationInfo *info;
@@ -306,6 +326,17 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdi=
ct)
         g_free(str);
         visit_free(v);
     }
+    if (info->has_socket_address) {
+        SocketAddressList *addr;
+
+        monitor_printf(mon, "socket address: [\n");
+
+        for (addr =3D info->socket_address; addr; addr =3D addr->next) {
+            char *s =3D SocketAddress_to_str(addr->value);
+            monitor_printf(mon, "\t%s\n", s);
+        }
+        monitor_printf(mon, "]\n");
+    }
     qapi_free_MigrationInfo(info);
     qapi_free_MigrationCapabilityStatusList(caps);
 }
diff --git a/migration/migration.c b/migration/migration.c
index 37e06b76dc..ef1d53cde2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -31,6 +31,8 @@
 #include "migration/vmstate.h"
 #include "block/block.h"
 #include "qapi/error.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
@@ -197,6 +199,11 @@ void migration_incoming_state_destroy(void)
     }
=20
     qemu_event_reset(&mis->main_thread_load_event);
+
+    if (mis->socket_address) {
+        qapi_free_SocketAddressList(mis->socket_address);
+        mis->socket_address =3D NULL;
+    }
 }
=20
 static void migrate_generate_event(int new_state)
@@ -312,6 +319,17 @@ void migration_incoming_enable_colo(void)
     migration_colo_enabled =3D true;
 }
=20
+void migrate_add_address(SocketAddress *address)
+{
+    MigrationIncomingState *mis =3D migration_incoming_get_current();
+    SocketAddressList *addrs;
+
+    addrs =3D g_new0(SocketAddressList, 1);
+    addrs->next =3D mis->socket_address;
+    mis->socket_address =3D addrs;
+    addrs->value =3D QAPI_CLONE(SocketAddress, address);
+}
+
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
@@ -966,6 +984,12 @@ static void fill_destination_migration_info(Migratio=
nInfo *info)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
=20
+    if (mis->socket_address) {
+        info->has_socket_address =3D true;
+        info->socket_address =3D
+            QAPI_CLONE(SocketAddressList, mis->socket_address);
+    }
+
     switch (mis->state) {
     case MIGRATION_STATUS_NONE:
         return;
diff --git a/migration/migration.h b/migration/migration.h
index dcd05d9f87..bd41b57af9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -80,6 +80,9 @@ struct MigrationIncomingState {
     bool postcopy_recover_triggered;
     QemuSemaphore postcopy_pause_sem_dst;
     QemuSemaphore postcopy_pause_sem_fault;
+
+    /* List of listening socket addresses  */
+    SocketAddressList *socket_address;
 };
=20
 MigrationIncomingState *migration_incoming_get_current(void);
@@ -300,6 +303,7 @@ void migrate_send_rp_resume_ack(MigrationIncomingStat=
e *mis, uint32_t value);
=20
 void dirty_bitmap_mig_before_vm_start(void);
 void init_dirty_bitmap_incoming_migration(void);
+void migrate_add_address(SocketAddress *address);
=20
 #define qemu_ram_foreach_block \
   #warning "Use qemu_ram_foreach_block_migratable in migration code"
diff --git a/migration/socket.c b/migration/socket.c
index f4c8174400..239527fb1f 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -15,6 +15,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
=20
 #include "qemu-common.h"
 #include "qemu/error-report.h"
@@ -177,6 +178,7 @@ static void socket_start_incoming_migration(SocketAdd=
ress *saddr,
                                             Error **errp)
 {
     QIONetListener *listener =3D qio_net_listener_new();
+    size_t i;
=20
     qio_net_listener_set_name(listener, "migration-socket-listener");
=20
@@ -189,6 +191,15 @@ static void socket_start_incoming_migration(SocketAd=
dress *saddr,
                                           socket_accept_incoming_migrati=
on,
                                           NULL, NULL,
                                           g_main_context_get_thread_defa=
ult());
+
+    for (i =3D 0; i < listener->nsioc; i++)  {
+        SocketAddress *address =3D
+            qio_channel_socket_get_local_address(listener->sioc[i], errp=
);
+        if (!address) {
+            return;
+        }
+        migrate_add_address(address);
+    }
 }
=20
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 7a795ecc16..d7b5b3f6e7 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -6,6 +6,7 @@
 ##
=20
 { 'include': 'common.json' }
+{ 'include': 'sockets.json' }
=20
 ##
 # @MigrationStats:
@@ -199,6 +200,8 @@
 # @compression: migration compression statistics, only returned if compr=
ession
 #           feature is on and status is 'active' or 'completed' (Since 3=
.1)
 #
+# @socket-address: Only used for tcp, to know what the real port is (Sin=
ce 3.1)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationInfo',
@@ -213,7 +216,8 @@
            '*error-desc': 'str',
            '*postcopy-blocktime' : 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
-           '*compression': 'CompressionStats'} }
+           '*compression': 'CompressionStats',
+           '*socket-address': ['SocketAddress'] } }
=20
 ##
 # @query-migrate:
diff --git a/qapi/sockets.json b/qapi/sockets.json
index fc81d8d5e8..d7f77984af 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -152,3 +152,16 @@
             'unix': 'UnixSocketAddress',
             'vsock': 'VsockSocketAddress',
             'fd': 'String' } }
+
+##
+# @DummyStruct:
+#
+# Both block-core and migration needs SocketAddressList
+# I am open to comments about how to share it
+#
+# @dummy-list: A dummy list
+#
+# Since: 3.1
+##
+{ 'struct': 'DummyStruct',
+  'data': { 'dummy-list': ['SocketAddress'] } }
--=20
2.20.1
