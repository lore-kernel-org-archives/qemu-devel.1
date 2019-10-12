Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44493C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 12:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE3A2087E
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 12:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmFmus87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE3A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJGYS-0007j7-5B
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 08:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJGRL-0008RX-QV
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 08:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJGRK-00025Y-Fl
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 08:24:07 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:38820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iJGRK-00025R-BA
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 08:24:06 -0400
Received: by mail-oi1-x231.google.com with SMTP id m16so10226293oic.5
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=TmGU9WAPsEVWhfmgtFdDLBvqM5rH3VdZccUlSg63gPM=;
 b=tmFmus87wgOZPtOKNkub0pT9/rFMn+RRVD5ry5sx4Qt5gvVEgnnB4RA8XSrh4t/Eej
 Rde7ddR5X9Xf/VaDHMzSnxCPF4ftmwHQPJLpy9Jp+4/FR3rSNdJrZxWA3/d8V0eOFQke
 NI8ccX/pqzAWQPpw1/HDC8fogQjEv9st3i+fPFBUEK1wJ4j0l44XdJv4gsNBqtUjYB4n
 bswEkCI5388H5Djbc/81rhnSpz4H6Y59cs6GBVq4OxN3EZ3IRPTyfTRqKqsOp6+by2a6
 gauAefHXm/OE33WwacMVmY7UtzvhbURgmG5S6VuWk4JWcu/IL6iocXJukF/KcAXdbZdY
 zYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=TmGU9WAPsEVWhfmgtFdDLBvqM5rH3VdZccUlSg63gPM=;
 b=iunPLNdVZoWazybfufKrdh7OZ59822NeCd1A8wK1mBlFi8QjjHMnNXcZfZrqNvO9p+
 KjWm4th7U0rDPIlrv7zgjQDK+jYBcOke7wYYpQvQMaH82KHkCQZ39hwiXWdaII+NDSs1
 UT/n/A69HsuPL9VpOP1uG6689hLz9i45AQjSKCITDS36AgNUmeOxrC85WB+4HFb5F0VX
 gb+UWyXKfJP7LuMUQz1qRVJKal4WYUn+Elqx13Q/ThmaZ4mZY0PCa66zD4g61Kwd7fJB
 /ENgnR9a77kyJqhwNsZl+ES8B/7vyQKdRSCh8qPU5ASh13GXwyEFGUjxdhw6rgEY3V3J
 uRDg==
X-Gm-Message-State: APjAAAV+cOoZ04EAXvXh26TfMkXKh04bxIHHYFLT3ZMnDwJ4+veeoPp7
 gNSzHy/RQPMMaiYi5KmEV5qtfG3mV0fU/kmY7Uk=
X-Google-Smtp-Source: APXvYqy7GpuECzCOcLE1T/S+w2DdJ2AOb57u/TBxDUhv+5K2slgHAAaATogcO83DfxPHlHJiAWaXDIsqmkYFJapuitI=
X-Received: by 2002:a54:460c:: with SMTP id p12mr16666994oip.62.1570883045317; 
 Sat, 12 Oct 2019 05:24:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 12 Oct 2019 05:24:04
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 12 Oct 2019 05:24:04
 -0700 (PDT)
In-Reply-To: <6dfd36cf-9d2f-d74a-2c8e-4b283973e8f7@redhat.com>
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
 <20190504083638.13380-9-S.E.Harris@kent.ac.uk>
 <c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
 <CAK4993h0yCqpjBFzPy7GHt3kbSK43nLD6EXh4WFd_STHu15DTA@mail.gmail.com>
 <20190510121732.de0aa4075bcf6962a7414054@kent.ac.uk>
 <6dfd36cf-9d2f-d74a-2c8e-4b283973e8f7@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 12 Oct 2019 14:24:04 +0200
Message-ID: <CAL1e-=h4-ebdM5yNjhx5hm0SB-3w+6KNECneZyq_pM4=Rkb7uA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support with
 the rest of QEMU, the build system, and the MAINTAINERS file
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e661100594b5b50e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 E.J.C.Robbins@kent.ac.uk, A.M.King@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e661100594b5b50e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

12.10.2019. 09.31, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi Sarah,
>
>
> On 5/10/19 1:17 PM, Sarah Harris wrote:
>>
>> Hi Richard,
>>
>> Having discussed with my colleagues, we don't have the resources to
maintain this.
>> If you wanted to take up Michael's offer then I'm happy to respond to
queries and provide minor fixes.
>> Otherwise, we will make our repository publicly available in the near
future for anyone who wants to use it.
>
>
> Would you agree to be listed as reviewer for AVR (Michael being the
maintainer)?
>

I support this idea, and hopefully Sarah agrees. Reviewer role typically
require mucj less tome resources.

>   M: Mail patches to: FullName <address@domain>
>      Maintainers are looking after a certain area and must be CCed on
>      patches. They are considered the main contact point.
>   R: Designated reviewer: FullName <address@domain>
>      These reviewers should be CCed on patches.
>      Reviewers are familiar with the subject matter and provide feedback
>      even though they are not maintainers.
>
>
>> Kind regards,
>> Sarah Harris
>>
>> On Sun, 5 May 2019 09:10:00 -0700
>> Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>>> Hi Richard.
>>>
>>> I can maintain it
>>>
>>> Sent from my cell phone, please ignore typos
>>>
>>> On Sun, May 5, 2019, 8:57 AM Richard Henderson <
richard.henderson@linaro.org>
>>> wrote:
>>>
>>>> On 5/4/19 1:36 AM, Sarah Harris wrote:
>>>>>
>>>>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>>>>
>>>> ...
>>>>>
>>>>>
>>>>> +AVR
>>>>> +M: Michael Rolnik <mrolnik@gmail.com>
>>>>> +S: Odd Fixes
>>>>> +F: target-avr/
>>>>> +F: hw/avr/
>>>>> +
>>>>
>>>>
>>>> This is not how things work.  Michael wasn't up to maintaining the
code 2
>>>> years
>>>> ago; that's why it was never committed.
>>>>
>>>> You would need to maintain this yourself, and for more than "Odd
Fixes".
>>>>
>>>>
>>>> r~
>>>>
>>
>
>

--000000000000e661100594b5b50e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
12.10.2019. 09.31, &quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"m=
ailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Hi Sarah,<br>
&gt;<br>
&gt;<br>
&gt; On 5/10/19 1:17 PM, Sarah Harris wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Richard,<br>
&gt;&gt;<br>
&gt;&gt; Having discussed with my colleagues, we don&#39;t have the resourc=
es to maintain this.<br>
&gt;&gt; If you wanted to take up Michael&#39;s offer then I&#39;m happy to=
 respond to queries and provide minor fixes.<br>
&gt;&gt; Otherwise, we will make our repository publicly available in the n=
ear future for anyone who wants to use it.<br>
&gt;<br>
&gt;<br>
&gt; Would you agree to be listed as reviewer for AVR (Michael being the ma=
intainer)?<br>
&gt;</p>
<p dir=3D"ltr">I support this idea, and hopefully Sarah agrees. Reviewer ro=
le typically require mucj less tome resources.</p>
<p dir=3D"ltr">&gt; =C2=A0 M: Mail patches to: FullName &lt;address@domain&=
gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0Maintainers are looking after a certain area and m=
ust be CCed on<br>
&gt; =C2=A0 =C2=A0 =C2=A0patches. They are considered the main contact poin=
t.<br>
&gt; =C2=A0 R: Designated reviewer: FullName &lt;address@domain&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0These reviewers should be CCed on patches.<br>
&gt; =C2=A0 =C2=A0 =C2=A0Reviewers are familiar with the subject matter and=
 provide feedback<br>
&gt; =C2=A0 =C2=A0 =C2=A0even though they are not maintainers.<br>
&gt;<br>
&gt;<br>
&gt;&gt; Kind regards,<br>
&gt;&gt; Sarah Harris<br>
&gt;&gt;<br>
&gt;&gt; On Sun, 5 May 2019 09:10:00 -0700<br>
&gt;&gt; Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrolnik@gm=
ail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Hi Richard.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I can maintain it<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Sent from my cell phone, please ignore typos<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Sun, May 5, 2019, 8:57 AM Richard Henderson &lt;<a href=3D"=
mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt;<b=
r>
&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 5/4/19 1:36 AM, Sarah Harris wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.=
Harris@kent.ac.uk">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ...<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; +AVR<br>
&gt;&gt;&gt;&gt;&gt; +M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail=
.com">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; +S: Odd Fixes<br>
&gt;&gt;&gt;&gt;&gt; +F: target-avr/<br>
&gt;&gt;&gt;&gt;&gt; +F: hw/avr/<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This is not how things work.=C2=A0 Michael wasn&#39;t up t=
o maintaining the code 2<br>
&gt;&gt;&gt;&gt; years<br>
&gt;&gt;&gt;&gt; ago; that&#39;s why it was never committed.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; You would need to maintain this yourself, and for more tha=
n &quot;Odd Fixes&quot;.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; r~<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
</p>

--000000000000e661100594b5b50e--

