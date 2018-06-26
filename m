Received: from eggs.gnu.org ([2001:4830:134:3::10]:41947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqfI-0008TT-Mr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqfF-0005Jm-Hg
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:18:00 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXqfF-0005Ja-B4
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:17:57 -0400
Received: by mail-pg0-x241.google.com with SMTP id m5-v6so7843216pgd.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:17:57 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-34-richard.henderson@linaro.org>
	<CAFEAcA_-39brD_S6SiDfaQRO16bE1pw79JDywnPfzybbPc_hCg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d778b758-6041-aa19-ed48-09749ba572fc@linaro.org>
Date: Tue, 26 Jun 2018 09:17:52 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_-39brD_S6SiDfaQRO16bE1pw79JDywnPfzybbPc_hCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 33/35] target/arm: Implement SVE dot
 product (indexed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/26/2018 08:30 AM, Peter Maydell wrote:
> On 21 June 2018 at 02:53, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper.h        |  5 ++
>>  target/arm/translate-sve.c | 18 +++++++
>>  target/arm/vec_helper.c    | 96 ++++++++++++++++++++++++++++++++++++++
>>  target/arm/sve.decode      |  8 +++-
>>  4 files changed, 126 insertions(+), 1 deletion(-)
>>
> 
>> +void HELPER(gvec_sdot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
>> +{
>> +    intptr_t i, j, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
>> +    intptr_t index = simd_data(desc);
>> +    uint32_t *d = vd;
>> +    int8_t *n = vn, *m = vm;
>> +
>> +    for (i = 0; i < opr_sz_4; i = j) {
>> +        int8_t m0 = m[(i + index) * 4 + 0];
>> +        int8_t m1 = m[(i + index) * 4 + 1];
>> +        int8_t m2 = m[(i + index) * 4 + 2];
>> +        int8_t m3 = m[(i + index) * 4 + 3];
>> +
>> +        j = i;
>> +        do {
>> +            d[j] += n[j * 4 + 0] * m0
>> +                  + n[j * 4 + 1] * m1
>> +                  + n[j * 4 + 2] * m2
>> +                  + n[j * 4 + 3] * m3;
>> +        } while (++j < MIN(i + 4, opr_sz_4));
>> +    }
>> +    clear_tail(d, opr_sz, simd_maxsz(desc));
>> +}
> 
> Maybe I'm just half asleep this afternoon, but this is pretty
> confusing -- nested loops where the outer loop's increment
> uses the inner loop's index, and the inner loop's conditions
> depend on the outer loop index...

Yeah, well.

There is an edge case of aa64 advsimd, reusing this same helper,

	sdot	v0.2s, v1.8b, v0.4b[0]

where m values must be read (and held) before writing d results,
and there are not 16/4=4 elements to process but only 2.

I suppose I could special-case oprsz == 8 in order to simplify
iteration of what is otherwise a multiple of 16.

I thought iterating J from I to I+4 was easier to read than
writing out I+J everywhere.  Perhaps not.


>> -DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5
>> +DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5      ra=%reg_movprfx
> 
> Should this have been in the previous patch ?

Yes, thanks.


r~
