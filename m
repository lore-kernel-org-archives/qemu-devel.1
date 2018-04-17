Received: from eggs.gnu.org ([2001:4830:134:3::10]:39102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8ZbR-0000P2-Gx
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 19:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8ZbQ-000773-Lr
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 19:01:33 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:41156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8ZbQ-00075m-Gr
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 19:01:32 -0400
Received: by mail-ot0-x22a.google.com with SMTP id m22-v6so23247630otf.8
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 16:01:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cee77754-64f5-e4e2-6462-f70603655e3e@linaro.org>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<20180417190439.GA28717@flamenco>
	<CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
	<20180417212710.GA10948@flamenco>
	<CAFEAcA9PS2FNSq0VFgO652RaemTViGKzOQStiycqFB8DDhy_ig@mail.gmail.com>
	<20180417223837.GA25085@flamenco>
	<cee77754-64f5-e4e2-6462-f70603655e3e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Apr 2018 00:01:11 +0100
Message-ID: <CAFEAcA_2=rYDZ7yVEHrENzWYsdDHf8DFba9ymffsVwHXvVP4ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 17 April 2018 at 23:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/17/2018 12:38 PM, Emilio G. Cota wrote:
>> On Tue, Apr 17, 2018 at 22:45:51 +0100, Peter Maydell wrote:
>>> On 17 April 2018 at 22:27, Emilio G. Cota <cota@braap.org> wrote:
>>>> (...)
>>>> +cff 0xffb00000, expected: 0x7ff8000000000000, returned: 0x7ff4000000000000, \
>>>>   expected exceptions: i, returned: none
>>>> +error: flags mismatch for input @ ibm/Basic-Types-Inputs.fptest:26170:
>>>> +b32b64cff =0 S -> Q i
>>>
>>> SNaN conversion from 32 bit to 64 bit. Here I agree
>>> with the test -- we should quieten the NaN and raise
>>> Invalid -- which implies that the hardware is wrong ?!?
>>
>> This passes on an Intel host, and fails on both Power7 and 8 hosts I have
>> access to. I don't have the Power ISA spec in front of me, but I hope
>> there's something about this specified in it.
>
> IIRC this is unspecified and does vary by implementation.

I think 754-2008 does specify it: s6.2 says that you get
'set Invalid and return a QNaN if an input is an SNaN' for
"every general-computational and signaling-computational
operation except for the conversions described in 5.12".
So the only exceptions are:
 1) the s5.12 conversions, which are to/from strings-of-characters
 2) quiet-computational operations, which are just
    copy, abs, negate, copySign, and some re-encoding
    operations involving decimal formats

float-to-float conversions are general-computational.

I don't have the original IEEE754 spec to hand though;
that may have left this unspecified.

thanks
-- PMM
