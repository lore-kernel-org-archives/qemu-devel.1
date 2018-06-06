Received: from eggs.gnu.org ([2001:4830:134:3::10]:59548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQRcq-0000D1-Nl
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQRcl-0000t0-Od
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:08:52 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:47672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQRcl-0000s2-Hz
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:08:47 -0400
Received: from player688.ha.ovh.net (unknown [10.109.108.34])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D79B616DED
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 08:08:45 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Jun 2018 08:08:30 +0200
Message-Id: <20180606060830.25942-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] target/ppc: extend eieio for POWER9
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

POWER9 introduced a new variant of the eieio instruction using bit 6
as a hint to tell the CPU it is a store-forwarding barrier.

The usage of this eieio extension was recently added in Linux 4.17
which activated the "support for a store forwarding barrier at kernel
entry/exit".

Unfortunately, it is not possible to insert this new eieio instruction
without considerable change in ppc_tr_translate_insn(). So instead we
loosen the QEMU eieio instruction mask. The gen_eieio() helper is
modified to test for bit6 and a custom instruction flag to catch
invalid eieio opcodes on non-POWER9 CPUs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h                |  5 ++++-
 target/ppc/translate.c          | 19 +++++++++++++++++--
 target/ppc/translate_init.inc.c |  3 ++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0247c1f04c37..021c9b2f10d1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2206,6 +2206,9 @@ enum {
     /* POWER ISA 3.0                                                    =
     */
     PPC2_ISA300        =3D 0x0000000000080000ULL,
=20
+    /* POWER ISA 3.0 eieio variants                                     =
     */
+    PPC2_MEM_EIEIO2    =3D 0x0000000000100000ULL,
+
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DB=
RX | \
                         PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 | \
                         PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
@@ -2213,7 +2216,7 @@ enum {
                         PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
-                        PPC2_ISA300)
+                        PPC2_ISA300 | PPC2_MEM_EIEIO2)
 };
=20
 /***********************************************************************=
******/
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8ba8f67dc513..a73ef02aef1d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2967,7 +2967,22 @@ static void gen_stswx(DisasContext *ctx)
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
+        if (!(ctx->insns_flags2 & PPC2_MEM_EIEIO2)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "invalid eieio using bit 6 at=
 @"
+                          TARGET_FMT_lx "\n", ctx->base.pc_next - 4);
+            return;
+        }
+        bar =3D TCG_MO_ST_LD;
+    }
+
+    tcg_gen_mb(bar | TCG_BAR_SC);
 }
=20
 #if !defined(CONFIG_USER_ONLY)
@@ -6483,7 +6498,7 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC=
_STRING),
 GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
-GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x03FFF801, PPC_MEM_EIEIO),
+GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
 GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 1a89017ddea8..6b70f6dc5a2c 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8847,7 +8847,8 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                         PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300 | PPC2_PR=
CNTL;
+                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300 | PPC2_PR=
CNTL |
+                        PPC2_MEM_EIEIO2;
     pcc->msr_mask =3D (1ull << MSR_SF) |
                     (1ull << MSR_TM) |
                     (1ull << MSR_VR) |
--=20
2.13.6
