Received: from eggs.gnu.org ([2001:4830:134:3::10]:46661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecBEJ-0007OA-Q8
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecBEJ-0006zW-1p
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:31:47 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:36692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecBEI-0006yk-Rg
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:31:46 -0500
Received: by mail-ot0-x22f.google.com with SMTP id f100so7654338otf.3
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 06:31:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAdtpL48633TDoSnhv1-iZ0QjWWQsuD1DxJTsniJg+AHbeiT_g@mail.gmail.com>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-11-alex.bennee@linaro.org>
	<1393deaf-c207-6055-1f7c-f7ae814cf2db@amsat.org>
	<87shb3nwkc.fsf@linaro.org>
	<CAAdtpL48633TDoSnhv1-iZ0QjWWQsuD1DxJTsniJg+AHbeiT_g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 14:31:25 +0000
Message-ID: <CAFEAcA8bEPohja9fw-5_BUnfExX4KA_syce8dpdD=trShV=qAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/20] fpu/softfloat: define decompose
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Francisco Iglesias <frasse.iglesias@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Dutcher <andrew@andrewdutcher.com>, bharata@linux.vnet.ibm.com, Aurelien Jarno <aurelien@aurel32.net>

On 18 January 2018 at 14:26, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
>
> Le 18 janv. 2018 10:09 AM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> a =
=C3=A9crit :
>
>
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>> +typedef struct {
>>> +    uint64_t frac   : 64;
>>
>> I think this does not work on LLP64/IL32P64 model.
>>
>> Should we add a check in ./configure and refuse to build on IL32P64
>> model? This would be safer IMHO.
>>
>>> +    int exp         : 32;
>>> +    float_class cls : 8;
>>> +    int             : 23;
>>> +    bool sign       : 1;
>>
>> checking on "ISO/IEC 14882:1998" 9.6 Bit-fields:
>>
>> Alignment of bit-fields is implementation-defined. Bit-fields are packed
>> into some addressable allocation unit. [Note: bit-fields straddle
>> allocation units on some machines and not on others. Bit-fields are
>> assigned right-to-left on some machines, left-to-right on others. ]
>>
>> I'd still write it:
>>
>>       int             :23, sign :1;
>>
>>> +} decomposed_parts;
>
> I think rather than stuff it into bit fields we can just leave it up to
> the compiler?
>
>
> Yep, my only worry here is the IL32P64 model, if we care.

I don't think we care much about IL32P64, but the code should
still work there, right? It doesn't actually make any assumptions
about bitfield layout.

I think I agree that we shouldn't use bitfields here if we don't
need to, though.

thanks
-- PMM
