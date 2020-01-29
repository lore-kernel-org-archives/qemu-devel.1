Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6023D20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHDLzwgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6023D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwnbm-0007ei-L4
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 08:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iwnb5-0007CY-5T
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iwnb3-0002FR-0U
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:41:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iwnb2-0002Db-M1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580305291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZfppl0gkuKnt1Z6Iuz2ldlJbuCAcAxAwNpBrp4oGRk=;
 b=KHDLzwgYkkJKKt//6VJS+1m+/ujGla2tshMzjpz18b9fSUcTaVsxFMc2qSHgtD55EF8X/e
 b7ANBe4ToK7YbLNvi9cYSz8hYFvvAhywpsk2PnMYGvELQT1rpMKicfl3hmcnF2UYcJckwk
 sXMNnDU7D/cN5zmEXbXbzDqxik1u5uQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-a--itaNdOMiamOxwYghtwg-1; Wed, 29 Jan 2020 08:41:29 -0500
Received: by mail-oi1-f200.google.com with SMTP id k3so4918218oig.17
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 05:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lZfppl0gkuKnt1Z6Iuz2ldlJbuCAcAxAwNpBrp4oGRk=;
 b=cmuR8UwmZM4dk9LJNZ/CkUbikggb3kLpbki0p1Q4WXV4qSjOoFEg2P2XOe6HtM1FX9
 WFdtYgIXxv4rNVEKF41X96aETq4Hqq4oTVkOD7f9kIEQ/HG6JJDWFdfSTIzRe89SF7k1
 RI3b0i4XYvtUnKbIhgeztL+GLOx9j0iTeTp48p2eTMLR7j5vpfyeGNWaGW17FAuCpyhf
 UiTxJkZyy6n2l5KP4C0Wrkcr55jlozFS0tN9aCZ1Tka7uySOarW0DyGDRGbOKCsLSGLO
 QxZJtS8kQ+a0kw4rmP1ikmgl3nco1pcHM3CfgH2agPMTKgbMERaXEqM3tjEgDRZKcXwr
 q8/g==
X-Gm-Message-State: APjAAAUBk5RmDCEbSTt26H6OqQWsMBYXy7jXyrvf21z4N9sx48lwwmtz
 RalOYcEoMrfpzsd45nY26LvGLeeLFeUXnDErPcWNGm9ywuliE5ljJ7VzAI5VsFUByJMKvUm0cfH
 1srWBAjIedAEm/oZMt9B/nIp7kAKMjoM=
X-Received: by 2002:aca:fd4c:: with SMTP id b73mr3978882oii.33.1580305288469; 
 Wed, 29 Jan 2020 05:41:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3Va64gwNK+NiQhUHzy4YtjoZfG9Oymtt9Nax5EgH2+NbZA1K6g7Ea+jgd64fxxQYKnlMRy6vRVonG52D5/YM=
X-Received: by 2002:aca:fd4c:: with SMTP id b73mr3978869oii.33.1580305288229; 
 Wed, 29 Jan 2020 05:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20200128175342.9066-1-pbonzini@redhat.com>
 <20200128175342.9066-2-pbonzini@redhat.com>
 <81393799-e936-d5dc-1681-4317bfae510e@redhat.com>
In-Reply-To: <81393799-e936-d5dc-1681-4317bfae510e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Jan 2020 14:41:16 +0100
Message-ID: <CAMxuvayx55=JaVCgtZew70jeoRSzpzuLDSe2sth91yiLb_kAXA@mail.gmail.com>
Subject: Re: [PATCH 001/142] minikconf: accept alnum identifiers
To: Thomas Huth <thuth@redhat.com>
X-MC-Unique: a--itaNdOMiamOxwYghtwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 29, 2020 at 1:09 PM Thomas Huth <thuth@redhat.com> wrote:
>
>
> -EMISSINGPATCHDESCRIPTION
>
> Why is this required? Bug fix? New feature? ... please add some words her=
e.

This is required for later patch "meson: convert hw/9pfs", which adds
config 9PFS.

You are right, several patches could use some comments. It's still
PoC. Otoh, a lot of them are quite mechanical or just what they are in
meson, there isn't much to say about it. We'll have to improve this
somehow.

>  Thomas
>
>
> On 28/01/2020 18.51, Paolo Bonzini wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  scripts/minikconf.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/minikconf.py b/scripts/minikconf.py
> > index 40ae1989e1..febd9a479f 100644
> > --- a/scripts/minikconf.py
> > +++ b/scripts/minikconf.py
> > @@ -645,7 +645,7 @@ class KconfigParser:
> >              self.cursor =3D self.src.find('\n', self.cursor)
> >              self.val =3D self.src[start:self.cursor]
> >              return TOK_SOURCE
> > -        elif self.tok.isalpha():
> > +        elif self.tok.isalnum():
> >              # identifier
> >              while self.src[self.cursor].isalnum() or self.src[self.cur=
sor] =3D=3D '_':
> >                  self.cursor +=3D 1
> >
>


