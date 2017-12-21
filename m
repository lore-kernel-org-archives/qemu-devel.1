Received: from eggs.gnu.org ([2001:4830:134:3::10]:60797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6eB-0006Ar-Hk
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6e7-0005cJ-By
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:51 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:57800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eS6e7-0005ay-2T
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:47 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 21 Dec 2017 20:36:39 +0100
Message-Id: <20171221193640.27418-5-laurent@vivier.eu>
In-Reply-To: <20171221193640.27418-1-laurent@vivier.eu>
References: <20171221193640.27418-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/5] target/m68k: fix set_cc_op()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The first call of set_cc_op() in a new translation sequence
is done with old_op set to CC_OP_DYNAMIC (-1).

This will do an out of bound access to the array cc_op_live[].

We fix that by adding an entry in cc_op_live[] for CC_OP_DYNAMIC.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20171221160558.14151-1-laurent@vivier.eu>
---
 target/m68k/cpu.h       | 2 +-
 target/m68k/translate.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index afae5f68ac..5d03764eab 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -182,7 +182,7 @@ void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
  */
 typedef enum {
     /* Translator only -- use env->cc_op.  */
-    CC_OP_DYNAMIC = -1,
+    CC_OP_DYNAMIC,
 
     /* Each flag bit computed into cc_[xcnvz].  */
     CC_OP_FLAGS,
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index dfb2d5dad2..bbda7399ec 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -202,6 +202,7 @@ typedef void (*disas_proc)(CPUM68KState *env, DisasContext *s, uint16_t insn);
 #endif
 
 static const uint8_t cc_op_live[CC_OP_NB] = {
+    [CC_OP_DYNAMIC] = CCF_C | CCF_V | CCF_Z | CCF_N | CCF_X,
     [CC_OP_FLAGS] = CCF_C | CCF_V | CCF_Z | CCF_N | CCF_X,
     [CC_OP_ADDB ... CC_OP_ADDL] = CCF_X | CCF_N | CCF_V,
     [CC_OP_SUBB ... CC_OP_SUBL] = CCF_X | CCF_N | CCF_V,
-- 
2.14.3
