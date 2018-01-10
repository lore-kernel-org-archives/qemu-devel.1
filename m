Received: from eggs.gnu.org ([2001:4830:134:3::10]:54611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZCl3-0007Vm-U7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZCkz-00067d-1Y
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:33:17 -0500
Received: from mail.ispras.ru ([83.149.199.45]:32794)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZCky-00064g-LF
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:33:12 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171220100205.16625.84632.stgit@pasha-VirtualBox>	<003c01d38923$1c5157f0$54f407d0$@ru>
	<87efmz1ddp.fsf@secure.laptop>	<004301d38940$56013bb0$0203b310$@ru>
	<87zi5nyyap.fsf@secure.laptop>
In-Reply-To: <87zi5nyyap.fsf@secure.laptop>
Date: Wed, 10 Jan 2018 12:33:11 +0300
Message-ID: <001601d389f6$0816d2f0$184478d0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v2] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, mst@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

> From: Juan Quintela [mailto:quintela@redhat.com]
> "Pavel Dovgalyuk" <dovgaluk@ispras.ru> wrote:
> >> From: Juan Quintela [mailto:quintela@redhat.com]
> If you *don't* use a needed function then please just increase the
> version.  You are just breaking compatibility anyways.  The whole point
> of subsections is that they are optional.  If they are mandatory (this
> case), then they bring no advantage at all.

Thanks, I thought that the sections are skipped automatically when there is no code for loading
them.

> What dave is asked for your previous version is that you disable the
> section for old machine types.  Look at how to use DEFINE_PROP_* for
> this use case.

How do you like this one?

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 577371b..539586f 100644
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
-    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOC
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
+    return s->hpet_offset_saved;
+}
+
 static bool hpet_rtc_irq_level_needed(void *opaque)
 {
     HPETState *s = opaque;
@@ -285,6 +298,17 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level 
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
index 263de97..8897302 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -13,6 +13,10 @@
         .driver   = "virtio-tablet-device",\
         .property = "wheel-axis",\
         .value    = "false",\
+    },{\
+        .driver   = "hpet",\
+        .property = "hpet-offset-saved",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_9 \

Pavel Dovgalyuk
