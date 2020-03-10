Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5BDC10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D41208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDYnMjvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D41208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBVdk-0006gz-1x
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 23:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBVcy-0006CG-HS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBVcv-0000j3-TA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:32:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57087
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBVcv-0000hO-Mz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583811136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nSMI/u+0nLeIXdqQwaXuDyuJ0bYfzQOXPfv121EwdNI=;
 b=GDYnMjvbpL8loCUhTlu0pLxw5w80OBhOCflqpdt4OQRUKg/xmZUhuzGfVr5fPT5IhZ4xH/
 qJDRG7ZS+W1tn5ggy88r23+oeIe2RHE78ItaeUCOMvkM/Nme52Sbj3p1wTF1Re4a3cx65w
 DuuUN0fYPixCY3Zgwia5/x++5FJ+GFQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-pMqU7PG5NwqpYyVjchMnbQ-1; Mon, 09 Mar 2020 23:32:12 -0400
X-MC-Unique: pMqU7PG5NwqpYyVjchMnbQ-1
Received: by mail-qv1-f71.google.com with SMTP id l16so8248954qvo.15
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 20:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m96l8NCDy5RLLu1Vh2O0iwkIdX4C6GaDcZXH5XMBKQE=;
 b=XhFFPJ549KV/AjC9zFHe4O1aI0FHCLOtIHgkqhspYTeodGyVMJOimeM2O1QKI0tZMU
 uPzpdFWgDEdjF3ldDH2I+8LgKzqQV1Ka7wAX2IEQDWvC2bDiyn+nailL+gCXdyfpRSO4
 Itbx4dsfci21PgOUQSEvkMRatufkjSwHPsUbgU13QPg4CUhq6RXRFxUtP1SiM129j0pw
 t+KRXtnEdMEu+5rqWsUO56TymV2cV41Q8YuOe22G+wnFtDV1d3Xj9fqf3Dyc3cx+YW5s
 UU8jIHcdjD/UAQBZpbm0hP+fM0tllqDGSvFktuCrEyTPIoywGty9LQlPa7oXVi7gg3nK
 6iKQ==
X-Gm-Message-State: ANhLgQ2gi9j108qhOiJoBS3la70eyKPD8o5VB+0qsRgfcbIseTd9+S8l
 RjYJMg8kHvv/mlfbz7YAi45WCut96kKoLe/SOsmfT6t6HQjUTENJGNVvT8aDHQjpY19pk5ciDSf
 3h/vwPszMty5cpXA=
X-Received: by 2002:ac8:6055:: with SMTP id k21mr17402709qtm.242.1583811132018; 
 Mon, 09 Mar 2020 20:32:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuzaHWoKItSJenqIHP8LAwg/X0cRrsRh0q17W0SMfgCXYj6pN2kC2l7avPg5jhL2MoexXUL1A==
X-Received: by 2002:ac8:6055:: with SMTP id k21mr17402688qtm.242.1583811131721; 
 Mon, 09 Mar 2020 20:32:11 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id g4sm1533981qki.8.2020.03.09.20.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 20:32:10 -0700 (PDT)
Date: Mon, 9 Mar 2020 23:32:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 3/3] via-ide: Also emulate non 100% native mode
Message-ID: <20200309232733-mutt-send-email-mst@kernel.org>
References: <cover.1583781493.git.balaton@eik.bme.hu>
 <ac37e5f5b86a3b2680c01d7b0d027dafd27a3ac7.1583781494.git.balaton@eik.bme.hu>
 <20200309163537-mutt-send-email-mst@kernel.org>
 <alpine.BSF.2.22.395.2003092148350.94024@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003092148350.94024@zero.eik.bme.hu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-block@nongnu.org, philmd@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 09:50:57PM +0100, BALATON Zoltan wrote:
> On Mon, 9 Mar 2020, Michael S. Tsirkin wrote:
> > On Mon, Mar 09, 2020 at 08:18:13PM +0100, BALATON Zoltan wrote:
> > > Some machines operate in "non 100% native mode" where interrupts are
> > > fixed at legacy IDE interrupts and some guests expect this behaviour
> > > without checking based on knowledge about hardware. Even Linux has
> > > arch specific workarounds for this that are activated on such boards
> > > so this needs to be emulated as well.
> > >=20
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > > v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()
> > > v3: Patch pci.c instead of local workaround for PCI reset clearing
> > >     PCI_INTERRUPT_PIN config reg
> > >=20
> > >  hw/ide/via.c            | 37 +++++++++++++++++++++++++++++--------
> > >  hw/mips/mips_fulong2e.c |  2 +-
> > >  include/hw/ide.h        |  3 ++-
> > >  3 files changed, 32 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/hw/ide/via.c b/hw/ide/via.c
> > > index 096de8dba0..02d29809f2 100644
> > > --- a/hw/ide/via.c
> > > +++ b/hw/ide/via.c
> > > @@ -1,9 +1,10 @@
> > >  /*
> > > - * QEMU IDE Emulation: PCI VIA82C686B support.
> > > + * QEMU VIA southbridge IDE emulation (VT82C686B, VT8231)
> > >   *
> > >   * Copyright (c) 2003 Fabrice Bellard
> > >   * Copyright (c) 2006 Openedhand Ltd.
> > >   * Copyright (c) 2010 Huacai Chen <zltjiangshi@gmail.com>
> > > + * Copyright (c) 2019-2020 BALATON Zoltan
> > >   *
> > >   * Permission is hereby granted, free of charge, to any person obtai=
ning a copy
> > >   * of this software and associated documentation files (the "Softwar=
e"), to deal
> > > @@ -25,6 +26,8 @@
> > >   */
> > >=20
> > >  #include "qemu/osdep.h"
> > > +#include "qemu/range.h"
> > > +#include "hw/qdev-properties.h"
> > >  #include "hw/pci/pci.h"
> > >  #include "migration/vmstate.h"
> > >  #include "qemu/module.h"
> > > @@ -111,11 +114,18 @@ static void via_ide_set_irq(void *opaque, int n=
, int level)
> > >      } else {
> > >          d->config[0x70 + n * 8] &=3D ~0x80;
> > >      }
> > > -
> > >      level =3D (d->config[0x70] & 0x80) || (d->config[0x78] & 0x80);
> > > -    n =3D pci_get_byte(d->config + PCI_INTERRUPT_LINE);
> > > -    if (n) {
> > > -        qemu_set_irq(isa_get_irq(NULL, n), level);
> > > +
> > > +    /*
> > > +     * Some machines operate in "non 100% native mode" where PCI_INT=
ERRUPT_LINE
> > > +     * is not used but IDE always uses ISA IRQ 14 and 15 even in nat=
ive mode.
> > > +     * Some guest drivers expect this, often without checking.
> > > +     */
> > > +    if (!(pci_get_byte(d->config + PCI_CLASS_PROG) & (n ? 4 : 1)) ||
> > > +        PCI_IDE(d)->flags & BIT(PCI_IDE_LEGACY_IRQ)) {
> > > +        qemu_set_irq(isa_get_irq(NULL, (n ? 15 : 14)), level);
> > > +    } else {
> > > +        qemu_set_irq(isa_get_irq(NULL, 14), level);
> > >      }
> > >  }
> > >=20
> > > @@ -169,7 +179,8 @@ static void via_ide_realize(PCIDevice *dev, Error=
 **errp)
> > >=20
> > >      pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA=
 mode */
> > >      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
> > > -    dev->wmask[PCI_INTERRUPT_LINE] =3D 0xf;
> > > +    dev->wmask[PCI_CLASS_PROG] =3D 5;
> >=20
> > What's the story here? Why is class suddenly writeable?
>=20
> The via-ide (function 1 of some VIA southbridge chips) use bits in this r=
eg
> to set legacy compatibility mode as described in VT82C686B and VT8231
> datasheets and Linux writes this on pegasos2 board I'm emulating. See lon=
ger
> description in this message:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg00019.html
>=20
> Regards,
> BALATON Zoltan


Pls add a code comment so people don't have to dig through mailing list
archives.

--=20
MST


