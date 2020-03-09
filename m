Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EA3C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32F220409
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsKUSHhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32F220409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBPC2-0001pc-Ts
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBPBP-0001MG-HL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBPBO-0007NW-Gh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:39:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBPBO-0007NH-By
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583786366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJjiwgW2O+3FTgKDKqEeQchdhtqdaj3fqcvL381Rqew=;
 b=GsKUSHhXckJTt7dlZ/mde/jT1l5Mx4v65xj127E6ee42eEgskhXkPVc6J5wNEZ5s8l91LT
 pRC8vR1+w1olVnRC9BqYpTT25aKczC1JKg57rpQSTrgtuYNvXXtePTJPBdulFnb3PQz15V
 DTItLEY1WPtUziy+/poq5eLyeiwHwQc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-rzec28QMPTmB6PzkyP65pg-1; Mon, 09 Mar 2020 16:39:24 -0400
X-MC-Unique: rzec28QMPTmB6PzkyP65pg-1
Received: by mail-wm1-f72.google.com with SMTP id a23so52005wmm.8
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FXFmu5l3T51UteK+EzPwT+ODBdWw/jTrhNXqiMIyEI0=;
 b=UrrhvpOhQv1TStUJE5fSMdxeh0JJZDMcGLR0vZgafa3h6z16ho5ORBDDIiOmrfq6Zw
 szAysQxb5FI/LfVZlPnL6aNUBGFeLUYNK/tt6r+HOrFcTvUPZTINrDgvB4aeZx5N5tx1
 9Si8jixZJms2QjcSHCu0ZlhI3xFDg49LQfzpJDtpLmCPXqlbcjwl7CzfU1KKjmfGBhLj
 II8dS66VDNn67DGuIpHB2Mm54QrrXbS3IvsvATtMByaKzFRCU2aXDj8Tu3qcc/Ln9hND
 Ayn/yyZb/YeSj2O7EiROo+sdgVpJV2CKlOvHjT1mWmc16ngVeBcIJYhTqOo0/xD69kJ/
 56FA==
X-Gm-Message-State: ANhLgQ1IUt1NeknoCBpC25zadgkFujCSp/GWJZkkRIm8b4qNYujKaYJq
 WK9YtfgpDpri8ENRyPbYGIGGN6NZXQlERKOGAy348v2DrZoG1VgUa/oofMry101IuhVfapWkECA
 WQy1jevHexawaYdk=
X-Received: by 2002:a05:6000:370:: with SMTP id
 f16mr16547914wrf.9.1583786362982; 
 Mon, 09 Mar 2020 13:39:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuwm4lksdkm7rrDkwbJjce1buidWtEEsVeSEpG3bZSgp81QzHiCZG1uDk42JRwM5Eqbi3Gtpw==
X-Received: by 2002:a05:6000:370:: with SMTP id
 f16mr16547900wrf.9.1583786362800; 
 Mon, 09 Mar 2020 13:39:22 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id y69sm919939wmd.46.2020.03.09.13.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 13:39:22 -0700 (PDT)
Date: Mon, 9 Mar 2020 16:39:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 2/3] pci: Honour wmask when resetting PCI_INTERRUPT_LINE
Message-ID: <20200309163632-mutt-send-email-mst@kernel.org>
References: <cover.1583781493.git.balaton@eik.bme.hu>
 <857e327a240f2175fe5105f0ebdfe1357fef32c7.1583781494.git.balaton@eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <857e327a240f2175fe5105f0ebdfe1357fef32c7.1583781494.git.balaton@eik.bme.hu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Mon, Mar 09, 2020 at 08:18:13PM +0100, BALATON Zoltan wrote:
> The pci_do_device_reset() function (called from pci_device_reset)
> clears the PCI_INTERRUPT_LINE config reg of devices on the bus but did
> this without taking wmask into account. We'll have a device model now
> that needs to set a constant value for this reg and this patch allows
> to do that without additional workaround in device emulation to
> reverse the effect of this PCI bus reset function.
>=20
> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e1ed6677e1..d07e4ed9de 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -302,8 +302,10 @@ static void pci_do_device_reset(PCIDevice *dev)
>      pci_word_test_and_clear_mask(dev->config + PCI_STATUS,
>                                   pci_get_word(dev->wmask + PCI_STATUS) |
>                                   pci_get_word(dev->w1cmask + PCI_STATUS)=
);
> +    pci_word_test_and_clear_mask(dev->config + PCI_INTERRUPT_LINE,
> +                              pci_get_word(dev->wmask + PCI_INTERRUPT_LI=
NE) |
> +                              pci_get_word(dev->w1cmask + PCI_INTERRUPT_=
LINE));

PCI spec says:

Interrupt Line
The Interrupt Line register is an eight-bit register used to communicate in=
terrupt line routing
information.

I don't see how it makes sense to access it as a word.


>      dev->config[PCI_CACHE_LINE_SIZE] =3D 0x0;
> -    dev->config[PCI_INTERRUPT_LINE] =3D 0x0;
>      for (r =3D 0; r < PCI_NUM_REGIONS; ++r) {
>          PCIIORegion *region =3D &dev->io_regions[r];
>          if (!region->size) {

Please add comments here explaining that some devices
make PCI_INTERRUPT_LINE read-only.


> --=20
> 2.21.1
>=20
>=20


