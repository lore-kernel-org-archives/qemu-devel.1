Received: from eggs.gnu.org ([209.51.188.92]:43607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Ux8-0006NO-Bu
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Ux7-00056P-1y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1Ux6-000566-Oc
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:12 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Mar 2019 11:42:16 +0000
Message-Id: <20190306114227.9125-12-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
References: <20190306114227.9125-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/22] migration: Create socket-address parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com
Cc: eblake@redhat.com, armbru@redhat.com

From: Juan Quintela <quintela@redhat.com>

It will be used to store the uri parameters. We want this only for
tcp, so we don't set it for other uris.  We need it to know what port
is migration running.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  dgilbert: Removed DummyStruct as suggested by Eric & Markus

--
---
 hmp.c                 | 33 +++++++++++++++++++++++++++++++++
 migration/migration.c | 24 ++++++++++++++++++++++++
 migration/migration.h |  4 ++++
 migration/socket.c    | 11 +++++++++++
 qapi/migration.json   |  6 +++++-
 5 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 5f13b16e24..c2ad3f8251 100644
--- a/hmp.c
+++ b/hmp.c
@@ -166,6 +166,27 @@ void hmp_info_mice(Monitor *mon, const QDict *qdict)
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
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        return g_strdup_printf("unix:%s",
+                               addr->u.q_unix.path);
+    case SOCKET_ADDRESS_TYPE_FD:
+        return g_strdup_printf("fd:%s", addr->u.fd.str);
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        return g_strdup_printf("tcp:%s:%s",
+                               addr->u.vsock.cid,
+                               addr->u.vsock.port);
+    default:
+        return g_strdup("unknown address type");
+    }
+}
+
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 {
     MigrationInfo *info;
@@ -306,6 +327,18 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdi=
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
+            g_free(s);
+        }
+        monitor_printf(mon, "]\n");
+    }
     qapi_free_MigrationInfo(info);
     qapi_free_MigrationCapabilityStatusList(caps);
 }
diff --git a/migration/migration.c b/migration/migration.c
index e823fd8b91..952d29243e 100644
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
@@ -213,6 +215,11 @@ void migration_incoming_state_destroy(void)
     }
=20
     qemu_event_reset(&mis->main_thread_load_event);
+
+    if (mis->socket_address_list) {
+        qapi_free_SocketAddressList(mis->socket_address_list);
+        mis->socket_address_list =3D NULL;
+    }
 }
=20
 static void migrate_generate_event(int new_state)
@@ -328,6 +335,17 @@ void migration_incoming_enable_colo(void)
     migration_colo_enabled =3D true;
 }
=20
+void migrate_add_address(SocketAddress *address)
+{
+    MigrationIncomingState *mis =3D migration_incoming_get_current();
+    SocketAddressList *addrs;
+
+    addrs =3D g_new0(SocketAddressList, 1);
+    addrs->next =3D mis->socket_address_list;
+    mis->socket_address_list =3D addrs;
+    addrs->value =3D QAPI_CLONE(SocketAddress, address);
+}
+
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
@@ -1009,6 +1027,12 @@ static void fill_destination_migration_info(Migrat=
ionInfo *info)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
=20
+    if (mis->socket_address_list) {
+        info->has_socket_address =3D true;
+        info->socket_address =3D
+            QAPI_CLONE(SocketAddressList, mis->socket_address_list);
+    }
+
     switch (mis->state) {
     case MIGRATION_STATUS_NONE:
         return;
diff --git a/migration/migration.h b/migration/migration.h
index 81c261941d..99e99e56bd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -84,6 +84,9 @@ struct MigrationIncomingState {
     bool postcopy_recover_triggered;
     QemuSemaphore postcopy_pause_sem_dst;
     QemuSemaphore postcopy_pause_sem_fault;
+
+    /* List of listening socket addresses  */
+    SocketAddressList *socket_address_list;
 };
=20
 MigrationIncomingState *migration_incoming_get_current(void);
@@ -305,6 +308,7 @@ void migrate_send_rp_resume_ack(MigrationIncomingStat=
e *mis, uint32_t value);
=20
 void dirty_bitmap_mig_before_vm_start(void);
 void init_dirty_bitmap_incoming_migration(void);
+void migrate_add_address(SocketAddress *address);
=20
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
=20
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
index eab87340b2..6bd7fd3f1a 100644
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
ce 4.0)
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
--=20
2.20.1
