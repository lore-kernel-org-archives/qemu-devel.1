Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8087FC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A889205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtRFZ7Jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A889205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jECx4-00044I-Gu
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jECvx-00034s-F0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jECvw-0003Q7-4k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:11:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jECvv-0003LE-VB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584454263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7irHrlsmj7YMvbsYW9FQVp4bPOWizWsJiOdTw0+S3mA=;
 b=WtRFZ7JrNamX+jKlyM0h5IPy46GkTn43iJ9K9o8NaDftlVy+1tv/T0/Zp7e6bGdqEYVnXl
 yGkuZpkbwyL7fvaihrRCX22ZonXnMfr3iruCyT6lUxE66rXpa2PWMfFFhg7l6VYV7oJ4bt
 OZtaLbvsgmywAkyfScwAkazRWcLCzB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-qBdaowvjOWS29Hx2yQrHtg-1; Tue, 17 Mar 2020 10:10:59 -0400
X-MC-Unique: qBdaowvjOWS29Hx2yQrHtg-1
Received: by mail-wr1-f71.google.com with SMTP id f13so4533470wro.23
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7irHrlsmj7YMvbsYW9FQVp4bPOWizWsJiOdTw0+S3mA=;
 b=FHnYMlsQgozGpmmscZosC5qKX6Kxtds+JtmgfqLpvj17cRhDEi4IH17BFC8s2hBMHk
 JBMEBc801QSB6X/dzpFSHOobQVNgCbEjbm53ggrvb0XSphJ/6jsJNj49nlLUOevMjSav
 jXJR7Ys1XCtVy8juNPyoAx/5MsxD78ibNmr9JCGn2WM9M6SarWve0zq6v58VH+WEwRoz
 4gPns6uJpG3F+TXj/mYVRb1pDrPPApdhMHQx7aAkpJg4xb4mQ/0zlsaqcclpg1C1f9Xm
 SmlG4lrOYJTLtwP0P6qm+z5+yYNDu904mRJYiaLnCw61PcDT7RKGBfvh/Xxdv8qhx1cK
 +WnQ==
X-Gm-Message-State: ANhLgQ05x57jwrcDTj5M7P/CAgU8VYV9Lz9pnnlK3SAi6hkb3UdZ2zY+
 buCbeum1C5/aS9/ENNQ4bzXMQ7Y9nPmcOps1qrb7rc3JV7Y4iybNkoFLmPnDz9238HGsPBTM6f/
 XXXepQg9hJ9ke7ND9belIvXszICvsWaQ=
X-Received: by 2002:a5d:4486:: with SMTP id j6mr5977042wrq.427.1584454258420; 
 Tue, 17 Mar 2020 07:10:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv87ekUlh6YhCa2qab4kOPsQGBpVptx3gOnzEKhxx7YqfAeBkxehLTdL2VEPtp3nUqNyOQQkmvJtPyiKtcF4qA=
X-Received: by 2002:a5d:4486:: with SMTP id j6mr5977013wrq.427.1584454258193; 
 Tue, 17 Mar 2020 07:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584437957.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584437958.git.balaton@eik.bme.hu>
 <c43e2f9b-3002-32f0-08fa-7164a98f3b9f@redhat.com>
 <f70ea487-c8e8-d76d-fbe5-9213284a8574@redhat.com>
 <2038186d-3f18-d430-2305-5697097397e9@redhat.com>
 <549ffd77-a020-51c8-96e7-c4afc28ff633@redhat.com>
 <alpine.BSF.2.22.395.2003171505380.40468@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003171505380.40468@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 17 Mar 2020 15:10:47 +0100
Message-ID: <CAP+75-Xu34jQ+WB+CHMm6udk5vhVVDi1e3YnB82KSpj72ztW6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] hw/ide: Get rid of piix4_init function
To: BALATON Zoltan <balaton@eik.bme.hu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 3:07 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Tue, 17 Mar 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 3/17/20 2:50 PM, John Snow wrote:
> >> On 3/17/20 6:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> On 3/17/20 11:41 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>> On 3/17/20 10:39 AM, BALATON Zoltan wrote:
> >>>>> This removes pci_piix4_ide_init() function similar to clean up done=
 to
> >>>>> other ide devices.
> >>>>>
> >>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >>>>
> >>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>>
> >>> Please disregard this tag (I withdraw it), I mis-read the pci variabl=
e
> >>> was not assigned.
> >>>
> >>
> >> Is there an issue you've noticed, or you are just no longer certain
> >> enough to give an RB?
> >
> > I asked Zoltan there why he was reassigning 'pci' and he replied here:
> > https://www.mail-archive.com/qemu-block@nongnu.org/msg63324.html
> >
> > I don't know enough the PCI API (and don't have time this week to dig i=
nto
> > it) to check how pci->devfn is used (is it populated by a pci_create()
> > call?).
> >
> >    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
> >                                          true, TYPE_PIIX4_PCI_DEVICE);
> >    ...
> > +   pci =3D pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
> >    ...
> >    pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
> >
> > What annoys me is here -------^^^^^^ I don't know if reassigning the pc=
i
> > variable can have an impact, so as I am not confident I prefer to withd=
raw my
> > review tag.
>
> OK, I did not know that's what you were asking about and did not notice
> this could be a problem. To avoid any doubt I'll send a new version to
> avoid this shortly.

Sorry I was a bit rushed for soft-freeze, I should have spent more
time in my comment then, this would have saved everybody a bit of
email traffic.
I'll try to remember next time.

Thanks for sending an updated version.

> Regards,
> BALATON Zoltan


