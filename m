Received: from eggs.gnu.org ([2001:4830:134:3::10]:46675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRlpG-0003xm-Ll
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRlpD-0004v3-DX
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:18:22 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:55168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cRlpD-0004tu-1j
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:18:19 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 12 Jan 2017 21:18:01 +0100
Message-Id: <1484252284-29291-3-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484252284-29291-1-git-send-email-laurent@vivier.eu>
References: <1484252284-29291-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/5] target-m68k: fix gen_flush_flags()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Laurent Vivier <laurent@vivier.eu>

gen_flush_flags() is setting unconditionally cc_op_synced to 1
and s->cc_op to CC_OP_FLAGS, whereas env->cc_op can be set
to something else by a previous tcg fragment.

We fix that by not setting cc_op_synced to 1
(except for gen_helper_flush_flags() that updates env->cc_op)

FIX: https://github.com/vivier/qemu-m68k/issues/19

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 410f56a..0e97900 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -595,18 +595,19 @@ static void gen_flush_flags(DisasContext *s)
 
     case CC_OP_DYNAMIC:
         gen_helper_flush_flags(cpu_env, QREG_CC_OP);
+        s->cc_op_synced = 1;
         break;
 
     default:
         t0 = tcg_const_i32(s->cc_op);
         gen_helper_flush_flags(cpu_env, t0);
         tcg_temp_free(t0);
+        s->cc_op_synced = 1;
         break;
     }
 
     /* Note that flush_flags also assigned to env->cc_op.  */
     s->cc_op = CC_OP_FLAGS;
-    s->cc_op_synced = 1;
 }
 
 static inline TCGv gen_extend(TCGv val, int opsize, int sign)
-- 
2.7.4
