Received: from eggs.gnu.org ([2001:4830:134:3::10]:47484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fPtA9-0008Ds-Ee
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fPtA5-0002Ez-3g
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:20:57 -0400
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:54433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fPtA4-0002DA-T3
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:20:53 -0400
Received: from player732.ha.ovh.net (unknown [10.109.108.5])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 2BD1215E39
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 19:20:51 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  4 Jun 2018 19:20:39 +0200
Message-Id: <20180604172039.19427-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH] target/ppc: extend eieio for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Michael Ellerman <mpe@ellerman.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

POWER9 introduced a new variant of the eieio instruction using bit 6
as a hint to tell the CPU it is a store-forwarding barrier.

The usage of this eieio extension was recently added in Linux 4.17
which activated the "support for a store forwarding barrier at kernel
entry/exit".

This loosen the QEMU eieio instruction mask to boot newer kernel but I
think we should be adding a new *eieio* instruction specific to POWER9
instead. I just don't know how to define an instruction variant with
the same op code for an ISA version. Any idea ?

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 target/ppc/translate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: qemu-powernv-2.13.git/target/ppc/translate.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- qemu-powernv-2.13.git.orig/target/ppc/translate.c
+++ qemu-powernv-2.13.git/target/ppc/translate.c
@@ -6496,7 +6496,7 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00
 GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
-GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x03FFF801, PPC_MEM_EIEIO),
+GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
 GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
