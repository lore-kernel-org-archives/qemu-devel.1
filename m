Received: from eggs.gnu.org ([2001:4830:134:3::10]:38643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flF05-0007JK-Mi
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flF01-000323-Kb
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:54:49 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Aug 2018 15:44:28 +0100
Message-Id: <20180802144430.13870-2-peter.maydell@linaro.org>
In-Reply-To: <20180802144430.13870-1-peter.maydell@linaro.org>
References: <20180802144430.13870-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] hw/ppc/prep: Remove ifdeffed-out stub of
 XCSR code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-ppc@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

The prep machine has some code which is stubs of accessors
for XCSR registers. This has been disabled via #if 0
since commit b6b8bd1819ff in 2004, and doesn't have any
actual interesting content. It also uses the deprecated
old_mmio accessor functions. Remove it entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ppc/prep.c | 97 +++------------------------------------------------
 1 file changed, 4 insertions(+), 93 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 3401570d981..b26138e5c47 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -78,94 +78,6 @@ static int ne2000_irq[NE2000_NB_MAX] = { 9, 10, 11, 3, 4, 5 };
 /* ISA IO ports bridge */
 #define PPC_IO_BASE 0x80000000
 
-/* PowerPC control and status registers */
-#if 0 // Not used
-static struct {
-    /* IDs */
-    uint32_t veni_devi;
-    uint32_t revi;
-    /* Control and status */
-    uint32_t gcsr;
-    uint32_t xcfr;
-    uint32_t ct32;
-    uint32_t mcsr;
-    /* General purpose registers */
-    uint32_t gprg[6];
-    /* Exceptions */
-    uint32_t feen;
-    uint32_t fest;
-    uint32_t fema;
-    uint32_t fecl;
-    uint32_t eeen;
-    uint32_t eest;
-    uint32_t eecl;
-    uint32_t eeint;
-    uint32_t eemck0;
-    uint32_t eemck1;
-    /* Error diagnostic */
-} XCSR;
-
-static void PPC_XCSR_writeb (void *opaque,
-                             hwaddr addr, uint32_t value)
-{
-    printf("%s: 0x" TARGET_FMT_plx " => 0x%08" PRIx32 "\n", __func__, addr,
-           value);
-}
-
-static void PPC_XCSR_writew (void *opaque,
-                             hwaddr addr, uint32_t value)
-{
-    printf("%s: 0x" TARGET_FMT_plx " => 0x%08" PRIx32 "\n", __func__, addr,
-           value);
-}
-
-static void PPC_XCSR_writel (void *opaque,
-                             hwaddr addr, uint32_t value)
-{
-    printf("%s: 0x" TARGET_FMT_plx " => 0x%08" PRIx32 "\n", __func__, addr,
-           value);
-}
-
-static uint32_t PPC_XCSR_readb (void *opaque, hwaddr addr)
-{
-    uint32_t retval = 0;
-
-    printf("%s: 0x" TARGET_FMT_plx " <= %08" PRIx32 "\n", __func__, addr,
-           retval);
-
-    return retval;
-}
-
-static uint32_t PPC_XCSR_readw (void *opaque, hwaddr addr)
-{
-    uint32_t retval = 0;
-
-    printf("%s: 0x" TARGET_FMT_plx " <= %08" PRIx32 "\n", __func__, addr,
-           retval);
-
-    return retval;
-}
-
-static uint32_t PPC_XCSR_readl (void *opaque, hwaddr addr)
-{
-    uint32_t retval = 0;
-
-    printf("%s: 0x" TARGET_FMT_plx " <= %08" PRIx32 "\n", __func__, addr,
-           retval);
-
-    return retval;
-}
-
-static const MemoryRegionOps PPC_XCSR_ops = {
-    .old_mmio = {
-        .read = { PPC_XCSR_readb, PPC_XCSR_readw, PPC_XCSR_readl, },
-        .write = { PPC_XCSR_writeb, PPC_XCSR_writew, PPC_XCSR_writel, },
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-#endif
-
 /* Fake super-io ports for PREP platform (Intel 82378ZB) */
 typedef struct sysctrl_t {
     qemu_irq reset_irq;
@@ -648,11 +560,10 @@ static void ppc_prep_init(MachineState *machine)
     portio_list_init(&prep_port_list, NULL, prep_portio_list, sysctrl, "prep");
     portio_list_add(&prep_port_list, isa_address_space_io(isa), 0x0);
 
-    /* PowerPC control and status register group */
-#if 0
-    memory_region_init_io(xcsr, NULL, &PPC_XCSR_ops, NULL, "ppc-xcsr", 0x1000);
-    memory_region_add_subregion(sysmem, 0xFEFF0000, xcsr);
-#endif
+    /*
+     * PowerPC control and status register group: unimplemented,
+     * would be at address 0xFEFF0000.
+     */
 
     if (machine_usb(machine)) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
-- 
2.17.1
