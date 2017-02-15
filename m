Received: from eggs.gnu.org ([2001:4830:134:3::10]:58918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ce3KX-0000oV-5A
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ce3KV-0006Tb-S7
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:25:25 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:2693)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ce3KV-0006TU-J6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:25:23 -0500
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Wed, 15 Feb 2017 17:23:49 +0000
Message-ID: <1487179434-13306-4-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1487179434-13306-1-git-send-email-yongbok.kim@imgtec.com>
References: <1487179434-13306-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 3/8] hw/mips_gic: Update pin state on mask
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <paul.burton@imgtec.com>

From: Paul Burton <paul.burton@imgtec.com>

If the GIC interrupt mask is changed by a write to the smask (set mask)
or rmask (reset mask) registers, we need to re-evaluate the state of the
pins/IRQs fed to the CPU. Without doing so we risk leaving a pin high
despite the interrupt that led to that state being masked, or losing
interrupts if an already pending interrupt is unmasked.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Leon Alrae <leon.alrae@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/intc/mips_gic.c | 56 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 6e25773..15e6e40 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -20,31 +20,29 @@
 #include "kvm_mips.h"
 #include "hw/intc/mips_gic.h"
 
-static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin, int level)
+static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin)
 {
-    int ored_level = level;
+    int ored_level = 0;
     int i;
 
     /* ORing pending registers sharing same pin */
-    if (!ored_level) {
-        for (i = 0; i < gic->num_irq; i++) {
-            if ((gic->irq_state[i].map_pin & GIC_MAP_MSK) == pin &&
-                    gic->irq_state[i].map_vp == vp &&
-                    gic->irq_state[i].enabled) {
-                ored_level |= gic->irq_state[i].pending;
-            }
-            if (ored_level) {
-                /* no need to iterate all interrupts */
-                break;
-            }
+    for (i = 0; i < gic->num_irq; i++) {
+        if ((gic->irq_state[i].map_pin & GIC_MAP_MSK) == pin &&
+                gic->irq_state[i].map_vp == vp &&
+                gic->irq_state[i].enabled) {
+            ored_level |= gic->irq_state[i].pending;
         }
-        if (((gic->vps[vp].compare_map & GIC_MAP_MSK) == pin) &&
-                (gic->vps[vp].mask & GIC_VP_MASK_CMP_MSK)) {
-            /* ORing with local pending register (count/compare) */
-            ored_level |= (gic->vps[vp].pend & GIC_VP_MASK_CMP_MSK) >>
-                          GIC_VP_MASK_CMP_SHF;
+        if (ored_level) {
+            /* no need to iterate all interrupts */
+            break;
         }
     }
+    if (((gic->vps[vp].compare_map & GIC_MAP_MSK) == pin) &&
+            (gic->vps[vp].mask & GIC_VP_MASK_CMP_MSK)) {
+        /* ORing with local pending register (count/compare) */
+        ored_level |= (gic->vps[vp].pend & GIC_VP_MASK_CMP_MSK) >>
+                      GIC_VP_MASK_CMP_SHF;
+    }
     if (kvm_enabled())  {
         kvm_mips_set_ipi_interrupt(mips_env_get_cpu(gic->vps[vp].env),
                                    pin + GIC_CPU_PIN_OFFSET,
@@ -55,21 +53,27 @@ static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin, int level)
     }
 }
 
-static void gic_set_irq(void *opaque, int n_IRQ, int level)
+static void gic_update_pin_for_irq(MIPSGICState *gic, int n_IRQ)
 {
-    MIPSGICState *gic = (MIPSGICState *) opaque;
     int vp = gic->irq_state[n_IRQ].map_vp;
     int pin = gic->irq_state[n_IRQ].map_pin & GIC_MAP_MSK;
 
+    if (vp < 0 || vp >= gic->num_vps) {
+        return;
+    }
+    mips_gic_set_vp_irq(gic, vp, pin);
+}
+
+static void gic_set_irq(void *opaque, int n_IRQ, int level)
+{
+    MIPSGICState *gic = (MIPSGICState *) opaque;
+
     gic->irq_state[n_IRQ].pending = (uint8_t) level;
     if (!gic->irq_state[n_IRQ].enabled) {
         /* GIC interrupt source disabled */
         return;
     }
-    if (vp < 0 || vp >= gic->num_vps) {
-        return;
-    }
-    mips_gic_set_vp_irq(gic, vp, pin, level);
+    gic_update_pin_for_irq(gic, n_IRQ);
 }
 
 #define OFFSET_CHECK(c)                         \
@@ -209,7 +213,7 @@ static void gic_timer_store_vp_compare(MIPSGICState *gic, uint32_t vp_index,
     gic->vps[vp_index].pend &= ~(1 << GIC_LOCAL_INT_COMPARE);
     if (gic->vps[vp_index].compare_map & GIC_MAP_TO_PIN_MSK) {
         uint32_t pin = (gic->vps[vp_index].compare_map & GIC_MAP_MSK);
-        mips_gic_set_vp_irq(gic, vp_index, pin, 0);
+        mips_gic_set_vp_irq(gic, vp_index, pin);
     }
     mips_gictimer_store_vp_compare(gic->gic_timer, vp_index, compare);
 }
@@ -286,6 +290,7 @@ static void gic_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
         OFFSET_CHECK((base + size * 8) <= gic->num_irq);
         for (i = 0; i < size * 8; i++) {
             gic->irq_state[base + i].enabled &= !((data >> i) & 1);
+            gic_update_pin_for_irq(gic, base + i);
         }
         break;
     case GIC_SH_WEDGE_OFS:
@@ -305,6 +310,7 @@ static void gic_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
         OFFSET_CHECK((base + size * 8) <= gic->num_irq);
         for (i = 0; i < size * 8; i++) {
             gic->irq_state[base + i].enabled |= (data >> i) & 1;
+            gic_update_pin_for_irq(gic, base + i);
         }
         break;
     case GIC_SH_MAP0_PIN_OFS ... GIC_SH_MAP255_PIN_OFS:
-- 
2.7.4
