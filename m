Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C57C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB5C2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB5C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCtU8-0005VF-Au
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 19:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCtTW-0004x3-44; Mon, 31 Aug 2020 19:44:34 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:32836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCtTU-0000yA-7b; Mon, 31 Aug 2020 19:44:33 -0400
Received: by mail-ej1-f67.google.com with SMTP id h4so9230152ejj.0;
 Mon, 31 Aug 2020 16:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cv6omRegAey/8dBtaOUKEmVJo5RANXjdsu6UrezM83s=;
 b=qfPZgDCNaUD4llVXS2ltbkAm7peXMLxG0NHk4lg+JdpqnMRcfASwr564oY5NOp9d/o
 cy6sP8ksShYOqmK7kr2i7BPDqh1aFzMlfVyZ7YEfrxtBqJmef7AKtTWMZJ5yc1o1ztvf
 vAdCOAsU6vlOIvHkeOkLKTZnOWVDZ1UT3CUg6sj4I+yigDXx4keL4+KWUFqSOzvxRbT0
 8E6hbJhWQNLKi8/OZIG6HjrDg1loI53UjMeH04pmNUijkxGHC84alACyZ3L+/PK/FkdQ
 4Jf0Blt2vqs+g668zQbLxo87h8nnYRSWLi+ayNq2rvfZX9tUtB99fBaSUxhresW2R3aG
 x7YA==
X-Gm-Message-State: AOAM530frzwQzFldN6yrn4YKB2tz7KR7G++2md9PyKvsEcnu220E1jqb
 Q6R6dEZZvuIs6T7Cncsvi8Kv8hAgnpjFSZgZFhA=
X-Google-Smtp-Source: ABdhPJx4xxADoXEFoC99R0NmaqlLrQZU0HrgtrZfX3DD5/nf/QEz7z/hRuJIR2Ni+LoG1gZoJ7DS3v+sjysuHagrguc=
X-Received: by 2002:a17:907:728e:: with SMTP id
 dt14mr3156309ejc.4.1598917470364; 
 Mon, 31 Aug 2020 16:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200819182856.4893-1-robert.foley@linaro.org>
 <20200819182856.4893-3-robert.foley@linaro.org>
 <439e8b14-adc1-b7ea-edaa-d11069863007@linaro.org>
 <e324f958-8c9e-ebe1-e624-7eec610fe5aa@linaro.org>
In-Reply-To: <e324f958-8c9e-ebe1-e624-7eec610fe5aa@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 1 Sep 2020 01:44:17 +0200
Message-ID: <CAAdtpL6hA0jQmivGrG7g9z4tbU8JhoW9zzhPgfh566r75XeZfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] target/arm: add ARMCPUClass->do_interrupt_locked
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d8aa8e05ae34fb5e"
Received-SPF: pass client-ip=209.85.218.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: peter.puhov@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Robert Foley <robert.foley@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d8aa8e05ae34fb5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 1 sept. 2020 00:02, Richard Henderson <richard.henderson@linaro.org=
>
a =C3=A9crit :

> On 8/31/20 2:18 PM, Richard Henderson wrote:
> > On 8/19/20 11:28 AM, Robert Foley wrote:
> >> Adding ->do_interrupt_locked to ARMCPUClass is preparation for
> >> pushing the BQL down into the per-arch implementation of ->do_interrup=
t.
> >>
> >> This is needed since ARM's *_cpu_exec_interrupt calls to *_do_interrup=
t.
> >> With the push down of the BQL into *_cpu_exec_interrupt and
> >> *_do_interrupt, *_cpu_exec_interrupt will call to ->do_interrupt
> >> with lock held.  Since ->do_interrupt also has the lock, we need a way
> >> to allow cpu_exec_interrupt to call do_interrupt with lock held.
> >> This patch solves this issue of *_cpu_exec_interrupt needing
> >> to call do_interrupt with lock held.
> >>
> >> This patch is part of a series of transitions to move the
> >> BQL down into the do_interrupt per arch functions.  This set of
> >> transitions is needed to maintain bisectability.
> >>
> >> This approach was suggested by Paolo Bonzini.
> >> For reference, here are two key posts in the discussion, explaining
> >> the reasoning/benefits of this approach.
> >> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
> >> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
> >> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
> >> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html
> >>
> >> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> >> ---
> >>  target/arm/cpu-qom.h | 3 +++
> >>  target/arm/cpu.c     | 5 +++--
> >>  target/arm/cpu_tcg.c | 5 +++--
> >>  3 files changed, 9 insertions(+), 4 deletions(-)
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> I take it back.  These two cc->do_interrupt calls can be replaced with
> direct
> calls.
>
> > #ifndef CONFIG_USER_ONLY
> >     cc->do_interrupt =3D arm_v7m_cpu_do_interrupt;
> > #endif
> >
> >     cc->cpu_exec_interrupt =3D arm_v7m_cpu_exec_interrupt;
>
> If we are in arm_v7m_cpu_exec_interrupt we will always call
> arm_v7m_cpu_do_interrupt.
>
> I think the mismatch of #ifdef, which implies a different destination is
> possible, is a bug -- cc->do_interrupt is not otherwise assigned and in
> fact
> would be NULL.
>
> I suspect that some of these slots themselves should be ifdefed, so that =
we
> cannot assign to them when they are unused.  That would help keep the
> ifdefs in
> the cpu init functions in sync.
>

I tried to do this once but this breaks sizeof(CPUState) archived in
libqemu.a vs linking softmmu / user.
IIRC Peter explained why we can't do that. I'll search the post tomorrow.


> This same condition is *not* true for cris -- there is no
> crisv10_cpu_exec_interrupt -- so you do need the new do_interrupt_locked
> field
> there.
>
>
> r~
>
>

--000000000000d8aa8e05ae34fb5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le mar. 1 sept. 2020 00:02, Richard Henderson &lt;<a h=
ref=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a=
>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 8/31/=
20 2:18 PM, Richard Henderson wrote:<br>
&gt; On 8/19/20 11:28 AM, Robert Foley wrote:<br>
&gt;&gt; Adding -&gt;do_interrupt_locked to ARMCPUClass is preparation for<=
br>
&gt;&gt; pushing the BQL down into the per-arch implementation of -&gt;do_i=
nterrupt.<br>
&gt;&gt;<br>
&gt;&gt; This is needed since ARM&#39;s *_cpu_exec_interrupt calls to *_do_=
interrupt.<br>
&gt;&gt; With the push down of the BQL into *_cpu_exec_interrupt and<br>
&gt;&gt; *_do_interrupt, *_cpu_exec_interrupt will call to -&gt;do_interrup=
t<br>
&gt;&gt; with lock held.=C2=A0 Since -&gt;do_interrupt also has the lock, w=
e need a way<br>
&gt;&gt; to allow cpu_exec_interrupt to call do_interrupt with lock held.<b=
r>
&gt;&gt; This patch solves this issue of *_cpu_exec_interrupt needing<br>
&gt;&gt; to call do_interrupt with lock held.<br>
&gt;&gt;<br>
&gt;&gt; This patch is part of a series of transitions to move the<br>
&gt;&gt; BQL down into the do_interrupt per arch functions.=C2=A0 This set =
of<br>
&gt;&gt; transitions is needed to maintain bisectability.<br>
&gt;&gt;<br>
&gt;&gt; This approach was suggested by Paolo Bonzini.<br>
&gt;&gt; For reference, here are two key posts in the discussion, explainin=
g<br>
&gt;&gt; the reasoning/benefits of this approach.<br>
&gt;&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-08/m=
sg00784.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists=
.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html</a><br>
&gt;&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-08/m=
sg01517.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists=
.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html</a><br>
&gt;&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/m=
sg08731.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists=
.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html</a><br>
&gt;&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-08/m=
sg00044.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists=
.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html</a><br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Robert Foley &lt;<a href=3D"mailto:robert.foley@lin=
aro.org" target=3D"_blank" rel=3D"noreferrer">robert.foley@linaro.org</a>&g=
t;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 target/arm/cpu-qom.h | 3 +++<br>
&gt;&gt;=C2=A0 target/arm/cpu.c=C2=A0 =C2=A0 =C2=A0| 5 +++--<br>
&gt;&gt;=C2=A0 target/arm/cpu_tcg.c | 5 +++--<br>
&gt;&gt;=C2=A0 3 files changed, 9 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.=
org</a>&gt;<br>
<br>
I take it back.=C2=A0 These two cc-&gt;do_interrupt calls can be replaced w=
ith direct<br>
calls.<br>
<br>
&gt; #ifndef CONFIG_USER_ONLY<br>
&gt;=C2=A0 =C2=A0 =C2=A0cc-&gt;do_interrupt =3D arm_v7m_cpu_do_interrupt;<b=
r>
&gt; #endif<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0cc-&gt;cpu_exec_interrupt =3D arm_v7m_cpu_exec_inte=
rrupt;<br>
<br>
If we are in arm_v7m_cpu_exec_interrupt we will always call<br>
arm_v7m_cpu_do_interrupt.<br>
<br>
I think the mismatch of #ifdef, which implies a different destination is<br=
>
possible, is a bug -- cc-&gt;do_interrupt is not otherwise assigned and in =
fact<br>
would be NULL.<br>
<br>
I suspect that some of these slots themselves should be ifdefed, so that we=
<br>
cannot assign to them when they are unused.=C2=A0 That would help keep the =
ifdefs in<br>
the cpu init functions in sync.<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">I tried to do this once but this breaks size=
of(CPUState) archived in libqemu.a vs linking softmmu / user.</div><div dir=
=3D"auto">IIRC Peter explained why we can&#39;t do that. I&#39;ll search th=
e post tomorrow.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
This same condition is *not* true for cris -- there is no<br>
crisv10_cpu_exec_interrupt -- so you do need the new do_interrupt_locked fi=
eld<br>
there.<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--000000000000d8aa8e05ae34fb5e--

