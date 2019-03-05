Received: from eggs.gnu.org ([209.51.188.92]:43396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fk-0002hR-0L
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fi-0000bL-SK
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h14Fi-0000aU-JM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:38 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  5 Mar 2019 15:12:12 +0800
Message-Id: <1551769940-22739-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
References: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 05/13] net: Introduce announce timer
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

The 'announce timer' will be used by migration, and explicit
requests for qemu to perform network announces.

Based on the work by Germano Veit Michel <germano@redhat.com>
 and Vlad Yasevich <vyasevic@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/net/announce.h  | 39 ++++++++++++++++++++++++++++++++
 include/qemu/typedefs.h |  1 +
 migration/migration.c   |  1 +
 net/Makefile.objs       |  1 +
 net/announce.c          | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/net.json           | 23 +++++++++++++++++++
 6 files changed, 125 insertions(+)
 create mode 100644 include/net/announce.h
 create mode 100644 net/announce.c

diff --git a/include/net/announce.h b/include/net/announce.h
new file mode 100644
index 0000000..b89f1c2
--- /dev/null
+++ b/include/net/announce.h
@@ -0,0 +1,39 @@
+/*
+ *  Self-announce facility
+ *  (c) 2017-2019 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_NET_ANNOUNCE_H
+#define QEMU_NET_ANNOUNCE_H
+
+#include "qemu-common.h"
+#include "qapi/qapi-types-net.h"
+#include "qemu/timer.h"
+
+struct AnnounceTimer {
+    QEMUTimer *tm;
+    AnnounceParameters params;
+    QEMUClockType type;
+    int round;
+};
+
+/* Returns: update the timer to the next time point */
+int64_t qemu_announce_timer_step(AnnounceTimer *timer);
+
+/* Delete the underlying timer */
+void qemu_announce_timer_del(AnnounceTimer *timer);
+
+/*
+ * Under BQL/main thread
+ * Reset the timer to the given parameters/type/notifier.
+ */
+void qemu_announce_timer_reset(AnnounceTimer *timer,
+                               AnnounceParameters *params,
+                               QEMUClockType type,
+                               QEMUTimerCB *cb,
+                               void *opaque);
+
+#endif
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 5d1a2d8..e4a0a65 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -8,6 +8,7 @@
 typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
+typedef struct AnnounceTimer AnnounceTimer;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
 typedef struct BlockBackend BlockBackend;
diff --git a/migration/migration.c b/migration/migration.c
index 37e06b7..a9c4c6f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -45,6 +45,7 @@
 #include "migration/colo.h"
 #include "hw/boards.h"
 #include "monitor/monitor.h"
+#include "net/announce.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
 
diff --git a/net/Makefile.objs b/net/Makefile.objs
index df2b409..8262f03 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -2,6 +2,7 @@ common-obj-y = net.o queue.o checksum.o util.o hub.o
 common-obj-y += socket.o
 common-obj-y += dump.o
 common-obj-y += eth.o
+common-obj-y += announce.o
 common-obj-$(CONFIG_L2TPV3) += l2tpv3.o
 common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET_USER)) += vhost-user.o
 common-obj-$(call land,$(call lnot,$(CONFIG_VIRTIO_NET)),$(CONFIG_VHOST_NET_USER)) += vhost-user-stub.o
diff --git a/net/announce.c b/net/announce.c
new file mode 100644
index 0000000..8876eb6
--- /dev/null
+++ b/net/announce.c
@@ -0,0 +1,60 @@
+/*
+ *  Self-announce
+ *  (c) 2017-2019 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "net/announce.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-net.h"
+
+int64_t qemu_announce_timer_step(AnnounceTimer *timer)
+{
+    int64_t step;
+
+    step =  timer->params.initial +
+            (timer->params.rounds - timer->round - 1) *
+            timer->params.step;
+
+    if (step < 0 || step > timer->params.max) {
+        step = timer->params.max;
+    }
+    timer_mod(timer->tm, qemu_clock_get_ms(timer->type) + step);
+
+    return step;
+}
+
+void qemu_announce_timer_del(AnnounceTimer *timer)
+{
+    if (timer->tm) {
+        timer_del(timer->tm);
+        timer_free(timer->tm);
+        timer->tm = NULL;
+    }
+}
+
+/*
+ * Under BQL/main thread
+ * Reset the timer to the given parameters/type/notifier.
+ */
+void qemu_announce_timer_reset(AnnounceTimer *timer,
+                               AnnounceParameters *params,
+                               QEMUClockType type,
+                               QEMUTimerCB *cb,
+                               void *opaque)
+{
+    /*
+     * We're under the BQL, so the current timer can't
+     * be firing, so we should be able to delete it.
+     */
+    qemu_announce_timer_del(timer);
+
+    QAPI_CLONE_MEMBERS(AnnounceParameters, &timer->params, params);
+    timer->round = params->rounds;
+    timer->type = type;
+    timer->tm = timer_new_ms(type, cb, opaque);
+}
diff --git a/qapi/net.json b/qapi/net.json
index a1a0f39..5face0c 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -684,3 +684,26 @@
 ##
 { 'event': 'NIC_RX_FILTER_CHANGED',
   'data': { '*name': 'str', 'path': 'str' } }
+
+##
+# @AnnounceParameters:
+#
+# Parameters for self-announce timers
+#
+# @initial: Initial delay (in ms) before sending the first GARP/RARP
+#       announcement
+#
+# @max: Maximum delay (in ms) between GARP/RARP announcement packets
+#
+# @rounds: Number of self-announcement attempts
+#
+# @step: Delay increase (in ms) after each self-announcement attempt
+#
+# Since: 4.0
+##
+
+{ 'struct': 'AnnounceParameters',
+  'data': { 'initial': 'int',
+            'max': 'int',
+            'rounds': 'int',
+            'step': 'int' } }
-- 
2.5.0
