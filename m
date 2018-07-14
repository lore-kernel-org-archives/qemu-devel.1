Received: from eggs.gnu.org ([2001:4830:134:3::10]:38452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1feO9u-0005nL-Cg
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 13:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1feO9q-0004ad-5u
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 13:16:37 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat, 14 Jul 2018 19:15:49 +0200
Message-Id: <20180714171601.5734-9-luc.michel@greensocs.com>
In-Reply-To: <20180714171601.5734-1-luc.michel@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v4 08/20] intc/arm_gic: Refactor secure/ns
 access check in the CPU interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

An access to the CPU interface is non-secure if the current GIC instance
implements the security extensions, and the memory access is actually
non-secure. Until then, it was checked with tests such as
  if (s->security_extn && !attrs.secure) { ... }
in various places of the CPU interface code.

With the implementation of the virtualization extensions, those tests
must be updated to take into account whether we are in a vCPU interface
or not. This is because the exposed vCPU interface does not implement
security extensions.

This commits replaces all those tests with a call to the
gic_cpu_ns_access() function to check if the current access to the CPU
interface is non-secure. This function takes into account whether the
current CPU is a vCPU or not.

Note that this function is used only in the (v)CPU interface code path.
The distributor code path is left unchanged, as the distributor is not
exposed to vCPUs at all.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 1ac0fe740c..53cc257ed8 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -74,6 +74,11 @@ static inline bool gic_has_groups(GICState *s)
     return s->revision == 2 || s->security_extn;
 }
 
+static inline bool gic_cpu_ns_access(GICState *s, int cpu, MemTxAttrs attrs)
+{
+    return !gic_is_vcpu(cpu) && s->security_extn && !attrs.secure;
+}
+
 /* TODO: Many places that call this routine could be optimized.  */
 /* Update interrupt status after enabled or pending bits have been changed.  */
 static void gic_update(GICState *s)
@@ -221,7 +226,7 @@ static uint16_t gic_get_current_pending_irq(GICState *s, int cpu,
         /* On a GIC without the security extensions, reading this register
          * behaves in the same way as a secure access to a GIC with them.
          */
-        bool secure = !s->security_extn || attrs.secure;
+        bool secure = !gic_cpu_ns_access(s, cpu, attrs);
 
         if (group == 0 && !secure) {
             /* Group0 interrupts hidden from Non-secure access */
@@ -428,7 +433,7 @@ static uint32_t gic_dist_get_priority(GICState *s, int cpu, int irq,
 static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
                                   MemTxAttrs attrs)
 {
-    if (s->security_extn && !attrs.secure) {
+    if (gic_cpu_ns_access(s, cpu, attrs)) {
         if (s->priority_mask[cpu] & 0x80) {
             /* Priority Mask in upper half */
             pmask = 0x80 | (pmask >> 1);
@@ -444,7 +449,7 @@ static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
 {
     uint32_t pmask = s->priority_mask[cpu];
 
-    if (s->security_extn && !attrs.secure) {
+    if (gic_cpu_ns_access(s, cpu, attrs)) {
         if (pmask & 0x80) {
             /* Priority Mask in upper half, return Non-secure view */
             pmask = (pmask << 1) & 0xff;
@@ -460,7 +465,7 @@ static uint32_t gic_get_cpu_control(GICState *s, int cpu, MemTxAttrs attrs)
 {
     uint32_t ret = s->cpu_ctlr[cpu];
 
-    if (s->security_extn && !attrs.secure) {
+    if (gic_cpu_ns_access(s, cpu, attrs)) {
         /* Construct the NS banked view of GICC_CTLR from the correct
          * bits of the S banked view. We don't need to move the bypass
          * control bits because we don't implement that (IMPDEF) part
@@ -476,7 +481,7 @@ static void gic_set_cpu_control(GICState *s, int cpu, uint32_t value,
 {
     uint32_t mask;
 
-    if (s->security_extn && !attrs.secure) {
+    if (gic_cpu_ns_access(s, cpu, attrs)) {
         /* The NS view can only write certain bits in the register;
          * the rest are unchanged
          */
@@ -507,7 +512,7 @@ static uint8_t gic_get_running_priority(GICState *s, int cpu, MemTxAttrs attrs)
         return 0xff;
     }
 
-    if (s->security_extn && !attrs.secure) {
+    if (gic_cpu_ns_access(s, cpu, attrs)) {
         if (s->running_priority[cpu] & 0x80) {
             /* Running priority in upper half of range: return the Non-secure
              * view of the priority.
@@ -531,7 +536,7 @@ static bool gic_eoi_split(GICState *s, int cpu, MemTxAttrs attrs)
         /* Before GICv2 prio-drop and deactivate are not separable */
         return false;
     }
-    if (s->security_extn && !attrs.secure) {
+    if (gic_cpu_ns_access(s, cpu, attrs)) {
         return s->cpu_ctlr[cpu] & GICC_CTLR_EOIMODE_NS;
     }
     return s->cpu_ctlr[cpu] & GICC_CTLR_EOIMODE;
@@ -549,7 +554,7 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
         return;
     }
 
-    if (s->security_extn && !attrs.secure && !group) {
+    if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
         DPRINTF("Non-secure DI for Group0 interrupt %d ignored\n", irq);
         return;
     }
@@ -591,7 +596,7 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
 
     group = gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
 
-    if (s->security_extn && !attrs.secure && !group) {
+    if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
         DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", irq);
         return;
     }
@@ -1265,7 +1270,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
         *data = gic_get_priority_mask(s, cpu, attrs);
         break;
     case 0x08: /* Binary Point */
-        if (s->security_extn && !attrs.secure) {
+        if (gic_cpu_ns_access(s, cpu, attrs)) {
             if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
                 /* NS view of BPR when CBPR is 1 */
                 *data = MIN(s->bpr[cpu] + 1, 7);
@@ -1292,7 +1297,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
          * With security extensions, secure access: ABPR (alias of NS BPR)
          * With security extensions, nonsecure access: RAZ/WI
          */
-        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
+        if (!gic_has_groups(s) || (gic_cpu_ns_access(s, cpu, attrs))) {
             *data = 0;
         } else {
             *data = s->abpr[cpu];
@@ -1304,7 +1309,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
 
         if (regno >= GIC_NR_APRS || s->revision != 2) {
             *data = 0;
-        } else if (s->security_extn && !attrs.secure) {
+        } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
             *data = gic_apr_ns_view(s, regno, cpu);
         } else {
@@ -1317,7 +1322,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
         int regno = (offset - 0xe0) / 4;
 
         if (regno >= GIC_NR_APRS || s->revision != 2 || !gic_has_groups(s) ||
-            (s->security_extn && !attrs.secure)) {
+            gic_cpu_ns_access(s, cpu, attrs)) {
             *data = 0;
         } else {
             *data = s->nsapr[regno][cpu];
@@ -1344,7 +1349,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
         gic_set_priority_mask(s, cpu, value, attrs);
         break;
     case 0x08: /* Binary Point */
-        if (s->security_extn && !attrs.secure) {
+        if (gic_cpu_ns_access(s, cpu, attrs)) {
             if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
                 /* WI when CBPR is 1 */
                 return MEMTX_OK;
@@ -1359,7 +1364,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
         gic_complete_irq(s, cpu, value & 0x3ff, attrs);
         return MEMTX_OK;
     case 0x1c: /* Aliased Binary Point */
-        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
+        if (!gic_has_groups(s) || (gic_cpu_ns_access(s, cpu, attrs))) {
             /* unimplemented, or NS access: RAZ/WI */
             return MEMTX_OK;
         } else {
@@ -1373,7 +1378,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
         if (regno >= GIC_NR_APRS || s->revision != 2) {
             return MEMTX_OK;
         }
-        if (s->security_extn && !attrs.secure) {
+        if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
             gic_apr_write_ns_view(s, regno, cpu, value);
         } else {
@@ -1388,7 +1393,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
         if (regno >= GIC_NR_APRS || s->revision != 2) {
             return MEMTX_OK;
         }
-        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
+        if (!gic_has_groups(s) || (gic_cpu_ns_access(s, cpu, attrs))) {
             return MEMTX_OK;
         }
         s->nsapr[regno][cpu] = value;
-- 
2.18.0
