Received: from eggs.gnu.org ([209.51.188.92]:41434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ0yj-0006zF-Os
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ0yi-0002Iu-1P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:21:17 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ0ye-0002Dd-31
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:21:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id z9so8074735pgu.10
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 12:21:10 -0700 (PDT)
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-18-richard.henderson@linaro.org>
	<0d4f60b4-84b7-6d36-b8d6-8107675200ff@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6824abca-a913-540d-55fe-c05823cc8c06@linaro.org>
Date: Tue, 23 Apr 2019 12:21:01 -0700
MIME-Version: 1.0
In-Reply-To: <0d4f60b4-84b7-6d36-b8d6-8107675200ff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/38] tcg: Add gvec expanders for vector
 shift by scalar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On 4/23/19 11:58 AM, David Hildenbrand wrote:
>> +void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
>> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
>> +void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
>> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
>> +void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
>> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
> 
> I assume all irrelevant bits of the shift have to be masked off by the
> caller, right?

Correct, just like for integers.

> 
> On s390x, I would use it for (one variant of) VECTOR ELEMENT SHIFT like
> this:
> 
> 
> +static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
> +{
> +    const uint8_t es = get_field(s->fields, m4);
> +    const uint8_t d2 = get_field(s->fields, d2) &
> +                       (NUM_VEC_ELEMENT_BITS(es) - 1);
> +    const uint8_t v1 = get_field(s->fields, v1);
> +    const uint8_t v3 = get_field(s->fields, v3);
> +    TCGv_i32 shift;
> +
> +    if (es > ES_64) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    shift = tcg_temp_new_i32();
> +    tcg_gen_extrl_i64_i32(shift, o->addr1);
> +    tcg_gen_andi_i32(shift, shift, NUM_VEC_ELEMENT_BITS(es) - 1);
> +
> +    switch (s->fields->op2) {
> +    case 0x30:
> +        if (likely(!get_field(s->fields, b2))) {
> +            gen_gvec_fn_2i(shli, es, v1, v3, d2);
> +        } else {
> +            gen_gvec_fn_2s(shls, es, v1, v3, shift);
> +        }
> +        break;
> +    case 0x3a:
> +        if (likely(!get_field(s->fields, b2))) {
> +            gen_gvec_fn_2i(sari, es, v1, v3, d2);
> +        } else {
> +            gen_gvec_fn_2s(sars, es, v1, v3, shift);
> +        }
> +        break;
> +    case 0x38:
> +        if (likely(!get_field(s->fields, b2))) {
> +            gen_gvec_fn_2i(shri, es, v1, v3, d2);
> +        } else {
> +            gen_gvec_fn_2s(shrs, es, v1, v3, shift);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    tcg_temp_free_i32(shift);
> +    return DISAS_NEXT;
> +}

Looks plausible.  I might have hoisted the b2 == 0 check,
and avoid the other tcg arithmetic when unused.

> Does it still make sense to special-case the const immediate case?

Yes.  We cannot turn non-constant scalar shift into immediate shift, when it
can be shown that the scalar is constant.

x86 (and s390, obviously) has all 3 forms of shift.
aarch64 and powerpc are missing the scalar form, having
only the immediate and vector forms.

The expansion that we do when a form is missing may make it
very difficult to undo via constant propagation.


r~
