Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F5C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2729217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnWj4n5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2729217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8tpT-0003qD-Qx
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 17:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j8ton-0003O3-Ks
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j8tol-0002GA-TZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:45:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39074
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j8tol-0002FV-Oy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583189142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LgS3Vy9/bsYSffCraJ55rLfokDod84CwiO3JoFlgTxs=;
 b=LnWj4n5DSu4ufhAHLEkCCPJGmKobtknuwABO4100SoTX2/bKljwkc2RTi4ZKBzc1CgrZFi
 meCdqAO1QRF/bTz2xa61hyUbLW6OqV4yto6bscPLjGNekfcHymB0EeBbRTPbeYMto9fq1Q
 cs+ATX5kidkvWTdzqx9NjBBFS856ARs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-qmJqThRgM6CCrVHgQ01bBA-1; Mon, 02 Mar 2020 17:45:40 -0500
X-MC-Unique: qmJqThRgM6CCrVHgQ01bBA-1
Received: by mail-ed1-f71.google.com with SMTP id y4so717272edm.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 14:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+uLkKlQVnZ9jg9o22TPMZ1yySS1DXRcOBqyCAeYDIt0=;
 b=tCRVZSQJNPaiHdRxjTuWYHDDzBnoq8nFlm3qVeVIqYHeuruKCtur9ye3dYsPCqfJQ2
 EzwjoBA9n60eNexUHPWkQn8KaDwNZCdEBS28QS48q2qDkmp2EO1MhjVY7oBdt81hQF+R
 /ClngmDHBL/EvNzFUzX3TWi+YcKSqcE5kcL0dpye1cxtOMtzaLlGlt+PTOqwRcWy+HKC
 uMwnTUqOGf5gVxSxo/dM1rnZYgUdrNeCbnMZa16HMKAY8fclEOcJHPoY+4pIa3v1rPCg
 Q6Pv9CMwQChhDk+HgYu33P51RVlNuNEylQELUdOCWDdJY8Vlq90rFDUTCPOMyxnOoxkU
 ef7g==
X-Gm-Message-State: ANhLgQ1kTZFO9RQ+0kTyombKst7t5rfzY+S+7OoOLDELDwpTmVPJV7ER
 hkEsNpJZ6mr16mTky4zbc5bedc1U1ZdVzEJLLoNxY8ODFnAFGiB8vLQUArD+/thZmlG/H1FHPMU
 42VDw/mfwWsHCO2COJhSbjWVWHTXjHQw=
X-Received: by 2002:a05:6402:36e:: with SMTP id
 s14mr1403913edw.379.1583189139373; 
 Mon, 02 Mar 2020 14:45:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vub71l1AcnIU3IXFI44bgKREhRe+z+HMfWb4C1kQqgCkZqaQocKKuCfa/SMbFtwMgflpxD9wqKvjdBmuyoELB4=
X-Received: by 2002:a05:6402:36e:: with SMTP id
 s14mr1403888edw.379.1583189139053; 
 Mon, 02 Mar 2020 14:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com>
 <20200128140945.929-3-n54@gmx.com>
 <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
 <4e29b732-ce95-02f1-ec9c-31f1ce33cda0@gmx.com>
 <4ece50db-33c7-4630-6b0f-52197b2ae845@redhat.com>
 <5b289981-1e54-2301-af36-86361415bf6b@gmx.com>
 <bd4bb6d3-be33-2f97-8ee5-695b41b5eff1@m00nbsd.net>
 <CABgObfZ5AdBmU7R8ycFwTLxEHXQw_GrXwJ0BMvDWgJEvKevcGg@mail.gmail.com>
 <8413a29d-3983-4176-5c6c-735a87ab7701@gmx.com>
In-Reply-To: <8413a29d-3983-4176-5c6c-735a87ab7701@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Mar 2020 23:45:26 +0100
Message-ID: <CABgObfYQPspZaoXwOAFkvEUv_20MFvE9fXd7CE5H3FD04-dBQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
To: Kamil Rytarowski <n54@gmx.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000003ef549059fe6f230"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "Maydell, Peter" <peter.maydell@linaro.org>, ehabkost@redhat.com,
 slp@redhat.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Maxime Villard <max@m00nbsd.net>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003ef549059fe6f230
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 2 mar 2020, 22:11 Kamil Rytarowski <n54@gmx.com> ha scritto:

> > The difference is that KVM for example does not need external includes
> > or libraries.
>

We don't support this scenario


What scenario?

and after a year there might be no
> supported release without NVMM.
>
> The only concern is about using qemu on !amd64, but we have there not
> many users of qemu for understandable reasons.
>

How do you know?

Paolo


> For AArch64 we plan to implement a dedicated NVMM backend.
>
> >
> >     > diff --git a/configure b/configure
> >     > index d4a837cf9d..b3560d88bb 100755
> >     > --- a/configure
> >     > +++ b/configure
> >     > @@ -836,7 +836,7 @@ DragonFly)
> >     >  NetBSD)
> >     >    bsd=3D"yes"
> >     >    hax=3D"yes"
> >     > -  nvmm=3D"yes"
> >     > +  nvmm=3D"check"
> >     >    make=3D"${MAKE-gmake}"
> >     >    audio_drv_list=3D"oss try-sdl"
> >     >    audio_possible_drivers=3D"oss sdl"
> >     >
> >
>
>

--0000000000003ef549059fe6f230
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 2 mar 2020, 22:11 Kamil Rytarowski &lt;<a href=
=3D"mailto:n54@gmx.com">n54@gmx.com</a>&gt; ha scritto:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">&gt; The difference is that KVM for example does not n=
eed external includes<br>
&gt; or libraries.<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
We don&#39;t support this scenario</blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">What scenario?</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">and after a year there might be no<br>
supported release without NVMM.<br>
<br>
The only concern is about using qemu on !amd64, but we have there not<br>
many users of qemu for understandable reasons.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">How do you know?</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
For AArch64 we plan to implement a dedicated NVMM backend.<br>
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/configure b/configure<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index d4a837cf9d..b3560d88bb 100755<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/configure<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/configure<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -836,7 +836,7 @@ DragonFly)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 NetBSD)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 bsd=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 hax=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 nvmm=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 nvmm=3D&quot;check&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 make=3D&quot;${MAKE-gmake}&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 audio_drv_list=3D&quot;oss try-sd=
l&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 audio_possible_drivers=3D&quot;os=
s sdl&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000003ef549059fe6f230--


