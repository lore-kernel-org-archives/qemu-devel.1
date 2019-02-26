Received: from eggs.gnu.org ([209.51.188.92]:40260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gykCZ-0001mK-2t
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 16:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gykCY-0000QN-4y
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 16:23:47 -0500
From: David Hildenbrand <david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-7-david@redhat.com>
	<f3a978e7-2e40-9f57-f085-ff5dbf259964@linaro.org>
	<7bfddcbc-5ace-5f28-8042-8b576f31d573@redhat.com>
Message-ID: <8b842e77-5d5e-c1eb-89e5-0c8816f0daf8@redhat.com>
Date: Tue, 26 Feb 2019 22:23:26 +0100
MIME-Version: 1.0
In-Reply-To: <7bfddcbc-5ace-5f28-8042-8b576f31d573@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/33] s390x/tcg: Implement VECTOR
 GENERATE BYTE MASK
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

On 26.02.19 20:23, David Hildenbrand wrote:
> On 26.02.19 20:12, Richard Henderson wrote:
>> On 2/26/19 3:38 AM, David Hildenbrand wrote:
>>> +static DisasJumpType op_vgbm(DisasContext *s, DisasOps *o)
>>> +{
>>> +    const uint16_t i2 = get_field(s->fields, i2);
>>> +    TCGv_i32 ones = tcg_const_i32(-1u);
>>> +    TCGv_i32 zeroes = tcg_const_i32(0);
>>> +    int i;
>>> +
>>> +    for (i = 0; i < 16; i++) {
>>> +        if (extract32(i2, 15 - i, 1)) {
>>> +            write_vec_element_i32(ones, get_field(s->fields, v1), i, MO_8);
>>> +        } else {
>>> +            write_vec_element_i32(zeroes, get_field(s->fields, v1), i, MO_8);
>>> +        }
>>> +    }
>>> +    tcg_temp_free_i32(ones);
>>> +    tcg_temp_free_i32(zeroes);
>>> +    return DISAS_NEXT;
>>> +}
>>
>> While this works, it's not in the spirit of
>>
>>> Programming Note: VECTOR GENERATE BYTE
>>> MASK is the preferred method for setting a vector
>>> register to all zeroes or ones.
> 
> Good point, I skipped that note so far.
> 
>>
>> Better, I think, with
> 
> Many instructions to implement, so little time to fine tune stuff so
> far. However I have tests for VGBM, so I can easily get it working. Will
> play with it!
> 
>>
>> uint64_t generate_byte_mask(uint8_t mask)
>> {
>>     uint64_t r = 0;
>>     int i;
>>     for (i = 0; i < 8; i++) {
>>         if ((mask >> i) & 1) {
>>             r |= 0xffull << (i * 8);
>>         }
>>     }
>>     return r;
>> }
>>
>>     if (i2 == (i2 & 0xff) * 0x0101) {
>>         /* masks for both halves of the vector are the same.
>>            trust tcg to produce a good constant loading.  */
>>         tcg_gen_gvec_dup64i(vec_full_reg_offset(s, v1), 16, 16,
>>                             generate_byte_mask(i2 & 0xff));
>>     } else {
>>         TCGv_i64 t = tcg_temp_new_i64();
>>         tcg_gen_movi_i64(t, generate_byte_mask(i2 >> 8));
>>         write_vec_element_i64(t, v1, 0, MO_64);
>>         tcg_gen_movi_i64(t, generate_byte_mask(i2 & 0xff));
>>         write_vec_element_i64(t, v1, 1, MO_64);
>>         tcg_temp_free_i64();
>>     }
>>
>> Somewhere behind tcg_gen_gvec_dup64i, I check to see if the constant can be
>> decomposed further, which will eventually bottom out at
>>
>> 	vpxor	%xmm0,%xmm0,%xmm0		// all zeros
>> 	vpcmpeq	%xmm0,%xmm0,%xmm0		// all ones
>>

Just tested with minor adaptions, works like a charm!

-- 

Thanks,

David / dhildenb
