Received: from eggs.gnu.org ([2001:4830:134:3::10]:49134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOQtE-00084k-JR
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOQtD-0002Eu-Fw
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:52:56 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:38044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOQtD-0002Ef-9c
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:52:55 -0400
Date: Fri, 23 Jun 2017 17:52:52 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623155252.wsdzhaaj563oxkqz@aurel32.net>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-16-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620000405.3391-16-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 15/18] target/s390x: Implement SRSTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 2017-06-19 17:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/mem_helper.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   |  8 ++++++++
>  4 files changed, 55 insertions(+)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index cd51b89..58d7f5b 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -13,6 +13,7 @@ DEF_HELPER_FLAGS_3(divu32, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_3(divs64, TCG_CALL_NO_WG, s64, env, s64, s64)
>  DEF_HELPER_FLAGS_4(divu64, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
>  DEF_HELPER_3(srst, i64, env, i64, i64)
> +DEF_HELPER_3(srstu, i64, env, i64, i64)
>  DEF_HELPER_4(clst, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32, i64, i64)
>  DEF_HELPER_FLAGS_4(mvo, TCG_CALL_NO_WG, void, env, i32, i64, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 634ef98..1bebcf2 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -736,6 +736,8 @@
>  
>  /* SEARCH STRING */
>      C(0xb25e, SRST,    RRE,   Z,   r1_o, r2_o, 0, 0, srst, 0)
> +/* SEARCH STRING UNICODE */
> +    C(0xb9be, SRSTU,   RRE,   ETF3, r1_o, r2_o, 0, 0, srstu, 0)
>  
>  /* SET ACCESS */
>      C(0xb24e, SAR,     RRE,   Z,   0, r2_o, 0, 0, sar, 0)
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 990858e..ce288d9 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -578,6 +578,50 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t end, uint64_t str)
>      return end;
>  }
>  
> +uint64_t HELPER(srstu)(CPUS390XState *env, uint64_t end, uint64_t str)
> +{
> +    uintptr_t ra = GETPC();
> +    uint32_t len;
> +    uint16_t v, c = env->regs[0];
> +    uint64_t adj_end;
> +
> +    /* Bits 32-47 of R0 must be zero.  */
> +    if (env->regs[0] & 0xffff0000u) {
> +        cpu_restore_state(ENV_GET_CPU(env), ra);
> +        program_interrupt(env, PGM_SPECIFICATION, 6);
> +    }
> +
> +    str = wrap_address(env, str);
> +    end = wrap_address(env, end);
> +
> +    /* If the LSB of the two addresses differ, use one extra byte.  */
> +    adj_end = end + ((str ^ end) & 1);
> +
> +    /* Assume for now that R2 is unmodified.  */
> +    env->retxl = str;
> +
> +    /* Lest we fail to service interrupts in a timely manner, limit the
> +       amount of work we're willing to do.  For now, let's cap at 8k.  */
> +    for (len = 0; len < 0x2000; len += 2) {
> +        if (str + len == adj_end) {
> +            /* End of input found.  */
> +            env->cc_op = 2;
> +            return end;
> +        }
> +        v = cpu_lduw_data_ra(env, str + len, ra);
> +        if (v == c) {
> +            /* Character found.  Set R1 to the location; R2 is unmodified.  */
> +            env->cc_op = 1;
> +            return str + len;
> +        }
> +    }
> +
> +    /* CPU-determined bytes processed.  Advance R2 to next byte to process.  */
> +    env->retxl = str + len;
> +    env->cc_op = 3;
> +    return end;
> +}
> +
>  /* unsigned string compare (c is string terminator) */
>  uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
>  {

Overall that looks fine, but I think we should get the wrapping (almost)
correct, now that we have the get_address / set_address functions. As
all registers are saved on input, I guess the registers can be directly
written back in the helper using set_address. It should handle most of
the cases, except wrapping at the end of the address space, but anyway
I don't think it's handled somewhere.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
