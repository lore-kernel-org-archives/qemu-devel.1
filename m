Received: from eggs.gnu.org ([209.51.188.92]:43445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fw-0002s3-Od
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fv-0000gR-CX
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h14Ft-0000fa-GQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:49 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  5 Mar 2019 15:12:15 +0800
Message-Id: <1551769940-22739-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
References: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 08/13] migration: Switch to using announce
 timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Switch the announcements to using the new announce timer.
Move the code that does it to announce.c rather than savevm
because it really has nothing to do with the actual migration.

Migration starts the announce from bh's and so they're all
in the main thread/bql, and so there's never any racing with
the timers themselves.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/migration/misc.h | 10 -------
 include/net/announce.h   |  2 ++
 include/sysemu/sysemu.h  |  2 --
 migration/migration.c    |  2 +-
 migration/migration.h    |  4 +++
 migration/savevm.c       | 72 ++----------------------------------------------
 migration/trace-events   |  1 -
 net/announce.c           | 68 +++++++++++++++++++++++++++++++++++++++++++++
 net/trace-events         |  3 ++
 9 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e837ab3..0471e04 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -29,16 +29,6 @@ void blk_mig_init(void);
 static inline void blk_mig_init(void) {}
 #endif
 
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
 
diff --git a/include/net/announce.h b/include/net/announce.h
index b89f1c2..892d302 100644
--- a/include/net/announce.h
+++ b/include/net/announce.h
@@ -36,4 +36,6 @@ void qemu_announce_timer_reset(AnnounceTimer *timer,
                                QEMUTimerCB *cb,
                                void *opaque);
 
+void qemu_announce_self(AnnounceTimer *timer, AnnounceParameters *params);
+
 #endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 4b5a6b7..89604a8 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -81,8 +81,6 @@ extern bool machine_init_done;
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
-void qemu_announce_self(void);
-
 extern int autostart;
 
 typedef enum {
diff --git a/migration/migration.c b/migration/migration.c
index ca9c35a..c39d305 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -374,7 +374,7 @@ static void process_incoming_migration_bh(void *opaque)
      * This must happen after all error conditions are dealt with and
      * we're sure the VM is going to be running on this host.
      */
-    qemu_announce_self();
+    qemu_announce_self(&mis->announce_timer, migrate_announce_params());
 
     if (multifd_load_cleanup(&local_err) != 0) {
         error_report_err(local_err);
diff --git a/migration/migration.h b/migration/migration.h
index dcd05d9..c99154d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -21,6 +21,7 @@
 #include "qemu/coroutine_int.h"
 #include "hw/qdev.h"
 #include "io/channel.h"
+#include "net/announce.h"
 
 struct PostcopyBlocktimeContext;
 
@@ -36,6 +37,9 @@ struct MigrationIncomingState {
      */
     QemuEvent main_thread_load_event;
 
+    /* For network announces */
+    AnnounceTimer  announce_timer;
+
     size_t         largest_page_size;
     bool           have_fault_thread;
     QemuThread     fault_thread;
diff --git a/migration/savevm.c b/migration/savevm.c
index 3226604..b3868f7 100644
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
 
 const unsigned int postcopy_ram_discard_version = 0;
 
@@ -125,67 +119,6 @@ static struct mig_cmd_args {
  * generic extendable format with an exception for two old entities.
  */
 
-static int announce_self_create(uint8_t *buf,
-                                uint8_t *mac_addr)
-{
-    /* Ethernet header. */
-    memset(buf, 0xff, 6);         /* destination MAC addr */
-    memcpy(buf + 6, mac_addr, 6); /* source MAC addr */
-    *(uint16_t *)(buf + 12) = htons(ETH_P_RARP); /* ethertype */
-
-    /* RARP header. */
-    *(uint16_t *)(buf + 14) = htons(ARP_HTYPE_ETH); /* hardware addr space */
-    *(uint16_t *)(buf + 16) = htons(ARP_PTYPE_IP); /* protocol addr space */
-    *(buf + 18) = 6; /* hardware addr length (ethernet) */
-    *(buf + 19) = 4; /* protocol addr length (IPv4) */
-    *(uint16_t *)(buf + 20) = htons(ARP_OP_REQUEST_REV); /* opcode */
-    memcpy(buf + 22, mac_addr, 6); /* source hw addr */
-    memset(buf + 28, 0x00, 4);     /* source protocol addr */
-    memcpy(buf + 32, mac_addr, 6); /* target hw addr */
-    memset(buf + 38, 0x00, 4);     /* target protocol addr */
-
-    /* Padding to get up to 60 bytes (ethernet min packet size, minus FCS). */
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
-    len = announce_self_create(buf, nic->conf->macaddr.a);
-
-    qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
-}
-
-
-static void qemu_announce_self_once(void *opaque)
-{
-    static int count = SELF_ANNOUNCE_ROUNDS;
-    QEMUTimer *timer = *(QEMUTimer **)opaque;
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
-    timer = timer_new_ms(QEMU_CLOCK_REALTIME, qemu_announce_self_once, &timer);
-    qemu_announce_self_once(&timer);
-}
-
 /***********************************************************/
 /* savevm/loadvm support */
 
@@ -1765,13 +1698,14 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 {
     Error *local_err = NULL;
     HandleRunBhData *data = opaque;
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
     /* TODO we should move all of this lot into postcopy_ram.c or a shared code
      * in migration.c
      */
     cpu_synchronize_all_post_init();
 
-    qemu_announce_self();
+    qemu_announce_self(&mis->announce_timer, migrate_announce_params());
 
     /* Make sure all file formats flush their mutable metadata.
      * If we get an error here, just don't restart the VM yet. */
diff --git a/migration/trace-events b/migration/trace-events
index bd2d0cd..72e3fcb 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -52,7 +52,6 @@ vmstate_save_state_top(const char *idstr) "%s"
 vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
 vmstate_subsection_save_top(const char *idstr) "%s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
-qemu_announce_self_iter(const char *mac) "%s"
 
 # migration/vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
diff --git a/net/announce.c b/net/announce.c
index 8876eb6..13ad9c2 100644
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
 
 int64_t qemu_announce_timer_step(AnnounceTimer *timer)
 {
@@ -58,3 +60,69 @@ void qemu_announce_timer_reset(AnnounceTimer *timer,
     timer->type = type;
     timer->tm = timer_new_ms(type, cb, opaque);
 }
+
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
+    *(uint16_t *)(buf + 12) = htons(ETH_P_RARP); /* ethertype */
+
+    /* RARP header. */
+    *(uint16_t *)(buf + 14) = htons(ARP_HTYPE_ETH); /* hardware addr space */
+    *(uint16_t *)(buf + 16) = htons(ARP_PTYPE_IP); /* protocol addr space */
+    *(buf + 18) = 6; /* hardware addr length (ethernet) */
+    *(buf + 19) = 4; /* protocol addr length (IPv4) */
+    *(uint16_t *)(buf + 20) = htons(ARP_OP_REQUEST_REV); /* opcode */
+    memcpy(buf + 22, mac_addr, 6); /* source hw addr */
+    memset(buf + 28, 0x00, 4);     /* source protocol addr */
+    memcpy(buf + 32, mac_addr, 6); /* target hw addr */
+    memset(buf + 38, 0x00, 4);     /* target protocol addr */
+
+    /* Padding to get up to 60 bytes (ethernet min packet size, minus FCS). */
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
+    len = announce_self_create(buf, nic->conf->macaddr.a);
+
+    qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
+}
+static void qemu_announce_self_once(void *opaque)
+{
+    AnnounceTimer *timer = (AnnounceTimer *)opaque;
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
+void qemu_announce_self(AnnounceTimer *timer, AnnounceParameters *params)
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
index 7b594cf..3417ac0 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -1,5 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# net/announce.c
+qemu_announce_self_iter(const char *mac) "%s"
+
 # net/vhost-user.c
 vhost_user_event(const char *chr, int event) "chr: %s got event: %d"
 
-- 
2.5.0
