Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5263C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FBD20719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCJH995e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FBD20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaLg-0005hc-Ne
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaKV-0004Bj-5v
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaKU-0002YS-0L
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:46:23 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaKT-0002XE-RA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:46:21 -0400
Received: by mail-ot1-x342.google.com with SMTP id j16so7663441otl.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rVZuRcHd0GmuI3bIUNO+YkcCkes9OHEppSpMgTRHnBY=;
 b=sCJH995egRSBc3CgCREQwxEeTRMJ3e0A7kMk1Ocjtro1myFTiqLRSIiV0VDBIVW0Cf
 rqr3luwSCcaabVUJp0Nd2VnAwmm3Bo+3y26s6RETM4BtB9k5IUsh4RhiBmROmrvQGbTk
 KWpx3H8wjxJ/fnrr4wDZ1tBd0h6SdUlQSSnnw77dQaAgVFf/ygJhyxOWaKGxpX0Tgg0j
 oSnhbwZDnyOw7WYP2AxsfGam11rH2TX6hQFhEKz13XBSF0v643xn/IHMFhnHefeKyO65
 ahS4tGg0XGLVKU6J9TTAfrIFIKjC7vy5N+EhvCVwJPbA4bMoOumpfdWlpR4j0owfnhX3
 z2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rVZuRcHd0GmuI3bIUNO+YkcCkes9OHEppSpMgTRHnBY=;
 b=Ej+igiOMBzIRk8bBrAXPAh5/03g9tvO+dw5fdeiFqhjKRGofyXlYeLMNzKfilRQvi8
 m87Ozsjoh0sNrrQycte+D7VLPSncEQnPNkYL2++eE/I0SaYjH7pKj4Sx9v8vk3kx71jg
 9XkT9okD6VQkFpMCoaSHDg4e+4mKjfBxiyqxrP8Pbn7mw909KQIrRLEWlDZfp0U7E8F6
 d8tj9rHxOE5vdb5+rgCtGybJo6CdPyfM5E37DzXjKsKb0GmZEFXFwPAAFpN02g5SyOkc
 NZVlgl4ocFIiu3x7yj7+O7fkNr+03pPhxtSSBT6SBDnywAW3/Hc3U8shLz9A1mUxMYgc
 3s3Q==
X-Gm-Message-State: ANhLgQ1TPXzVHbZdkE3hkjmCEPJEFuFrIxsGAQI2hLiuYhCcdPJlKnxB
 +Xjz409TcSi2vOLL3POzjYQXu9UdPzPUe8FSXo95+sDKmXs=
X-Google-Smtp-Source: ADFU+vtsnowzu7TJWuapTCqru0b80QfmWi1zJfj2KLVnmfyKS1vjNS4GUYBAgZtd2s0VDThZWfTEJXgVR5zjiSSwEUY=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr8142040oth.135.1585259180913; 
 Thu, 26 Mar 2020 14:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-7-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-7-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:46:09 +0000
Message-ID: <CAFEAcA8Bb8r-vSWmh97tjnydG9CHS-Kh4qCnU1rAGYF689BEYQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 06/12] hw/dma/xilinx_axidma: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 19:18, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_link() hw//dma/xilinx_axidma.c:542:4]]
>
> Add the missing error_propagate() after manual review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/dma/xilinx_axidma.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 018f36991b..6e3406321c 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -521,39 +521,42 @@ static const MemoryRegionOps axidma_ops =3D {
>  static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>  {
>      XilinxAXIDMA *s =3D XILINX_AXI_DMA(dev);
>      XilinxAXIDMAStreamSlave *ds =3D XILINX_AXI_DMA_DATA_STREAM(&s->rx_da=
ta_dev);
>      XilinxAXIDMAStreamSlave *cs =3D XILINX_AXI_DMA_CONTROL_STREAM(
>                                                              &s->rx_contr=
ol_dev);
>      Error *local_err =3D NULL;
>
>      object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
>                               (Object **)&ds->dma,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG,
>                               &local_err);

Isn't there also a check on local_err missing here ?

>      object_property_add_link(OBJECT(cs), "dma", TYPE_XILINX_AXI_DMA,
>                               (Object **)&cs->dma,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG,
>                               &local_err);
>      if (local_err) {
>          goto xilinx_axidma_realize_fail;
>      }
>      object_property_set_link(OBJECT(ds), OBJECT(s), "dma", &local_err);
> +    if (local_err) {
> +        goto xilinx_axidma_realize_fail;
> +    }
>      object_property_set_link(OBJECT(cs), OBJECT(s), "dma", &local_err);
>      if (local_err) {
>          goto xilinx_axidma_realize_fail;
>      }

thanks
-- PMM

