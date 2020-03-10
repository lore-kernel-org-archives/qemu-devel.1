Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2196C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA45E24649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ln6uRYpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA45E24649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBVhm-0007sa-Tk
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 23:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBVgz-0007Lb-Cp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBVgy-0000B1-AI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:36:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBVgy-0000A3-5o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583811387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6x2AuqbTM0HH+hLi+ppOnJLMlYcOL3w+Y8s2qhhclg=;
 b=Ln6uRYpic5QlwUwr+QbA0VddOBxwNaEGtIZUUFMQy4FuxVsXavSQ1wK/13hZt0xpHo3R2n
 Wft9Nej6QZuBIfOv8rjMLnzxpf3kveeZECp2/mmWqxqYYmLXUX44/JXhcYf36zbAWDswQQ
 j45c9uaDto0AZTuYVnVrVccUvK1yHT0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-T2lDAP93Mw-lcXdv2WrY8w-1; Mon, 09 Mar 2020 23:36:25 -0400
X-MC-Unique: T2lDAP93Mw-lcXdv2WrY8w-1
Received: by mail-qv1-f71.google.com with SMTP id e16so1459222qvr.16
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 20:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UXcbb1r1XzulIJ/mrArJi/fGGnmqd4jlzpBt71ttkoU=;
 b=blhexan4Ui9TCy9lFuh2oq3FRI/qUcg/IGSpVmO/GyoDXTNZPZx7rymAuEb5WgX/T5
 s2FB1SNoEeTe0uKqDO22bd+hVGYLnpwt5Kl3TfkESUV+h9zhLItaywE6yOUzqZnpHpaM
 E40JlxQV5VS2tKJrvaspgaf2ldzUYOVjKl77uF6fHUwH+3+QJ6+1J2+fOnB7LcJUxp7t
 jMsK1Pkmt6v0aQryfFQqBlJ1/fkEJoSP09hFdlqEJ6+5+nMWYQxBL0X2WLllo8VL+VEe
 cvuIRlQSyh8EG/RSUm6PEVB1+EWMZmRQIo9nX0t11VBRazpbIxTsUTgijON1kMwLDp0F
 7vdg==
X-Gm-Message-State: ANhLgQ3KTWveFAUbyKkC/kh7nj/+tEdYUCiECLAHXsfs5UkfFAlXhMuW
 JV4Ar5vA04py+T+x+ekz9TZqMOml5zK72SDpIO46zeEmXZ0lfkXuIEts28VvcDMs9nft619k74E
 XCZA0HaRRk/Sl5iA=
X-Received: by 2002:a05:620a:a94:: with SMTP id
 v20mr17491463qkg.153.1583811385420; 
 Mon, 09 Mar 2020 20:36:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvIa6xkBbOHrqttJ6V9rn7CqGoFxgbuN/lXEQyqzl1h7jAyIGWdIi5vuj/W61AYTgt+y/xT/Q==
X-Received: by 2002:a05:620a:a94:: with SMTP id
 v20mr17491447qkg.153.1583811385168; 
 Mon, 09 Mar 2020 20:36:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id x19sm23048539qtm.47.2020.03.09.20.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 20:36:24 -0700 (PDT)
Date: Mon, 9 Mar 2020 23:36:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 2/3] pci: Honour wmask when resetting PCI_INTERRUPT_LINE
Message-ID: <20200309233242-mutt-send-email-mst@kernel.org>
References: <cover.1583781493.git.balaton@eik.bme.hu>
 <857e327a240f2175fe5105f0ebdfe1357fef32c7.1583781494.git.balaton@eik.bme.hu>
 <20200309163632-mutt-send-email-mst@kernel.org>
 <alpine.BSF.2.22.395.2003092151340.94024@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003092151340.94024@zero.eik.bme.hu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-block@nongnu.org, philmd@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 09:54:27PM +0100, BALATON Zoltan wrote:
> On Mon, 9 Mar 2020, Michael S. Tsirkin wrote:
> > On Mon, Mar 09, 2020 at 08:18:13PM +0100, BALATON Zoltan wrote:
> > > The pci_do_device_reset() function (called from pci_device_reset)
> > > clears the PCI_INTERRUPT_LINE config reg of devices on the bus but di=
d
> > > this without taking wmask into account. We'll have a device model now
> > > that needs to set a constant value for this reg and this patch allows
> > > to do that without additional workaround in device emulation to
> > > reverse the effect of this PCI bus reset function.
> > >=20
> > > Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > >  hw/pci/pci.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index e1ed6677e1..d07e4ed9de 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -302,8 +302,10 @@ static void pci_do_device_reset(PCIDevice *dev)
> > >      pci_word_test_and_clear_mask(dev->config + PCI_STATUS,
> > >                                   pci_get_word(dev->wmask + PCI_STATU=
S) |
> > >                                   pci_get_word(dev->w1cmask + PCI_STA=
TUS));
> > > +    pci_word_test_and_clear_mask(dev->config + PCI_INTERRUPT_LINE,
> > > +                              pci_get_word(dev->wmask + PCI_INTERRUP=
T_LINE) |
> > > +                              pci_get_word(dev->w1cmask + PCI_INTERR=
UPT_LINE));
> >=20
> > PCI spec says:
> >=20
> > Interrupt Line
> > The Interrupt Line register is an eight-bit register used to communicat=
e interrupt line routing
> > information.
> >=20
> > I don't see how it makes sense to access it as a word.
>=20
> Patch actually comes from Mark, I don't know. Should we change it to
> pci_byte_test_and_clear_mask or what's the appropriate way here?

Superficially that makes sense. I don't know if that does what
you want to do.


> >=20
> > >      dev->config[PCI_CACHE_LINE_SIZE] =3D 0x0;
> > > -    dev->config[PCI_INTERRUPT_LINE] =3D 0x0;
> > >      for (r =3D 0; r < PCI_NUM_REGIONS; ++r) {
> > >          PCIIORegion *region =3D &dev->io_regions[r];
> > >          if (!region->size) {
> >=20
> > Please add comments here explaining that some devices
> > make PCI_INTERRUPT_LINE read-only.
>=20
> Something like the commit message would be appropriate?

Code comments are more appropriate when we want to describe why code is
the way it is. commit message is there to describe the change, answering
questions like: why we aren't happy with the old code? why is the new
code is better? etc ...

> Regards,
> BALATON Zoltan


