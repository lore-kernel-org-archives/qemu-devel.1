Received: from eggs.gnu.org ([2001:4830:134:3::10]:41623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXFLt-0008SW-Fg
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXFLq-0000jp-Al
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:27:29 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:46492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXFLq-0000jS-4r
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:27:26 -0400
Received: by mail-pg0-x242.google.com with SMTP id q14-v6so1503844pgt.13
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 17:27:26 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-20-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0cc3d11-6e8c-b214-5cf0-4f6197a04457@linaro.org>
Date: Sun, 24 Jun 2018 17:27:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-20-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/35] target/mips: Implement nanoMIPS
 LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 05:06 AM, Yongbok Kim wrote:
> +void helper_llwp(CPUMIPSState *env, target_ulong addr, uint32_t reg1,
> +                 uint32_t reg2, uint32_t mem_idx)
> +{
> +    if (addr & 0x7) {
> +        env->CP0_BadVAddr = addr;
> +        do_raise_exception(env, EXCP_AdEL, GETPC());
> +    }
> +    env->lladdr = do_translate_address(env, addr, 0, GETPC());
> +    env->active_tc.gpr[reg1] = env->llval = do_lw(env, addr, mem_idx, GETPC());
> +    env->active_tc.gpr[reg2] = env->llval_wp = do_lw(env, addr + 4, mem_idx,
> +                                                     GETPC());
> +}

Performing two loads is a mistake.  You need to perform one single 64-bit load
in order for this to be atomic.  There is also no point in performing such out
of line.


> +target_ulong helper_scwp(CPUMIPSState *env, target_ulong addr,
> +                         uint64_t data, int mem_idx)
> +{
> +    uint32_t tmp;
> +    uint32_t tmp2;
> +
> +    if (addr & 0x7) {
> +        env->CP0_BadVAddr = addr;
> +        do_raise_exception(env, EXCP_AdES, GETPC());
> +    }
> +    if (do_translate_address(env, addr, 1, GETPC()) == env->lladdr) {
> +        tmp = do_lw(env, addr, mem_idx, GETPC());
> +        tmp2 = do_lw(env, addr + 4, mem_idx, GETPC());
> +        if (tmp == env->llval && tmp2 == env->llval_wp) {
> +            do_sw(env, addr, (uint32_t) data, mem_idx, GETPC());
> +            do_sw(env, addr + 4, (uint32_t) *(&data + 4), mem_idx, GETPC());

This must use a 64-bit atomic_cmpxchg.
This can also be done inline with

  tcg_gen_atomic_cmpxchg_i64.


r~
