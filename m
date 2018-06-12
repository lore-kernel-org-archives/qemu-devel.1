Received: from eggs.gnu.org ([2001:4830:134:3::10]:58954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3p-0002mG-7M
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3o-0001wA-2f
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:52 +1000
Message-Id: <20180612064503.14282-23-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/33] target/ppc: extend eieio for POWER9
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

POWER9 introduced a new variant of the eieio instruction using bit 6
as a hint to tell the CPU it is a store-forwarding barrier.

The usage of this eieio extension was recently added in Linux 4.17
which activated the "support for a store forwarding barrier at kernel
entry/exit".

Unfortunately, it is not possible to insert this new eieio instruction
without considerable change in ppc_tr_translate_insn(). So instead we
loosen the QEMU eieio instruction mask and modify the gen_eieio()
helper to test for bit6. On non-POWER9 CPUs, the bit6 is just ignored
but a warning is emitted as this is not an instruction software should
be using.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8ba8f67dc5..5fe1ba6555 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2967,7 +2967,28 @@ static void gen_stswx(DisasContext *ctx)
 /* eieio */
 static void gen_eieio(DisasContext *ctx)
 {
-    tcg_gen_mb(TCG_MO_LD_ST | TCG_BAR_SC);
+    TCGBar bar =3D TCG_MO_LD_ST;
+
+    /*
+     * POWER9 has a eieio instruction variant using bit 6 as a hint to
+     * tell the CPU it is a store-forwarding barrier.
+     */
+    if (ctx->opcode & 0x2000000) {
+        /*
+         * ISA says that "Reserved fields in instructions are ignored
+         * by the processor". So ignore the bit 6 on non-POWER9 CPU but
+         * as this is not an instruction software should be using,
+         * complain to the user.
+         */
+        if (!(ctx->insns_flags2 & PPC2_ISA300)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "invalid eieio using bit 6 at=
 @"
+                          TARGET_FMT_lx "\n", ctx->base.pc_next - 4);
+        } else {
+            bar =3D TCG_MO_ST_LD;
+        }
+    }
+
+    tcg_gen_mb(bar | TCG_BAR_SC);
 }
=20
 #if !defined(CONFIG_USER_ONLY)
@@ -6483,7 +6504,7 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC=
_STRING),
 GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
-GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x03FFF801, PPC_MEM_EIEIO),
+GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
 GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
--=20
2.17.1
