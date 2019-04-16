Received: from eggs.gnu.org ([209.51.188.92]:48653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGShL-0004K8-IJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGShK-0003Ec-Et
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:20:47 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-42-david@redhat.com>
	<0871b6f8-6073-4311-78a5-4772817a009e@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5cadf319-7320-85a1-67d4-e03638cc4d63@redhat.com>
Date: Tue, 16 Apr 2019 20:20:42 +0200
MIME-Version: 1.0
In-Reply-To: <0871b6f8-6073-4311-78a5-4772817a009e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 41/41] s390x/tcg: Implement VECTOR TEST
 UNDER MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13.04.19 08:28, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> +void HELPER(gvec_vtm)(void *v1, const void *v2, CPUS390XState *env,
>> +                      uint32_t desc)
>> +{
>> +    S390Vector tmp;
>> +
>> +    s390_vec_and(&tmp, v1, v2);
>> +    if (s390_vec_is_zero(&tmp)) {
>> +        /* Selected bits all zeros; or all mask bits zero */
>> +        env->cc_op = 0;
>> +    } else if (s390_vec_equal(&tmp, v2)) {
>> +        /* Selected bits all ones */
>> +        env->cc_op = 3;
>> +    } else {
>> +        /* Selected bits a mix of zeros and ones */
>> +        env->cc_op = 1;
>> +    }
>> +}
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> However, if you return this value, then you can do
> 
> DEF_HELPER_FLAGS_4(gvec_vtm, TCG_CALL_NO_RWG_SE, i32, cptr, cptr)
> 
> static DisasJumpType op_vtm(DisasContext *s, DisasOps *o)
> {
>     TCGv_ptr p1 = tcg_temp_new_ptr();
>     TCGv_ptr p2 = tcg_temp_new_ptr();
> 
>     tcg_gen_addi_ptr(p1, cpu_env,
>         vec_full_reg_offset(get_field(s->fields, v1)));
>     tcg_gen_addi_ptr(p2, cpu_env,
>         vec_full_reg_offset(get_field(s->fields, v2)));
>     gen_helper_gvec_vtm(cc_op, p1, p2);
>     tcg_temp_free_ptr(p1);
>     tcg_temp_free_ptr(p2);
>     set_cc_static(s);
>     return DISAS_NEXT;
> }
> 
> Perhaps it doesn't matter though, since use of vtm probably implies a jump,
> which implies end of TB, which means that registers are going to get saved to
> backing store anyway.

Had a similar idea, but I guess it doesn't really matter. This way, we
can at least use standardized gvec ool helpers. Will leave it as is for
now, thanks!


-- 

Thanks,

David / dhildenb
