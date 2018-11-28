Received: from eggs.gnu.org ([2001:4830:134:3::10]:38201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRz8p-0008JG-R1
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRz8m-0004IN-LD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:40:31 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRz8m-0004G8-Cc
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:40:28 -0500
Received: by mail-wm1-x32e.google.com with SMTP id 125so2478446wmh.0
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 04:40:27 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org>
	<87lg5f51sz.fsf@linaro.org>
	<e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
	<20181126190733.GC6688@flamenco>
	<7ff01881-3130-ef72-217d-511b4de0cd3c@linaro.org>
	<20181127013825.GE22108@flamenco> <20181128005402.GA1523@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181128005402.GA1523@flamenco>
Date: Wed, 28 Nov 2018 12:40:23 +0000
Message-ID: <87a7lt4bpk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>


Emilio G. Cota <cota@braap.org> writes:

> On Mon, Nov 26, 2018 at 20:38:25 -0500, Emilio G. Cota wrote:
>> On Mon, Nov 26, 2018 at 11:30:25 -0800, Richard Henderson wrote:
>> > On 11/26/18 11:07 AM, Emilio G. Cota wrote:
>> > > The main reason why I added the qemu_plugin_insn_append calls
>> > > was to avoid reading the instructions twice from guest memory,
>> > > because I was worried that doing so might somehow alter the
>> > > guest's execution, e.g. what if we read a cross-page instruction,
>> > > and both pages mapped to the same TLB entry? We'd end up having
>> > > more TLB misses because instrumentation was enabled.
>> >
>> > A better solution for this, I think is to change direct calls from
>> >
>> >   cpu_ldl_code(env, pc);
>> > to
>> >   translator_ldl_code(dc_base, env, pc);
>> >
>> > instead of passing around a new argument separate from DisasContextBase?
>>
>> I think this + diff'ing pc_next should work to figure out the
>> contents and size of each instruction.
>
> I just tried doing things this way.
>
> For some targets like i386, the translator_ld* helpers work
> great; the instruction contents are copied, and through
> the helpers we get the sizes of the instructions as well.
>
> For ARM though (and maybe others, I haven't gone
> through all of them yet), arm_ldl_code does the following:
>
> /* Load an instruction and return it in the standard little-endian order */
> static inline uint32_t arm_ldl_code(CPUARMState *env, target_ulong addr,
>                                     bool sctlr_b)
> {
>     uint32_t insn = cpu_ldl_code(env, addr);
>     if (bswap_code(sctlr_b)) {
>         return bswap32(insn);
>     }
>     return insn;
> }
>
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
>
> (NB. tcg_ctx->plugin_insn is updated by translator_loop
> on every iteration.)
>
> Let me know if you think I should do this differently.

I was envisioning something more like the following so all the plugin
gubins could be kept in the core code:

accel/tcg/translator.c    | 25 +++++++++++++++++++++++++
include/exec/translator.h | 10 ++++++++++
target/arm/arm_ldst.h     | 16 +++-------------

modified   accel/tcg/translator.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/bswap.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
@@ -18,6 +19,30 @@
 #include "exec/log.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
+#include "exec/cpu_ldst.h"
+
+/*
+ * Translator Code Load Helpers
+ */
+
+uint16_t translator_ld16(CPUArchState *env, target_ulong ptr, bool bswap)
+{
+    uint16_t insn = cpu_lduw_code(env, ptr);
+    if (bswap) {
+        insn = bswap16(insn);
+    }
+    return insn;
+}
+
+uint32_t translator_ld32(CPUArchState *env, target_ulong ptr, bool bswap)
+{
+    uint32_t insn = cpu_ldl_code(env, ptr);
+    if (bswap) {
+        insn = bswap32(insn);
+    }
+    return insn;
+}
+

 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
modified   include/exec/translator.h
@@ -147,4 +147,14 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,

 void translator_loop_temp_check(DisasContextBase *db);

+/*
+ * Translator Code Load Helpers
+ *
+ * These allow the core translator code to track where code is being
+ * loaded from.
+ */
+
+uint16_t translator_ld16(CPUArchState *env, target_ulong ptr, bool bswap);
+uint32_t translator_ld32(CPUArchState *env, target_ulong ptr, bool bswap);
+
 #endif  /* EXEC__TRANSLATOR_H */
modified   target/arm/arm_ldst.h
@@ -20,25 +20,19 @@
 #ifndef ARM_LDST_H
 #define ARM_LDST_H

-#include "exec/cpu_ldst.h"
-#include "qemu/bswap.h"
+#include "exec/translator.h"

 /* Load an instruction and return it in the standard little-endian order */
 static inline uint32_t arm_ldl_code(CPUARMState *env, target_ulong addr,
                                     bool sctlr_b)
 {
-    uint32_t insn = cpu_ldl_code(env, addr);
-    if (bswap_code(sctlr_b)) {
-        return bswap32(insn);
-    }
-    return insn;
+    return translator_ld32(env, addr, bswap_code(sctlr_b));
 }

 /* Ditto, for a halfword (Thumb) instruction */
 static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
                                      bool sctlr_b)
 {
-    uint16_t insn;
 #ifndef CONFIG_USER_ONLY
     /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
        within each word.  Undo that now.  */
@@ -46,11 +40,7 @@ static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
         addr ^= 2;
     }
 #endif
-    insn = cpu_lduw_code(env, addr);
-    if (bswap_code(sctlr_b)) {
-        return bswap16(insn);
-    }
-    return insn;
+    return translator_ld16(env, addr, bswap_code(sctlr_b));
 }

 #endif
