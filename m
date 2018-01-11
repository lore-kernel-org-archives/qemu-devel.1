Received: from eggs.gnu.org ([2001:4830:134:3::10]:42871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiV9-0008Tz-NV
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiV6-0001O5-JX
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:26:59 -0500
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:43072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZiV6-0001NR-Bm
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:26:56 -0500
Received: by mail-pg0-x233.google.com with SMTP id f14so2824302pga.10
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:26:56 -0800 (PST)
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<20171218174552.18871-2-richard.henderson@linaro.org>
	<CAFEAcA_zoqWwAhg5PhuUG=xkRuC3uwT0MF7D3NOvEFg0Z3yKMQ@mail.gmail.com>
	<3ffa6112-d2bf-df10-c8ee-e96ead760359@linaro.org>
	<CAFEAcA8QxgaaLNc_+-5M9D8LQCp3mkUBmfZpt4Gq58DtKgtGCw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1f96c97d-9eba-03f2-dce6-19f17723754f@linaro.org>
Date: Thu, 11 Jan 2018 11:26:52 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8QxgaaLNc_+-5M9D8LQCp3mkUBmfZpt4Gq58DtKgtGCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/23] scripts: Add decodetree.py
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

On 01/11/2018 11:21 AM, Peter Maydell wrote:
> On 11 January 2018 at 19:10, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 01/11/2018 10:06 AM, Peter Maydell wrote:
>>> On 18 December 2017 at 17:45, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
> 
>>>> +# Pattern examples:
>>>> +#
>>>> +#   addl_r   010000 ..... ..... .... 0000000 ..... @opr
>>>> +#   addl_i   010000 ..... ..... .... 0000000 ..... @opi
>>>> +#
>>>
>>> I think we should insist that a pattern defines all the
>>> bits (either as constant values or as fields that get
>>> passed to the decode function). That will help prevent
>>> accidental under-decoding.
>>
>> Hmm.  What do you suggest then for bits that the cpu does not decode at all?
>> This doesn't happen with ARM (I don't think) but it does happen with HPPA, and
>> probably others.
> 
> Arm does have undecoded bits (they're in brackets in encoding diagrams),
> but they're UNPREDICTABLE if you don't set them right, so ideally we
> check them all and UNDEF. Our current aarch32 decoder doesn't always
> do this, and it's non-obvious when that happens.
> 
>> I suppose I could either wrap it in a field that the translator ignores, or
>> choose another character besides ".", e.g.
>>
>> mfia            000000 xxxxx 00000 xxx 10100101 t:5
>>
>> where bits [21-25] and bits [13-15] really are ignored by hardware.
> 
> Yes, I'd like to see something so that if you want the translator
> to ignore a bit you have to explicitly mark it as to be ignored.

Ok.

> Something I noticed the doc comment doesn't mention: what's the
> semantics for if the patterns you declare overlap? Is this a
> purely declarative language where you have to make sure an
> insn can only match one pattern (or get an error, presumably),
> or is there an implicit "match starting from the top, so put
> looser patterns last" process?

It *should* error.  But I'm not sure that it does.
It's probably worth adding some unit tests for this...


r~
