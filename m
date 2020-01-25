Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA95C35241
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 04:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2013E2071A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 04:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbHBnJ2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2013E2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivDKA-00031R-83
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 23:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ivDJQ-0002ZS-Bk
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 23:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ivDJP-0002zY-6G
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 23:44:48 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ivDJO-0002z5-UB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 23:44:47 -0500
Received: by mail-wr1-x42d.google.com with SMTP id q10so4555063wrm.11
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 20:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TpwSMvzB0z0Vx3/fa79Ow2o7LAOW9he+aj6IS9+h3sc=;
 b=IbHBnJ2k0TK3cxddhWRrDbBNmQzaIWQptcGvWJ5fVUz5M/W2aa+OB9Xibn1c957yq5
 eF6N1hgDpedef6EBvGiX5RshJiaXk46O7YHVnxBwGqQplfT4yIX8VGUB1IBnmqrj5Dkb
 R10ZctgmuBNa2C/Gy+TmA61SqJ8TaY4qnqGN99pabVGs+GdeQScHqU9D+Km3RfYzgxKd
 Ivp78CDD9NmkLAoWPK52C+Nr3dkv5JNVYWqIfnzCgsLvJ6enPVKsQtWnEMlIXhdJ+Mxk
 bRffWCnz5dsze8RJ7/X+x4VL+K63B1Q2iQ1mRY/ZiZx0tyiJbaUBftR25wnTpxeABJCA
 NvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TpwSMvzB0z0Vx3/fa79Ow2o7LAOW9he+aj6IS9+h3sc=;
 b=rEAoKVUZcTXkfsJUCIjns8Xfzw/TyHRoA6dRCO55TZDjyuK2Hbbe3UK5iVWkZaKRW7
 X4a7CI/B0ucvGMByjZgYKIC6IlceZw7cDEKVp1zjVsQkeSZGsoksgAyWl9mE/8plJ1kZ
 zfpnDKyy1hJ3w2Ko6KNOvTsGHXBV7ZoiwIRjlivn4rrlTcHwYnPSSQxWX/b4Z762jDMU
 KVsy2Sv/z3FZIZlWAy0RVkpO1jMggNoUHPnis9eoJx6nEHmKyvqLIl5KxChfRldzFjbC
 A6ELLgkzIAlm3Pyz8ihNi32YzHBf6u+JQNLsIz9fcNoM0ozv40rAAougE8l2jNjkeCuO
 7Thw==
X-Gm-Message-State: APjAAAW602ISruiaw0HwAnfb2ING8eva7pIIO4CHZtTthO3665PUDH/3
 HPfzNlP/mTwIZEq2vfgvkTbXzVVL5AQVm8/pOPE=
X-Google-Smtp-Source: APXvYqwgJTVF2KZ2phMawDEFZqEouPS7i0YJJPOTcxZqlkYWqF4jvCxubuZn2kO4AtxlBQ1A/OMPTMJOiQvaji2z7wI=
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr7775195wrt.381.1579927484833; 
 Fri, 24 Jan 2020 20:44:44 -0800 (PST)
MIME-Version: 1.0
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <87y2tzzrwo.fsf@linaro.org> <87wo9ju19n.fsf@dusky.pond.sub.org>
 <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
 <c68f8ffd-dc8a-f282-3195-aa9e8760de7a@redhat.com>
In-Reply-To: <c68f8ffd-dc8a-f282-3195-aa9e8760de7a@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 25 Jan 2020 05:44:31 +0100
Message-ID: <CAJ+F1CKukvqb+=q922Eh1HHHFe6nOkLsnCwWamc0303F14QFqQ@mail.gmail.com>
Subject: Re: Integrating QOM into QAPI
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008123cf059cef8851"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008123cf059cef8851
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Le ven. 24 janv. 2020 =C3=A0 19:32, Paolo Bonzini <pbonzini@redhat.com> a =
=C3=A9crit :

> On 22/01/20 13:42, Marc-Andr=C3=A9 Lureau wrote:
> > From the top of my mind, this is the pain point when trying to use
> GObject:
> > - static/inlined object, not supported by GObject, unlikely to ever be
> > - few users in qemu, transition possible.
> > - 64k limit of GObject, for some reason, unlikely to change but I will
> > take a look. Some users in qemu, code adaptation possible.
> > - dynamic properties, possible in GObject with hacks, but not
> > recommended and going to be deprecated from what I remember
> > - "array" properties - would need extra layer/tweaks for compatibility
> > - link properties - would need special handling
> > - different limitations for type names and properties names
>
> The properties in general are very different between QOM and QAPI.  They
> have different limitations and features as Marc-Andr=C3=A9 mentioned, but=
 an
> especially important one is the integration with QAPI visitors.  This is
> what allows us to support -object and object-add with the same code, and
> is what separates QOM from GObject the most.
>
> Maybe it would be possible to build an adapter, but having written in
> the past code that uses GType to do marshalling and unmarshalling, I'm
> not really fond of repeating the experience...
>

I agree it is one of the things that look very different from gobject. At
the same time, I think defining conventions/types or interface to describe
hierarchy isn't so difficult, and then adapting the visitors shouldn't be
either.

I try to find a good reason qom was chosen over gobject, and I can't find
it.

>

--0000000000008123cf059cef8851
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi<br><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">Le ven. 24 janv. 2020 =C3=A0 19:32, Paolo Bonzini &l=
t;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; a =C3=
=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 22/01/20 13:42, M=
arc-Andr=C3=A9 Lureau wrote:<br>
&gt; From the top of my mind, this is the pain point when trying to use GOb=
ject:<br>
&gt; - static/inlined object, not supported by GObject, unlikely to ever be=
<br>
&gt; - few users in qemu, transition possible.<br>
&gt; - 64k limit of GObject, for some reason, unlikely to change but I will=
<br>
&gt; take a look. Some users in qemu, code adaptation possible.<br>
&gt; - dynamic properties, possible in GObject with hacks, but not<br>
&gt; recommended and going to be deprecated from what I remember<br>
&gt; - &quot;array&quot; properties - would need extra layer/tweaks for com=
patibility<br>
&gt; - link properties - would need special handling<br>
&gt; - different limitations for type names and properties names<br>
<br>
The properties in general are very different between QOM and QAPI.=C2=A0 Th=
ey<br>
have different limitations and features as Marc-Andr=C3=A9 mentioned, but a=
n<br>
especially important one is the integration with QAPI visitors.=C2=A0 This =
is<br>
what allows us to support -object and object-add with the same code, and<br=
>
is what separates QOM from GObject the most.<br>
<br>
Maybe it would be possible to build an adapter, but having written in<br>
the past code that uses GType to do marshalling and unmarshalling, I&#39;m<=
br>
not really fond of repeating the experience...<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">I agree it is one of the thin=
gs that look very different from gobject. At the same time, I think definin=
g conventions/types or interface to describe hierarchy isn&#39;t so difficu=
lt, and then adapting the visitors shouldn&#39;t be either.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I try to find a good reason qom was c=
hosen over gobject, and I can&#39;t find it.</div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div=
></div>

--0000000000008123cf059cef8851--

