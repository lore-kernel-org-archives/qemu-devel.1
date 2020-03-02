Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66122C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED212166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQqXr+pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED212166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jBB-0004Yb-B1
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jAE-0003av-Fi
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jAD-0005lO-CQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:23:10 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8jAD-0005lG-7V
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:23:09 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so9885175oif.10
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Axy/r17mlcKBB2b5GnWrMnEY/Pjs/UUWkrC5McDPdg=;
 b=XQqXr+pj+ebDznUxaHFEl6QMw9MFOy0HJELLEWE25FDoACcZqWwQXS2LQadk7WTIHJ
 d4GzYP4scZHRQaSG1PD5k8Ql2jOOggfGgbiJ7+VK/PwoD+cFH2XkRfBIGaArnJDr77s1
 wC2XPWYvfeQrPOAnQdhNgAErUH25pmw3N7Tdaw5jA4BjuLnk71mio7QApqhOGRAWG3t1
 gt3xOkLp+0rlKqYtcsZXzfsUza81YDPLfbMyljIFMQzGvcxRj3hR33mrOmpb3+/nU/EB
 ZDj+H8plyCu9UGJY/3BpfDep9bHKyhf9AWK0mD8JhmUQB1MDvfJZcCbBHiGLk/svc/lv
 Syxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Axy/r17mlcKBB2b5GnWrMnEY/Pjs/UUWkrC5McDPdg=;
 b=kkwNQC8eO458o4RIxgkg2t0S38WrVZf9/vQ2g5qlNc/Op2W3G4Ta3V/xTtrS2Yh4D6
 wbpC+diMtcf7tT/QTzwkk5hv65aTGL9JoODHwLDiAug1zdr6GJnQjQuPkqUa1DOr741M
 slc/bEaUsq378Di3qsRw8/rj6NHRPpktYAmuVdVTJPqL+qNrU8ICQgCRbRYpEA5LiNH5
 cdxtMjWpgHTTY3Z/RlB0Fi2fStRvYXF+/WXWQKGYXhC0GDjWZdhGqopR+Or+PZh47UUM
 fcVko7OLOb1GIGSbWjT9ErTg0GZzcCURn/oUc6dV+Rd5KoUPyOO+CiNrTj7473eJkWY4
 SeqA==
X-Gm-Message-State: APjAAAWqdMVyY0pPecsrvWjv7imBQ087rNvvd9K+59vXeK4KxTrCOJkk
 gQKjL2Ycp/mRvfNj2jCVeOWaA3EBHDQpApBUFniD/Q==
X-Google-Smtp-Source: APXvYqyERdr0SV0t08xMqYp5TRPBfustTGDyeEqofmSMprUZ15e0Go2yXa91UgoyWTj6UG/PvQrLdERjNgdG9t9sSJQ=
X-Received: by 2002:aca:b2c5:: with SMTP id
 b188mr11333058oif.163.1583148187792; 
 Mon, 02 Mar 2020 03:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20200227154424.6849-1-edgar.iglesias@gmail.com>
 <20200227154424.6849-2-edgar.iglesias@gmail.com>
In-Reply-To: <20200227154424.6849-2-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 11:22:56 +0000
Message-ID: <CAFEAcA9ap6MLmQvdD82HaioDeQj3vxtsyLaTN-OGEu0BDygBCg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] hw/arm: versal: Add support for the LPD ADMAs
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: figlesia@xilinx.com, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 03:17, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add support for the Versal LPD ADMAs.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/arm/xlnx-versal.c         | 24 ++++++++++++++++++++++++
>  include/hw/arm/xlnx-versal.h |  6 ++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 1cf3daaf4f..f9beba07ed 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -193,6 +193,29 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
>      }
>  }
>
> +static void versal_create_admas(Versal *s, qemu_irq *pic)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
> +        char *name = g_strdup_printf("adma%d", i);
> +        DeviceState *dev;
> +        MemoryRegion *mr;
> +
> +        dev = qdev_create(NULL, "xlnx.zdma");
> +        s->lpd.iou.adma[i] = SYS_BUS_DEVICE(dev);
> +        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
> +        qdev_init_nofail(dev);
> +
> +        mr = sysbus_mmio_get_region(s->lpd.iou.adma[i], 0);
> +        memory_region_add_subregion(&s->mr_ps,
> +                                    MM_ADMA_CH0 + i * MM_ADMA_CH0_SIZE, mr);
> +
> +        sysbus_connect_irq(s->lpd.iou.adma[i], 0, pic[VERSAL_ADMA_IRQ_0 + i]);
> +        g_free(name);
> +    }
> +}

It would be more in the modern style to write it with the child device
struct embedded in the parent struct, object_initialize_child() in the
parent init, and object_property_set_bool(..., true, "realized", ...)
in the parent realized, but I guess this fits with the way the
rest of the existing device is written.

Series applied to target-arm.next, thanks.

thanks
-- PMM

