Received: from eggs.gnu.org ([2001:4830:134:3::10]:33306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f4DuQ-0005fa-5D
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 19:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f4DuN-0006Az-2J
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 19:03:10 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 6 Apr 2018 00:42:48 +0200
Message-Id: <20180405230258.680CB7456D6@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH for-2.12] sam460ex: Fix timer frequency and
 clock multipliers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

We only emulate timer running at CPU frequency which is what most
guests expect so set the frequency to match real hardware. This also
allows setting clock multipliers which caused slowdown previously due
to wrong timer frequency.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_uc.c | 3 +--
 hw/ppc/sam460ex.c  | 7 ++++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 976ab2b..e312fdb 100644
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
index 70b8e76..dfff262 100644
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
2.7.6
