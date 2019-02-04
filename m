Received: from eggs.gnu.org ([209.51.188.92]:38293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8f-0000b4-N6
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8e-0007cw-78
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:00:51 +1100
Message-Id: <20190204090124.26191-5-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/37] ppc4xx: Use ram_addr_t in
 ppc4xx_sdram_adjust()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

To avoid overflow if larger values are added later use ram_addr_t for
the sdram_bank_sizes parameter to match ram_size to which it is compared.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_bamboo.c  | 2 +-
 hw/ppc/ppc4xx_devs.c    | 4 ++--
 hw/ppc/sam460ex.c       | 2 +-
 include/hw/ppc/ppc4xx.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index fc06191588..4b547eaf77 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -49,7 +49,7 @@
=20
 #define PPC440EP_SDRAM_NR_BANKS 4
=20
-static const unsigned int ppc440ep_sdram_bank_sizes[] =3D {
+static const ram_addr_t ppc440ep_sdram_bank_sizes[] =3D {
     256 * MiB, 128 * MiB, 64 * MiB, 32 * MiB, 16 * MiB, 8 * MiB, 0
 };
=20
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 9b6e4c60fa..9418478575 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -679,12 +679,12 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size,=
 int nr_banks,
                                MemoryRegion ram_memories[],
                                hwaddr ram_bases[],
                                hwaddr ram_sizes[],
-                               const unsigned int sdram_bank_sizes[])
+                               const ram_addr_t sdram_bank_sizes[])
 {
     MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
     ram_addr_t size_left =3D ram_size;
     ram_addr_t base =3D 0;
-    unsigned int bank_size;
+    ram_addr_t bank_size;
     int i;
     int j;
=20
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 03d70ec1e8..7a8c745021 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -77,7 +77,7 @@
 #define SDRAM_NR_BANKS 4
=20
 /* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
-static const unsigned int ppc460ex_sdram_bank_sizes[] =3D {
+static const ram_addr_t ppc460ex_sdram_bank_sizes[] =3D {
     1 * GiB, 512 * MiB, 256 * MiB, 128 * MiB, 64 * MiB, 32 * MiB, 0
 };
=20
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 3a2a04c8ce..39a7ba1ce6 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -43,7 +43,7 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int=
 nr_banks,
                                MemoryRegion ram_memories[],
                                hwaddr ram_bases[],
                                hwaddr ram_sizes[],
-                               const unsigned int sdram_bank_sizes[]);
+                               const ram_addr_t sdram_bank_sizes[]);
=20
 void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
                         MemoryRegion ram_memories[],
--=20
2.20.1
