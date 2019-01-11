Received: from eggs.gnu.org ([209.51.188.92]:52540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gi45K-00040u-0N
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gi45H-0005vQ-M9
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:11:21 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gi45G-0005uy-BD
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:11:19 -0500
Received: by mail-pl1-x641.google.com with SMTP id gn14so7279423plb.10
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 13:11:17 -0800 (PST)
References: <20190111114918.27893-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e61a4039-cf71-973d-0a11-b77c6c7eed75@linaro.org>
Date: Sat, 12 Jan 2019 08:11:11 +1100
MIME-Version: 1.0
In-Reply-To: <20190111114918.27893-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: rework zero overhead loops
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org

On 1/11/19 10:49 PM, Max Filippov wrote:
> @@ -706,6 +716,17 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
>      *flags |= xtensa_get_ring(env);
>      if (env->sregs[PS] & PS_EXCM) {
>          *flags |= XTENSA_TBFLAG_EXCM;
> +    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
> +        target_ulong lend_dist = env->sregs[LEND] - (env->pc & LINKABLE_MASK);
> +
> +        if (lend_dist < LINKABLE_SIZE + env->config->max_insn_size) {
> +            target_ulong lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
> +
> +            *cs_base = lend_dist;
> +            if (lbeg_off < 256) {
> +                *cs_base |= lbeg_off << XTENSA_CSBASE_LBEG_OFF_SHIFT;
> +            }
> +        }
>      }
>      if (xtensa_option_enabled(env->config, XTENSA_OPTION_EXTENDED_L32R) &&
>              (env->sregs[LITBASE] & 1)) {

I think the only other thing that would be nice is some comment that describes
the loop scheme.  I can follow it now, but it took a while of re-reading.  In
particular, the fact that 0 means "disabled", and happens to work because we
(correctly) only check for LEND at the end of an instruction.  Thus the offset
from pc_first will always be non-zero when we check.


r~
