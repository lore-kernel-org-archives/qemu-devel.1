Received: from eggs.gnu.org ([2001:4830:134:3::10]:40852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnWb-0001JD-Cu
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnWa-0006yN-8D
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:16:57 -0500
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-3-mark.cave-ayland@ilande.co.uk>
	<e4de9517-e90f-076a-a358-eec1e1d2de64@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <f9e48ac5-cef9-6b0c-ab4e-dd5e1aff9232@ilande.co.uk>
Date: Tue, 11 Dec 2018 19:16:39 +0000
MIME-Version: 1.0
In-Reply-To: <e4de9517-e90f-076a-a358-eec1e1d2de64@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] target/ppc: introduce get_avr64()
 and set_avr64() helpers for VMX register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 10/12/2018 18:49, Richard Henderson wrote:

> On 12/7/18 2:56 AM, Mark Cave-Ayland wrote:
>> +    avr = tcg_temp_new_i64();                                                 \
>>      EA = tcg_temp_new();                                                      \
>>      gen_addr_reg_index(ctx, EA);                                              \
>>      tcg_gen_andi_tl(EA, EA, ~0xf);                                            \
>>      /* We only need to swap high and low halves. gen_qemu_ld64_i64 does       \
>>         necessary 64-bit byteswap already. */                                  \
>>      if (ctx->le_mode) {                                                       \
>> -        gen_qemu_ld64_i64(ctx, cpu_avrl[rD(ctx->opcode)], EA);                \
>> +        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
>> +        set_avr64(rD(ctx->opcode), avr, false);                               \
>>          tcg_gen_addi_tl(EA, EA, 8);                                           \
>> -        gen_qemu_ld64_i64(ctx, cpu_avrh[rD(ctx->opcode)], EA);                \
>> +        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
>> +        set_avr64(rD(ctx->opcode), avr, true);  
> 
> An accurate conversion, but I'm going to call this an existing bug:
> 
> The writeback to both avr{l,h} should be delayed until all exceptions have been
> raised.  Thus you should perform the two gen_qemu_ld64_i64 into two temporaries
> and only then write them both back via set_avr64.

Thanks for the pointer. I'll add this to the list of changes for the next revision of
the patchset.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


ATB,

Mark.
