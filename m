Received: from eggs.gnu.org ([2001:4830:134:3::10]:53620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN42D-0005Qd-Vz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN42A-00028X-0X
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:16:33 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN429-00028T-Sm
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:16:29 -0400
Received: by mail-qk0-x22a.google.com with SMTP id a199so43699549qkb.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 14:16:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170611231633.32582-1-laurent@vivier.eu>
	<20170611231633.32582-8-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bc38850c-cc93-80da-1c67-534a42d3ebcd@twiddle.net>
Date: Mon, 19 Jun 2017 14:16:26 -0700
MIME-Version: 1.0
In-Reply-To: <20170611231633.32582-8-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 7/7] target-m68k: add FPCR and FPSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 06/11/2017 04:16 PM, Laurent Vivier wrote:
> @@ -95,8 +101,14 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
>           env->fregs[n].d = float64_to_floatx80(ldfq_p(mem_buf), &s);
>           return 8;
>       }
> -    if (n < 11) {
> -        /* FP control registers (not implemented)  */
> +    switch (n) {
> +    case 8: /* fpcontrol */
> +        env->fpcr = ldl_p(mem_buf);
> +        return 4;

Should use cpu_m68k_set_fpcr.


> +DEF_HELPER_2(set_fpcr, void, env, i32)

Hmm.  I suppose the write to env->fpcr means you can't indicate 
TCG_CALL_NO_RWG.  I wonder if it's better as

uint32_t HELPER(set_fpcr)(CPUM68KState *env, uint32_t val)
{
    cpu_m68k_set_fpcr(env, val);
    return env->fpcr;
}

DEF_HELPER_FLAGS_2(set_fpcr, i32, env, i32)

gen_helper_set_fpcr(QEMU_FPCR, cpu_env, val);

This skirts the rules of TCG, but it'll work, since we disguise the (incorrect) 
write to env->fpcr with a (correct but redundant) write to QEMU_FPCR.

Any time we can avoid spilling all globals we're better off.

As an alternative, is it really that important to represent FPSR and FPCR as 
tcg registers?  Perhaps it's better to just tcg_gen_ld/st instead?


r~
