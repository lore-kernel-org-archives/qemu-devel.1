Received: from eggs.gnu.org ([2001:4830:134:3::10]:39331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyod7-0004JH-NG
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 21:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyod3-0001Kd-RY
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 21:35:13 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyod1-0001HE-Qr
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 21:35:09 -0400
Received: by mail-wm0-x242.google.com with SMTP id s12-v6so18069382wmc.0
	for <qemu-devel@nongnu.org>; Sat, 08 Sep 2018 18:35:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  9 Sep 2018 02:34:43 +0100
Message-Id: <20180909013444.18936-2-f4bug@amsat.org>
In-Reply-To: <20180909013444.18936-1-f4bug@amsat.org>
References: <20180909013444.18936-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] target/mips: Increase the 'supported
 instructions' flags holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

Currently this holder is limited to at most 32 flags on
a 32-bit architecture, which lets an unique bit available
for another 'chip specific instructions' flag.

Relax this limit using a 64-bit integer.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.h       | 2 +-
 target/mips/internal.h  | 2 +-
 target/mips/translate.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 28af4d191c..f2a5031fd2 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -614,7 +614,7 @@ struct CPUMIPSState {
     int CCRes; /* Cycle count resolution/divisor */
     uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
     uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus */
-    int insn_flags; /* Supported instruction set */
+    uint64_t insn_flags; /* Supported instruction set */
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/target/mips/internal.h b/target/mips/internal.h
index e41051f8e6..bfe83ee613 100644
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
 
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ab16cdb911..3b4e9ebae9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1870,7 +1870,7 @@ static inline void check_dspr2(DisasContext *ctx)
 
 /* This code generates a "reserved instruction" exception if the
    CPU does not support the instruction set corresponding to flags. */
-static inline void check_insn(DisasContext *ctx, int flags)
+static inline void check_insn(DisasContext *ctx, uint64_t flags)
 {
     if (unlikely(!(ctx->insn_flags & flags))) {
         generate_exception_end(ctx, EXCP_RI);
@@ -1880,7 +1880,7 @@ static inline void check_insn(DisasContext *ctx, int flags)
 /* This code generates a "reserved instruction" exception if the
    CPU has corresponding flag set which indicates that the instruction
    has been removed. */
-static inline void check_insn_opc_removed(DisasContext *ctx, int flags)
+static inline void check_insn_opc_removed(DisasContext *ctx, uint64_t flags)
 {
     if (unlikely(ctx->insn_flags & flags)) {
         generate_exception_end(ctx, EXCP_RI);
-- 
2.19.0.rc2
