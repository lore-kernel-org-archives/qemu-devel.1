Received: from eggs.gnu.org ([2001:4830:134:3::10]:40291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXqna-0006Fb-MD
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXqnX-0006sb-I8
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:22:02 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:6526)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXqnX-0006sP-Bd
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:21:59 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 19 Jul 2017 16:21:42 +0100
Message-ID: <4053c89eefa69e2b4aa3e1072a6ae975b8d87734.1500477656.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] target/mips: Fix microMIPS jumps in 128MB block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Nathan Froyd <froydnj@codesourcery.com>

Three microMIPS jump instruction encodings (namely J32, JAL32, JALS32)
shift their 26-bit immediate field by 1 instead of 2, allowing a jump
only within the 128MB aligned block rather than the more common 256MB
aligned block.

This wasn't being taken into account when masking the address of the
delay slot in gen_compute_branch(), resulting in bit 27 of the PC being
cleared. This meant that any such jump in an odd 128MB block incorrectly
jumped to the even 128MB block before it.

For example this jals jumped to 0x17000010:
1f00000a:	7780 0008 	jals	1f000010 <.L11>

And this jal jumped to 0x17000022:
1f00001a:	f780 0011 	jal	1f000022 <.L12>

And this j jumped to 0x17000030:
1f00002a:	d780 0018 	j	1f000030 <.L13>

All three encodings pass OPC_J or OPC_JAL to gen_compute_branch(), so
allow the mask applied to the delay slot address to be changed from
0xF0000000 to 0xF8000000 for these opcodes, but only when microMIPS is
in use.

Fixes: 3c824109da07 ("target-mips: microMIPS ASE support")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Nathan Froyd <froydnj@codesourcery.com>
---
 target/mips/translate.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3022f349cb2a..7071b124344a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4248,6 +4248,7 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
     int bcond_compute = 0;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
+    int32_t seg_mask = 0xF0000000;      /* 256 MB-aligned region */
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
@@ -4303,9 +4304,15 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
         break;
     case OPC_J:
     case OPC_JAL:
+        /* microMIPS J32, JAL32 & JALS32 offsets are in 128 MB region not 256 */
+        if ((ctx->hflags & MIPS_HFLAG_M16) &&
+            (ctx->insn_flags & ASE_MICROMIPS)) {
+            seg_mask = 0xF8000000;      /* 128 MB-aligned region */
+        }
+        /* fall through */
     case OPC_JALX:
         /* Jump to immediate */
-        btgt = ((ctx->pc + insn_bytes) & (int32_t)0xF0000000) | (uint32_t)offset;
+        btgt = ((ctx->pc + insn_bytes) & seg_mask) | (uint32_t)offset;
         break;
     case OPC_JR:
     case OPC_JALR:
-- 
git-series 0.8.10
