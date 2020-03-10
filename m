Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F9AC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCA1215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS7/isVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCA1215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmIZ-0001y8-LO
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBmHV-0001IU-7w
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBmHU-0006HF-1o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:19:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBmHT-0006Gx-UH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583875155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MKC6jVWUxe/QwWodzIkuCkmtNCaPrLO0RqudcraN84=;
 b=VS7/isVxkGs73oI6sqxwkbREORiJ0w0r7yZ5ZzveRA8oujSTHiLdsCbjohptOyt+0ytdA/
 28IOx9vl1MA8NLgg4ZeDRrtUXyLZt6EDm2fV4YrWl7WyqW24k1x4PRTmkbnRVwqgQyFErv
 RokRAfJtXv62NPcYTtqjGQ128Y7GG3Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-UJcJ_QMCOoqqdUVA0ap-PA-1; Tue, 10 Mar 2020 17:19:03 -0400
X-MC-Unique: UJcJ_QMCOoqqdUVA0ap-PA-1
Received: by mail-qt1-f199.google.com with SMTP id y3so10042604qti.15
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 14:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=suItr7S7WPbL+Ysn4X6bwAS881kQtFsMmGrp5QsvBZ8=;
 b=EqM/DcYuS8R+Rnzx96NyhcCI8Bex5EyfqUg4RFPQipj2w+hpOHJ6D1WbfMjXVI3AmO
 EXKu79FskUgjCV17P972qK0WW9pMqCGaG88NJGaFeVE5g07DdeAP7hYwfRUb72QrR1d+
 SyojXQg0u4ILjqyxraxPjqGZY++kbnD/jp2WHna1sAsCUI+ArLyiE/3ZBeNpIKiewOzj
 a5OeT3KHx/vipu0A9FzUaeCnW88iSZ2m7XSLWvs8XdDuPgfD/SM+Zf6ribCjHdX8wypQ
 H91Y61K+LtQWEZjP4mEDR04rnb4jIavgFLsK2IJrsHCdI7i+d1BHeC1NZZDeKC69etF6
 8D+Q==
X-Gm-Message-State: ANhLgQ2+RwSEt0Dp4ErZ/hSRHLQqMu9l3aO3KJxAntxBzbJClAfWW5FF
 yZ2SVQvkINignKssLQ2CBeQaZNbFkpGA2lTaV4GSzL1vvaofsK4e0ri11bymnposP33A9Rpc/v/
 CrRclHuD3um7Lufo=
X-Received: by 2002:a05:620a:22e3:: with SMTP id
 p3mr17436870qki.23.1583875141437; 
 Tue, 10 Mar 2020 14:19:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvJyCPB0jEDeeNSGRZpDJzTh14bqsiTiAQqf20xb49dNojsWtI6Uzs/lwjYdAAUVRK08oQTwg==
X-Received: by 2002:a05:620a:22e3:: with SMTP id
 p3mr17436851qki.23.1583875141178; 
 Tue, 10 Mar 2020 14:19:01 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id n190sm2750515qkb.93.2020.03.10.14.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 14:19:00 -0700 (PDT)
Date: Tue, 10 Mar 2020 17:18:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v4 3/4] pci: Honour wmask when resetting PCI_INTERRUPT_LINE
Message-ID: <20200310171802-mutt-send-email-mst@kernel.org>
References: <cover.1583867210.git.balaton@eik.bme.hu>
 <5e372f6a73d4f45c0c18a264e986c29fc075f2d4.1583867210.git.balaton@eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <5e372f6a73d4f45c0c18a264e986c29fc075f2d4.1583867210.git.balaton@eik.bme.hu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 08:06:50PM +0100, BALATON Zoltan wrote:
> The pci_do_device_reset() function (called from pci_device_reset)
> clears the PCI_INTERRUPT_LINE config reg of devices on the bus but did
> this without taking wmask into account. We'll have a device model now
> that needs to set a constant value for this reg and this patch allows
> to do that without additional workaround in device emulation to
> reverse the effect of this PCI bus reset function.
>=20
> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Looks ok to me

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge with the rest of the series.


> ---
>  hw/pci/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e1ed6677e1..b5bc842fac 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -302,8 +302,11 @@ static void pci_do_device_reset(PCIDevice *dev)
>      pci_word_test_and_clear_mask(dev->config + PCI_STATUS,
>                                   pci_get_word(dev->wmask + PCI_STATUS) |
>                                   pci_get_word(dev->w1cmask + PCI_STATUS)=
);
> +    /* Some devices make bits of PCI_INTERRUPT_LINE read only */
> +    pci_byte_test_and_clear_mask(dev->config + PCI_INTERRUPT_LINE,
> +                              pci_get_word(dev->wmask + PCI_INTERRUPT_LI=
NE) |
> +                              pci_get_word(dev->w1cmask + PCI_INTERRUPT_=
LINE));
>      dev->config[PCI_CACHE_LINE_SIZE] =3D 0x0;
> -    dev->config[PCI_INTERRUPT_LINE] =3D 0x0;
>      for (r =3D 0; r < PCI_NUM_REGIONS; ++r) {
>          PCIIORegion *region =3D &dev->io_regions[r];
>          if (!region->size) {
> --=20
> 2.21.1


