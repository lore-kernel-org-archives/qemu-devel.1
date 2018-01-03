Received: from eggs.gnu.org ([2001:4830:134:3::10]:46788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWqy3-0003Xj-E9
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWqy0-0006bb-RK
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:52:59 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWqy0-0006b7-Kd
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:52:56 -0500
Received: by mail-pl0-x244.google.com with SMTP id b96so2034406pli.2
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:52:56 -0800 (PST)
References: <20180102234108.32713-1-laurent@vivier.eu>
	<20180102234108.32713-8-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5630ba80-503f-f7e7-2764-c433aa3ea19a@linaro.org>
Date: Wed, 3 Jan 2018 13:52:52 -0800
MIME-Version: 1.0
In-Reply-To: <20180102234108.32713-8-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 07/17] target/m68k: add chk and chk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/02/2018 03:40 PM, Laurent Vivier wrote:
> +void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
> +{
> +    if (val < 0 || val > ub) {
> +        CPUState *cs = CPU(m68k_env_get_cpu(env));
> +
> +        /* Recover PC and CC_OP for the beginning of the insn.  */
> +        cpu_restore_state(cs, GETPC());
> +
> +        /* Adjust PC and FLAGS to end of the insn.  */
> +        env->pc += 2;
> +        helper_flush_flags(env, env->cc_op);
> +        env->cc_n = val;
> +
> +        cs->exception_index = EXCP_CHK;
> +        cpu_loop_exit(cs);
> +    }
> +}
> +

I thought you said for 68040, N is always unset for val >= 0.
That would suggest

  helper_flush_flags(env, env->cc_op);
  env->cc_n = val;
  if (val < 0 || val > ub) {
    ...
  }

Did you examine the real hw change to the other flags?
Because they're officially undefined, which suggests

  env->cc_n = val;
  env->cc_op = CC_OP_LOGIC;

> +void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
> +{
> +    helper_flush_flags(env, env->cc_op);
> +
> +    env->cc_z = val != lb && val != ub;
> +    env->cc_c = lb <= ub ? val < lb || val > ub : val > ub && val < lb;
> +
> +    if (env->cc_c) {
> +        CPUState *cs = CPU(m68k_env_get_cpu(env));
> +
> +        cpu_restore_state(cs, GETPC());
> +        env->cc_op = CC_OP_FLAGS;

A comment that we're reverting a change made during unwind would be helpful here.


r~
