Received: from eggs.gnu.org ([2001:4830:134:3::10]:38102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUH-0007hU-9N
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUC-0007Hq-Ea
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:57 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 29 Jun 2018 15:29:47 +0200
Message-Id: <20180629132954.24269-14-luc.michel@greensocs.com>
In-Reply-To: <20180629132954.24269-1-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 13/20] intc/arm_gic: Implement
 virtualization extensions in gic_cpu_(read|write)
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

Implement virtualization extensions in the gic_cpu_read() and
gic_cpu_write() functions. Those are the last bits missing to fully
support virtualization extensions in the CPU interface path.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/intc/arm_gic.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 434dc9c7b2..2b1fa280eb 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1336,9 +1336,12 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
     case 0xd0: case 0xd4: case 0xd8: case 0xdc:
     {
         int regno = (offset - 0xd0) / 4;
+        int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
 
-        if (regno >= GIC_NR_APRS || s->revision != 2) {
+        if (regno >= nr_aprs || s->revision != 2) {
             *data = 0;
+        } else if (gic_is_vcpu(cpu)) {
+            *data = s->h_apr[gic_get_vcpu_real_id(cpu)];
         } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
             *data = gic_apr_ns_view(s, regno, cpu);
@@ -1352,7 +1355,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
         int regno = (offset - 0xe0) / 4;
 
         if (regno >= GIC_NR_APRS || s->revision != 2 || !gic_has_groups(s) ||
-            gic_cpu_ns_access(s, cpu, attrs)) {
+            gic_cpu_ns_access(s, cpu, attrs) || gic_is_vcpu(cpu)) {
             *data = 0;
         } else {
             *data = s->nsapr[regno][cpu];
@@ -1387,7 +1390,8 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
                 s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
             }
         } else {
-            s->bpr[cpu] = MAX(value & 0x7, GIC_MIN_BPR);
+            int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+            s->bpr[cpu] = MAX(value & 0x7, min_bpr);
         }
         break;
     case 0x10: /* End Of Interrupt */
@@ -1404,11 +1408,14 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
     case 0xd0: case 0xd4: case 0xd8: case 0xdc:
     {
         int regno = (offset - 0xd0) / 4;
+        int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
 
-        if (regno >= GIC_NR_APRS || s->revision != 2) {
+        if (regno >= nr_aprs || s->revision != 2) {
             return MEMTX_OK;
         }
-        if (gic_cpu_ns_access(s, cpu, attrs)) {
+        if (gic_is_vcpu(cpu)) {
+            s->h_apr[gic_get_vcpu_real_id(cpu)] = value;
+        } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
             gic_apr_write_ns_view(s, regno, cpu, value);
         } else {
@@ -1423,6 +1430,9 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
         if (regno >= GIC_NR_APRS || s->revision != 2) {
             return MEMTX_OK;
         }
+        if (gic_is_vcpu(cpu)) {
+            return MEMTX_OK;
+        }
         if (!gic_has_groups(s) || (gic_cpu_ns_access(s, cpu, attrs))) {
             return MEMTX_OK;
         }
-- 
2.17.1
