Received: from eggs.gnu.org ([2001:4830:134:3::10]:44590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2k-0001it-MO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2i-0006g7-H5
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:18 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39444 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2i-0006eo-8C
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:16 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:41 +0200
Message-Id: <1539779635-15445-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/27] target/mips: Increase 'supported
 ISAs/ASEs' flag holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Increase the size of insn_flags holder size to 64 bits. This is
needed for future extensions since existing bits are almost all used.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 2 +-
 target/mips/internal.h  | 2 +-
 target/mips/translate.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 37703ea..3b3509c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -811,7 +811,7 @@ struct CPUMIPSState {
     int CCRes; /* Cycle count resolution/divisor */
     uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
     uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus=
 */
-    int insn_flags; /* Supported instruction set */
+    uint64_t insn_flags; /* Supported instruction set */
=20
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/target/mips/internal.h b/target/mips/internal.h
index e41051f..bfe83ee 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -59,7 +59,7 @@ struct mips_def_t {
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
     target_ulong CP0_EBaseWG_rw_bitmask;
-    int insn_flags;
+    uint64_t insn_flags;
     enum mips_mmu_types mmu_type;
 };
=20
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4d652dc..ce4a1bd 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1987,7 +1987,7 @@ typedef struct DisasContext {
     target_ulong saved_pc;
     target_ulong page_start;
     uint32_t opcode;
-    int insn_flags;
+    uint64_t insn_flags;
     int32_t CP0_Config1;
     int32_t CP0_Config3;
     int32_t CP0_Config5;
@@ -2410,7 +2410,7 @@ static inline void check_dspr2(DisasContext *ctx)
=20
 /* This code generates a "reserved instruction" exception if the
    CPU does not support the instruction set corresponding to flags. */
-static inline void check_insn(DisasContext *ctx, int flags)
+static inline void check_insn(DisasContext *ctx, uint64_t flags)
 {
     if (unlikely(!(ctx->insn_flags & flags))) {
         generate_exception_end(ctx, EXCP_RI);
@@ -2420,7 +2420,7 @@ static inline void check_insn(DisasContext *ctx, in=
t flags)
 /* This code generates a "reserved instruction" exception if the
    CPU has corresponding flag set which indicates that the instruction
    has been removed. */
-static inline void check_insn_opc_removed(DisasContext *ctx, int flags)
+static inline void check_insn_opc_removed(DisasContext *ctx, uint64_t fl=
ags)
 {
     if (unlikely(ctx->insn_flags & flags)) {
         generate_exception_end(ctx, EXCP_RI);
--=20
2.7.4
