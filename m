Received: from eggs.gnu.org ([2001:4830:134:3::10]:40885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eRZGT-0003dC-Qo
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eRZGQ-0001gk-J6
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:58:09 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45036)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eRZGQ-0001f8-9e
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:58:06 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 20 Dec 2017 10:58:04 +0300
Message-ID: <20171220075804.15036.93598.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [ PATCH  ] hpet: recover timer offset correctly
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
 hw/timer/hpet.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 577371b..4cf6a5b 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -221,7 +221,9 @@ static int hpet_pre_save(void *opaque)
     HPETState *s = opaque;
 
     /* save current counter value */
-    s->hpet_counter = hpet_get_ticks(s);
+    if (hpet_enabled(s)) {
+        s->hpet_counter = hpet_get_ticks(s);
+    }
 
     return 0;
 }
@@ -252,7 +254,10 @@ static int hpet_post_load(void *opaque, int version_id)
     HPETState *s = opaque;
 
     /* Recalculate the offset between the main counter and guest time */
-    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    if (version_id <= 2) {
+        s->hpet_offset = ticks_to_ns(s->hpet_counter)
+                        - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
 
     /* Push number of timers into capability returned via HPET_ID */
     s->capability &= ~HPET_ID_NUM_TIM_MASK;
@@ -303,7 +308,7 @@ static const VMStateDescription vmstate_hpet_timer = {
 
 static const VMStateDescription vmstate_hpet = {
     .name = "hpet",
-    .version_id = 2,
+    .version_id = 3,
     .minimum_version_id = 1,
     .pre_save = hpet_pre_save,
     .pre_load = hpet_pre_load,
@@ -312,6 +317,7 @@ static const VMStateDescription vmstate_hpet = {
         VMSTATE_UINT64(config, HPETState),
         VMSTATE_UINT64(isr, HPETState),
         VMSTATE_UINT64(hpet_counter, HPETState),
+        VMSTATE_UINT64_V(hpet_offset, HPETState, 3),
         VMSTATE_UINT8_V(num_timers, HPETState, 2),
         VMSTATE_VALIDATE("num_timers in range", hpet_validate_num_timers),
         VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
