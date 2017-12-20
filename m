Received: from eggs.gnu.org ([2001:4830:134:3::10]:33470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eRbCU-0002Z7-B2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eRbCQ-0007Nm-11
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:02:10 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57688)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eRbCP-0007N6-P9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:02:05 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 20 Dec 2017 13:02:05 +0300
Message-ID: <20171220100205.16625.84632.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, mst@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com

HPET saves its state by calculating the current time and recovers timer
offset using this calculated value. But these calculations include
divisions and multiplications. Therefore the timer state cannot be recovered
precise enough.
This patch introduces saving of the original value of the offset to
preserve the determinism of the timer.

Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 hw/timer/hpet.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 577371b..4904a60 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -70,6 +70,7 @@ typedef struct HPETState {
 
     MemoryRegion iomem;
     uint64_t hpet_offset;
+    bool hpet_offset_loaded;
     qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
     uint32_t flags;
     uint8_t rtc_irq_level;
@@ -221,7 +222,9 @@ static int hpet_pre_save(void *opaque)
     HPETState *s = opaque;
 
     /* save current counter value */
-    s->hpet_counter = hpet_get_ticks(s);
+    if (hpet_enabled(s)) {
+        s->hpet_counter = hpet_get_ticks(s);
+    }
 
     return 0;
 }
@@ -232,6 +235,8 @@ static int hpet_pre_load(void *opaque)
 
     /* version 1 only supports 3, later versions will load the actual value */
     s->num_timers = HPET_MIN_TIMERS;
+    /* for checking whether the hpet_offset section is loaded */
+    s->hpet_offset_loaded = false;
     return 0;
 }
 
@@ -252,7 +257,10 @@ static int hpet_post_load(void *opaque, int version_id)
     HPETState *s = opaque;
 
     /* Recalculate the offset between the main counter and guest time */
-    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    if (!s->hpet_offset_loaded) {
+        s->hpet_offset = ticks_to_ns(s->hpet_counter)
+                        - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
 
     /* Push number of timers into capability returned via HPET_ID */
     s->capability &= ~HPET_ID_NUM_TIM_MASK;
@@ -267,6 +275,14 @@ static int hpet_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static int hpet_offset_post_load(void *opaque, int version_id)
+{
+    HPETState *s = opaque;
+
+    s->hpet_offset_loaded = true;
+    return 0;
+}
+
 static bool hpet_rtc_irq_level_needed(void *opaque)
 {
     HPETState *s = opaque;
@@ -285,6 +301,17 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level = {
     }
 };
 
+static const VMStateDescription vmstate_hpet_offset = {
+    .name = "hpet/offset",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = hpet_offset_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(hpet_offset, HPETState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_hpet_timer = {
     .name = "hpet_timer",
     .version_id = 1,
@@ -320,6 +347,7 @@ static const VMStateDescription vmstate_hpet = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_hpet_rtc_irq_level,
+        &vmstate_hpet_offset,
         NULL
     }
 };
