Received: from eggs.gnu.org ([2001:4830:134:3::10]:33404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5J-0003Ki-Lt
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5I-0006VL-B1
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:29 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  9 Oct 2017 21:50:55 +0200
Message-Id: <1507578671-158758-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/24] ppc: replace cpu_model with cpu_type
 on ref405ep, taihu boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405_uc.c   | 6 ++++--
 hw/ppc/ppc4xx_devs.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 8e58065..205ebce 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -1629,7 +1629,8 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
     qemu_irq *pic, *irqs;
 
     memset(clk_setup, 0, sizeof(clk_setup));
-    cpu = ppc4xx_init("405cr", &clk_setup[PPC405CR_CPU_CLK],
+    cpu = ppc4xx_init(POWERPC_CPU_TYPE_NAME("405crc"),
+                      &clk_setup[PPC405CR_CPU_CLK],
                       &clk_setup[PPC405CR_TMR_CLK], sysclk);
     env = &cpu->env;
     /* Memory mapped devices registers */
@@ -1981,7 +1982,8 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_space_mem,
 
     memset(clk_setup, 0, sizeof(clk_setup));
     /* init CPUs */
-    cpu = ppc4xx_init("405ep", &clk_setup[PPC405EP_CPU_CLK],
+    cpu = ppc4xx_init(POWERPC_CPU_TYPE_NAME("405ep"),
+                      &clk_setup[PPC405EP_CPU_CLK],
                       &tlb_clk_setup, sysclk);
     env = &cpu->env;
     clk_setup[PPC405EP_CPU_CLK].cb = tlb_clk_setup.cb;
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 6d7f785..2e96389 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -48,7 +48,7 @@ static void ppc4xx_reset(void *opaque)
 
 /*****************************************************************************/
 /* Generic PowerPC 4xx processor instantiation */
-PowerPCCPU *ppc4xx_init(const char *cpu_model,
+PowerPCCPU *ppc4xx_init(const char *cpu_type,
                         clk_setup_t *cpu_clk, clk_setup_t *tb_clk,
                         uint32_t sysclk)
 {
@@ -56,7 +56,7 @@ PowerPCCPU *ppc4xx_init(const char *cpu_model,
     CPUPPCState *env;
 
     /* init CPUs */
-    cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
+    cpu = POWERPC_CPU(cpu_create(cpu_type));
     env = &cpu->env;
 
     cpu_clk->cb = NULL; /* We don't care about CPU clock frequency changes */
-- 
2.7.4
