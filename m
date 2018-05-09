Received: from eggs.gnu.org ([2001:4830:134:3::10]:40833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNnE-0008PA-HU
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNnC-0005QL-Hx
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:02:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNnC-0005Pp-DZ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:01:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00C37819D1D1
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 12:01:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 14:01:38 +0200
Message-Id: <20180509120140.6612-2-quintela@redhat.com>
In-Reply-To: <20180509120140.6612-1-quintela@redhat.com>
References: <20180509120140.6612-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 1/3] migration: Create socket-address
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

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
---
 hmp.c                 | 31 +++++++++++++++++++++++++++++++
 migration/migration.c | 23 +++++++++++++++++++++++
 migration/migration.h |  4 ++++
 migration/socket.c    | 11 +++++++++++
 qapi/migration.json   |  6 +++++-
 qapi/sockets.json     | 13 +++++++++++++
 6 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 35a23d8cb8..63e718bd69 100644
--- a/hmp.c
+++ b/hmp.c
@@ -166,6 +166,26 @@ void hmp_info_mice(Monitor *mon, const QDict *qdict)
     qapi_free_MouseInfoList(mice_list);
 }
 
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
@@ -289,6 +309,17 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         g_free(str);
         visit_free(v);
     }
+    if (info->has_socket_address) {
+        SocketAddressList *addr;
+
+        monitor_printf(mon, "socket address: [\n");
+
+        for (addr = info->socket_address; addr; addr = addr->next) {
+            char *s = SocketAddress_to_str(addr->value);
+            monitor_printf(mon, "\t%s\n", s);
+        }
+        monitor_printf(mon, "]\n");
+    }
     qapi_free_MigrationInfo(info);
     qapi_free_MigrationCapabilityStatusList(caps);
 }
diff --git a/migration/migration.c b/migration/migration.c
index 05aec2c905..11d16a80c7 100644
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
@@ -193,6 +195,11 @@ void migration_incoming_state_destroy(void)
     }
 
     qemu_event_reset(&mis->main_thread_load_event);
+
+    if (mis->socket_address) {
+        qapi_free_SocketAddressList(mis->socket_address);
+        mis->socket_address = NULL;
+    }
 }
 
 static void migrate_generate_event(int new_state)
@@ -282,6 +289,17 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
     return migrate_send_rp_message(mis, msg_type, msglen, bufc);
 }
 
+void migrate_add_address(SocketAddress *address)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    SocketAddressList *addrs;
+
+    addrs = g_new0(SocketAddressList, 1);
+    addrs->next = mis->socket_address;
+    mis->socket_address = addrs;
+    addrs->value = QAPI_CLONE(SocketAddress, address);
+}
+
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
@@ -843,6 +861,11 @@ static void fill_destination_migration_info(MigrationInfo *info)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (mis->socket_address) {
+        info->has_socket_address = true;
+        info->socket_address =  QAPI_CLONE(SocketAddressList, mis->socket_address);
+    }
+
     switch (mis->state) {
     case MIGRATION_STATUS_NONE:
         return;
diff --git a/migration/migration.h b/migration/migration.h
index 8f0c82159b..16c26600e2 100644
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
 
 MigrationIncomingState *migration_incoming_get_current(void);
@@ -276,5 +279,6 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 
 void dirty_bitmap_mig_before_vm_start(void);
 void init_dirty_bitmap_incoming_migration(void);
+void migrate_add_address(SocketAddress *address);
 
 #endif
diff --git a/migration/socket.c b/migration/socket.c
index 3456eb76e9..0eb9b53f81 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 
 #include "qemu-common.h"
 #include "qemu/error-report.h"
@@ -182,6 +183,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                                             Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
+    size_t i;
 
     qio_net_listener_set_name(listener, "migration-socket-listener");
 
@@ -194,6 +196,15 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                                           socket_accept_incoming_migration,
                                           NULL, NULL,
                                           g_main_context_get_thread_default());
+
+    for (i = 0; i < listener->nsioc; i++)  {
+        SocketAddress *address =
+            qio_channel_socket_get_local_address(listener->sioc[i], errp);
+        if (!address) {
+            return;
+        }
+        migrate_add_address(address);
+    }
 }
 
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 66c6b38f88..9085007ff8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -6,6 +6,7 @@
 ##
 
 { 'include': 'common.json' }
+{ 'include': 'sockets.json' }
 
 ##
 # @MigrationStats:
@@ -169,6 +170,7 @@
 #           only present when the postcopy-blocktime migration capability
 #           is enabled. (Since 2.13)
 #
+# @socket-address: Only used for tcp, to know what the real port is (Since 2.13)
 #
 # Since: 0.14.0
 ##
@@ -183,7 +185,8 @@
            '*cpu-throttle-percentage': 'int',
            '*error-desc': 'str',
            '*postcopy-blocktime' : 'uint32',
-           '*postcopy-vcpu-blocktime': ['uint32']} }
+           '*postcopy-vcpu-blocktime': ['uint32'],
+           '*socket-address': ['SocketAddress'] } }
 
 ##
 # @query-migrate:
@@ -690,6 +693,7 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
diff --git a/qapi/sockets.json b/qapi/sockets.json
index fc81d8d5e8..f1ca09a927 100644
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
+# Since: 2.13
+##
+{ 'struct': 'DummyStruct',
+  'data': { 'dummy-list': ['SocketAddress'] } }
-- 
2.17.0
