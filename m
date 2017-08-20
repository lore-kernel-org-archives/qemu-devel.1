Received: from eggs.gnu.org ([2001:4830:134:3::10]:39808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUKy-000459-He
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUKw-00055v-Va
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:36 -0400
Message-Id: <86d29467038393122310cf0ba1c2547489324c61.1503249785.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1503249785.git.balaton@eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 20 Aug 2017 19:23:05 +0200
Subject: [Qemu-devel] [PATCH 12/15] ppc4xx: Export ECB and PLB emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

Make these device models available outside ppc405_uc.c for reuse in
460EX emulation. They are left in their current place for now because
they are used mostly unchanged and I'm not sure these correctly model
the components in 440 SoCs (but they seem to be good enough). These
functions could be moved in a subsequent clean up series when this is
confirmed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc405.h    | 3 +++
 hw/ppc/ppc405_uc.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
index a9ffc87..7ed25cf 100644
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
index 8f44cb4..e621d0a 100644
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
2.7.6
