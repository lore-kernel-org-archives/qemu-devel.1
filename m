Received: from eggs.gnu.org ([2001:4830:134:3::10]:51444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYg2l-0005Oe-EA
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYg2g-0005QN-Dk
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:09:39 -0400
Message-Id: <bf4086546f08124e57b9676e6c0b81386ee59b67.1530225513.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1530225513.git.balaton@eik.bme.hu>
References: <cover.1530225513.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 29 Jun 2018 00:38:33 +0200
Subject: [Qemu-devel] [PATCH v6 5/5] target/ppc: Relax reserved bitmask of
 indexed store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The PPC440 User Manual says that if bit 31 is set, the contents of
CR[CR0] are undefined for indexed store instructions but this form is
not invalid. Other PPC variants confirming to recent ISA where this
bit may be reserved should ignore reserved bits and not raise invalid
instruction exception. In particular, MorphOS has an stwx instruction
with bit 31 set and fails to boot currently because of this. With this
patch it gets further.

---
On sam460ex MorhpOS still has problems accessing PCI devices so cannot
yet boot but does not hit the invalid instruction exception and gets
further and fails due to not finding boot volume or display controller.
On mac99 it actually boots but needs an OpenBIOS patch to get USB
working (needed for mouse and keyboard). I'll prepare some docs on how
to run different guests but for the impatient here's a little hint:
-M mac99 -m 512 -vga none -device sm501 \
-prom-env 'boot-device=cd:,\mac_ppc32\boot.img'

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3a215a1..525d55e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6886,7 +6886,7 @@ GEN_HANDLER(stop##u, opc, 0xFF, 0xFF, 0x00000000, type),
 #define GEN_STUX(name, stop, opc2, opc3, type)                                \
 GEN_HANDLER(name##ux, 0x1F, opc2, opc3, 0x00000001, type),
 #define GEN_STX_E(name, stop, opc2, opc3, type, type2, chk)                   \
-GEN_HANDLER_E(name##x, 0x1F, opc2, opc3, 0x00000001, type, type2),
+GEN_HANDLER_E(name##x, 0x1F, opc2, opc3, 0x00000000, type, type2),
 #define GEN_STS(name, stop, op, type)                                         \
 GEN_ST(name, stop, op | 0x20, type)                                           \
 GEN_STU(name, stop, op | 0x21, type)                                          \
-- 
2.7.6
