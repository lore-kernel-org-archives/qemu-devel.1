Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689D6C35240
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 02:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4992083E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 02:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am+pXPUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4992083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivu6o-0000ro-Ag
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 21:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivu63-0008RA-Mo
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 21:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivu62-0002Hv-H0
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 21:25:51 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ivu62-0002Hd-BU; Sun, 26 Jan 2020 21:25:50 -0500
Received: by mail-oi1-x241.google.com with SMTP id a142so3716780oii.7;
 Sun, 26 Jan 2020 18:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZUd6d07jDQKG/lVoBSvsCjWj4YjqzhgMSWovAObEQN8=;
 b=am+pXPUbmfGljM4HMy7kh9IsCiKkqiSPs+4t8XvOeM2Ev7kiS5nRfahhcuTdH/haho
 DLMqPT+jRhgR/121OFh2oHsIwMNjZqNdTZuZsO88PUTO0ux7Odh/r9WSvelpTiQ5ET9t
 SkpOU2OJSV4hG9SipsGfUIQxX/lvxWDHnJswDhJYkWZHVvO4DEYeA0H7x8PawBz1+a4j
 XA1siM4U4iK82UgSfvnKp9GTkxRS3U+H8+fMqsyNAfAVZRiQWC3kZdIjkm8M2lVmVoNQ
 mpwEloh43K46SGLSc57g1jOjY4w8BoRCSH2zZQgK0kOvGm7zko9vxIwrySJHfV7h3uIH
 avDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZUd6d07jDQKG/lVoBSvsCjWj4YjqzhgMSWovAObEQN8=;
 b=ZAB1wyEAYWcGLVl7jwj6KYAQgXqM9Kvf3LYi/AF9mHsZ+IGIn2EqMa1Sa99PDL2z8r
 VHcsib9HgexGGfJN6596eHpbH434lETBGfWKG6xMk9WrSnwOWBAPmCYW/4DCk5STTwvs
 fyeSjyS/nlabbvazrTGO3fRaPMM8/dKReipaIi8GTPrP/LgL4B5ZO+2a1SOEMdCZ/GAs
 k6HUGZ3Zjh7jlUi2bP2Eb50/OkEiE5NbZLI+PO85CmRIhQse/CmZSzl8qps/aaV0BwXj
 bcvLHq4QY/BPzq+J66fXbSQoCEwRhUgE3yVqP7/xWWfSXyycNmqeJNiPSBsZz9IopJ8y
 T5wQ==
X-Gm-Message-State: APjAAAVwUDSiga2+joZsMa9l7xC7lh5LF+0lCT/toGkkweJqahyUZAEP
 ZaHcpZMDJXRxytF0B0wNhfGenzIMZaDkni6Afjs=
X-Google-Smtp-Source: APXvYqxKvMi2XJYOVZrO7MKESeQXl6tbVwNrlCFQRK0hwGIfD6jT44G0swj+3G/3mZ1vMIig+WfwK7QRKoFvPxkicAE=
X-Received: by 2002:a05:6808:3ba:: with SMTP id
 n26mr4586462oie.62.1580091949436; 
 Sun, 26 Jan 2020 18:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-2-f4bug@amsat.org>
 <7ae1607e-060e-23ac-f651-8f2ace8991ba@xcancerberox.com.ar>
In-Reply-To: <7ae1607e-060e-23ac-f651-8f2ace8991ba@xcancerberox.com.ar>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 27 Jan 2020 03:25:37 +0100
Message-ID: <CAL1e-=gkUg3hk68uO2tYEmBR=ARUAKgj0c0q8x7w40gi2O4X2A@mail.gmail.com>
Subject: Re: [PATCH rc2 01/25] target/avr: Add outward facing interfaces and
 core CPU logic
To: Joaquin de Andres <me@xcancerberox.com.ar>
Content-Type: multipart/alternative; boundary="0000000000005bd4f2059d15d34c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Igor Mammedov <imammedo@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005bd4f2059d15d34c
Content-Type: text/plain; charset="UTF-8"

On Sun, Jan 26, 2020 at 1:15 PM Joaquin de Andres <me@xcancerberox.com.ar>
wrote:

> > +struct CPUAVRState {
> > +    uint32_t pc_w; /* 0x003fffff up to 22 bits */
> > +
> > +    uint32_t sregC; /* 0x00000001 1 bit */
> > +    uint32_t sregZ; /* 0x00000001 1 bit */
> > +    uint32_t sregN; /* 0x00000001 1 bit */
> > +    uint32_t sregV; /* 0x00000001 1 bit */
> > +    uint32_t sregS; /* 0x00000001 1 bit */
> > +    uint32_t sregH; /* 0x00000001 1 bit */
> > +    uint32_t sregT; /* 0x00000001 1 bit */
> > +    uint32_t sregI; /* 0x00000001 1 bit */
> > +
> > +    uint32_t rampD; /* 0x00ff0000 8 bits */
> > +    uint32_t rampX; /* 0x00ff0000 8 bits */
> > +    uint32_t rampY; /* 0x00ff0000 8 bits */
> > +    uint32_t rampZ; /* 0x00ff0000 8 bits */
> > +    uint32_t eind; /* 0x00ff0000 8 bits */
> > +
> > +    uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each */
> > +    uint32_t sp; /* 16 bits */
> > +
> > +    uint32_t skip; /* if set skip instruction */
> > +
> > +    uint64_t intsrc; /* interrupt sources */
> > +    bool fullacc; /* CPU/MEM if true MEM only otherwise */
> > +
> > +    uint32_t features;
> > +};
>
> Why not use 'uint8_t' for all sreg bits, ramps, eind and user registers,
> and bool for skip flag?
>

On the other hand, there are already appr. 25 features, and "uint32_t
feature" won't be likely to be enough in near future. I suggested earlier
"uint64_t" to be used.

Thanks,
Aleksandar

--0000000000005bd4f2059d15d34c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sun, Jan 26, 2020 at 1:15 PM Joaquin de Andres =
&lt;<a href=3D"mailto:me@xcancerberox.com.ar">me@xcancerberox.com.ar</a>&gt=
; wrote:<br><br>&gt; &gt; +struct CPUAVRState {<br>&gt; &gt; + =C2=A0 =C2=
=A0uint32_t pc_w; /* 0x003fffff up to 22 bits */<br>&gt; &gt; +<br>&gt; &gt=
; + =C2=A0 =C2=A0uint32_t sregC; /* 0x00000001 1 bit */<br>&gt; &gt; + =C2=
=A0 =C2=A0uint32_t sregZ; /* 0x00000001 1 bit */<br>&gt; &gt; + =C2=A0 =C2=
=A0uint32_t sregN; /* 0x00000001 1 bit */<br>&gt; &gt; + =C2=A0 =C2=A0uint3=
2_t sregV; /* 0x00000001 1 bit */<br>&gt; &gt; + =C2=A0 =C2=A0uint32_t sreg=
S; /* 0x00000001 1 bit */<br>&gt; &gt; + =C2=A0 =C2=A0uint32_t sregH; /* 0x=
00000001 1 bit */<br>&gt; &gt; + =C2=A0 =C2=A0uint32_t sregT; /* 0x00000001=
 1 bit */<br>&gt; &gt; + =C2=A0 =C2=A0uint32_t sregI; /* 0x00000001 1 bit *=
/<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0uint32_t rampD; /* 0x00ff0000 =
8 bits */<br>&gt; &gt; + =C2=A0 =C2=A0uint32_t rampX; /* 0x00ff0000 8 bits =
*/<br>&gt; &gt; + =C2=A0 =C2=A0uint32_t rampY; /* 0x00ff0000 8 bits */<br>&=
gt; &gt; + =C2=A0 =C2=A0uint32_t rampZ; /* 0x00ff0000 8 bits */<br>&gt; &gt=
; + =C2=A0 =C2=A0uint32_t eind; /* 0x00ff0000 8 bits */<br>&gt; &gt; +<br>&=
gt; &gt; + =C2=A0 =C2=A0uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each=
 */<br>&gt; &gt; + =C2=A0 =C2=A0uint32_t sp; /* 16 bits */<br>&gt; &gt; +<b=
r>&gt; &gt; + =C2=A0 =C2=A0uint32_t skip; /* if set skip instruction */<br>=
&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0uint64_t intsrc; /* interrupt sourc=
es */<br>&gt; &gt; + =C2=A0 =C2=A0bool fullacc; /* CPU/MEM if true MEM only=
 otherwise */<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0uint32_t features;=
<br>&gt; &gt; +};<br>&gt;<br>&gt; Why not use &#39;uint8_t&#39; for all sre=
g bits, ramps, eind and user registers,<br>&gt; and bool for skip flag?<br>=
&gt;<br><div><br></div><div>On the other hand, there are already appr. 25 f=
eatures, and &quot;uint32_t feature&quot; won&#39;t be likely to be enough =
in near future. I suggested earlier &quot;uint64_t&quot; to be used.</div><=
div><br></div><div>Thanks,</div><div>Aleksandar<br></div></div>

--0000000000005bd4f2059d15d34c--

