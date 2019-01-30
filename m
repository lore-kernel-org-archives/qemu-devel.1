Received: from eggs.gnu.org ([209.51.188.92]:57036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gonB9-0004yo-Se
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gonB8-0003Mi-3S
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:33:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gonB7-0003L3-RK
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:33:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27F8DC057E2D
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 10:33:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 30 Jan 2019 10:32:31 +0000
Message-Id: <20190130103236.18302-5-dgilbert@redhat.com>
In-Reply-To: <20190130103236.18302-1-dgilbert@redhat.com>
References: <20190130103236.18302-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/9] migration: Switch to using announce
 timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com
Cc: germano@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Switch the announcements to using the new announce timer.
Move the code that does it to announce.c rather than savevm
because it really has nothing to do with the actual migration.

Migration starts the announce from bh's and so they're all
in the main thread/bql, and so there's never any racing with
the timers themselves.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/misc.h | 10 ------
 include/net/announce.h   |  2 ++
 include/sysemu/sysemu.h  |  2 --
 migration/migration.c    |  2 +-
 migration/migration.h    |  4 +++
 migration/savevm.c       | 72 ++--------------------------------------
 migration/trace-events   |  1 -
 net/announce.c           | 67 +++++++++++++++++++++++++++++++++++++
 net/trace-events         |  4 +++
 9 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e837ab3042..0471e04d1f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -29,16 +29,6 @@ void blk_mig_init(void);
 static inline void blk_mig_init(void) {}
 #endif
=20
-#define SELF_ANNOUNCE_ROUNDS 5
-
-static inline
-int64_t self_announce_delay(int round)
-{
-    assert(round < SELF_ANNOUNCE_ROUNDS && round > 0);
-    /* delay 50ms, 150ms, 250ms, ... */
-    return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
-}
-
 AnnounceParameters *migrate_announce_params(void);
 /* migration/savevm.c */
=20
diff --git a/include/net/announce.h b/include/net/announce.h
index b89f1c28b5..892d302b65 100644
--- a/include/net/announce.h
+++ b/include/net/announce.h
@@ -36,4 +36,6 @@ void qemu_announce_timer_reset(AnnounceTimer *timer,
                                QEMUTimerCB *cb,
                                void *opaque);
=20
+void qemu_announce_self(AnnounceTimer *timer, AnnounceParameters *params=
);
+
 #endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 85877b7e43..e322e696f2 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -81,8 +81,6 @@ extern bool machine_init_done;
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
=20
-void qemu_announce_self(void);
-
 extern int autostart;
=20
 typedef enum {
diff --git a/migration/migration.c b/migration/migration.c
index ca9c35a5cd..c39d3054ec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -374,7 +374,7 @@ static void process_incoming_migration_bh(void *opaqu=
e)
      * This must happen after all error conditions are dealt with and
      * we're sure the VM is going to be running on this host.
      */
-    qemu_announce_self();
+    qemu_announce_self(&mis->announce_timer, migrate_announce_params());
=20
     if (multifd_load_cleanup(&local_err) !=3D 0) {
         error_report_err(local_err);
diff --git a/migration/migration.h b/migration/migration.h
index dcd05d9f87..c99154dea2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -21,6 +21,7 @@
 #include "qemu/coroutine_int.h"
 #include "hw/qdev.h"
 #include "io/channel.h"
+#include "net/announce.h"
=20
 struct PostcopyBlocktimeContext;
=20
@@ -36,6 +37,9 @@ struct MigrationIncomingState {
      */
     QemuEvent main_thread_load_event;
=20
+    /* For network announces */
+    AnnounceTimer  announce_timer;
+
     size_t         largest_page_size;
     bool           have_fault_thread;
     QemuThread     fault_thread;
diff --git a/migration/savevm.c b/migration/savevm.c
index 322660438d..b3868f7fb5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -57,13 +57,7 @@
 #include "sysemu/replay.h"
 #include "qjson.h"
 #include "migration/colo.h"
-
-#ifndef ETH_P_RARP
-#define ETH_P_RARP 0x8035
-#endif
-#define ARP_HTYPE_ETH 0x0001
-#define ARP_PTYPE_IP 0x0800
-#define ARP_OP_REQUEST_REV 0x3
+#include "net/announce.h"
=20
 const unsigned int postcopy_ram_discard_version =3D 0;
=20
@@ -125,67 +119,6 @@ static struct mig_cmd_args {
  * generic extendable format with an exception for two old entities.
  */
=20
-static int announce_self_create(uint8_t *buf,
-                                uint8_t *mac_addr)
-{
-    /* Ethernet header. */
-    memset(buf, 0xff, 6);         /* destination MAC addr */
-    memcpy(buf + 6, mac_addr, 6); /* source MAC addr */
-    *(uint16_t *)(buf + 12) =3D htons(ETH_P_RARP); /* ethertype */
-
-    /* RARP header. */
-    *(uint16_t *)(buf + 14) =3D htons(ARP_HTYPE_ETH); /* hardware addr s=
pace */
-    *(uint16_t *)(buf + 16) =3D htons(ARP_PTYPE_IP); /* protocol addr sp=
ace */
-    *(buf + 18) =3D 6; /* hardware addr length (ethernet) */
-    *(buf + 19) =3D 4; /* protocol addr length (IPv4) */
-    *(uint16_t *)(buf + 20) =3D htons(ARP_OP_REQUEST_REV); /* opcode */
-    memcpy(buf + 22, mac_addr, 6); /* source hw addr */
-    memset(buf + 28, 0x00, 4);     /* source protocol addr */
-    memcpy(buf + 32, mac_addr, 6); /* target hw addr */
-    memset(buf + 38, 0x00, 4);     /* target protocol addr */
-
-    /* Padding to get up to 60 bytes (ethernet min packet size, minus FC=
S). */
-    memset(buf + 42, 0x00, 18);
-
-    return 60; /* len (FCS will be added by hardware) */
-}
-
-static void qemu_announce_self_iter(NICState *nic, void *opaque)
-{
-    uint8_t buf[60];
-    int len;
-
-    trace_qemu_announce_self_iter(qemu_ether_ntoa(&nic->conf->macaddr));
-    len =3D announce_self_create(buf, nic->conf->macaddr.a);
-
-    qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
-}
-
-
-static void qemu_announce_self_once(void *opaque)
-{
-    static int count =3D SELF_ANNOUNCE_ROUNDS;
-    QEMUTimer *timer =3D *(QEMUTimer **)opaque;
-
-    qemu_foreach_nic(qemu_announce_self_iter, NULL);
-
-    if (--count) {
-        /* delay 50ms, 150ms, 250ms, ... */
-        timer_mod(timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
-                  self_announce_delay(count));
-    } else {
-            timer_del(timer);
-            timer_free(timer);
-    }
-}
-
-void qemu_announce_self(void)
-{
-    static QEMUTimer *timer;
-    timer =3D timer_new_ms(QEMU_CLOCK_REALTIME, qemu_announce_self_once,=
 &timer);
-    qemu_announce_self_once(&timer);
-}
-
 /***********************************************************/
 /* savevm/loadvm support */
=20
@@ -1765,13 +1698,14 @@ static void loadvm_postcopy_handle_run_bh(void *o=
paque)
 {
     Error *local_err =3D NULL;
     HandleRunBhData *data =3D opaque;
+    MigrationIncomingState *mis =3D migration_incoming_get_current();
=20
     /* TODO we should move all of this lot into postcopy_ram.c or a shar=
ed code
      * in migration.c
      */
     cpu_synchronize_all_post_init();
=20
-    qemu_announce_self();
+    qemu_announce_self(&mis->announce_timer, migrate_announce_params());
=20
     /* Make sure all file formats flush their mutable metadata.
      * If we get an error here, just don't restart the VM yet. */
diff --git a/migration/trace-events b/migration/trace-events
index bd2d0cd25a..72e3fcb885 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -52,7 +52,6 @@ vmstate_save_state_top(const char *idstr) "%s"
 vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
 vmstate_subsection_save_top(const char *idstr) "%s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
-qemu_announce_self_iter(const char *mac) "%s"
=20
 # migration/vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load =
failed, ret =3D %d"
diff --git a/net/announce.c b/net/announce.c
index a37089bf27..13ad9c2ba8 100644
--- a/net/announce.c
+++ b/net/announce.c
@@ -9,8 +9,10 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "net/announce.h"
+#include "net/net.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-net.h"
+#include "trace.h"
=20
 int64_t qemu_announce_timer_step(AnnounceTimer *timer)
 {
@@ -59,3 +61,68 @@ void qemu_announce_timer_reset(AnnounceTimer *timer,
     timer->tm =3D timer_new_ms(type, cb, opaque);
 }
=20
+#ifndef ETH_P_RARP
+#define ETH_P_RARP 0x8035
+#endif
+#define ARP_HTYPE_ETH 0x0001
+#define ARP_PTYPE_IP 0x0800
+#define ARP_OP_REQUEST_REV 0x3
+
+static int announce_self_create(uint8_t *buf,
+                                uint8_t *mac_addr)
+{
+    /* Ethernet header. */
+    memset(buf, 0xff, 6);         /* destination MAC addr */
+    memcpy(buf + 6, mac_addr, 6); /* source MAC addr */
+    *(uint16_t *)(buf + 12) =3D htons(ETH_P_RARP); /* ethertype */
+
+    /* RARP header. */
+    *(uint16_t *)(buf + 14) =3D htons(ARP_HTYPE_ETH); /* hardware addr s=
pace */
+    *(uint16_t *)(buf + 16) =3D htons(ARP_PTYPE_IP); /* protocol addr sp=
ace */
+    *(buf + 18) =3D 6; /* hardware addr length (ethernet) */
+    *(buf + 19) =3D 4; /* protocol addr length (IPv4) */
+    *(uint16_t *)(buf + 20) =3D htons(ARP_OP_REQUEST_REV); /* opcode */
+    memcpy(buf + 22, mac_addr, 6); /* source hw addr */
+    memset(buf + 28, 0x00, 4);     /* source protocol addr */
+    memcpy(buf + 32, mac_addr, 6); /* target hw addr */
+    memset(buf + 38, 0x00, 4);     /* target protocol addr */
+
+    /* Padding to get up to 60 bytes (ethernet min packet size, minus FC=
S). */
+    memset(buf + 42, 0x00, 18);
+
+    return 60; /* len (FCS will be added by hardware) */
+}
+
+static void qemu_announce_self_iter(NICState *nic, void *opaque)
+{
+    uint8_t buf[60];
+    int len;
+
+    trace_qemu_announce_self_iter(qemu_ether_ntoa(&nic->conf->macaddr));
+    len =3D announce_self_create(buf, nic->conf->macaddr.a);
+
+    qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
+}
+static void qemu_announce_self_once(void *opaque)
+{
+    AnnounceTimer *timer =3D (AnnounceTimer *)opaque;
+
+    qemu_foreach_nic(qemu_announce_self_iter, NULL);
+
+    if (--timer->round) {
+        qemu_announce_timer_step(timer);
+    } else {
+        qemu_announce_timer_del(timer);
+    }
+}
+
+void qemu_announce_self(AnnounceTimer *timer, AnnounceParameters *params=
)
+{
+    qemu_announce_timer_reset(timer, params, QEMU_CLOCK_REALTIME,
+                              qemu_announce_self_once, timer);
+    if (params->rounds) {
+        qemu_announce_self_once(timer);
+    } else {
+        qemu_announce_timer_del(timer);
+    }
+}
diff --git a/net/trace-events b/net/trace-events
index 7b594cfdd2..7effa62787 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -1,5 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
+# net/announce.c
+qemu_announce_self_iter(const char *mac) "%s"
+
 # net/vhost-user.c
 vhost_user_event(const char *chr, int event) "chr: %s got event: %d"
=20
@@ -19,3 +22,4 @@ colo_compare_tcp_info(const char *pkt, uint32_t seq, ui=
nt32_t ack, int hdlen, in
 colo_filter_rewriter_debug(void) ""
 colo_filter_rewriter_pkt_info(const char *func, const char *src, const c=
har *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s =
p: seq/ack=3D%u/%u  flags=3D0x%x\n"
 colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=3D%u\n"
+
--=20
2.20.1
