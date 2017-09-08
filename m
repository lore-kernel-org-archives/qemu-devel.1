Received: from eggs.gnu.org ([2001:4830:134:3::10]:58765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe8-0002C8-Nk
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe2-0003H5-HO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:24 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:45 +1000
Message-Id: <20170908103558.31632-28-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 27/40] ppc4xx: Export ECB and PLB emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Make these device models available outside ppc405_uc.c for reuse in
460EX emulation. They are left in their current place for now because
they are used mostly unchanged and I'm not sure these correctly model
the components in 440 SoCs (but they seem to be good enough). These
functions could be moved in a subsequent clean up series when this is
confirmed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405.h    | 3 +++
 hw/ppc/ppc405_uc.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
index a9ffc87f19..7ed25cfa1b 100644
--- a/hw/ppc/ppc405.h
+++ b/hw/ppc/ppc405.h
@@ -59,6 +59,9 @@ struct ppc4xx_bd_info_t {
 ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
                                 uint32_t flags);
 
+void ppc4xx_plb_init(CPUPPCState *env);
+void ppc405_ebc_init(CPUPPCState *env);
+
 CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
                         MemoryRegion ram_memories[4],
                         hwaddr ram_bases[4],
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 8f44cb46d0..e621d0aec5 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -174,7 +174,7 @@ static void ppc4xx_plb_reset (void *opaque)
     plb->besr = 0x00000000;
 }
 
-static void ppc4xx_plb_init(CPUPPCState *env)
+void ppc4xx_plb_init(CPUPPCState *env)
 {
     ppc4xx_plb_t *plb;
 
@@ -585,7 +585,7 @@ static void ebc_reset (void *opaque)
     ebc->cfg = 0x80400000;
 }
 
-static void ppc405_ebc_init(CPUPPCState *env)
+void ppc405_ebc_init(CPUPPCState *env)
 {
     ppc4xx_ebc_t *ebc;
 
-- 
2.13.5
