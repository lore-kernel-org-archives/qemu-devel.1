Received: from eggs.gnu.org ([2001:4830:134:3::10]:40303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst2s-0007b3-Cd
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst2r-00071d-9R
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cst2r-00071T-1n
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1328E9F737
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 15:28:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Mar 2017 16:27:42 +0100
Message-Id: <20170328152745.28186-4-dgilbert@redhat.com>
In-Reply-To: <20170328152745.28186-1-dgilbert@redhat.com>
References: <20170328152745.28186-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] migration/announce: Use the new parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: kashyap@redhat.com, germano@redhat.com, armbru@redhat.com, jasowang@redhat.com, jdenemar@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Rework the existing constants to use the new parameters.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/virtio-net.c           |  3 ++-
 include/migration/migration.h |  1 +
 include/migration/vmstate.h   | 10 ----------
 migration/savevm.c            | 32 ++++++++++++++++++++++++++++++--
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c321680..b56b74a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -19,6 +19,7 @@
 #include "net/tap.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "migration/migration.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "hw/virtio/virtio-bus.h"
@@ -1611,7 +1612,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
         virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
-        n->announce_counter = SELF_ANNOUNCE_ROUNDS;
+        n->announce_counter = migrate_announce_rounds();
         timer_mod(n->announce_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL));
     }
 
diff --git a/include/migration/migration.h b/include/migration/migration.h
index a75800c..ba25dbf 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -344,6 +344,7 @@ int migrate_announce_initial(void);
 int migrate_announce_max(void);
 int migrate_announce_rounds(void);
 int migrate_announce_step(void);
+int64_t self_announce_delay(int round);
 
 /* Sending on the return path - generic and then for each message type */
 void migrate_send_rp_message(MigrationIncomingState *mis,
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f2dbf84..c7ef11d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1003,8 +1003,6 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_END_OF_LIST()                                         \
     {}
 
-#define SELF_ANNOUNCE_ROUNDS 5
-
 void loadvm_free_handlers(MigrationIncomingState *mis);
 
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
@@ -1038,14 +1036,6 @@ void vmstate_register_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_register_ram_global(struct MemoryRegion *memory);
 
-static inline
-int64_t self_announce_delay(int round)
-{
-    assert(round < SELF_ANNOUNCE_ROUNDS && round > 0);
-    /* delay 50ms, 150ms, 250ms, ... */
-    return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
-}
-
 void dump_vmstate_json_to_file(FILE *out_fp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 361a926..69bb1d2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -118,16 +118,44 @@ static void qemu_announce_self_iter(NICState *nic, void *opaque)
     qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
 }
 
+/* Increasing delays between packets in the network announcments,
+ * both in the RARPs sent by QEMU and the ARPs triggered via virtio-net
+ * for the guest to send.
+ *
+ * Default parameters generate delays of
+ *   50, 150, 250, 350
+ *   between 5 packets.
+ * which corresponds to:
+ *  <> initial <> initial+step <> initial+2*step <> initial+3*step <>
+ *   between 'rounds' packets
+ * A maximum can be used to override the step after a few packets.
+ */
+int64_t self_announce_delay(int round)
+{
+    int64_t ret;
+    ret = migrate_announce_initial() +
+           (migrate_announce_rounds() - round - 1) *
+           migrate_announce_step();
+    if (ret < 0 || ret > migrate_announce_max()) {
+        ret = migrate_announce_max();
+    }
+    return ret;
+}
 
 static void qemu_announce_self_once(void *opaque)
 {
-    static int count = SELF_ANNOUNCE_ROUNDS;
+    static bool once = true;
+    static int count = -1;
     QEMUTimer *timer = *(QEMUTimer **)opaque;
 
+    if (once) {
+        count = migrate_announce_rounds();
+        once = false;
+    }
+
     qemu_foreach_nic(qemu_announce_self_iter, NULL);
 
     if (--count) {
-        /* delay 50ms, 150ms, 250ms, ... */
         timer_mod(timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
                   self_announce_delay(count));
     } else {
-- 
2.9.3
