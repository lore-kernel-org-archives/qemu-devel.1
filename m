Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB69AC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8630621852
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmjjEJwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8630621852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKxU-0004Cq-Dk
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iXKuR-0001Zo-N6
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iXKuQ-0002WF-6J
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:00:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40214
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iXKuQ-0002V4-25
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574236817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F746zgA8JqqgChdMAqH+9H0HjT1putHM3OkKEsKa34s=;
 b=XmjjEJwkd7/SH+WtoHuuNZtPMOEVvu+/RY3RsyYwGGaYBd0jaiOyYhI9n21QUx4GUs86CF
 GANp49/Zy/zqDk5obThQ8uKFS172qdZtKqLNiLlBQaTfJ04SkrcwYSA04BtiJzBCtyYju7
 OPRNoPga1YBtt62YEwD56hmKYoxr65M=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-RqQHWIqWNtq0gPIT9LD3MQ-1; Wed, 20 Nov 2019 03:00:09 -0500
Received: by mail-oi1-f200.google.com with SMTP id l67so12093630oih.4
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 00:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F746zgA8JqqgChdMAqH+9H0HjT1putHM3OkKEsKa34s=;
 b=nxIMUXjeychUbI8w1bqQb9a04+wcwREB87zu5IDPWs9vrtmN4Yo8OLWVpwXcYwkerG
 jUL6fBsVrYpPZD3mHXb26kcIG20g+pC0vJklOVOEUpArzD69eEavXKn/OCaXK3YH+4YX
 jC5Ic78yc2zCAbZn6I22gV2t7iLSxfhN2NT5LiAAGHcIXRpomK1yevSBdM5GDB7CN3NQ
 dtVUzNhB7AoN8iKzGFNtmzy/WSk8BAMmYgPiOU5DkmyDCo2Goo5WMOPalkuq4KpY8Ier
 LbCzvc0uJ1hb3SBGFmaWAjYJX2wc8xrGcrcjAF0FO1juh7Ac2nmmv3SBgqavIp1SCdmA
 rFQw==
X-Gm-Message-State: APjAAAU4DIeVdmZ7TTnreggDc8IBjox3ihRJI3d61XAJ4yxGovjv6wZf
 rWTzFxcCQqHZ65U78e6J36tr+rFevKw3WyVzZ2QqAuoQ9NaNPzXtVssMVEqPQGCApg3Tbeaqg5e
 J4uG3nn+O8QHaw9jOGXDFaeZWLUBjkaw=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr915226otg.368.1574236808548;
 Wed, 20 Nov 2019 00:00:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPb/YPu9V/GriCaTq7cu1mivN3SHd21f9JZORN/G7MbuYS8E2JZPqsSXhC4wk1WwieOS3g13SdAf/xZfly8nw=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr915206otg.368.1574236808364;
 Wed, 20 Nov 2019 00:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-16-marcandre.lureau@redhat.com>
 <CAFEAcA_e4byjW-zPWPWdwZX0qFwUesKo+FTFK6Y9_tMTejSsBQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_e4byjW-zPWPWdwZX0qFwUesKo+FTFK6Y9_tMTejSsBQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Nov 2019 11:59:56 +0400
Message-ID: <CAMxuvazCLfcWsWadPE0LP15Ej6k873FSD_rWJDRkeTf4xfzy6Q@mail.gmail.com>
Subject: Re: [PATCH v3 15/33] serial-mm: add endianness property
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: RqQHWIqWNtq0gPIT9LD3MQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 18, 2019 at 7:07 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Add a qdev property for endianness, so memory region setup can be done
> > in realize.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/char/serial.c         | 2 ++
> >  include/hw/char/serial.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index c28cfc94fd..2f7667c30c 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -1081,6 +1081,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_sp=
ace,
> >      qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
> >      qdev_prop_set_chr(DEVICE(s), "chardev", chr);
> >      qdev_prop_set_int32(DEVICE(s), "instance-id", base);
> > +    qdev_prop_set_uint8(DEVICE(s), "endianness", end);
> >
> >      qdev_init_nofail(DEVICE(s));
> >      qdev_init_nofail(DEVICE(self));
> > @@ -1102,6 +1103,7 @@ static void serial_mm_instance_init(Object *o)
> >
> >  static Property serial_mm_properties[] =3D {
> >      DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
> > +    DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIV=
E_ENDIAN),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
>
> ...on reading patch 16, I just noticed that here in patch 15
> you define the 'endianness' property on the SerialMM object, but
> you're trying to set it on the SerialState object. This bug then
> gets fixed in passing in patch 16, but we should just be
> setting it on the right object to start with.

Correct! fixed.

thanks


