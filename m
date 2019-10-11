Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C56CC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3723E2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWuSik5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3723E2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2HR-0007IW-EO
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 17:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJ2Fj-0006gi-04
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJ2Fh-00064t-8j
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:15:10 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iJ2Fh-00064T-0G
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:15:09 -0400
Received: by mail-ot1-x344.google.com with SMTP id g13so9145461otp.8
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=7LdmbTs9qV6aqwRqrfduURKFO2GjoNPW5Qiouy36Vp4=;
 b=HWuSik5eR9rscyiFxQ8XKXVTi8haVNuhZiL2Sp9WjDNVbuGrIrjsgJOO2TZrUVhkdR
 0XHNPcoLyLR7O3n2sb24PfF1vifIpXMwJ/yNP7SW93f84f0YKq2MxuyfV5UYx4swsZG+
 U26gAwGAr7pbTbYN/Wm7OWEqA1OAM/HhTar+JUbEtfJgkTy+VcXbloGAwCeNpaPj7zV6
 74zYrYZVj/w5I0RGlcfTVlIUEYv2tcVgWVl2JDD/SsiQQTQRYei+q8Nii7Xk/r1clTaK
 uO0mjpsHr+lmVA7q0unokQfA8p27BjehIBMLLjP+i5Xp0u+dWy8WK8NmWJRdxys0cUAH
 vc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=7LdmbTs9qV6aqwRqrfduURKFO2GjoNPW5Qiouy36Vp4=;
 b=ACg6FJW8zeU4+b9WSD+r9FcAA1ayu10Jjq5jhpwlvpqTLQ0FXSB9NE+vNLktW0Ipqq
 bKnzP4wzx6Rj35HEJgwthcP9xcsodEudvNuuTfRJEzxKGx7n7jiMWa4E0s0zwvGsmA/j
 Z0a4O14Q1Y7DY41X18UI0eiU80227wL1v9JQTG9Z/wVB9fW3ES5fsopa+a7P3d6LOgZe
 hZdFTe2QIuMinBK88B4gUQlNEFG7yPZD7IQHM44kO+1MuoWih4pvRduah6HaVvPvQ7Ns
 tAVlHzyKc0tYTAOXNlp9uQIL5bb6L3TJI5qJzSBbbhNuWdV2fsNhHQDRfaEGYnIs4MGu
 TSgg==
X-Gm-Message-State: APjAAAU6FC1AyB5I8wuHf8NusQXS++uFoV7hO3M0XJNmR82b4OeEzDJI
 JokTtMqZJ/qsK3aDt0ImtbNkPN6qghfijF2SFvE=
X-Google-Smtp-Source: APXvYqyQABWKSi6iMiHUg/hQItY/lKVT5qTM+UgNAExG3sSANaiEpo1LsIsIYzTuXrXTFw4cdphCe0hbrcf6c4eVaHE=
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr13979027otl.64.1570828508093; 
 Fri, 11 Oct 2019 14:15:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 11 Oct 2019 14:15:07
 -0700 (PDT)
In-Reply-To: <87y2xrl0ta.fsf@linaro.org>
References: <20190902140134.74081-1-mrolnik@gmail.com>
 <949009b8-58ec-4a9e-cfd7-7d4611fad380@redhat.com>
 <CAL1e-=h1PV6djRgWXikjnU79Ca7Pjfw9=0u9__Nz00FJ4R49Hg@mail.gmail.com>
 <87y2xrl0ta.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 11 Oct 2019 23:15:07 +0200
Message-ID: <CAL1e-=i-dqSy7dXhs_OAtfWEcSnKccQ6QvDOGPj42oruCAxV=Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v30 0/8] QEMU AVR 8 bit cores
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003a653a0594a90382"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "thuth@redhat.com" <thuth@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003a653a0594a90382
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, October 11, 2019, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:

>
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>
> > On Friday, October 11, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
> > wrote:
> >
> >> Hi Michael,
> >>
> >> On 9/2/19 4:01 PM, Michael Rolnik wrote:
> >>
> >>> This series of patches adds 8bit AVR cores to QEMU.
> >>> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not full=
y
> >>> tested yet.
> >>> However I was able to execute simple code with functions. e.g fibonac=
ci
> >>> calculation.
> >>> This series of patches include a non real, sample board.
> >>> No fuses support yet. PC is set to 0 at reset.
> >>>
> >>> the patches include the following
> >>> 1. just a basic 8bit AVR CPU, without instruction decoding or
> translation
> >>> 2. CPU features which allow define the following 8bit AVR cores
> >>>       avr1
> >>>       avr2 avr25
> >>>       avr3 avr31 avr35
> >>>       avr4
> >>>       avr5 avr51
> >>>       avr6
> >>>       xmega2 xmega4 xmega5 xmega6 xmega7
> >>> 3. a definition of sample machine with SRAM, FLASH and CPU which allo=
ws
> >>> to execute simple code
> >>> 4. encoding for all AVR instructions
> >>> 5. interrupt handling
> >>> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
> >>> 7. a decoder which given an opcode decides what istruction it is
> >>> 8. translation of AVR instruction into TCG
> >>> 9. all features together
> >>>
> >>> [..]
> >>
> >>> Michael Rolnik (7):
> >>>    target/avr: Add outward facing interfaces and core CPU logic
> >>>    target/avr: Add instruction helpers
> >>>    target/avr: Add instruction decoding
> >>>    target/avr: Add instruction translation
> >>>    target/avr: Add example board configuration
> >>>    target/avr: Register AVR support with the rest of QEMU, the build
> >>>      system, and the MAINTAINERS file
> >>>    target/avr: Add tests
> >>>
> >>> Sarah Harris (1):
> >>>    target/avr: Add limited support for USART and 16 bit timer
> peripherals
> >>>
> >>
> >> Overall architecture patches look good, but I'd like some more time to
> >> review the hardware patches. Unfortunately I won't have time until
> November.
> >> There was a chat on IRC about your series,
> >>
> > I don't see the reason why do you initiate IRC communication on this
> topic,
> > if we have the mailing list for discussing such important issues as
> > introducing a new target (that should be definitely visible to all
> > participants).
>
> IRC is often a good way of quickly discussing something when someone is
> about (often as a tangent from another discussion). I don't think there
> is anything wrong with that as long as it's followed up on the mailing
> list.
>
>
OK, at least the series got some attention, be it on IRC or on the list. I
still find it odd that suddenly, after months and months of this series
practically sitting on the list, any suggestion couldn't first be discussed
here, so that we collectively find the best outcome. But, yes, I probably
produced much ado about nothing. I hope that this would soon result in
helping Michael complete the integration. Micheal, whatever I said
regarding patch 4, is only a suggestion - if others are fine with it, I am
fine too. Best luck to all involved! :)

Aleksandar



> >
> >> I suggested Richard we could merge patches 1-4 and 7. They are almost
> >> sufficient to run the qemu-avr-tests gdbstub tests (but not the FreeRT=
OS
> >> ones).
>
> Which is was ;-)
>
> --
> Alex Benn=C3=A9e
>
>

--0000000000003a653a0594a90382
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, October 11, 2019, Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><br>
Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">alek=
sandar.m.mail@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Friday, October 11, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; Hi Michael,<br>
&gt;&gt;<br>
&gt;&gt; On 9/2/19 4:01 PM, Michael Rolnik wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; This series of patches adds 8bit AVR cores to QEMU.<br>
&gt;&gt;&gt; All instruction, except BREAK/DES/SPM/SPMX, are implemented. N=
ot fully<br>
&gt;&gt;&gt; tested yet.<br>
&gt;&gt;&gt; However I was able to execute simple code with functions. e.g =
fibonacci<br>
&gt;&gt;&gt; calculation.<br>
&gt;&gt;&gt; This series of patches include a non real, sample board.<br>
&gt;&gt;&gt; No fuses support yet. PC is set to 0 at reset.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; the patches include the following<br>
&gt;&gt;&gt; 1. just a basic 8bit AVR CPU, without instruction decoding or =
translation<br>
&gt;&gt;&gt; 2. CPU features which allow define the following 8bit AVR core=
s<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0avr1<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0avr2 avr25<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0avr3 avr31 avr35<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0avr4<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0avr5 avr51<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0avr6<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0xmega2 xmega4 xmega5 xmega6 xmega7<b=
r>
&gt;&gt;&gt; 3. a definition of sample machine with SRAM, FLASH and CPU whi=
ch allows<br>
&gt;&gt;&gt; to execute simple code<br>
&gt;&gt;&gt; 4. encoding for all AVR instructions<br>
&gt;&gt;&gt; 5. interrupt handling<br>
&gt;&gt;&gt; 6. helpers for IN, OUT, SLEEP, WBR &amp; unsupported instructi=
ons<br>
&gt;&gt;&gt; 7. a decoder which given an opcode decides what istruction it =
is<br>
&gt;&gt;&gt; 8. translation of AVR instruction into TCG<br>
&gt;&gt;&gt; 9. all features together<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [..]<br>
&gt;&gt;<br>
&gt;&gt;&gt; Michael Rolnik (7):<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/avr: Add outward facing interfaces and cor=
e CPU logic<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction helpers<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction decoding<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction translation<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/avr: Add example board configuration<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/avr: Register AVR support with the rest of=
 QEMU, the build<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 system, and the MAINTAINERS file<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/avr: Add tests<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Sarah Harris (1):<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/avr: Add limited support for USART and 16 =
bit timer peripherals<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Overall architecture patches look good, but I&#39;d like some more=
 time to<br>
&gt;&gt; review the hardware patches. Unfortunately I won&#39;t have time u=
ntil November.<br>
&gt;&gt; There was a chat on IRC about your series,<br>
&gt;&gt;<br>
&gt; I don&#39;t see the reason why do you initiate IRC communication on th=
is topic,<br>
&gt; if we have the mailing list for discussing such important issues as<br=
>
&gt; introducing a new target (that should be definitely visible to all<br>
&gt; participants).<br>
<br>
IRC is often a good way of quickly discussing something when someone is<br>
about (often as a tangent from another discussion). I don&#39;t think there=
<br>
is anything wrong with that as long as it&#39;s followed up on the mailing<=
br>
list.<br>
<br></blockquote><div><br></div><div>OK, at least the series got some atten=
tion, be it on IRC or on the list. I still find it odd that suddenly, after=
 months and months of this series practically sitting on the list, any sugg=
estion couldn&#39;t first be discussed here, so that we collectively find t=
he best outcome. But, yes, I probably produced much ado about nothing. I ho=
pe that this would soon result in helping Michael complete the integration.=
 Micheal, whatever I said regarding patch 4, is only a suggestion - if othe=
rs are fine with it, I am fine too. Best luck to all involved! :)</div><div=
><br></div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
&gt;<br>
&gt;&gt; I suggested Richard we could merge patches 1-4 and 7. They are alm=
ost<br>
&gt;&gt; sufficient to run the qemu-avr-tests gdbstub tests (but not the Fr=
eeRTOS<br>
&gt;&gt; ones).<br>
<br>
Which is was ;-)<br>
<br>
--<br>
Alex Benn=C3=A9e<br>
<br>
</blockquote>

--0000000000003a653a0594a90382--

