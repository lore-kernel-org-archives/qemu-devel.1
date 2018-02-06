Received: from eggs.gnu.org ([2001:4830:134:3::10]:39006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ej8RK-0000OT-4S
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ej8RJ-0003gq-9e
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:57:58 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ej8RJ-0003gg-50
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:57:57 -0500
Received: by mail-ot0-x242.google.com with SMTP id e64so2744063ote.4
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 10:57:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu80ngyOewT-J3sKVV2pn8e7SVspF8py_yiuQzY1KEEE-w@mail.gmail.com>
References: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
	<20180122172643.29742-2-ard.biesheuvel@linaro.org>
	<CAFEAcA9zA=PTmxQH1W1ht8sj9HFMVKSb12dsm-jX6FQEmQR+FA@mail.gmail.com>
	<CAKv+Gu80ngyOewT-J3sKVV2pn8e7SVspF8py_yiuQzY1KEEE-w@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 6 Feb 2018 18:57:55 +0000
Message-ID: <CAKv+Gu8ZnyorvLnSackEyHCd7dRjN-Uh1Ywv_nj7iZwE=8z1og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/4] target/arm: implement SHA-512
 instructions
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

On 6 February 2018 at 18:56, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 6 February 2018 at 18:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 22 January 2018 at 17:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> This implements emulation of the new SHA-512 instructions that have
>>> been added as an optional extensions to the ARMv8 Crypto Extensions
>>> in ARM v8.2.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>>
>>> +void HELPER(crypto_sha512h)(void *vd, void *vn, void *vm)
>>> +{
>>> +    uint64_t *rd = vd;
>>> +    uint64_t *rn = vn;
>>> +    uint64_t *rm = vm;
>>> +
>>> +    rd[1] += S1_512(rm[1]) + cho512(rm[1], rn[0], rn[1]);
>>> +    rd[0] += S1_512(rd[1] + rm[0]) + cho512(rd[1] + rm[0], rm[1], rn[0]);
>>
>> This gives the wrong answer if the destination register
>> happens to be the same as one of the inputs, because the
>> assignment to rd[1] will overwrite the input before the
>> calculation of rd[0] uses it.
>>
>
> It is supposed to use the new value of rd[1], so this is expected.
>

Ah hold on, I hit send too quickly, apologies.

Yes, if rd == rm, then it will assume the wrong value. I missed this
when doing the rewrite to use the new interface.

>> Some extra temporaries should fix this. I'll try fixing
>> that up locally and see if it passes tests then.
>>
>> thanks
>> -- PMM
