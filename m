Received: from eggs.gnu.org ([2001:4830:134:3::10]:38217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fVCzM-0005VI-EZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fVCzJ-0006KJ-EX
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:31:48 -0400
From: luc.michel@greensocs.com
Date: Tue, 19 Jun 2018 11:31:18 +0200
Message-Id: <20180619093124.24011-2-luc.michel@greensocs.com>
In-Reply-To: <20180619093124.24011-1-luc.michel@greensocs.com>
References: <20180619093124.24011-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/7] intc/arm_gic: Refactor operations on
 the distributor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

From: Luc MICHEL <luc.michel@greensocs.com>

In preparation for the virtualization extensions implementation,
refactor the name of the functions and macros that act on the GIC
distributor to make that fact explicit. It will be useful to
differentiate them from the ones that will act on the virtual
interfaces.

Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c        | 164 ++++++++++++++++++++-------------------
 hw/intc/arm_gic_common.c |   6 +-
 hw/intc/arm_gic_kvm.c    |  23 +++---
 hw/intc/gic_internal.h   |  51 ++++++------
 4 files changed, 127 insertions(+), 117 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index ea0323f969..141f3e7a48 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -92,11 +92,12 @@ void gic_update(GICState *s)
         best_prio =3D 0x100;
         best_irq =3D 1023;
         for (irq =3D 0; irq < s->num_irq; irq++) {
-            if (GIC_TEST_ENABLED(irq, cm) && gic_test_pending(s, irq, cm=
) &&
-                (!GIC_TEST_ACTIVE(irq, cm)) &&
-                (irq < GIC_INTERNAL || GIC_TARGET(irq) & cm)) {
-                if (GIC_GET_PRIORITY(irq, cpu) < best_prio) {
-                    best_prio =3D GIC_GET_PRIORITY(irq, cpu);
+            if (GIC_DIST_TEST_ENABLED(irq, cm) &&
+                gic_test_pending(s, irq, cm) &&
+                (!GIC_DIST_TEST_ACTIVE(irq, cm)) &&
+                (irq < GIC_INTERNAL || GIC_DIST_TARGET(irq) & cm)) {
+                if (GIC_DIST_GET_PRIORITY(irq, cpu) < best_prio) {
+                    best_prio =3D GIC_DIST_GET_PRIORITY(irq, cpu);
                     best_irq =3D irq;
                 }
             }
@@ -112,7 +113,7 @@ void gic_update(GICState *s)
         if (best_prio < s->priority_mask[cpu]) {
             s->current_pending[cpu] =3D best_irq;
             if (best_prio < s->running_priority[cpu]) {
-                int group =3D GIC_TEST_GROUP(best_irq, cm);
+                int group =3D GIC_DIST_TEST_GROUP(best_irq, cm);
=20
                 if (extract32(s->ctlr, group, 1) &&
                     extract32(s->cpu_ctlr[cpu], group, 1)) {
@@ -145,7 +146,7 @@ void gic_set_pending_private(GICState *s, int cpu, in=
t irq)
     }
=20
     DPRINTF("Set %d pending cpu %d\n", irq, cpu);
-    GIC_SET_PENDING(irq, cm);
+    GIC_DIST_SET_PENDING(irq, cm);
     gic_update(s);
 }
=20
@@ -153,13 +154,13 @@ static void gic_set_irq_11mpcore(GICState *s, int i=
rq, int level,
                                  int cm, int target)
 {
     if (level) {
-        GIC_SET_LEVEL(irq, cm);
-        if (GIC_TEST_EDGE_TRIGGER(irq) || GIC_TEST_ENABLED(irq, cm)) {
+        GIC_DIST_SET_LEVEL(irq, cm);
+        if (GIC_DIST_TEST_EDGE_TRIGGER(irq) || GIC_DIST_TEST_ENABLED(irq=
, cm)) {
             DPRINTF("Set %d pending mask %x\n", irq, target);
-            GIC_SET_PENDING(irq, target);
+            GIC_DIST_SET_PENDING(irq, target);
         }
     } else {
-        GIC_CLEAR_LEVEL(irq, cm);
+        GIC_DIST_CLEAR_LEVEL(irq, cm);
     }
 }
=20
@@ -167,13 +168,13 @@ static void gic_set_irq_generic(GICState *s, int ir=
q, int level,
                                 int cm, int target)
 {
     if (level) {
-        GIC_SET_LEVEL(irq, cm);
+        GIC_DIST_SET_LEVEL(irq, cm);
         DPRINTF("Set %d pending mask %x\n", irq, target);
-        if (GIC_TEST_EDGE_TRIGGER(irq)) {
-            GIC_SET_PENDING(irq, target);
+        if (GIC_DIST_TEST_EDGE_TRIGGER(irq)) {
+            GIC_DIST_SET_PENDING(irq, target);
         }
     } else {
-        GIC_CLEAR_LEVEL(irq, cm);
+        GIC_DIST_CLEAR_LEVEL(irq, cm);
     }
 }
=20
@@ -192,7 +193,7 @@ static void gic_set_irq(void *opaque, int irq, int le=
vel)
         /* The first external input line is internal interrupt 32.  */
         cm =3D ALL_CPU_MASK;
         irq +=3D GIC_INTERNAL;
-        target =3D GIC_TARGET(irq);
+        target =3D GIC_DIST_TARGET(irq);
     } else {
         int cpu;
         irq -=3D (s->num_irq - GIC_INTERNAL);
@@ -204,7 +205,7 @@ static void gic_set_irq(void *opaque, int irq, int le=
vel)
=20
     assert(irq >=3D GIC_NR_SGIS);
=20
-    if (level =3D=3D GIC_TEST_LEVEL(irq, cm)) {
+    if (level =3D=3D GIC_DIST_TEST_LEVEL(irq, cm)) {
         return;
     }
=20
@@ -224,7 +225,7 @@ static uint16_t gic_get_current_pending_irq(GICState =
*s, int cpu,
     uint16_t pending_irq =3D s->current_pending[cpu];
=20
     if (pending_irq < GIC_MAXIRQ && gic_has_groups(s)) {
-        int group =3D GIC_TEST_GROUP(pending_irq, (1 << cpu));
+        int group =3D GIC_DIST_TEST_GROUP(pending_irq, (1 << cpu));
         /* On a GIC without the security extensions, reading this regist=
er
          * behaves in the same way as a secure access to a GIC with them=
.
          */
@@ -255,7 +256,7 @@ static int gic_get_group_priority(GICState *s, int cp=
u, int irq)
=20
     if (gic_has_groups(s) &&
         !(s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) &&
-        GIC_TEST_GROUP(irq, (1 << cpu))) {
+        GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
         bpr =3D s->abpr[cpu] - 1;
         assert(bpr >=3D 0);
     } else {
@@ -268,7 +269,7 @@ static int gic_get_group_priority(GICState *s, int cp=
u, int irq)
      */
     mask =3D ~0U << ((bpr & 7) + 1);
=20
-    return GIC_GET_PRIORITY(irq, cpu) & mask;
+    return GIC_DIST_GET_PRIORITY(irq, cpu) & mask;
 }
=20
 static void gic_activate_irq(GICState *s, int cpu, int irq)
@@ -281,14 +282,14 @@ static void gic_activate_irq(GICState *s, int cpu, =
int irq)
     int regno =3D preemption_level / 32;
     int bitno =3D preemption_level % 32;
=20
-    if (gic_has_groups(s) && GIC_TEST_GROUP(irq, (1 << cpu))) {
+    if (gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
         s->nsapr[regno][cpu] |=3D (1 << bitno);
     } else {
         s->apr[regno][cpu] |=3D (1 << bitno);
     }
=20
     s->running_priority[cpu] =3D prio;
-    GIC_SET_ACTIVE(irq, 1 << cpu);
+    GIC_DIST_SET_ACTIVE(irq, 1 << cpu);
 }
=20
 static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
@@ -357,7 +358,7 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, Me=
mTxAttrs attrs)
         return irq;
     }
=20
-    if (GIC_GET_PRIORITY(irq, cpu) >=3D s->running_priority[cpu]) {
+    if (GIC_DIST_GET_PRIORITY(irq, cpu) >=3D s->running_priority[cpu]) {
         DPRINTF("ACK, pending interrupt (%d) has insufficient priority\n=
", irq);
         return 1023;
     }
@@ -366,7 +367,8 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, Me=
mTxAttrs attrs)
         /* Clear pending flags for both level and edge triggered interru=
pts.
          * Level triggered IRQs will be reasserted once they become inac=
tive.
          */
-        GIC_CLEAR_PENDING(irq, GIC_TEST_MODEL(irq) ? ALL_CPU_MASK : cm);
+        GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_M=
ASK
+                                                             : cm);
         ret =3D irq;
     } else {
         if (irq < GIC_NR_SGIS) {
@@ -378,7 +380,9 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, Me=
mTxAttrs attrs)
             src =3D ctz32(s->sgi_pending[irq][cpu]);
             s->sgi_pending[irq][cpu] &=3D ~(1 << src);
             if (s->sgi_pending[irq][cpu] =3D=3D 0) {
-                GIC_CLEAR_PENDING(irq, GIC_TEST_MODEL(irq) ? ALL_CPU_MAS=
K : cm);
+                GIC_DIST_CLEAR_PENDING(irq,
+                                       GIC_DIST_TEST_MODEL(irq) ? ALL_CP=
U_MASK
+                                                                : cm);
             }
             ret =3D irq | ((src & 0x7) << 10);
         } else {
@@ -386,7 +390,8 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, Me=
mTxAttrs attrs)
              * interrupts. (level triggered interrupts with an active li=
ne
              * remain pending, see gic_test_pending)
              */
-            GIC_CLEAR_PENDING(irq, GIC_TEST_MODEL(irq) ? ALL_CPU_MASK : =
cm);
+            GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_C=
PU_MASK
+                                                                 : cm);
             ret =3D irq;
         }
     }
@@ -397,11 +402,11 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, =
MemTxAttrs attrs)
     return ret;
 }
=20
-void gic_set_priority(GICState *s, int cpu, int irq, uint8_t val,
+void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
                       MemTxAttrs attrs)
 {
     if (s->security_extn && !attrs.secure) {
-        if (!GIC_TEST_GROUP(irq, (1 << cpu))) {
+        if (!GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
             return; /* Ignore Non-secure access of Group0 IRQ */
         }
         val =3D 0x80 | (val >> 1); /* Non-secure view */
@@ -414,13 +419,13 @@ void gic_set_priority(GICState *s, int cpu, int irq=
, uint8_t val,
     }
 }
=20
-static uint32_t gic_get_priority(GICState *s, int cpu, int irq,
+static uint32_t gic_dist_get_priority(GICState *s, int cpu, int irq,
                                  MemTxAttrs attrs)
 {
-    uint32_t prio =3D GIC_GET_PRIORITY(irq, cpu);
+    uint32_t prio =3D GIC_DIST_GET_PRIORITY(irq, cpu);
=20
     if (s->security_extn && !attrs.secure) {
-        if (!GIC_TEST_GROUP(irq, (1 << cpu))) {
+        if (!GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
             return 0; /* Non-secure access cannot read priority of Group=
0 IRQ */
         }
         prio =3D (prio << 1) & 0xff; /* Non-secure view */
@@ -543,7 +548,7 @@ static bool gic_eoi_split(GICState *s, int cpu, MemTx=
Attrs attrs)
 static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs=
 attrs)
 {
     int cm =3D 1 << cpu;
-    int group =3D gic_has_groups(s) && GIC_TEST_GROUP(irq, cm);
+    int group =3D gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
=20
     if (!gic_eoi_split(s, cpu, attrs)) {
         /* This is UNPREDICTABLE; we choose to ignore it */
@@ -557,7 +562,7 @@ static void gic_deactivate_irq(GICState *s, int cpu, =
int irq, MemTxAttrs attrs)
         return;
     }
=20
-    GIC_CLEAR_ACTIVE(irq, cm);
+    GIC_DIST_CLEAR_ACTIVE(irq, cm);
 }
=20
 void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
@@ -584,14 +589,15 @@ void gic_complete_irq(GICState *s, int cpu, int irq=
, MemTxAttrs attrs)
     if (s->revision =3D=3D REV_11MPCORE) {
         /* Mark level triggered interrupts as pending if they are still
            raised.  */
-        if (!GIC_TEST_EDGE_TRIGGER(irq) && GIC_TEST_ENABLED(irq, cm)
-            && GIC_TEST_LEVEL(irq, cm) && (GIC_TARGET(irq) & cm) !=3D 0)=
 {
+        if (!GIC_DIST_TEST_EDGE_TRIGGER(irq) && GIC_DIST_TEST_ENABLED(ir=
q, cm)
+            && GIC_DIST_TEST_LEVEL(irq, cm)
+            && (GIC_DIST_TARGET(irq) & cm) !=3D 0) {
             DPRINTF("Set %d pending mask %x\n", irq, cm);
-            GIC_SET_PENDING(irq, cm);
+            GIC_DIST_SET_PENDING(irq, cm);
         }
     }
=20
-    group =3D gic_has_groups(s) && GIC_TEST_GROUP(irq, cm);
+    group =3D gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
=20
     if (s->security_extn && !attrs.secure && !group) {
         DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", irq)=
;
@@ -607,7 +613,7 @@ void gic_complete_irq(GICState *s, int cpu, int irq, =
MemTxAttrs attrs)
=20
     /* In GICv2 the guest can choose to split priority-drop and deactiva=
te */
     if (!gic_eoi_split(s, cpu, attrs)) {
-        GIC_CLEAR_ACTIVE(irq, cm);
+        GIC_DIST_CLEAR_ACTIVE(irq, cm);
     }
     gic_update(s);
 }
@@ -655,7 +661,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr o=
ffset, MemTxAttrs attrs)
                     goto bad_reg;
                 }
                 for (i =3D 0; i < 8; i++) {
-                    if (GIC_TEST_GROUP(irq + i, cm)) {
+                    if (GIC_DIST_TEST_GROUP(irq + i, cm)) {
                         res |=3D (1 << i);
                     }
                 }
@@ -675,11 +681,11 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr=
 offset, MemTxAttrs attrs)
         res =3D 0;
         for (i =3D 0; i < 8; i++) {
             if (s->security_extn && !attrs.secure &&
-                !GIC_TEST_GROUP(irq + i, 1 << cpu)) {
+                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                 continue; /* Ignore Non-secure access of Group0 IRQ */
             }
=20
-            if (GIC_TEST_ENABLED(irq + i, cm)) {
+            if (GIC_DIST_TEST_ENABLED(irq + i, cm)) {
                 res |=3D (1 << i);
             }
         }
@@ -696,7 +702,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr o=
ffset, MemTxAttrs attrs)
         mask =3D (irq < GIC_INTERNAL) ?  cm : ALL_CPU_MASK;
         for (i =3D 0; i < 8; i++) {
             if (s->security_extn && !attrs.secure &&
-                !GIC_TEST_GROUP(irq + i, 1 << cpu)) {
+                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                 continue; /* Ignore Non-secure access of Group0 IRQ */
             }
=20
@@ -713,11 +719,11 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr=
 offset, MemTxAttrs attrs)
         mask =3D (irq < GIC_INTERNAL) ?  cm : ALL_CPU_MASK;
         for (i =3D 0; i < 8; i++) {
             if (s->security_extn && !attrs.secure &&
-                !GIC_TEST_GROUP(irq + i, 1 << cpu)) {
+                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                 continue; /* Ignore Non-secure access of Group0 IRQ */
             }
=20
-            if (GIC_TEST_ACTIVE(irq + i, mask)) {
+            if (GIC_DIST_TEST_ACTIVE(irq + i, mask)) {
                 res |=3D (1 << i);
             }
         }
@@ -726,7 +732,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr o=
ffset, MemTxAttrs attrs)
         irq =3D (offset - 0x400) + GIC_BASE_IRQ;
         if (irq >=3D s->num_irq)
             goto bad_reg;
-        res =3D gic_get_priority(s, cpu, irq, attrs);
+        res =3D gic_dist_get_priority(s, cpu, irq, attrs);
     } else if (offset < 0xc00) {
         /* Interrupt CPU Target.  */
         if (s->num_cpu =3D=3D 1 && s->revision !=3D REV_11MPCORE) {
@@ -740,7 +746,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr o=
ffset, MemTxAttrs attrs)
             if (irq >=3D 29 && irq <=3D 31) {
                 res =3D cm;
             } else {
-                res =3D GIC_TARGET(irq);
+                res =3D GIC_DIST_TARGET(irq);
             }
         }
     } else if (offset < 0xf00) {
@@ -751,14 +757,16 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr=
 offset, MemTxAttrs attrs)
         res =3D 0;
         for (i =3D 0; i < 4; i++) {
             if (s->security_extn && !attrs.secure &&
-                !GIC_TEST_GROUP(irq + i, 1 << cpu)) {
+                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                 continue; /* Ignore Non-secure access of Group0 IRQ */
             }
=20
-            if (GIC_TEST_MODEL(irq + i))
+            if (GIC_DIST_TEST_MODEL(irq + i)) {
                 res |=3D (1 << (i * 2));
-            if (GIC_TEST_EDGE_TRIGGER(irq + i))
+            }
+            if (GIC_DIST_TEST_EDGE_TRIGGER(irq + i)) {
                 res |=3D (2 << (i * 2));
+            }
         }
     } else if (offset < 0xf10) {
         goto bad_reg;
@@ -776,7 +784,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr o=
ffset, MemTxAttrs attrs)
         }
=20
         if (s->security_extn && !attrs.secure &&
-            !GIC_TEST_GROUP(irq, 1 << cpu)) {
+            !GIC_DIST_TEST_GROUP(irq, 1 << cpu)) {
             res =3D 0; /* Ignore Non-secure access of Group0 IRQ */
         } else {
             res =3D s->sgi_pending[irq][cpu];
@@ -872,10 +880,10 @@ static void gic_dist_writeb(void *opaque, hwaddr of=
fset,
                     int cm =3D (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_C=
PU_MASK;
                     if (value & (1 << i)) {
                         /* Group1 (Non-secure) */
-                        GIC_SET_GROUP(irq + i, cm);
+                        GIC_DIST_SET_GROUP(irq + i, cm);
                     } else {
                         /* Group0 (Secure) */
-                        GIC_CLEAR_GROUP(irq + i, cm);
+                        GIC_DIST_CLEAR_GROUP(irq + i, cm);
                     }
                 }
             }
@@ -893,26 +901,26 @@ static void gic_dist_writeb(void *opaque, hwaddr of=
fset,
=20
         for (i =3D 0; i < 8; i++) {
             if (value & (1 << i)) {
-                int mask =3D
-                    (irq < GIC_INTERNAL) ? (1 << cpu) : GIC_TARGET(irq +=
 i);
+                int mask =3D (irq < GIC_INTERNAL) ? (1 << cpu)
+                                                : GIC_DIST_TARGET(irq + =
i);
                 int cm =3D (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_M=
ASK;
=20
                 if (s->security_extn && !attrs.secure &&
-                    !GIC_TEST_GROUP(irq + i, 1 << cpu)) {
+                    !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                     continue; /* Ignore Non-secure access of Group0 IRQ =
*/
                 }
=20
-                if (!GIC_TEST_ENABLED(irq + i, cm)) {
+                if (!GIC_DIST_TEST_ENABLED(irq + i, cm)) {
                     DPRINTF("Enabled IRQ %d\n", irq + i);
                     trace_gic_enable_irq(irq + i);
                 }
-                GIC_SET_ENABLED(irq + i, cm);
+                GIC_DIST_SET_ENABLED(irq + i, cm);
                 /* If a raised level triggered IRQ enabled then mark
                    is as pending.  */
-                if (GIC_TEST_LEVEL(irq + i, mask)
-                        && !GIC_TEST_EDGE_TRIGGER(irq + i)) {
+                if (GIC_DIST_TEST_LEVEL(irq + i, mask)
+                        && !GIC_DIST_TEST_EDGE_TRIGGER(irq + i)) {
                     DPRINTF("Set %d pending mask %x\n", irq + i, mask);
-                    GIC_SET_PENDING(irq + i, mask);
+                    GIC_DIST_SET_PENDING(irq + i, mask);
                 }
             }
         }
@@ -930,15 +938,15 @@ static void gic_dist_writeb(void *opaque, hwaddr of=
fset,
                 int cm =3D (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_M=
ASK;
=20
                 if (s->security_extn && !attrs.secure &&
-                    !GIC_TEST_GROUP(irq + i, 1 << cpu)) {
+                    !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                     continue; /* Ignore Non-secure access of Group0 IRQ =
*/
                 }
=20
-                if (GIC_TEST_ENABLED(irq + i, cm)) {
+                if (GIC_DIST_TEST_ENABLED(irq + i, cm)) {
                     DPRINTF("Disabled IRQ %d\n", irq + i);
                     trace_gic_disable_irq(irq + i);
                 }
-                GIC_CLEAR_ENABLED(irq + i, cm);
+                GIC_DIST_CLEAR_ENABLED(irq + i, cm);
             }
         }
     } else if (offset < 0x280) {
@@ -953,11 +961,11 @@ static void gic_dist_writeb(void *opaque, hwaddr of=
fset,
         for (i =3D 0; i < 8; i++) {
             if (value & (1 << i)) {
                 if (s->security_extn && !attrs.secure &&
-                    !GIC_TEST_GROUP(irq + i, 1 << cpu)) {
+                    !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                     continue; /* Ignore Non-secure access of Group0 IRQ =
*/
                 }
=20
-                GIC_SET_PENDING(irq + i, GIC_TARGET(irq + i));
+                GIC_DIST_SET_PENDING(irq + i, GIC_DIST_TARGET(irq + i));
             }
         }
     } else if (offset < 0x300) {
@@ -971,7 +979,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offs=
et,
=20
         for (i =3D 0; i < 8; i++) {
             if (s->security_extn && !attrs.secure &&
-                !GIC_TEST_GROUP(irq + i, 1 << cpu)) {
+                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                 continue; /* Ignore Non-secure access of Group0 IRQ */
             }
=20
@@ -979,7 +987,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offs=
et,
                for per-CPU interrupts.  It's unclear whether this is the
                corect behavior.  */
             if (value & (1 << i)) {
-                GIC_CLEAR_PENDING(irq + i, ALL_CPU_MASK);
+                GIC_DIST_CLEAR_PENDING(irq + i, ALL_CPU_MASK);
             }
         }
     } else if (offset < 0x400) {
@@ -990,7 +998,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offs=
et,
         irq =3D (offset - 0x400) + GIC_BASE_IRQ;
         if (irq >=3D s->num_irq)
             goto bad_reg;
-        gic_set_priority(s, cpu, irq, value, attrs);
+        gic_dist_set_priority(s, cpu, irq, value, attrs);
     } else if (offset < 0xc00) {
         /* Interrupt CPU Target. RAZ/WI on uniprocessor GICs, with the
          * annoying exception of the 11MPCore's GIC.
@@ -1016,21 +1024,21 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
             value |=3D 0xaa;
         for (i =3D 0; i < 4; i++) {
             if (s->security_extn && !attrs.secure &&
-                !GIC_TEST_GROUP(irq + i, 1 << cpu)) {
+                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                 continue; /* Ignore Non-secure access of Group0 IRQ */
             }
=20
             if (s->revision =3D=3D REV_11MPCORE) {
                 if (value & (1 << (i * 2))) {
-                    GIC_SET_MODEL(irq + i);
+                    GIC_DIST_SET_MODEL(irq + i);
                 } else {
-                    GIC_CLEAR_MODEL(irq + i);
+                    GIC_DIST_CLEAR_MODEL(irq + i);
                 }
             }
             if (value & (2 << (i * 2))) {
-                GIC_SET_EDGE_TRIGGER(irq + i);
+                GIC_DIST_SET_EDGE_TRIGGER(irq + i);
             } else {
-                GIC_CLEAR_EDGE_TRIGGER(irq + i);
+                GIC_DIST_CLEAR_EDGE_TRIGGER(irq + i);
             }
         }
     } else if (offset < 0xf10) {
@@ -1044,10 +1052,10 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
         irq =3D (offset - 0xf10);
=20
         if (!s->security_extn || attrs.secure ||
-            GIC_TEST_GROUP(irq, 1 << cpu)) {
+            GIC_DIST_TEST_GROUP(irq, 1 << cpu)) {
             s->sgi_pending[irq][cpu] &=3D ~value;
             if (s->sgi_pending[irq][cpu] =3D=3D 0) {
-                GIC_CLEAR_PENDING(irq, 1 << cpu);
+                GIC_DIST_CLEAR_PENDING(irq, 1 << cpu);
             }
         }
     } else if (offset < 0xf30) {
@@ -1058,8 +1066,8 @@ static void gic_dist_writeb(void *opaque, hwaddr of=
fset,
         irq =3D (offset - 0xf20);
=20
         if (!s->security_extn || attrs.secure ||
-            GIC_TEST_GROUP(irq, 1 << cpu)) {
-            GIC_SET_PENDING(irq, 1 << cpu);
+            GIC_DIST_TEST_GROUP(irq, 1 << cpu)) {
+            GIC_DIST_SET_PENDING(irq, 1 << cpu);
             s->sgi_pending[irq][cpu] |=3D value;
         }
     } else {
@@ -1106,7 +1114,7 @@ static void gic_dist_writel(void *opaque, hwaddr of=
fset,
             mask =3D ALL_CPU_MASK;
             break;
         }
-        GIC_SET_PENDING(irq, mask);
+        GIC_DIST_SET_PENDING(irq, mask);
         target_cpu =3D ctz32(mask);
         while (target_cpu < GIC_NCPU) {
             s->sgi_pending[irq][target_cpu] |=3D (1 << cpu);
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index aee50a20e0..295ee9cc5e 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -204,8 +204,8 @@ static void arm_gic_common_reset(DeviceState *dev)
         }
     }
     for (i =3D 0; i < GIC_NR_SGIS; i++) {
-        GIC_SET_ENABLED(i, ALL_CPU_MASK);
-        GIC_SET_EDGE_TRIGGER(i);
+        GIC_DIST_SET_ENABLED(i, ALL_CPU_MASK);
+        GIC_DIST_SET_EDGE_TRIGGER(i);
     }
=20
     for (i =3D 0; i < ARRAY_SIZE(s->priority2); i++) {
@@ -222,7 +222,7 @@ static void arm_gic_common_reset(DeviceState *dev)
     }
     if (s->security_extn && s->irq_reset_nonsecure) {
         for (i =3D 0; i < GIC_MAXIRQ; i++) {
-            GIC_SET_GROUP(i, ALL_CPU_MASK);
+            GIC_DIST_SET_GROUP(i, ALL_CPU_MASK);
         }
     }
=20
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 204369d0e2..799136732a 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -140,10 +140,10 @@ static void translate_group(GICState *s, int irq, i=
nt cpu,
     int cm =3D (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_MASK;
=20
     if (to_kernel) {
-        *field =3D GIC_TEST_GROUP(irq, cm);
+        *field =3D GIC_DIST_TEST_GROUP(irq, cm);
     } else {
         if (*field & 1) {
-            GIC_SET_GROUP(irq, cm);
+            GIC_DIST_SET_GROUP(irq, cm);
         }
     }
 }
@@ -154,10 +154,10 @@ static void translate_enabled(GICState *s, int irq,=
 int cpu,
     int cm =3D (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_MASK;
=20
     if (to_kernel) {
-        *field =3D GIC_TEST_ENABLED(irq, cm);
+        *field =3D GIC_DIST_TEST_ENABLED(irq, cm);
     } else {
         if (*field & 1) {
-            GIC_SET_ENABLED(irq, cm);
+            GIC_DIST_SET_ENABLED(irq, cm);
         }
     }
 }
@@ -171,7 +171,7 @@ static void translate_pending(GICState *s, int irq, i=
nt cpu,
         *field =3D gic_test_pending(s, irq, cm);
     } else {
         if (*field & 1) {
-            GIC_SET_PENDING(irq, cm);
+            GIC_DIST_SET_PENDING(irq, cm);
             /* TODO: Capture is level-line is held high in the kernel */
         }
     }
@@ -183,10 +183,10 @@ static void translate_active(GICState *s, int irq, =
int cpu,
     int cm =3D (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_MASK;
=20
     if (to_kernel) {
-        *field =3D GIC_TEST_ACTIVE(irq, cm);
+        *field =3D GIC_DIST_TEST_ACTIVE(irq, cm);
     } else {
         if (*field & 1) {
-            GIC_SET_ACTIVE(irq, cm);
+            GIC_DIST_SET_ACTIVE(irq, cm);
         }
     }
 }
@@ -195,10 +195,10 @@ static void translate_trigger(GICState *s, int irq,=
 int cpu,
                               uint32_t *field, bool to_kernel)
 {
     if (to_kernel) {
-        *field =3D (GIC_TEST_EDGE_TRIGGER(irq)) ? 0x2 : 0x0;
+        *field =3D (GIC_DIST_TEST_EDGE_TRIGGER(irq)) ? 0x2 : 0x0;
     } else {
         if (*field & 0x2) {
-            GIC_SET_EDGE_TRIGGER(irq);
+            GIC_DIST_SET_EDGE_TRIGGER(irq);
         }
     }
 }
@@ -207,9 +207,10 @@ static void translate_priority(GICState *s, int irq,=
 int cpu,
                                uint32_t *field, bool to_kernel)
 {
     if (to_kernel) {
-        *field =3D GIC_GET_PRIORITY(irq, cpu) & 0xff;
+        *field =3D GIC_DIST_GET_PRIORITY(irq, cpu) & 0xff;
     } else {
-        gic_set_priority(s, cpu, irq, *field & 0xff, MEMTXATTRS_UNSPECIF=
IED);
+        gic_dist_set_priority(s, cpu, irq,
+                              *field & 0xff, MEMTXATTRS_UNSPECIFIED);
     }
 }
=20
diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index 7fe87b13de..6f8d242904 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -27,30 +27,31 @@
=20
 #define GIC_BASE_IRQ 0
=20
-#define GIC_SET_ENABLED(irq, cm) s->irq_state[irq].enabled |=3D (cm)
-#define GIC_CLEAR_ENABLED(irq, cm) s->irq_state[irq].enabled &=3D ~(cm)
-#define GIC_TEST_ENABLED(irq, cm) ((s->irq_state[irq].enabled & (cm)) !=3D=
 0)
-#define GIC_SET_PENDING(irq, cm) s->irq_state[irq].pending |=3D (cm)
-#define GIC_CLEAR_PENDING(irq, cm) s->irq_state[irq].pending &=3D ~(cm)
-#define GIC_SET_ACTIVE(irq, cm) s->irq_state[irq].active |=3D (cm)
-#define GIC_CLEAR_ACTIVE(irq, cm) s->irq_state[irq].active &=3D ~(cm)
-#define GIC_TEST_ACTIVE(irq, cm) ((s->irq_state[irq].active & (cm)) !=3D=
 0)
-#define GIC_SET_MODEL(irq) s->irq_state[irq].model =3D true
-#define GIC_CLEAR_MODEL(irq) s->irq_state[irq].model =3D false
-#define GIC_TEST_MODEL(irq) s->irq_state[irq].model
-#define GIC_SET_LEVEL(irq, cm) s->irq_state[irq].level |=3D (cm)
-#define GIC_CLEAR_LEVEL(irq, cm) s->irq_state[irq].level &=3D ~(cm)
-#define GIC_TEST_LEVEL(irq, cm) ((s->irq_state[irq].level & (cm)) !=3D 0=
)
-#define GIC_SET_EDGE_TRIGGER(irq) s->irq_state[irq].edge_trigger =3D tru=
e
-#define GIC_CLEAR_EDGE_TRIGGER(irq) s->irq_state[irq].edge_trigger =3D f=
alse
-#define GIC_TEST_EDGE_TRIGGER(irq) (s->irq_state[irq].edge_trigger)
-#define GIC_GET_PRIORITY(irq, cpu) (((irq) < GIC_INTERNAL) ?            =
\
+#define GIC_DIST_SET_ENABLED(irq, cm) (s->irq_state[irq].enabled |=3D (c=
m))
+#define GIC_DIST_CLEAR_ENABLED(irq, cm) (s->irq_state[irq].enabled &=3D =
~(cm))
+#define GIC_DIST_TEST_ENABLED(irq, cm) ((s->irq_state[irq].enabled & (cm=
)) !=3D 0)
+#define GIC_DIST_SET_PENDING(irq, cm) (s->irq_state[irq].pending |=3D (c=
m))
+#define GIC_DIST_CLEAR_PENDING(irq, cm) (s->irq_state[irq].pending &=3D =
~(cm))
+#define GIC_DIST_SET_ACTIVE(irq, cm) (s->irq_state[irq].active |=3D (cm)=
)
+#define GIC_DIST_CLEAR_ACTIVE(irq, cm) (s->irq_state[irq].active &=3D ~(=
cm))
+#define GIC_DIST_TEST_ACTIVE(irq, cm) ((s->irq_state[irq].active & (cm))=
 !=3D 0)
+#define GIC_DIST_SET_MODEL(irq) (s->irq_state[irq].model =3D true)
+#define GIC_DIST_CLEAR_MODEL(irq) (s->irq_state[irq].model =3D false)
+#define GIC_DIST_TEST_MODEL(irq) (s->irq_state[irq].model)
+#define GIC_DIST_SET_LEVEL(irq, cm) (s->irq_state[irq].level |=3D (cm))
+#define GIC_DIST_CLEAR_LEVEL(irq, cm) (s->irq_state[irq].level &=3D ~(cm=
))
+#define GIC_DIST_TEST_LEVEL(irq, cm) ((s->irq_state[irq].level & (cm)) !=
=3D 0)
+#define GIC_DIST_SET_EDGE_TRIGGER(irq) (s->irq_state[irq].edge_trigger =3D=
 true)
+#define GIC_DIST_CLEAR_EDGE_TRIGGER(irq) \
+    (s->irq_state[irq].edge_trigger =3D false)
+#define GIC_DIST_TEST_EDGE_TRIGGER(irq) (s->irq_state[irq].edge_trigger)
+#define GIC_DIST_GET_PRIORITY(irq, cpu) (((irq) < GIC_INTERNAL) ?       =
     \
                                     s->priority1[irq][cpu] :            =
\
                                     s->priority2[(irq) - GIC_INTERNAL])
-#define GIC_TARGET(irq) s->irq_target[irq]
-#define GIC_CLEAR_GROUP(irq, cm) (s->irq_state[irq].group &=3D ~(cm))
-#define GIC_SET_GROUP(irq, cm) (s->irq_state[irq].group |=3D (cm))
-#define GIC_TEST_GROUP(irq, cm) ((s->irq_state[irq].group & (cm)) !=3D 0=
)
+#define GIC_DIST_TARGET(irq) (s->irq_target[irq])
+#define GIC_DIST_CLEAR_GROUP(irq, cm) (s->irq_state[irq].group &=3D ~(cm=
))
+#define GIC_DIST_SET_GROUP(irq, cm) (s->irq_state[irq].group |=3D (cm))
+#define GIC_DIST_TEST_GROUP(irq, cm) ((s->irq_state[irq].group & (cm)) !=
=3D 0)
=20
 #define GICD_CTLR_EN_GRP0 (1U << 0)
 #define GICD_CTLR_EN_GRP1 (1U << 1)
@@ -79,8 +80,8 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemT=
xAttrs attrs);
 void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs);
 void gic_update(GICState *s);
 void gic_init_irqs_and_distributor(GICState *s);
-void gic_set_priority(GICState *s, int cpu, int irq, uint8_t val,
-                      MemTxAttrs attrs);
+void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
+                           MemTxAttrs attrs);
=20
 static inline bool gic_test_pending(GICState *s, int irq, int cm)
 {
@@ -93,7 +94,7 @@ static inline bool gic_test_pending(GICState *s, int ir=
q, int cm)
          * GICD_ISPENDR to set the state pending.
          */
         return (s->irq_state[irq].pending & cm) ||
-            (!GIC_TEST_EDGE_TRIGGER(irq) && GIC_TEST_LEVEL(irq, cm));
+            (!GIC_DIST_TEST_EDGE_TRIGGER(irq) && GIC_DIST_TEST_LEVEL(irq=
, cm));
     }
 }
=20
--=20
2.17.1
