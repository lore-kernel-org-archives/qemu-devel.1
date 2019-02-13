Received: from eggs.gnu.org ([209.51.188.92]:44575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtu9g-0004PW-WF
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtu22-0001iR-Gn
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:52:55 -0500
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-14-david@redhat.com>
	<ed96b3d1-309a-4e39-2386-52b76dd38567@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0784fb21-a3f1-70b7-28a6-e43925ff17f8@redhat.com>
Date: Wed, 13 Feb 2019 13:52:29 +0100
MIME-Version: 1.0
In-Reply-To: <ed96b3d1-309a-4e39-2386-52b76dd38567@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 12/15] s390x/tcg: Implement XxC and
 checks for most FP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 12.02.19 21:23, Richard Henderson wrote:
> On 2/12/19 3:03 AM, David Hildenbrand wrote:
>> -uint64_t HELPER(cegb)(CPUS390XState *env, int64_t v2, uint32_t m3)
>> +uint64_t HELPER(cegb)(CPUS390XState *env, int64_t v2, uint32_t m)
>>  {
>> -    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
>> +    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
>>  
>>      float32 ret = int64_to_float32(v2, &env->fpu_status);
>>      s390_restore_bfp_rounding_mode(env, old_mode);
>> -    handle_exceptions(env, false, GETPC());
>> +    handle_exceptions(env, (m >> 8) & 1, GETPC());
>>      return ret;
>>  }
> 
> It might be helpful to have inlines for these extractions.  E.g
> 
> static inline uint32_t round_from_m34(uint32_t m);
> static inline bool xxc_from_m34(uint32_t m);
> 
>>  static DisasJumpType op_cfeb(DisasContext *s, DisasOps *o)
>>  {
>> -    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
>> -    gen_helper_cfeb(o->out, cpu_env, o->in2, m3);
>> -    tcg_temp_free_i32(m3);
>> +    TCGv_i32 m;
>> +
>> +    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
>> +        gen_program_exception(s, PGM_SPECIFICATION);
>> +        return DISAS_NORETURN;
>> +    }
>> +    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
>> +    gen_helper_cfeb(o->out, cpu_env, o->in2, m);
>> +    tcg_temp_free_i32(m);
>>      gen_set_cc_nz_f32(s, o->in2);
>>      return DISAS_NEXT;
>>  }
> 
> The m4 field does not exist unless fp extension facility is enabled.  You
> should ignore the field if not installed.

As all users I know already take the floating-point extension facility
for granted, I wanted to avoid faking it away for now. Old
implementations set all fields to zero either way. But I'll take another
shot if it can be easily added without uglifying the code.

> 
> It would be good to split this out to a helper, since there are so many copies.
>  E.g.
> 
> static bool extract_m3_m4(DisasContext *s, uint32_t *m34)
> {
>     int m3 = get_field(s->fields, m3);
>     int m4 = get_field(s->fields, m4);
> 
>     if (!valid_bfp_rounding_mode(m3)) {
>         gen_program_exception(s, PGM_SPECIFICATION);
>         return false;
>     }
>     if (feature) {
>         return deposit32(m3, 8, 1, m4);
>     }
>     return m3;
> }

Okay, I'll play with it to see what the end result would look like.

> 
> Hmm..  Except that I see we don't have enough stored in DisasContext to allow
> you to look up the proper feature.  So perhaps just a FIXME for now?

We do have s390_has_feat(S390_FEAT_FLOATING_POINT_EXT)

> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
