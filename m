Received: from eggs.gnu.org ([2001:4830:134:3::10]:54978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEYr3-0002pE-4B
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEYqz-0006Cx-Vy
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:58:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43879 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEYqz-0005Sy-KU
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:58:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 13:57:25 +0200
Message-Id: <1540209445-28831-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540209445-28831-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540209445-28831-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/2] target/mips: Fix decoding of ALIGN and
 DALIGN instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Opcode for ALIGN and DALIGN must be in fact ranges of opcodes, to
allow paremeter 'bp' to occupy two and three bits, respectively.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1afb105..e5db92e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -463,8 +463,10 @@ enum {
     OPC_WSBH      = (0x02 << 6) | OPC_BSHFL,
     OPC_SEB       = (0x10 << 6) | OPC_BSHFL,
     OPC_SEH       = (0x18 << 6) | OPC_BSHFL,
-    OPC_ALIGN     = (0x08 << 6) | OPC_BSHFL, /* 010.bp */
-    OPC_ALIGN_END = (0x0B << 6) | OPC_BSHFL, /* 010.00 to 010.11 */
+    OPC_ALIGN     = (0x08 << 6) | OPC_BSHFL, /* 010.bp (010.00 to 010.11) */
+    OPC_ALIGN_1   = (0x09 << 6) | OPC_BSHFL,
+    OPC_ALIGN_2   = (0x0A << 6) | OPC_BSHFL,
+    OPC_ALIGN_3   = (0x0B << 6) | OPC_BSHFL,
     OPC_BITSWAP   = (0x00 << 6) | OPC_BSHFL  /* 00000 */
 };
 
@@ -474,8 +476,14 @@ enum {
 enum {
     OPC_DSBH       = (0x02 << 6) | OPC_DBSHFL,
     OPC_DSHD       = (0x05 << 6) | OPC_DBSHFL,
-    OPC_DALIGN     = (0x08 << 6) | OPC_DBSHFL, /* 01.bp */
-    OPC_DALIGN_END = (0x0F << 6) | OPC_DBSHFL, /* 01.000 to 01.111 */
+    OPC_DALIGN     = (0x08 << 6) | OPC_DBSHFL, /* 01.bp (01.000 to 01.111) */
+    OPC_DALIGN_1   = (0x09 << 6) | OPC_DBSHFL,
+    OPC_DALIGN_2   = (0x0A << 6) | OPC_DBSHFL,
+    OPC_DALIGN_3   = (0x0B << 6) | OPC_DBSHFL,
+    OPC_DALIGN_4   = (0x0C << 6) | OPC_DBSHFL,
+    OPC_DALIGN_5   = (0x0D << 6) | OPC_DBSHFL,
+    OPC_DALIGN_6   = (0x0E << 6) | OPC_DBSHFL,
+    OPC_DALIGN_7   = (0x0F << 6) | OPC_DBSHFL,
     OPC_DBITSWAP   = (0x00 << 6) | OPC_DBSHFL, /* 00000 */
 };
 
@@ -23957,7 +23965,9 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
             op2 = MASK_BSHFL(ctx->opcode);
             switch (op2) {
             case OPC_ALIGN:
-            case OPC_ALIGN_END:
+            case OPC_ALIGN_1:
+            case OPC_ALIGN_2:
+            case OPC_ALIGN_3:
                 gen_align(ctx, 32, rd, rs, rt, sa & 3);
                 break;
             case OPC_BITSWAP:
@@ -23983,7 +23993,13 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
             op2 = MASK_DBSHFL(ctx->opcode);
             switch (op2) {
             case OPC_DALIGN:
-            case OPC_DALIGN_END:
+            case OPC_DALIGN_1:
+            case OPC_DALIGN_2:
+            case OPC_DALIGN_3:
+            case OPC_DALIGN_4:
+            case OPC_DALIGN_5:
+            case OPC_DALIGN_6:
+            case OPC_DALIGN_7:
                 gen_align(ctx, 64, rd, rs, rt, sa & 7);
                 break;
             case OPC_DBITSWAP:
@@ -24843,7 +24859,9 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         op2 = MASK_BSHFL(ctx->opcode);
         switch (op2) {
         case OPC_ALIGN:
-        case OPC_ALIGN_END:
+        case OPC_ALIGN_1:
+        case OPC_ALIGN_2:
+        case OPC_ALIGN_3:
         case OPC_BITSWAP:
             check_insn(ctx, ISA_MIPS32R6);
             decode_opc_special3_r6(env, ctx);
@@ -24869,7 +24887,13 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         op2 = MASK_DBSHFL(ctx->opcode);
         switch (op2) {
         case OPC_DALIGN:
-        case OPC_DALIGN_END:
+        case OPC_DALIGN_1:
+        case OPC_DALIGN_2:
+        case OPC_DALIGN_3:
+        case OPC_DALIGN_4:
+        case OPC_DALIGN_5:
+        case OPC_DALIGN_6:
+        case OPC_DALIGN_7:
         case OPC_DBITSWAP:
             check_insn(ctx, ISA_MIPS32R6);
             decode_opc_special3_r6(env, ctx);
-- 
2.7.4
