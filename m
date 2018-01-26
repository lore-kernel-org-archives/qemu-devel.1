Received: from eggs.gnu.org ([2001:4830:134:3::10]:49212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeznI-0007Sk-4d
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeznF-00032n-1Z
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:55:32 -0500
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:41967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeznE-00032L-RV
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:55:28 -0500
Received: by mail-pg0-x22e.google.com with SMTP id 136so6876513pgd.8
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 00:55:28 -0800 (PST)
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-10-richard.henderson@linaro.org>
	<CAFEAcA9Dmdh+u7AZHhjEkS3zc6i4yf+Eo1-NuksgVdo1cqmKFQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <707306d7-8ee4-ab6b-2154-290647a72779@linaro.org>
Date: Thu, 25 Jan 2018 23:29:07 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Dmdh+u7AZHhjEkS3zc6i4yf+Eo1-NuksgVdo1cqmKFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 01/15/2018 10:18 AM, Peter Maydell wrote:
>> +void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm,
>> +                         void *vfpst, uint32_t desc)
>> +{
>> +    uintptr_t opr_sz = simd_oprsz(desc);
>> +    float16 *d = vd;
>> +    float16 *n = vn;
>> +    float16 *m = vm;
>> +    float_status *fpst = vfpst;
>> +    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
>> +    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
>> +    uint32_t neg_real = flip ^ neg_imag;
>> +    uintptr_t i;
>> +
>> +    neg_real <<= 15;
>> +    neg_imag <<= 15;
>> +
>> +    for (i = 0; i < opr_sz / 2; i += 2) {
>> +        float16 e0 = n[H2(i + flip)];
>> +        float16 e1 = m[H2(i + flip)] ^ neg_real;
>> +        float16 e2 = e0;
>> +        float16 e3 = m[H2(i + 1 - flip)] ^ neg_imag;
> 
> This is again rather confusing to compare against the pseudocode.
> What order are your e0/e1/e2/e3 compared to the pseudocode's
> element1/element2/element3/element4 ?

The SVE pseudocode for the same operation is clearer than that in the main ARM
ARM, and is nearer to what I used:

  for e = 0 to elements-1
    if ElemP[mask, e, esize] == '1' then
        pair = e - (e MOD 2);  // index of first element in pair
        addend = Elem[result, e, esize];
        if IsEven(e) then  // real part
            // realD = realA [+-] flip ? (imagN * imagM) : (realN * realM)
            element1 = Elem[operand1, pair + flip, esize];
            element2 = Elem[operand2, pair + flip, esize];
            if neg_real then element2 = FPNeg(element2);
        else  // imaginary part
            // imagD = imagA [+-] flip ? (imagN * realM) : (realN * imagM)
            element1 = Elem[operand1, pair + flip, esize];
            element2 = Elem[operand2, pair + (1 - flip), esize];
            if neg_imag then element2 = FPNeg(element2);
        Elem[result, e, esize] = FPMulAdd(addend, element1, element2, FPCR);

In my version, e0/e1 are element1/element2 (real) and e2/e3 are
element1/element2 (imag).


r~
