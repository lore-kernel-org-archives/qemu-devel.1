Received: from eggs.gnu.org ([2001:4830:134:3::10]:46378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ci51A-0006pw-Cb
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ci519-0005ym-5p
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:02:04 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 26 Feb 2017 22:01:42 +0200
Message-Id: <20170226200142.31169-2-krzk@kernel.org>
In-Reply-To: <20170226200142.31169-1-krzk@kernel.org>
References: <20170226200142.31169-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v2 2/2] hw/arm/exynos: Fix proper mapping of
 CPUs by providing real cluster ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

The Exynos4210 has cluster ID 0x9 in its MPIDR register (raw value
0x8000090x).  If this cluster ID is not provided, then Linux kernel
cannot map DeviceTree nodes to MPIDR values resulting in kernel
warning and lack of any secondary CPUs:

    DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
    ...
    smp: Bringing up secondary CPUs ...
    smp: Brought up 1 node, 1 CPU
    SMP: Total of 1 processors activated (24.00 BogoMIPS).

Provide a cluster ID so Linux will see proper MPIDR and will try to
bring the secondary CPU online.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
None
---
 hw/arm/exynos4210.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index a0ecbe8c1ffc..1d2b50cc4eea 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -142,6 +142,16 @@ void exynos4210_write_secondary(ARMCPU *cpu,
                        info->smp_loader_start);
 }
 
+static uint64_t exynos4210_calc_affinity(int cpu)
+{
+    uint64_t mp_affinity;
+
+    /* Exynos4210 has 0x9 as cluster ID */
+    mp_affinity = (0x9 << ARM_AFF1_SHIFT) | cpu;
+
+    return mp_affinity;
+}
+
 Exynos4210State *exynos4210_init(MemoryRegion *system_mem,
         unsigned long ram_size)
 {
@@ -167,6 +177,8 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem,
         }
 
         s->cpu[n] = ARM_CPU(cpuobj);
+        object_property_set_int(cpuobj, exynos4210_calc_affinity(n),
+                                "mp-affinity", &error_abort);
         object_property_set_int(cpuobj, EXYNOS4210_SMP_PRIVATE_BASE_ADDR,
                                 "reset-cbar", &error_abort);
         object_property_set_bool(cpuobj, true, "realized", &error_fatal);
-- 
2.9.3
