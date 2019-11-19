Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87739C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D2D208CC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcFSGEle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D2D208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0qE-0006sW-Qk
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iX0oO-0005iJ-1O
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iX0oM-0007Xd-DA
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:32:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56795
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iX0oM-0007Ww-39
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574159561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3TUCNexgMfU/nLexGTBepoGvxwI+HbwU/fb1WjFGQUM=;
 b=TcFSGEleymwvhlaW+MxNDm8S0ix/qpiKHotPibKz+Kefu7qeW3+Sa07OpA4TA+GRZK4k8/
 m+en1arBiKg2/vH5WUa1vq7XQW15vHGgr/taHDT7lFOwILbj7hVpqg2f5iHPDwia/y/Kxx
 l4+cs21+dAldX2HZv5mYY68GFEHcEIA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-ZrctAoYvM1qI1O7H4KAtRw-1; Tue, 19 Nov 2019 05:32:40 -0500
Received: by mail-ot1-f70.google.com with SMTP id h15so11755286otr.11
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 02:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3TUCNexgMfU/nLexGTBepoGvxwI+HbwU/fb1WjFGQUM=;
 b=RRhbFmHMCLa+7dq7Gn5A1UHRYKQMBogUrZ7XwwP4nAvUiApTjVaM2uQ/VkC7pvR/S3
 G7jMBc4abnaRIr2TW4p3mOf8CaMkt0LmFZwTKHY9D3tVbH5ZFwyhiQrmXDtzTOAzoNrD
 ZxjHz9XOcVAJFgU8tGV7Wo2xH9PEsQxwGjyL0Htl+klxyyPjvhSIYh8TOO5eskCSgBaX
 w+Ln2J/2Y6X5WRD96+Ynr/ZvKy9K53RZYCynw7+nM6ub1hPL4D4kPteVh1pGAtL3ZOuG
 bujqsv+7EugBiw/8ASgtUc3lb6A3KT6cje6pcnDWCcUrAs4tYNH+ht7nn57j7EevIHuX
 A7WA==
X-Gm-Message-State: APjAAAWFEG4lVfhwmLKocgDP087Tb5NCSFw4OpZBMMt0X2uSEf43zzf6
 u1YVy82IQo92XWIERpANeUGgPLSsM6rFi8i40d+70ursb/WGUBawvv8Io7gEfMqtEPKhBqzXIx6
 9WKG9okCqfeMTdMFMb9AdSQwCuiG2U2M=
X-Received: by 2002:aca:62c6:: with SMTP id w189mr3532395oib.33.1574159559432; 
 Tue, 19 Nov 2019 02:32:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqyO80LdcPPYlOHRIiQrFrVWzKDf7gtRJ1CGykOdl7ILK0LcZNEJbJRgFyhSW+dyR4aKpnbBFLMKDc9drFinOqQ=
X-Received: by 2002:aca:62c6:: with SMTP id w189mr3532349oib.33.1574159559117; 
 Tue, 19 Nov 2019 02:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-11-marcandre.lureau@redhat.com>
 <CAFEAcA-vhJZSKH8hDsBYVi9WKMNOFL19Q+XrwRvp94uXMbyNbA@mail.gmail.com>
In-Reply-To: <CAFEAcA-vhJZSKH8hDsBYVi9WKMNOFL19Q+XrwRvp94uXMbyNbA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Nov 2019 14:32:27 +0400
Message-ID: <CAMxuvaxkHpowe8ZLBiNpnN5QXOGU711FsR3iwWFYGAEL2WVZOQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/33] serial: add "instance-id" property
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: ZrctAoYvM1qI1O7H4KAtRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 18, 2019 at 6:30 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 23 Oct 2019 at 18:33, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > This property will be used to move common vmstate registration to
> > device realize in following patch.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/char/serial.c         | 3 +++
> >  include/hw/char/serial.h | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index 069d8715d0..0b61a71e4e 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -990,6 +990,7 @@ SerialState *serial_init(int base, qemu_irq irq, in=
t baudbase,
> >      s->irq =3D irq;
> >      qdev_prop_set_uint32(dev, "baudbase", baudbase);
> >      qdev_prop_set_chr(dev, "chardev", chr);
> > +    qdev_prop_set_int32(dev, "instance-id", base);
> >      serial_realize_core(s, &error_fatal);
> >      qdev_set_legacy_instance_id(dev, base, 2);
> >      qdev_init_nofail(dev);
> > @@ -1003,6 +1004,7 @@ SerialState *serial_init(int base, qemu_irq irq, =
int baudbase,
> >  static Property serial_properties[] =3D {
> >      DEFINE_PROP_CHR("chardev", SerialState, chr),
> >      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> > +    DEFINE_PROP_INT32("instance-id", SerialState, instance_id, 0),
>
> This could use an explanatory comment, because I have no
> idea what it does or when a user of the device would want
> or need to set it... (I am guessing that part of the answer
> may be "needed only by legacy users of this device that don't
> want to break migration compatibility" ?)

That's right, I'll add that comment.

>
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
>
> thanks
> -- PMM
>


