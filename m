Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBA2C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 08:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FE92070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 08:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LL2e9EI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FE92070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiwPk-0006I7-7C
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 03:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iiwOh-0005Zj-Bc
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 03:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iiwOa-0003FJ-AW
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 03:15:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iiwOa-00039v-4x
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 03:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577002523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r5eQCqTYLEuWUXnCsHus2MNtPm9rNGNXKC4GnW0xnkY=;
 b=LL2e9EI6FD7+dJ+3jdaRbcF2faNfKi8A2WHWuHXbE9yUJ0p1JsI58RAwXeh/UjEhW+WfpM
 zYKTjH0FxS5UTe1IjYM8XpM3Zj+yteVxWQYqbliqin6a7OewFXLYJNfxXxw02kbeNsRsKv
 lh8BX4FQ9bOa8mA4FmZjyj225ke0mBI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-gCwGeIdZOfqG0BvKiIV6hQ-1; Sun, 22 Dec 2019 03:15:16 -0500
Received: by mail-ed1-f72.google.com with SMTP id n63so8690284edc.20
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 00:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r5eQCqTYLEuWUXnCsHus2MNtPm9rNGNXKC4GnW0xnkY=;
 b=DQt00FnNYWDeqLogNBjbP9QZlL9J71WcbLspBV1pO1fnFyxLnELb4okr7jh19HXgb6
 HvIgiq06KV0xMcSexUtfSjZ08PCkiTiKKEAa+ruwT0+HWn0cbkLItddkCQaFLYBEt4yU
 8Fluhy7oraw6Jq/+IDUFo0JuZ6AJHbZY52RE5ecNwGW6POJpm+/MrWkI+IxhPOV9ntYD
 K/TEG79UnJspSu0TRz5MBDETOlIBjPLdxOd5JOcOgPo9qb/uE7nicjHSDB2M1nuQBFPZ
 YckAtAsZizLtMuTeL+PNK/6fcuYO7aBoD100L9yT5cLraXiQe4KdYFzE3ZAk2tUUAFgw
 C1NA==
X-Gm-Message-State: APjAAAW572Eh1whAjpibvdBwCnxaiWusatUJrxkrp7QaA296IO6Dbpu+
 pzebmkNSCFtjmnC3K4hKWKxosnOoL3j6RrcHKWX8JKNA2EzAT7/dgcCVptFgvSgO6nQvYWS7uTb
 3bS8jetQByghQH7WAPZesZVKiSKcX7rA=
X-Received: by 2002:a05:6402:1771:: with SMTP id
 da17mr26668265edb.68.1577002515192; 
 Sun, 22 Dec 2019 00:15:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqzabMcELlNxekqOGbMYKQ5MkAOG+ahmaNxAYLZ6lvI/RV2e6eWHZbg1b6GGyS7H7a/pAbgwELtoRdwdaH8d2TY=
X-Received: by 2002:a05:6402:1771:: with SMTP id
 da17mr26668243edb.68.1577002514837; 
 Sun, 22 Dec 2019 00:15:14 -0800 (PST)
MIME-Version: 1.0
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <7452FAE9-ACDF-495E-AE5A-8A8ED9488B03@nutanix.com>
In-Reply-To: <7452FAE9-ACDF-495E-AE5A-8A8ED9488B03@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 22 Dec 2019 09:15:02 +0100
Message-ID: <CABgObfaNtUsDiQ8SrwzsTmJEkqa14RiDyUmxeeAgNwYHUm2F7w@mail.gmail.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
To: Ani Sinha <ani.sinha@nutanix.com>
X-MC-Unique: gCwGeIdZOfqG0BvKiIV6hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="000000000000b50b9b059a468239"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Habkost,
 Eduardo" <ehabkost@redhat.com>, rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b50b9b059a468239
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il dom 22 dic 2019, 08:49 Ani Sinha <ani.sinha@nutanix.com> ha scritto:

>
> Ping =E2=80=A6
>

Why ping? You got questions from Eduardo, so you need to answer them and/or
send a fixed version of the patch.

Thanks,

Paolo


> > On Dec 18, 2019, at 5:23 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 18/12/19 10:05, Ani Sinha wrote:
> >> CLZERO CPUID should be passed on to the guests that use EPYC or
> EPYC-IBPB CPU
> >> model when the AMD ZEN based host supports it. This change makes it
> recognize
> >> this CPUID for guests which use EPYC or EPYC-IBPB CPU model.
> >>
> >> Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> >> ---
> >> target/i386/cpu.c | 2 ++
> >> 1 file changed, 2 insertions(+)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index 69f518a..55f0691 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -3813,6 +3813,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
> >>             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM=
 |
> >>             CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
> >>             CPUID_EXT3_TOPOEXT,
> >> +        .features[FEAT_8000_0008_EBX] =3D
> >> +            CPUID_8000_0008_EBX_CLZERO,
> >>         .features[FEAT_7_0_EBX] =3D
> >>             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
> CPUID_7_0_EBX_AVX2 |
> >>             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 |
> CPUID_7_0_EBX_RDSEED |
> >>
> >
> > This needs to be done only for newer machine type (or is it CPU model
> > versions now? need Eduardo to respond).
> >
> > Paolo
>
>

--000000000000b50b9b059a468239
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 22 dic 2019, 08:49 Ani Sinha &lt;<a href=3D"mai=
lto:ani.sinha@nutanix.com">ani.sinha@nutanix.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><br>
Ping =E2=80=A6<br></blockquote></div></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Why ping? You got questions from Eduardo, so you need to answ=
er them and/or send a fixed version of the patch.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; On Dec 18, 2019, at 5:23 PM, Paolo Bonzini &lt;<a href=3D"mailto:pbonz=
ini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a=
>&gt; wrote:<br>
&gt; <br>
&gt; On 18/12/19 10:05, Ani Sinha wrote:<br>
&gt;&gt; CLZERO CPUID should be passed on to the guests that use EPYC or EP=
YC-IBPB CPU<br>
&gt;&gt; model when the AMD ZEN based host supports it. This change makes i=
t recognize<br>
&gt;&gt; this CPUID for guests which use EPYC or EPYC-IBPB CPU model.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani.sinha@nutanix.c=
om" target=3D"_blank" rel=3D"noreferrer">ani.sinha@nutanix.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; target/i386/cpu.c | 2 ++<br>
&gt;&gt; 1 file changed, 2 insertions(+)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt;&gt; index 69f518a..55f0691 100644<br>
&gt;&gt; --- a/target/i386/cpu.c<br>
&gt;&gt; +++ b/target/i386/cpu.c<br>
&gt;&gt; @@ -3813,6 +3813,8 @@ static X86CPUDefinition builtin_x86_defs[] =
=3D {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT3_MISALIGN=
SSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT3_CR8LEG |=
 CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT3_TOPOEXT,=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .features[FEAT_8000_0008_EBX] =3D<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_8000_0008_EBX_CLZ=
ERO,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.features[FEAT_7_0_EBX] =3D<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_7_0_EBX_FSGSB=
ASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_7_0_EBX_SMEP =
| CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |<br>
&gt;&gt; <br>
&gt; <br>
&gt; This needs to be done only for newer machine type (or is it CPU model<=
br>
&gt; versions now? need Eduardo to respond).<br>
&gt; <br>
&gt; Paolo<br>
<br>
</blockquote></div></div></div>

--000000000000b50b9b059a468239--


