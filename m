Received: from eggs.gnu.org ([2001:4830:134:3::10]:59162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3t-0002rj-P3
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3s-00022L-Rq
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:45:01 +1000
Message-Id: <20180612064503.14282-32-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/33] ppc/pnv: fix LPC HC firmware address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

A specific MemoryRegion is required for the LPC HC Firmware address
space.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_lpc.c         | 4 +++-
 include/hw/ppc/pnv_lpc.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 2317d1e62c..402c4fefa8 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -79,6 +79,7 @@ enum {
=20
 #define ISA_IO_SIZE             0x00010000
 #define ISA_MEM_SIZE            0x10000000
+#define ISA_FW_SIZE             0x10000000
 #define LPC_IO_OPB_ADDR         0xd0010000
 #define LPC_IO_OPB_SIZE         0x00010000
 #define LPC_MEM_OPB_ADDR        0xe0010000
@@ -429,6 +430,7 @@ static void pnv_lpc_realize(DeviceState *dev, Error *=
*errp)
      */
     memory_region_init(&lpc->isa_io, OBJECT(dev), "isa-io", ISA_IO_SIZE)=
;
     memory_region_init(&lpc->isa_mem, OBJECT(dev), "isa-mem", ISA_MEM_SI=
ZE);
+    memory_region_init(&lpc->isa_fw, OBJECT(dev),  "isa-fw", ISA_FW_SIZE=
);
=20
     /* Create windows from the OPB space to the ISA space */
     memory_region_init_alias(&lpc->opb_isa_io, OBJECT(dev), "lpc-isa-io"=
,
@@ -440,7 +442,7 @@ static void pnv_lpc_realize(DeviceState *dev, Error *=
*errp)
     memory_region_add_subregion(&lpc->opb_mr, LPC_MEM_OPB_ADDR,
                                 &lpc->opb_isa_mem);
     memory_region_init_alias(&lpc->opb_isa_fw, OBJECT(dev), "lpc-isa-fw"=
,
-                             &lpc->isa_mem, 0, LPC_FW_OPB_SIZE);
+                             &lpc->isa_fw, 0, LPC_FW_OPB_SIZE);
     memory_region_add_subregion(&lpc->opb_mr, LPC_FW_OPB_ADDR,
                                 &lpc->opb_isa_fw);
=20
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 023b4f0fec..53fdd5bb64 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -38,6 +38,7 @@ typedef struct PnvLpcController {
     /* ISA IO and Memory space */
     MemoryRegion isa_io;
     MemoryRegion isa_mem;
+    MemoryRegion isa_fw;
=20
     /* Windows from OPB to ISA (aliases) */
     MemoryRegion opb_isa_io;
--=20
2.17.1
