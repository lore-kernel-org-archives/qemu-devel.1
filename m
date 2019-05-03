Received: from eggs.gnu.org ([209.51.188.92]:53364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMXab-0006ZM-WC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMXaa-0006Qn-Uz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:46:57 -0400
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-3-david@redhat.com>
	<69b8508d-9586-ab11-3318-83d21ddd4d25@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <045f9c87-858c-507d-a8ae-01ccff9c3cab@redhat.com>
Date: Fri, 3 May 2019 14:46:51 +0200
MIME-Version: 1.0
In-Reply-To: <69b8508d-9586-ab11-3318-83d21ddd4d25@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/40] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
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

On 03.05.19 05:45, Richard Henderson wrote:
> On 5/2/19 7:09 AM, David Hildenbrand wrote:
>> 128-bit handling courtesy of Richard H.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/insn-data.def      |  2 +
>>  target/s390x/translate_vx.inc.c | 94 +++++++++++++++++++++++++++++++++
>>  2 files changed, 96 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +static void gen_acc(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, uint8_t es)
>> +{
>> +    const uint8_t msb_bit_nr = NUM_VEC_ELEMENT_BITS(es) - 1;
>> +    TCGv_i64 msb_mask = tcg_const_i64(dup_const(es, 1ull << msb_bit_nr));
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    TCGv_i64 t3 = tcg_temp_new_i64();
>> +
>> +    /* Calculate the carry into the MSB, ignoring the old MSBs */
>> +    tcg_gen_andc_i64(t1, a, msb_mask);
>> +    tcg_gen_andc_i64(t2, b, msb_mask);
>> +    tcg_gen_add_i64(t1, t1, t2);
>> +    /* Calculate the MSB without any carry into it */
>> +    tcg_gen_xor_i64(t3, a, b);
>> +    /* Calculate the carry out of the MSB in the MSB bit position */
>> +    tcg_gen_and_i64(d, a, b);
>> +    tcg_gen_and_i64(t1, t1, t3);
>> +    tcg_gen_or_i64(d, d, t1);
>> +    /* Isolate and shift the carry into position */
>> +    tcg_gen_and_i64(d, d, msb_mask);
>> +    tcg_gen_shri_i64(d, d, msb_bit_nr);
>> +
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +    tcg_temp_free_i64(t3);
>> +}
> ...> +static void gen_acc32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
>> +{
>> +    gen_acc(d, a, b, ES_32);
>> +}
>> +
>> +static void gen_acc_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
>> +{
>> +    TCGv_i64 t = tcg_temp_new_i64();
>> +
>> +    tcg_gen_add_i64(t, a, b);
>> +    tcg_gen_setcond_i64(TCG_COND_LTU, d, t, b);
>> +    tcg_temp_free_i64(t);
>> +}
> 
> As an aside, I think the 32-bit version should use 32-bit ops, as per
> gen_acc_i64.  That would be 4 * 2 operations instead of 2 * 9 over the 128-bit
> vector.

Makes sense, thanks!

> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
