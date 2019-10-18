Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF75DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9701521D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkvaaZd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9701521D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUhr-0005Kv-3r
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLUf4-0003Ri-GJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLUf3-0002fp-9i
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:59:30 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLUf3-0002fC-3b
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:59:29 -0400
Received: by mail-oi1-x244.google.com with SMTP id o205so5597110oib.12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rI19fQfi1soXk94bvmbxspVOx+LD4mjimJcvoV3KteI=;
 b=nkvaaZd0EvQYu/0NgQzGjB5RrGnooI+jyLuOt7nDTYRNFWoSguLexjlwisYd4BapON
 NDUSue6A3fdJiaHJBnB+trGvaYZEFRzgGqEnN9/qdGZjebnyPnwebYbBwg3gyBdBJCKE
 AkXApj5SrF5qDw3qyEJBUg1YJJIPhHkfPJs8+Gg956dovEtehmujkIkteRCPDq6yOgi7
 eVY/sjBeDAiTKZhhRVoGgL0r//AJjercLyIHNUd8jkdZNmPUJPKTLI3DtpiZHEUiyzoK
 Sd8Kc7qHjSdqW8lgillUgc06NImzdM1f3mbPa/vQLu/pnxrs1pwfMZJlggktl8jB4ouB
 8/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rI19fQfi1soXk94bvmbxspVOx+LD4mjimJcvoV3KteI=;
 b=gJpOoX/uJ9KxMpmI5bo8Gx9xk6B+gogY//ssierKu93sXUdYqBl/xIBsfPdfSUy2a4
 gXJeFEiksm0TXlBbAx5YA2tjnHE2O0lZHn9xjC7zkRekJMYe6Z9ZEN4H4/YcB8Z74jfx
 cDCfKfZdY2GRKMwumfbb0mWnYVPWfL+suNOY0TMLAz/mVm5C363+9Xq0hy9LJ60YcJAe
 OUUqzQMbUfgZLNu9vxiAmXfb2Y14sYqBplkNW/beoM6gno9Nr7h9KZplI6baQGhBTdru
 dCyfXx0k7QV8XUJyDOaM8M4K/B3KG2KFxoMhSWHG6cZBEGsXCWgZBtWFThFimYvrlc+X
 IZvg==
X-Gm-Message-State: APjAAAXzzKm6TUpQjfs7w3Fjd1eOCBjaKGGGpLWFSoFsaeOQnLm3GJv8
 BAizNCyRxsxGWKtqHHy4r2KNaraKfLy2IRFT/mKYBA==
X-Google-Smtp-Source: APXvYqz7lYNiF5Z1+BLE5ifZujMcnlC275r3asx/YuR8ZBN3JZ2c03oYDz+0uyUPu7/Q/+e6OJapvUI+Uv26ucQpMcg=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr8278208oia.48.1571414368065; 
 Fri, 18 Oct 2019 08:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-5-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-5-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 16:59:16 +0100
Message-ID: <CAFEAcA-Qaq0W-4kpRGSQTxzH1LZ3znoxZo6Fnd4NmnnE4O_G9w@mail.gmail.com>
Subject: Re: [PATCH 04/14] etraxfs: remove PROP_PTR usage
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
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

On Fri, 18 Oct 2019 at 16:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> etraxfs_dma_client are not Object, so can't be exposed to user with
> QOM path. Let's remove property usage and move the constructor to the
> .c unit, simplifying some code on the way.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> +
> +/* Instantiate an ETRAXFS Ethernet MAC.  */
> +DeviceState *
> +etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
> +                 struct etraxfs_dma_client *dma_out,
> +                 struct etraxfs_dma_client *dma_in)
> +{
> +    DeviceState *dev;
> +    qemu_check_nic_model(nd, "fseth");
> +
> +    dev =3D qdev_create(NULL, "etraxfs-eth");
> +    qdev_set_nic_properties(dev, nd);
> +    qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
> +    ETRAX_FS_ETH(dev)->dma_out =3D dma_out;
> +    ETRAX_FS_ETH(dev)->dma_in =3D dma_in;
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +
> +    return dev;
> +}
> +
>  static const TypeInfo etraxfs_eth_info =3D {
>      .name          =3D TYPE_ETRAX_FS_ETH,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
> diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
> index aa146a2cd8..403e7f95e6 100644
> --- a/include/hw/cris/etraxfs.h
> +++ b/include/hw/cris/etraxfs.h
> @@ -30,23 +30,9 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/sysbus.h"
>
> -/* Instantiate an ETRAXFS Ethernet MAC.  */
> -static inline DeviceState *
> -etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
> -                 void *dma_out, void *dma_in)
> -{
> -    DeviceState *dev;
> -    qemu_check_nic_model(nd, "fseth");
> -
> -    dev =3D qdev_create(NULL, "etraxfs-eth");
> -    qdev_set_nic_properties(dev, nd);
> -    qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
> -    qdev_prop_set_ptr(dev, "dma_out", dma_out);
> -    qdev_prop_set_ptr(dev, "dma_in", dma_in);
> -    qdev_init_nofail(dev);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> -    return dev;
> -}
> +DeviceState *etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
> +                              struct etraxfs_dma_client *dma_out,
> +                              struct etraxfs_dma_client *dma_in);


I don't think this is an improvement -- it's taking a step
back in the direction of "you need to call a funny _init
function to initialize a device". You should be able to
create devices using generic qdev functions.

What we're actually connecting here is 'etraxfs_dma_client'
struct pointers between the devices like this ethernet
device and the DMA controller. The connection is currently
done via a pointer property because we don't have a more
QOM-like way to do it, but if we want to get rid of the
pointer property we need to actually implement the more
QOM-like mechanism, not go backwards from having devices
connected via properties.

(Similar comments apply for the omap clock connections.
In that case the answer might be Damien's clock framework
API, eventually.)

thanks
-- PMM

