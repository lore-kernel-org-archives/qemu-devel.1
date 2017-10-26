Received: from eggs.gnu.org ([2001:4830:134:3::10]:56431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjs-0007oY-BL
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjp-0002jM-Ud
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:16 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:56663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7fjp-0002iZ-Ku
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:13 -0400
Received: by mail-wr0-x241.google.com with SMTP id r79so2700250wrb.13
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 03:50:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Oct 2017 12:50:04 +0200
Message-Id: <20171026105007.31777-2-richard.henderson@linaro.org>
In-Reply-To: <20171026105007.31777-1-richard.henderson@linaro.org>
References: <20171026105007.31777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/4] target/i386: Decode AMD XOP prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7df9233ded..db88cc4764 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4536,8 +4536,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #endif
     case 0xc5: /* 2-byte VEX */
     case 0xc4: /* 3-byte VEX */
+    case 0x8f: /* 3-byte XOP */
         /* VEX prefixes cannot be used except in 32-bit mode.
-           Otherwise the instruction is LES or LDS.  */
+           Otherwise the instruction is LES, LDS, or POP.  */
         if (s->code32 && !s->vm86) {
             static const int pp_prefix[4] = {
                 0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
@@ -4546,7 +4547,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
                 /* 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,
-                   otherwise the instruction is LES or LDS.  */
+                   otherwise the instruction is LES, LDS, or POP.  */
+                break;
+            }
+            if (b == 0x8f && (vex2 & 0x1f) < 8) {
+                /* If the value of the XOP.map_select field is less than 8,
+                   the first two bytes of the three-byte XOP are interpreted
+                   as a form of the POP instruction.  */
                 break;
             }
             s->pc++;
@@ -4572,18 +4579,25 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #endif
                 vex3 = x86_ldub_code(env, s);
                 rex_w = (vex3 >> 7) & 1;
-                switch (vex2 & 0x1f) {
-                case 0x01: /* Implied 0f leading opcode bytes.  */
-                    b = x86_ldub_code(env, s) | 0x100;
-                    break;
-                case 0x02: /* Implied 0f 38 leading opcode bytes.  */
-                    b = 0x138;
-                    break;
-                case 0x03: /* Implied 0f 3a leading opcode bytes.  */
-                    b = 0x13a;
-                    break;
-                default:   /* Reserved for future use.  */
-                    goto unknown_op;
+                if (b == 0xc4) {
+                    switch (vex2 & 0x1f) {
+                    case 0x01: /* Implied 0f leading opcode bytes.  */
+                        b = x86_ldub_code(env, s) | 0x100;
+                        break;
+                    case 0x02: /* Implied 0f 38 leading opcode bytes.  */
+                        b = 0x138;
+                        break;
+                    case 0x03: /* Implied 0f 3a leading opcode bytes.  */
+                        b = 0x13a;
+                        break;
+                    default:   /* Reserved for future use.  */
+                        goto unknown_op;
+                    }
+                } else {
+                    /* Unlike VEX, XOP.map_select does not overlap the
+                       base instruction set.  Prepend the map_select to
+                       the next opcode byte.  */
+                    b = x86_ldub_code(env, s) + (vex2 & 0x1f) * 0x100;
                 }
             }
             s->vex_v = (~vex3 >> 3) & 0xf;
@@ -8307,6 +8321,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1d0 ... 0x1fe:
         gen_sse(env, s, b, pc_start, rex_r);
         break;
+
+    case 0x800 ... 0x8ff: /* XOP opcode map 8 */
+    case 0x900 ... 0x9ff: /* XOP opcode map 9 */
+    case 0xa00 ... 0xaff: /* XOP opcode map 10 */
     default:
         goto unknown_op;
     }
-- 
2.13.6
