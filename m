Received: from eggs.gnu.org ([2001:4830:134:3::10]:45553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYAa-0007t5-4q
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYAT-00009W-Sq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:25:04 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41446)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYAT-00009F-Fd
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:24:57 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:24:58 +0300
Message-ID: <20180111082458.27295.43885.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v3 01/30] hpet: recover timer offset
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

HPET saves its state by calculating the current time and recovers timer
offset using this calculated value. But these calculations include
divisions and multiplications. Therefore the timer state cannot be recovered
precise enough.
This patch introduces saving of the original value of the offset to
preserve the determinism of the timer.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>

--
v3: Added compat property for correct migration.
---
 hw/timer/hpet.c     |   30 ++++++++++++++++++++++++++++--
 include/hw/compat.h |    6 +++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 577371b..d97436b 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -70,6 +70,7 @@ typedef struct HPETState {
 
     MemoryRegion iomem;
     uint64_t hpet_offset;
+    bool hpet_offset_saved;
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
@@ -252,7 +255,10 @@ static int hpet_post_load(void *opaque, int version_id)
     HPETState *s = opaque;
 
     /* Recalculate the offset between the main counter and guest time */
-    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    if (!s->hpet_offset_saved) {
+        s->hpet_offset = ticks_to_ns(s->hpet_counter)
+                        - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
 
     /* Push number of timers into capability returned via HPET_ID */
     s->capability &= ~HPET_ID_NUM_TIM_MASK;
@@ -267,6 +273,13 @@ static int hpet_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static bool hpet_offset_needed(void *opaque)
+{
+    HPETState *s = opaque;
+
+    return hpet_enabled(s) && s->hpet_offset_saved;
+}
+
 static bool hpet_rtc_irq_level_needed(void *opaque)
 {
     HPETState *s = opaque;
@@ -285,6 +298,17 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level = {
     }
 };
 
+static const VMStateDescription vmstate_hpet_offset = {
+    .name = "hpet/offset",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hpet_offset_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(hpet_offset, HPETState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_hpet_timer = {
     .name = "hpet_timer",
     .version_id = 1,
@@ -320,6 +344,7 @@ static const VMStateDescription vmstate_hpet = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_hpet_rtc_irq_level,
+        &vmstate_hpet_offset,
         NULL
     }
 };
@@ -762,6 +787,7 @@ static Property hpet_device_properties[] = {
     DEFINE_PROP_UINT8("timers", HPETState, num_timers, HPET_MIN_TIMERS),
     DEFINE_PROP_BIT("msi", HPETState, flags, HPET_MSI_SUPPORT, false),
     DEFINE_PROP_UINT32(HPET_INTCAP, HPETState, intcap, 0),
+    DEFINE_PROP_BOOL("hpet-offset-saved", HPETState, hpet_offset_saved, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 263de97..7f31850 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,11 @@
 #define HW_COMPAT_H
 
 #define HW_COMPAT_2_11 \
-    /* empty */
+    {\
+        .driver   = "hpet",\
+        .property = "hpet-offset-saved",\
+        .value    = "false",\
+    },
 
 #define HW_COMPAT_2_10 \
     {\
