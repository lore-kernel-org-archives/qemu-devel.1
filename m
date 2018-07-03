Received: from eggs.gnu.org ([2001:4830:134:3::10]:39988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKb-0002wG-0y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKY-00076V-DB
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:58:03 +1000
Message-Id: <20180703055804.13449-35-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 34/35] target/ppc: Relax reserved bitmask of
 indexed store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

The PPC440 User Manual says that if bit 31 is set, the contents of
CR[CR0] are undefined for indexed store instructions but this form is
not invalid. Other PPC variants confirming to recent ISA where this
bit may be reserved should ignore reserved bits and not raise invalid
instruction exception. In particular, MorphOS has an stwx instruction
with bit 31 set and fails to boot currently because of this. With this
patch it gets further.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 65c8cc94e7..9eaa10b421 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7054,7 +7054,7 @@ GEN_HANDLER(stop##u, opc, 0xFF, 0xFF, 0x00000000, type),
 #define GEN_STUX(name, stop, opc2, opc3, type)                                \
 GEN_HANDLER(name##ux, 0x1F, opc2, opc3, 0x00000001, type),
 #define GEN_STX_E(name, stop, opc2, opc3, type, type2, chk)                   \
-GEN_HANDLER_E(name##x, 0x1F, opc2, opc3, 0x00000001, type, type2),
+GEN_HANDLER_E(name##x, 0x1F, opc2, opc3, 0x00000000, type, type2),
 #define GEN_STS(name, stop, op, type)                                         \
 GEN_ST(name, stop, op | 0x20, type)                                           \
 GEN_STU(name, stop, op | 0x21, type)                                          \
-- 
2.17.1
