Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D86BC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A29A20702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDFZFgkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A29A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izN2y-0000Hd-HU
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1izN29-0007c5-63
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1izN27-0008Sx-DL
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:56:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30286
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1izN27-0008PT-9X
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580918166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghhxFzag2agPbzpFE21KqchuBLwLaBRvih4BEnUPxQI=;
 b=gDFZFgkpo0chnWlZuSQavKR7zBTUyKzlsbFIAsd5SOB1O9Wslt2XGuE83R7DYP4/Z2iIhA
 OzBodBpMS6MgJKG8ygjodeTBqSDsmeZPkh3OjC29vBlf42x1bNwSc39vw7PVn8ePQr0Qtr
 avPpPkDz8/4iUN7zMlWN+LTvyxcHB04=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-nMeDv8-bPteMlOpA4HCVaw-1; Wed, 05 Feb 2020 10:56:04 -0500
Received: by mail-lf1-f69.google.com with SMTP id y4so709511lfg.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 07:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ghhxFzag2agPbzpFE21KqchuBLwLaBRvih4BEnUPxQI=;
 b=RmwlPZqk/AyFcDerKekiuvJu/absqFVWUO9hALPaooqUosm/byhSa0/IdcEQK2fMTF
 wYopt77+bCSqgg/h3sk8+1CBgkLA9Fd18xd1/FBCVx4KjNZX872R8WrWpUE0dUbd4MpG
 MBNKpMSfKzl0CauG+xj2FatAyhI0K2MS44gavREEEtCP6zG+2fc1DXm+xLreurYr0LUT
 4xkTJGkFZrx/vvtZwhjZKqs1JhX5+U7y3s8ruZ88Jw8zdtZYHTzZFWH5FfIVQaOlHSO3
 ncUGF3mSImEAW0Cf9M0ZebC8/m451Q7Dz/SNjMp30BOOlsTlIv9U0LmTqMXiZ+8EydN3
 yJ1Q==
X-Gm-Message-State: APjAAAUfQfOAF7mbbp09c9NoAEJpAekMHKtCFMc0RZsYcJUu1f5W16Tv
 kVmS/mvSZ3us5D1gJPiS9HoD6Rc20Bo/nPFNdDbqIxnIRKvvp4UlS/KCyeUNAVGmX3DlQYA2mJu
 56bRLPL0TPddmeJQihcAojA9OJKI3iIY=
X-Received: by 2002:a2e:580c:: with SMTP id m12mr20295869ljb.252.1580918162994; 
 Wed, 05 Feb 2020 07:56:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKsKGYPKzxIkj3A2/QAIaYK+ZXUTOKroShozatTjpci8RzOucxJhoKmvrHDo6yWXRw04srMap5YWqODi/6iNE=
X-Received: by 2002:a2e:580c:: with SMTP id m12mr20295838ljb.252.1580918162577; 
 Wed, 05 Feb 2020 07:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20200130213114.325157-1-stefanha@redhat.com>
 <20200130213114.325157-16-stefanha@redhat.com>
 <CAFEAcA8J-nFZFawn49uDzDtQVMYM4qhXnT7Pb41gS-n_GjofiA@mail.gmail.com>
In-Reply-To: <CAFEAcA8J-nFZFawn49uDzDtQVMYM4qhXnT7Pb41gS-n_GjofiA@mail.gmail.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 5 Feb 2020 16:55:51 +0100
Message-ID: <CAMDeoFUu5bM=mG2dTW=VxSYzZWUBgnnhG-49PfWPvTigsxGAPQ@mail.gmail.com>
Subject: Re: [PULL 15/18] qemu-img: adds option to use aio engine for
 benchmarking
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: nMeDv8-bPteMlOpA4HCVaw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 3, 2020 at 11:56 AM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Thu, 30 Jan 2020 at 21:32, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > From: Aarushi Mehta <mehta.aaru20@gmail.com>
> >
> > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-id: 20200120141858.587874-13-stefanha@redhat.com
> > Message-Id: <20200120141858.587874-13-stefanha@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> > --- a/qemu-img-cmds.hx
> > +++ b/qemu-img-cmds.hx
> > @@ -20,9 +20,9 @@ STEXI
> >  ETEXI
> >
> >  DEF("bench", img_bench,
> > -    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_in=
terval] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buffer=
_size] [-S step_size] [-t cache] [-w] [-U] filename")
> > +    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_in=
terval] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buffer=
_size] [-S step_size] [-t cache] [-i aio] [-w] [-U] filename")
> >  STEXI
> > -@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-=
interval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pat=
tern=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t =
@var{cache}] [-w] [-U] @var{filename}
> > +@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-=
interval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pat=
tern=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t =
@var{cache}] [-i @var{aio}] [-w] [-U] @var{filename}
> >  ETEXI
>
> > diff --git a/qemu-img.texi b/qemu-img.texi
> > index b5156d6316..20136fcb94 100644
> > --- a/qemu-img.texi
> > +++ b/qemu-img.texi
> > @@ -206,7 +206,7 @@ Command description:
> >  Amends the image format specific @var{options} for the image file
> >  @var{filename}. Not all file formats support this operation.
> >
> > -@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-=
interval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pat=
tern=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t =
@var{cache}] [-w] [-U] @var{filename}
> > +@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-=
interval=3D@var{flush_interval}] [-n] [-i @var{aio}] [--no-drain] [-o @var{=
offset}] [--pattern=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{s=
tep_size}] [-t @var{cache}] [-w] [-U] @var{filename}
>
> Is there a reason why the new '-i aio' option is added to the synopsis
> line after '-t cache' in the DEF() line and the STEXI/ETEXI fragment,
> but after '-n' in the line in the qemu-img.texi file ?

No reason, just an accident.

> All the other options here are in alphabetical order, so logically
> '-i aio' should go in neither of those two places but after
> '--flush-interval'...
>
> (This change is a conflict with the in-flight qemu-img conversion
> to rST; to fix that up I'm going to just change the rST conversion
> to exactly follow the texi here; we can fix the option ordering
> as a followup patch.)


Ok. I'll send a follow-up patch.

Best regards, Julia Suvorova.


