Received: from eggs.gnu.org ([209.51.188.92]:48117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwE4C-0004zH-0K
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwE49-0008Nm-By
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:40:43 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:43379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwE47-0008Lz-HE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:40:41 -0500
Received: by mail-pg1-x530.google.com with SMTP id v28so10799867pgk.10
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 14:40:37 -0800 (PST)
References: <20190214040652.4811-1-richard.henderson@linaro.org>
	<20190214040652.4811-5-richard.henderson@linaro.org>
	<8736oj5y8s.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b7a1ab1-d156-bd86-ca89-f85e4f2046a3@linaro.org>
Date: Tue, 19 Feb 2019 14:40:32 -0800
MIME-Version: 1.0
In-Reply-To: <8736oj5y8s.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] target/arm: Rely on hflags correct in
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org

On 2/19/19 12:17 PM, Alex Bennée wrote:
> While debugging I came up with this monstrosity:
> 
>     if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
> #ifdef CONFIG_DEBUG_TCG
>         static uint32_t tb_state = 0;
>         uint32_t recalc_flags = rebuild_hflags_a64(env, arm_current_el(env));
>         tb_state++;
>         if (flags != recalc_flags) {
>             fprintf(stderr, "%s: flags %#x, should be %#x (%#x/%d)\n", __func__,
>                     flags, recalc_flags, flags ^ recalc_flags, tb_state);
>             abort();
>         }
> #endif
>         *pc = env->pc;
>         flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
>         pstate_for_ss = env->pstate;
>     } else {

I have now included

+#ifdef CONFIG_DEBUG_TCG
+    {
+        int el = arm_current_el(env);
+        uint32_t check_flags;
+        if (is_a64(env)) {
+            check_flags = rebuild_hflags_a64(env, el);
+        } else {
+            check_flags = rebuild_hflags_a32(env, el);
+        }
+        g_assert_cmphex(flags, ==, check_flags);
+    }
+#endif


r~
