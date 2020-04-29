Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B48C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A922D208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKVH2GTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A922D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlLq-0006sX-RR
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTlL5-0005ud-Nc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTlL3-0004IC-MA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:57:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:50643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTlL3-0004HU-2O
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:57:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id x25so1720683wmc.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ABaujoye9FH8Kn3mODUHNZENQ/20wQwwCcjRa8QRCmk=;
 b=BKVH2GTbCGcWnDuh4+dfUOUJhFhFw6WrNDzqPW//pJbKz6SaGqKwrGqQXwBweMfm6Q
 6B6OGs/yUGUc/e9mCxIl2XBUxzp1jVJOHPMimjoPM749eD3qdGXg63Aj8mWVHRq0eEmm
 KV/jX5osat5eK4DJFa2cK1kTAHXVCtowF5aBrDZMYeKNNwJDTeYqJqDkVKcU9cc7XIZg
 KLY1WZFqxxYEssJwGoJkIK5CqlnAFIhThpOj0zxKqtBnquQ8hRoD+rPV9hBCZc0HytJ5
 Kded8p+OG+xSb5uve5gLUQ3MFGh/NzRlnaNEt3Js6VGvFwXTuDIAdLC/xwA6WSl1++nH
 TfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ABaujoye9FH8Kn3mODUHNZENQ/20wQwwCcjRa8QRCmk=;
 b=GmuXXT8sVeDlxZ9rxp7YqV6GHm6bOz4G2bZgU9XiP5k/z0grJKoqiswu2H5X7GD/Y3
 IFs2b9Ln6tH3Herf+Lc/fSaB6ZA83LSKFjBDZSKGYajB5jw52Np0aiSzjJKQduD9YmHg
 Suo/Hbjx4JLNLyJKDnYJ+r9o7AsBzoAqbQ9l+UB7ZGvAEVNl3kbZv08B7wVlJLWQJJ0m
 3G7Xwj4P/1rS9UN6DaikrrwQNXtdDCtsPHGqHXYkJ6ES82CVxbDoAI1C1XZu+qPa7DDv
 g2WdG1r15fwdMzc0/gFgCviiHlUKKj9jsGthzensD7yA0cY/hnq9MJr7/bkJyKwJ1oTb
 bzbw==
X-Gm-Message-State: AGi0PuYJBDfTH31rngaWyqVfcrInETtkAmaCwsYVsvR0Z/qpyTcxwCVU
 B2axsoWJF5LYipXMo7VD7VzmtA==
X-Google-Smtp-Source: APiQypK78rWjgS6o9Zs5vjeHk5j0LHjv1JAPWRgvH/a/BGf2BQc687QXXGiNpKUoqrzktWC2oCX4MQ==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr2865314wmj.6.1588161435162; 
 Wed, 29 Apr 2020 04:57:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s18sm31702703wra.94.2020.04.29.04.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 04:57:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 322811FF7E;
 Wed, 29 Apr 2020 12:57:12 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dino Papararo <skizzato73@msn.com>
Subject: Re: R: About hardfloat in ppc
In-reply-to: <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
Date: Wed, 29 Apr 2020 12:57:12 +0100
Message-ID: <871ro6ld2f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "luoyonggang@gmail.com" <luoyonggang@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dino Papararo <skizzato73@msn.com> writes:

> Hello,
> about handling of PPC fpu exceptions and Hard Floats support we could con=
sider a different approach for different instructions.
> i.e. not all fpu instructions take care about inexact or exceptions bits:=
 if I take a simple fadd f0,f1,f2 I'll copy value derived from adding f1+f2=
 into f1 register and no one will check about inexact or exception bits rai=
sed into FPSCR register.
> Instead if I'll take fadd. f0,f1,f2 the dot following the add instruction=
s means I want take inexact or exceptions bits into account.
> So I could use hard floats for first case and softfloats for second case.
> Could this be a fast solution to start implement hard floats for PPC??

While it may be true that normal software practice is not to read the
exception registers for every operation we can't base our emulation on
that. We must always be able to re-create the state of the exception
registers whenever they may be read by the program. There are 3 cases
this may happen:

  - a direct read of the inexact register
  - checking the sigcontext of a synchronous exception (e.g. fault)
  - checking the sigcontext of an asynchronous exception (e.g. timer/IPI)

Given the way the translator works we can simplify the asynchronous case
because we know they are only ever delivered at the start of translated
blocks. We must have a fully rectified system state at the end of every
block. So lets consider some cases:

  fpOpA
  clear flags
  fpOpB
  clear flags
  fpOpC
  read flags

Assuming we know the fpOps can't generate exceptions we can know that
only fpOpC will ever generate a user visible floating point flags so we
can indeed use hardfloat for fpOpA and fpOpB. However if we see the
pattern:

  fpOpA
  ld/st
  clear flags
  fpOpB
  read flags

we must have the fully rectified version of the flags because the ld/st
may fault. However it's not guaranteed it will fault so we could defer
the flag calculation for fpOpA until such time as we need it. The
easiest way would be to save the values going into the operation and
then re-run it in softfloat when required (hopefully never ;-).

A lot will depend on the behaviour of the architecture. For example:

  fpOpA
  fpOpB
  read flags

whether or not we need to be able to calculate the flags for fpOpA will
depend on if fpOpB completely resets the flags visible or if the result
is additive.

So in short I think there may be scope for using hardfloat but it will
require knowledge of front-end knowing if it is safe to skip flag
calculation in particular cases. We might even need support within TCG
for saving (and marking) temporaries over potentially faulting
boundaries so these lazy evaluations can be done. We can certainly add a
fp-status less set of primitives to softfloat which can use the
hardfloat path when we know we are using normal numbers.

>
> A little of documentation here: http://mirror.informatimago.com/next/deve=
loper.apple.com/documentation/mac/PPCNumerics/PPCNumerics-154.html
>
> Regards,
> Dino Papararo
>
> -----Messaggio originale-----
> Da: Qemu-devel <qemu-devel-bounces+skizzato73=3Dmsn.com@nongnu.org> Per c=
onto di Alex Benn=C3=A9e
> Inviato: marted=C3=AC 28 aprile 2020 10:37
> A: luoyonggang@gmail.com
> Cc: qemu-ppc@nongnu.org; qemu-devel@nongnu.org
> Oggetto: Re: About hardfloat in ppc
>
>
> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:
>
>> I am confusing why only  inexact  are set then we can use hard-float.
>
> The inexact behaviour of the host hardware may be different from the gues=
t architecture we are trying to emulate and the host hardware may not be co=
nfigurable to emulate the guest mode.
>
> Have a look in softfloat.c and see all the places where float_flag_inexac=
t is set. Can you convince yourself that the host hardware will do the same?
>
>> And PPC always clearing inexact  flag before calling to soft-float=20
>> funcitons. so we can not optimize it with hard-float.
>> I need some resouces about ineact flag and why always clearing inexcat=20
>> in PPC FP simualtion.
>
> Because that is the behaviour of the PPC floating point unit. The inexact=
 flag will represent the last operation done.
>
>> I am looking for two possible solution:
>> 1. do not clear inexact flag in PPC simulation 2. even the inexact are=20
>> cleared, we can still use alternative hard-float.
>>
>> But now I am the beginner, Have no clue about all the things.
>
> Well you'll need to learn about floating point because these are rather f=
undamental aspects of it's behaviour. In the old days QEMU used to use the =
host floating point processor with it's template based translation.
> However this led to lots of weird bugs because the floating point answers=
 under qemu where different from the target it was trying to emulate. It wa=
s for this reason softfloat was introduced. The hardfloat optimisation can =
only be done when we are confident that we will get the exact same answer o=
f the target we are trying to emulate - a "faster but incorrect" mode is ju=
st going to cause confusion as discussed in the previous thread. Have you r=
ead that yet?
>
>>
>> On Mon, Apr 27, 2020 at 7:10 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>
>>>
>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>
>>> > On Mon, 27 Apr 2020, Alex Benn=C3=A9e wrote:
>>> >> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> wr=
ites:
>>> >>> Because ppc fpu-helper are always clearing float_flag_inexact, So=20
>>> >>> is that possible to optimize the performance when
>>> float_flag_inexact
>>> >>> are cleared?
>>> >>
>>> >> There was some discussion about this in the last thread about=20
>>> >> enabling hardfloat for PPC. See the thread:
>>> >>
>>> >>  Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
>>> >>  Date: Tue, 18 Feb 2020 18:10:16 +0100
>>> >>  Message-Id: <20200218171702.979F074637D@zero.eik.bme.hu>
>>> >
>>> > I've answered this already with link to that thread here:
>>> >
>>> > On Fri, 10 Apr 2020, BALATON Zoltan wrote:
>>> > : Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)
>>> > : From: BALATON Zoltan <balaton@eik.bme.hu>
>>> > : To: "=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)" <luoyonggang@gmail.=
com>
>>> > : Cc: qemu-devel@nongnu.org, Mark Cave-Ayland, John Arbuckle,
>>> qemu-ppc@nongnu.org, Paul Clarke, Howard Spoelstra, David Gibson
>>> > : Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
>>> > :
>>> > : On Fri, 10 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrot=
e:
>>> > :> Are this stable now? I'd like to see hard float to be landed:)
>>> > :
>>> > : If you want to see hardfloat for PPC then you should read the=20
>>> > replies to : this patch which can be found here:
>>> > :
>>> > : http://patchwork.ozlabs.org/patch/1240235/
>>> > :
>>> > : to understand what's needed then try to implement the solution=20
>>> > with FP : exceptions cached in a global that maybe could work. I=20
>>> > won't be able to : do that as said here:
>>> > :
>>> > :=20
>>> > https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00006.htm
>>> > l
>>> > :
>>> > : because I don't have time to learn all the details needed. I think :
>>> > others are in the same situation so unless somebody puts in the :
>>> > necessary effort this won't change.
>>> >
>>> > Which also had a proposed solution to the problem that you could=20
>>> > try to implement, in particular see this message:
>>> >
>>> >
>>> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200218171702.9
>>> 79F074637D@zero.eik.bme.hu/#2375124
>>> >
>>> > amd Richard's reply immediately below that. In short to optimise=20
>>> > FPU emulation we would either find a way to compute inexact flag=20
>>> > quickly without reading the FPU status (this may not be possible)=20
>>> > or somehow get status from the FPU but the obvious way of claring=20
>>> > the flag and reading them after each operation is too slow. So=20
>>> > maybe using exceptions and only clearing when actually there's a=20
>>> > change could be faster.
>>> >
>>> > As to how to use exceptions see this message in above thread:
>>> >
>>> > https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00005.htm
>>> > l
>>> >
>>> > But that's only to show how to hook in an exception handler what it=20
>>> > does needs to be implemented. Then tested and benchmarked.
>>> >
>>> > I still don't know where are the extensive PPC floating point tests=20
>>> > to use for checking results though as that was never answered.
>>>
>>> Specifically for PPC we don't have them. We use the softfloat test=20
>>> cases to exercise our softfloat/hardfloat code as part of "make=20
>>> check-softfloat". You can also re-build fp-bench for each guest=20
>>> target to measure raw throughput.
>>>
>>> >> However in short the problem is if the float_flag_inexact is clear=20
>>> >> you must use softfloat so you can properly calculate the inexact=20
>>> >> status. We can't take advantage of the inexact stickiness without=20
>>> >> loosing the fidelity of the calculation.
>>> >
>>> > I still don't get why can't we use hardware via exception handler=20
>>> > to detect flags for us and why do we only use hardfloat in some=20
>>> > corner cases. If reading the status is too costly then we could=20
>>> > mirror it in a global which is set by an FP exception handler.=20
>>> > Shouldn't that be faster? Is there a reason that can't work?
>>>
>>> It would work but it would be slow. Almost every FP operation sets=20
>>> the inexact flag so it would generate an exception and exceptions=20
>>> take time to process.
>>>
>>> For the guests where we use hardfloat operations with inexact already=20
>>> latched is not a corner case - it is the common case which is why it=20
>>> helps.
>>>
>>> >
>>> > Regards,
>>> > BALATON Zoltan
>>>
>>>
>>> --
>>> Alex Benn=C3=A9e
>>>


--=20
Alex Benn=C3=A9e

