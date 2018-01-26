Received: from eggs.gnu.org ([2001:4830:134:3::10]:42417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef9kB-0002XT-Aq
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef9kA-00046S-Cj
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:32:59 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:35420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef9kA-000469-6z
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:32:58 -0500
Received: by mail-ot0-x236.google.com with SMTP id w26so1360913otj.2
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 11:32:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <707306d7-8ee4-ab6b-2154-290647a72779@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-10-richard.henderson@linaro.org>
	<CAFEAcA9Dmdh+u7AZHhjEkS3zc6i4yf+Eo1-NuksgVdo1cqmKFQ@mail.gmail.com>
	<707306d7-8ee4-ab6b-2154-290647a72779@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 10:07:14 +0000
Message-ID: <CAFEAcA9PGHMPeATRHESeUEWaU17OpVw99p-+U9KzOPaitSgEGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 09/11] target/arm: Decode aa64 armv8.3
 fcmla
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 26 January 2018 at 07:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 01/15/2018 10:18 AM, Peter Maydell wrote:
>>> +void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm,
>>> +                         void *vfpst, uint32_t desc)
>>> +{
>>> +    uintptr_t opr_sz = simd_oprsz(desc);
>>> +    float16 *d = vd;
>>> +    float16 *n = vn;
>>> +    float16 *m = vm;
>>> +    float_status *fpst = vfpst;
>>> +    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
>>> +    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
>>> +    uint32_t neg_real = flip ^ neg_imag;
>>> +    uintptr_t i;
>>> +
>>> +    neg_real <<= 15;
>>> +    neg_imag <<= 15;
>>> +
>>> +    for (i = 0; i < opr_sz / 2; i += 2) {
>>> +        float16 e0 = n[H2(i + flip)];
>>> +        float16 e1 = m[H2(i + flip)] ^ neg_real;
>>> +        float16 e2 = e0;
>>> +        float16 e3 = m[H2(i + 1 - flip)] ^ neg_imag;
>>
>> This is again rather confusing to compare against the pseudocode.
>> What order are your e0/e1/e2/e3 compared to the pseudocode's
>> element1/element2/element3/element4 ?
>
> The SVE pseudocode for the same operation is clearer than that in the main ARM
> ARM, and is nearer to what I used:
>
>   for e = 0 to elements-1
>     if ElemP[mask, e, esize] == '1' then
>         pair = e - (e MOD 2);  // index of first element in pair
>         addend = Elem[result, e, esize];
>         if IsEven(e) then  // real part
>             // realD = realA [+-] flip ? (imagN * imagM) : (realN * realM)
>             element1 = Elem[operand1, pair + flip, esize];
>             element2 = Elem[operand2, pair + flip, esize];
>             if neg_real then element2 = FPNeg(element2);
>         else  // imaginary part
>             // imagD = imagA [+-] flip ? (imagN * realM) : (realN * imagM)
>             element1 = Elem[operand1, pair + flip, esize];
>             element2 = Elem[operand2, pair + (1 - flip), esize];
>             if neg_imag then element2 = FPNeg(element2);
>         Elem[result, e, esize] = FPMulAdd(addend, element1, element2, FPCR);
>
> In my version, e0/e1 are element1/element2 (real) and e2/e3 are
> element1/element2 (imag).

Thanks. Could we use the same indexing (1/2/3/4) as the final Arm ARM
pseudocode?

thanks
-- PMM
