Received: from eggs.gnu.org ([208.118.235.92]:35857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgT-0004Oo-Rd
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgS-0005Rt-0Z
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:05 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:60315)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1geWgR-0005Qs-L0
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:03 -0500
Message-Id: <16d6e1b4987d30c11ace0211e9d6a57303784467.1546394798.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1546394798.git.balaton@eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 02 Jan 2019 03:06:38 +0100
Subject: [Qemu-devel] [PATCH 4/8] ppc4xx: Use ram_addr_t in
 ppc4xx_sdram_adjust()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

To avoid overflow if larger values are added later use ram_addr_t for
the sdram_bank_sizes parameter to match ram_size to which it is compared.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_bamboo.c  | 2 +-
 hw/ppc/ppc4xx_devs.c    | 4 ++--
 hw/ppc/sam460ex.c       | 2 +-
 include/hw/ppc/ppc4xx.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index b8aa55d526..8277c0f784 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -49,7 +49,7 @@
 
 #define PPC440EP_SDRAM_NR_BANKS 4
 
-static const unsigned int ppc440ep_sdram_bank_sizes[] = {
+static const ram_addr_t ppc440ep_sdram_bank_sizes[] = {
     256 * MiB, 128 * MiB, 64 * MiB, 32 * MiB, 16 * MiB, 8 * MiB, 0
 };
 
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 9b6e4c60fa..9418478575 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -679,12 +679,12 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
                                MemoryRegion ram_memories[],
                                hwaddr ram_bases[],
                                hwaddr ram_sizes[],
-                               const unsigned int sdram_bank_sizes[])
+                               const ram_addr_t sdram_bank_sizes[])
 {
     MemoryRegion *ram = g_malloc0(sizeof(*ram));
     ram_addr_t size_left = ram_size;
     ram_addr_t base = 0;
-    unsigned int bank_size;
+    ram_addr_t bank_size;
     int i;
     int j;
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 2bb91ed21b..7cbd2f54c6 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -77,7 +77,7 @@
 #define SDRAM_NR_BANKS 4
 
 /* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
-static const unsigned int ppc460ex_sdram_bank_sizes[] = {
+static const ram_addr_t ppc460ex_sdram_bank_sizes[] = {
     1 * GiB, 512 * MiB, 256 * MiB, 128 * MiB, 64 * MiB, 32 * MiB, 0
 };
 
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 3a2a04c8ce..39a7ba1ce6 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -43,7 +43,7 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
                                MemoryRegion ram_memories[],
                                hwaddr ram_bases[],
                                hwaddr ram_sizes[],
-                               const unsigned int sdram_bank_sizes[]);
+                               const ram_addr_t sdram_bank_sizes[]);
 
 void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
                         MemoryRegion ram_memories[],
-- 
2.13.7
