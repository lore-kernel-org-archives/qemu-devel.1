Received: from eggs.gnu.org ([2001:4830:134:3::10]:52537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSQMl-00010t-GF
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSQMi-0001dj-6v
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:12:27 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:53498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSQMi-0001ct-0E
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:12:24 -0400
Received: from player799.ha.ovh.net (unknown [10.109.108.80])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 312ACE5EBA
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 19:12:22 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Jun 2018 19:12:10 +0200
Message-Id: <20180611171210.2571-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/pnv: fix LPC HC firmware address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

A specific MemoryRegion is required for the LPC HC Firmware address
space.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_lpc.h | 1 +
 hw/ppc/pnv_lpc.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 023b4f0fec86..53fdd5bb6450 100644
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
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index c42b4a8f6c0f..a0dba657ee60 100644
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
@@ -437,6 +438,7 @@ static void pnv_lpc_realize(DeviceState *dev, Error *=
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
@@ -448,7 +450,7 @@ static void pnv_lpc_realize(DeviceState *dev, Error *=
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
--=20
2.13.6
