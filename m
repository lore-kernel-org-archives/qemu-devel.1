Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F743C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262D0206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwgKX9TC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262D0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmy0t-0003G3-6I
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33243)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hmy0Z-0002YT-Do
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hmy0X-0002wK-Rq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:14:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hmy0X-0002vS-JH
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:14:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so16473705wrs.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7dD2vWrj4ks/NqPU9zS8RRmfCqPi1PlcqtXPFTDb1D0=;
 b=jwgKX9TCI/TDEYc98o3DSQHr9pHoS/lP4ugsO9LH8QlWkj1Xu46MQ/+ML7NRKvwuDj
 RTJVJCvOyZrAzFi/0eLDYnVGvPGB2zZbIKzLV4onbiHfxaD+vfa1WNmQ1dNxgMx7PdUa
 KadlwhivRcIexlUP8+Y2CK/dwHf4pCqrvuhwlWES9RBMeW57gFtswZE9pmL/VwTZycrD
 tqVW42v5LvZugCNeTv79n8B/qVgMlRWPm/nF5JaCZvDI87WrdcXzZghdLieKtBw9AtOQ
 12Y3nAATn0CKazp2CTwmz2tofYKzACfxGEuvoj+fLzh2b0vV4BrxAhQgRE0ltoxBz1A/
 vgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7dD2vWrj4ks/NqPU9zS8RRmfCqPi1PlcqtXPFTDb1D0=;
 b=bMtsl55mhb/0TIyrP3D9MXIJ0Ho2jZOYExn3UvB6RbucWdeACO1+1BM23OFYF4EdLh
 BprxgJkZ95b9le/J0ykkpytYQG98zaUz1Dv9zro9ibdROmSkleFDSxZj47PIZRq9Zi27
 NDj+32+fEjEsQ4tKjiFQgyfnehXyjDDBwtH7FlzrOls3G3dMDOMLTcF45XolG/noNZcX
 CeIU/P+svXbCtV+bG2ufBXnT/D4QMWKBr9MTdmOHDjUpuscqoFYoMW25kg20r204vg41
 lv8cJwOGJcL9FBK8pn/eyRJkxtJALnElk1ULyaTcHPKdddjF+bSHQsovTYIBIp1Ke5lW
 Y/Mg==
X-Gm-Message-State: APjAAAVo4T7jdOYs/D4RL/wxQJBax25EmK5YwGSP9ZW1PngTNaNCXA6M
 tuMRRIGPm3nRJ1+zze2CZm9ORw==
X-Google-Smtp-Source: APXvYqwa0MDYbqSD96N4TPA4C4PqwwFBCRHSAbOrPCood+jCRvghhRYJFpEnePeHDq3wClH4eDogyg==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr29692961wrj.283.1563185695463; 
 Mon, 15 Jul 2019 03:14:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a64sm18341593wmf.1.2019.07.15.03.14.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 03:14:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 14E9D1FF87;
 Mon, 15 Jul 2019 11:14:54 +0100 (BST)
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <87zhljcr6c.fsf@zen.linaroharston>
 <71f1ca40-9457-62c1-f585-6b3d6c523e3c@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <71f1ca40-9457-62c1-f585-6b3d6c523e3c@gmail.com>
Date: Mon, 15 Jul 2019 11:14:54 +0100
Message-ID: <87pnmbvc2p.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RISU PATCH v3 00/18] Support for generating x86
 SIMD test images
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> On 7/12/19 9:34 AM, Alex Benn=C3=A9e wrote:
>>
>> Jan Bobek <jan.bobek@gmail.com> writes:
>>
>>> This is v3 of the patch series posted in [1] and [2]. Note that this
>>> is the first fully-featured patch series implementing all desired
>>> functionality, including (V)LDMXCSR and VSIB-based instructions like
>>> VGATHER*.
>>>
>>> While implementing the last bits required in order to support VGATHERx
>>> instructions, I ran into problems which required a larger redesign;
>>> namely, there are no more !emit blocks as their functionality is now
>>> implemented in regular !constraints blocks. Also, memory constraints
>>> are specified in !memory blocks, similarly to other architectures.
>>>
>>> I tested these changes on my machine; both master and slave modes work
>>> in both 32-bit and 64-bit modes.
>>
>> Two things I've noticed:
>>
>>   ./contrib/generate_all.sh -n 1 x86.risu testcases.x86
>>
>> takes a very long time. I wonder if this is a consequence of constantly
>> needing to re-query the random number generator?
>
> I believe so. While other architectures can be as cheap as a single rand()
> call per instruction, x86 does more like 5-10.

OK

> Even worse, there are some instructions which cannot be generated in
> 32-bit mode (those requiring REX.W prefix, e.g. MMX MOVQ). When I let
> the script run for a little bit, risugen would get stuck in an
> infinite loop, because it could only choose from a single instruction
> which wasn't valid for 32-bit....

The first instruction I see hang is:

  Running: /home/alex/lsrc/tests/risu.git/risugen --xfeatures avx  --patter=
n CVTSD2SI_64 x86.risu testcases.x86/insn_CVTSD2SI_64__INC.risu.bin
  Generating code using patterns: CVTSD2SI_64 SSE2...
  [                                                                        =
    ]

I wonder if this means we should split the x86.risu by mode? Or some
other way of filtering out patterns that are invalid for a mode?

We do have the concept of classes, see the @ annotations in
aarch64.risu. I guess the generate_all script doesn't handle that nicely
yet though. For now I lumped them all together with:

  ./risugen --pattern "MMX" --xfeatures=3Dsse x86.risu all_mmx.risu.bin
  ./risugen --pattern "SSE" --xfeatures=3Dsse x86.risu all_sse.risu.bin
  ./risugen --pattern "SSE2" --xfeatures=3Dsse x86.risu all_sse2.risu.bin
  ./risugen --pattern "SSE3" --xfeatures=3Dsse x86.risu all_sse3.risu.bin
  ./risugen --pattern "AVX" --xfeatures=3Davx x86.risu all_avx.risu.bin
  ./risugen --pattern "AVX2" --xfeatures=3Davx x86.risu all_avx2.risu.bin

>
>> The other is:
>>
>>   set -x RISU ./build/i686-linux-gnu/risu
>>   ./contrib/record_traces.sh testcases.x86/*.risu.bin
>>
>> fails on the first trace when validating the playback. Might want to
>> check why that is.
>
> The SIMD registers aren't getting initialized; both master and
> apprentice need an --xfeatures=3DXXX parameter for that. Right now the
> default is 'none'; unless the instructions are filtered, you'd need
> --xfeatures=3Davx (or --xfeatures=3Dsse, and that only works because on my
> laptop, the upper part of ymm registers seems to be always zeroed when
> risu starts).

Ahh OK, I did a lot better with:

  ./contrib/generate_all.sh -n 1 x86.risu testcases.x86 -- --xfeatures avx
  set -x RISU ./build/i686-linux-gnu/risu --xfeatures=3Davx
  ./contrib/record_traces.sh testcases.x86-avx/*.risu.bin

There are enough failures when you run those against QEMU for now that
we don't need to worry too much about coverage yet ;-)

>>>
>>> Cheers,
>>>  -Jan
>>>
>>> Changes since v2:
>>>   Too many to be listed individually; this patch series might be
>>>   better reviewed on its own.
>>>
>>> References:
>>>   1. https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg04123.=
html
>>>   2. https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg00001.=
html
>>>
>>> Jan Bobek (18):
>>>   risugen_common: add helper functions insnv, randint
>>>   risugen_common: split eval_with_fields into extract_fields and
>>>     eval_block
>>>   risugen_x86_asm: add module
>>>   risugen_x86_constraints: add module
>>>   risugen_x86_memory: add module
>>>   risugen_x86: add module
>>>   risugen: allow all byte-aligned instructions
>>>   risugen: add command-line flag --x86_64
>>>   risugen: add --xfeatures option for x86
>>>   x86.risu: add MMX instructions
>>>   x86.risu: add SSE instructions
>>>   x86.risu: add SSE2 instructions
>>>   x86.risu: add SSE3 instructions
>>>   x86.risu: add SSSE3 instructions
>>>   x86.risu: add SSE4.1 and SSE4.2 instructions
>>>   x86.risu: add AES and PCLMULQDQ instructions
>>>   x86.risu: add AVX instructions
>>>   x86.risu: add AVX2 instructions
>>>
>>>  risugen                    |   27 +-
>>>  risugen_arm.pm             |    6 +-
>>>  risugen_common.pm          |  117 +-
>>>  risugen_m68k.pm            |    3 +-
>>>  risugen_ppc64.pm           |    6 +-
>>>  risugen_x86.pm             |  518 +++++
>>>  risugen_x86_asm.pm         |  918 ++++++++
>>>  risugen_x86_constraints.pm |  154 ++
>>>  risugen_x86_memory.pm      |   87 +
>>>  x86.risu                   | 4499 ++++++++++++++++++++++++++++++++++++
>>>  10 files changed, 6293 insertions(+), 42 deletions(-)
>>>  create mode 100644 risugen_x86.pm
>>>  create mode 100644 risugen_x86_asm.pm
>>>  create mode 100644 risugen_x86_constraints.pm
>>>  create mode 100644 risugen_x86_memory.pm
>>>  create mode 100644 x86.risu
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e

