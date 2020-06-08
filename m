Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A8BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485D320760
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOhhi4O2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485D320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiNVS-0002Yb-I3
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 15:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jiNU0-000270-Bq
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:30:56 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:35781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jiNTz-00020e-HY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:30:56 -0400
Received: by mail-io1-xd44.google.com with SMTP id s18so20106000ioe.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9PoKUaOH7RtpGUdbKrnaj7grruo5W3hOkAboAai4o6o=;
 b=dOhhi4O2FAyNe+Ql1ZG6uEAsHS8JcUpL4V+0pkUVsUVS3Rf4ZccCpnr7y3DWOl1bT1
 KVyP6c/IkOEARE1gUQ9IEH8wDb7jnl9uQCMD5WYqq2MSjR993UeYLtohyd0Z+lLGHzZc
 keU0rXSMRd+21gWz3U5nyW3s5DwDny/OAshwIho3/uJDJqkVbkwoqIW0WC7PtxT8U4d0
 Gc0uTl0b0u8XLgjnRjQWJkkHXh/hEGRTljMOgJGc3gPg/1hnfyhivvElr+X3gBmrj1tE
 vyP/k4VzVU3C07oyGaDpl94IjuMoExAQ5ZtrML8eT149e7evd5uqAP4u3RG/tAubQ6HM
 YcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9PoKUaOH7RtpGUdbKrnaj7grruo5W3hOkAboAai4o6o=;
 b=VoMUHWLUto/248UoJ3U+eeHLGoTqo+wje1fBdNpA9G3Fk7Y0vyOiummFnRiA0EGG+j
 cXIRoqW/yoWR44Qa2hlx4UgCJbSvyWLcdkbGC82cW72bJhUOmELYi6IewjiNivtA33sX
 MFeZ1HY03BqWma2J3wt8OI+vSFFTZ/LEf0UtOIrNQ+S4ih5o3R/NRMCaGyxQuCx9Lxoq
 OyGGb6xP8T2tRkmbe6J+rqr8bFTJIGJptJ+y7QOOVRg4dZNqcB6H7VKP1FutQYxKtz2+
 IHmnNN7fjSjAzjVjczAHjwEmi1guItln4i1mSMfBJJdJgVhfZA2r0P/D7KpIyB0mN2Md
 4mFg==
X-Gm-Message-State: AOAM531GbZITbT76mLNRRCcOcTPyQgvGhG4EABaacZZ4ChuF4samHdhf
 Sx62ryy4bPa3yHiRkEzsxEo2BgA0Okgf6YJAmOs=
X-Google-Smtp-Source: ABdhPJzsa10YkpsNDj9O5qZgN1OYw2zsR446+A4JiJ4cdDdphOlXf7VFc2Ecz5qZ0yoWlwXZeONP5hBmqGvevcywvBI=
X-Received: by 2002:a6b:740b:: with SMTP id s11mr21065327iog.10.1591644654442; 
 Mon, 08 Jun 2020 12:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200608172144.20461-1-f4bug@amsat.org>
 <20200608172144.20461-2-f4bug@amsat.org>
 <696e124e-c709-7f7c-fdd0-d3d42db0ebb6@adacore.com>
In-Reply-To: <696e124e-c709-7f7c-fdd0-d3d42db0ebb6@adacore.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 8 Jun 2020 21:30:43 +0200
Message-ID: <CACXAS8DNHw7K=qwpeqO2US1gPrE6_hFEwPw9=kBxLExBEObsFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/sparc/leon3: Map the UART device unconditionally
To: Fred Konrad <konrad@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=atar4qemu@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 7:28 PM Fred Konrad <konrad@adacore.com> wrote:
>
>
>
> Le 6/8/20 =C3=A0 7:21 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
> > The UART is present on the chipset regardless there is a
> > character device connected to it. Map it unconditionally.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >   hw/sparc/leon3.c | 18 ++++++++----------
> >   1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> > index 8f024dab7b..cc55117dec 100644
> > --- a/hw/sparc/leon3.c
> > +++ b/hw/sparc/leon3.c
> > @@ -339,16 +339,14 @@ static void leon3_generic_hw_init(MachineState *m=
achine)
> >                               0, LEON3_TIMER_IRQ, GRLIB_APBIO_AREA);
> >
> >       /* Allocate uart */
> > -    if (serial_hd(0)) {
> > -        dev =3D qdev_create(NULL, TYPE_GRLIB_APB_UART);
> > -        qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
> > -        qdev_init_nofail(dev);
> > -        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
> > -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART=
_IRQ]);
> > -        grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
> > -                                GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DE=
V, 1,
> > -                                LEON3_UART_IRQ, GRLIB_APBIO_AREA);
> > -    }
> > +    dev =3D qdev_create(NULL, TYPE_GRLIB_APB_UART);
> > +    qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
> > +    qdev_init_nofail(dev);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART_IRQ=
]);
> > +    grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
> > +                            GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1=
,
> > +                            LEON3_UART_IRQ, GRLIB_APBIO_AREA);
> >   }
> >
> >   static void leon3_generic_machine_init(MachineClass *mc)
> >
>
> Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>




--
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

