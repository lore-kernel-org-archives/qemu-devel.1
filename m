Received: from eggs.gnu.org ([2001:4830:134:3::10]:50180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV2cC-0000H6-8e
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV2c9-0005ts-46
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:22:40 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dV2c8-0005tO-Vf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:22:37 -0400
Received: by mail-qk0-f195.google.com with SMTP id p21so682922qke.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 14:22:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 11 Jul 2017 11:21:22 -1000
Message-Id: <20170711212123.4368-2-rth@twiddle.net>
In-Reply-To: <20170711212123.4368-1-rth@twiddle.net>
References: <20170711212123.4368-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 1/2] target/i386: Decode AMD XOP prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, ricardo.ribalda@gmail.com

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index ed3b896..6082db2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4500,8 +4500,9 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
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
@@ -4510,7 +4511,13 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
 
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
@@ -4536,18 +4543,25 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
 #endif
                 vex3 = cpu_ldub_code(env, s->pc++);
                 rex_w = (vex3 >> 7) & 1;
-                switch (vex2 & 0x1f) {
-                case 0x01: /* Implied 0f leading opcode bytes.  */
-                    b = cpu_ldub_code(env, s->pc++) | 0x100;
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
+                        b = cpu_ldub_code(env, s->pc++) | 0x100;
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
+                    b = cpu_ldub_code(env, s->pc++) + (vex2 & 0x1f) * 0x100;
                 }
             }
             s->vex_v = (~vex3 >> 3) & 0xf;
@@ -8276,6 +8290,10 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
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
2.9.4
