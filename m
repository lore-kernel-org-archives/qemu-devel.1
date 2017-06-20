Received: from eggs.gnu.org ([2001:4830:134:3::10]:40479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNEHK-0003F6-6D
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNEHH-0001b0-2F
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNEHG-0001ag-PA
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:12:46 -0400
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-16-rth@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <169e898c-98f6-a6d6-7045-1b2606469fe4@redhat.com>
Date: Tue, 20 Jun 2017 10:12:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170620000405.3391-16-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/18] target/s390x: Implement SRSTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

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

This could theoretically wrap. Not sure how this is to be handled, do you?

> +
> +    /* Assume for now that R2 is unmodified.  */
> +    env->retxl = str;

If str was wrapped, r2 could be modified although it should not be touched.

> +
> +    /* Lest we fail to service interrupts in a timely manner, limit the
> +       amount of work we're willing to do.  For now, let's cap at 8k.  */
> +    for (len = 0; len < 0x2000; len += 2) {
> +        if (str + len == adj_end) {
> +            /* End of input found.  */
> +            env->cc_op = 2;
> +            return end;

If end was wrapped, r1 is modified here.

> +        }

Also str + len could wrap here. Not sure how this is to be handled.

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

Also wonder if r2 should be wrapped here. And if the "unused" bits
should be left unmodified here.

> +    env->cc_op = 3;
> +    return end;

Again, r1 could be modified here if end was wrapped.

> +}
> +
>  /* unsigned string compare (c is string terminator) */
>  uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
>  {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 4a860f1..e594b91 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4262,6 +4262,14 @@ static ExitStatus op_srst(DisasContext *s, DisasOps *o)
>      return NO_EXIT;
>  }
>  
> +static ExitStatus op_srstu(DisasContext *s, DisasOps *o)
> +{
> +    gen_helper_srstu(o->in1, cpu_env, o->in1, o->in2);
> +    set_cc_static(s);
> +    return_low128(o->in2);
> +    return NO_EXIT;
> +}
> +
>  static ExitStatus op_sub(DisasContext *s, DisasOps *o)
>  {
>      tcg_gen_sub_i64(o->out, o->in1, o->in2);
> 

Apart from special wrapping conditions, looks good to me!

(will scan the PoP how wrapping is to be handled in general during an
instruction. Some (like mvcos) mention it explicitly, others don't)

-- 

Thanks,

David
