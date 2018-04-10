Received: from eggs.gnu.org ([2001:4830:134:3::10]:45500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slY-0007Ae-IB
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slX-0002hS-3U
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:52 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 10 Apr 2018 22:52:32 +1000
Message-Id: <20180410125233.31618-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180410125233.31618-1-david@gibson.dropbear.id.au>
References: <20180410125233.31618-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 6/7] sam460ex: Fix timer frequency and clock
 multipliers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

We only emulate timer running at CPU frequency which is what most
guests expect so set the frequency to match real hardware. This also
allows setting clock multipliers which caused slowdown previously due
to wrong timer frequency.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 3 +--
 hw/ppc/sam460ex.c  | 7 ++++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 976ab2b5d8..e312fdba70 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -392,8 +392,7 @@ static uint32_t dcr_read_sdr(void *opaque, int dcrn)
     case SDR0_CFGDATA:
         switch (sdr->addr) {
         case SDR0_STRP0:
-            /* FIXME: Is this correct? This breaks timing in U-Boot */
-            ret = 0; /*(0xb5 << 8) | (1 << 4) | 9 */
+            ret = (0xb5 << 8) | (1 << 4) | 9;
             break;
         case SDR0_STRP1:
             ret = (5 << 29) | (2 << 26) | (1 << 24);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 70b8e76d9c..dfff262f96 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -67,6 +67,7 @@
    IRQ12 = SM502_INT
 */
 
+#define CPU_FREQ 1150000000
 #define SDRAM_NR_BANKS 4
 
 /* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
@@ -253,8 +254,8 @@ static int sam460ex_load_device_tree(hwaddr addr,
     char *filename;
     int fdt_size;
     void *fdt;
-    uint32_t tb_freq = 50000000;
-    uint32_t clock_freq = 50000000;
+    uint32_t tb_freq = CPU_FREQ;
+    uint32_t clock_freq = CPU_FREQ;
 
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
     if (!filename) {
@@ -416,7 +417,7 @@ static void sam460ex_init(MachineState *machine)
     boot_info = g_malloc0(sizeof(*boot_info));
     env->load_info = boot_info;
 
-    ppc_booke_timers_init(cpu, 50000000, 0);
+    ppc_booke_timers_init(cpu, CPU_FREQ, 0);
     ppc_dcr_init(env, NULL, NULL);
 
     /* PLB arbitrer */
-- 
2.14.3
