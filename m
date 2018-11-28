Received: from eggs.gnu.org ([2001:4830:134:3::10]:57597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRoOu-0006um-52
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRoOq-0006i3-66
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:12:24 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51973)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRoOp-0006h9-UV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:12:20 -0500
Date: Tue, 27 Nov 2018 20:12:17 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181128011217.GA9976@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org>
	<87lg5f51sz.fsf@linaro.org>
	<e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
	<20181126190733.GC6688@flamenco>
	<7ff01881-3130-ef72-217d-511b4de0cd3c@linaro.org>
	<20181127013825.GE22108@flamenco> <20181128005402.GA1523@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128005402.GA1523@flamenco>
Subject: Re: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument
 to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>

On Tue, Nov 27, 2018 at 19:54:02 -0500, Emilio G. Cota wrote:
> To avoid altering the signature of .translate_insn, I've modified
> arm_ldl_code directly, as follows:
> 
>      uint32_t insn = cpu_ldl_code(env, addr);
> +
>      if (bswap_code(sctlr_b)) {
> -        return bswap32(insn);
> +        insn = bswap32(insn);
> +    }
> +    if (tcg_ctx->plugin_insn) {
> +        qemu_plugin_insn_append(tcg_ctx->plugin_insn, &insn, sizeof(insn));
>      }
>      return insn;
>  }

Turns out it got even more complicated with thumb, since instructions
can be 16 or 32 bits.

I ended up with the appended (qemu_plugin_insn_append() returns
when the first argument is NULL).

		Emilio

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 88195ab949..e6caaff976 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -38,6 +38,7 @@
 #include "trace-tcg.h"
 #include "translate-a64.h"
 #include "qemu/atomic128.h"
+#include "qemu/plugin.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
@@ -13321,6 +13322,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     uint32_t insn;
 
     insn = arm_ldl_code(env, s->pc, s->sctlr_b);
+    qemu_plugin_insn_append(tcg_ctx->plugin_insn, &insn, sizeof(insn));
     s->insn = insn;
     s->pc += 4;
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7c4675ffd8..7523257b85 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -36,6 +36,7 @@
 
 #include "trace-tcg.h"
 #include "exec/log.h"
+#include "qemu/plugin.h"
 
 
 #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
@@ -13234,6 +13235,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
+    qemu_plugin_insn_append(tcg_ctx->plugin_insn, &insn, sizeof(insn));
     dc->insn = insn;
     dc->pc += 4;
     disas_arm_insn(dc, insn);
@@ -13304,11 +13306,16 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
     is_16bit = thumb_insn_is_16bit(dc, insn);
     dc->pc += 2;
-    if (!is_16bit) {
+    if (is_16bit) {
+        uint16_t insn16 = insn;
+
+        qemu_plugin_insn_append(tcg_ctx->plugin_insn, &insn16, sizeof(insn16));
+    } else {
         uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);
 
         insn = insn << 16 | insn2;
         dc->pc += 2;
+        qemu_plugin_insn_append(tcg_ctx->plugin_insn, &insn, sizeof(insn));
     }
     dc->insn = insn;
 
