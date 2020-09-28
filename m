Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A071BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A1520774
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="DQEOWlxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A1520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt6f-0003Rr-7z
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kMpJ7-0006L3-I1
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:18:54 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kMpJ3-0002lC-Bn
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:18:52 -0400
Received: by mail-oi1-x243.google.com with SMTP id u126so553299oif.13
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3qLrdCzFYgtP9BgQ7Rm5nWG5qkmajwgHh/VsOeGeiWE=;
 b=DQEOWlxK0yXLynLjaBRoOQkecEd+1secO6ximlmfXSPYd4HuR7Wkgj01H8WbXDbr00
 Fs1c5E12SPAVWmIENksQGcB3RZjXcX76YslO8/MlSpr+VjdP8rtQ7ifTWh9ybeCNDO3W
 wBJR7rOXr4xOyMq9aTIeFAsDN62V+EVxd+shklXA0gSMZU3/MEKbrAYZC2TlqzeNLEPn
 3rAoa4KRrkGiNRIK44hoX4o7wz0HiLp6c9kSv+oj2GfX0zQ17QLE8QE032r239ZPbZKT
 qYw6zRr+itI26svsKt9fLHL/Zfsclk9dFZP2oAhMGm7i58hTQ2RaHdvdmycp92xbn1Pq
 PmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3qLrdCzFYgtP9BgQ7Rm5nWG5qkmajwgHh/VsOeGeiWE=;
 b=g308XNhLi7xxa7YMjmaqtaN0YNnDOcpqKINuHxmsbJXrF8/XTZmhOz3XBUYwcJpCDl
 Q57QXNYJ/euCfh92S+lbkZOR50xJ0NkvHZkFsfFMit5NMzd1I/Zm8IcG6045b4hdv7HP
 LHqDkotRnODzdkrLTBra3vB/HbE/11dRotP25MMmNxLrdSnkYiWALw63bF5A3JpGenGu
 EDIPd3+2V65yZZPl6478EKG3Hm4vgZvFT1xba8ZJonN9tzSc4YKpJPisE/1YSr1vQXEf
 9llHVRw+kBy+67A8MZWRgjskcqCBB8oOFcKfu9+BsLch+1J0otxW20UBsZoCX3qEBPO6
 ZoPg==
X-Gm-Message-State: AOAM531PI02+VheLZvERbceOfsR6nORPIgKV4FZ6k9EchWSo4Sz4EOq2
 aZyq+HYmsx1tnYdmVTDEAve6RgoU/wNPRduIkwbpRA==
X-Google-Smtp-Source: ABdhPJzEnkmCSBWYMfUgiB4419mKwon6DfWD0GEJXfsBw8noWi15CO2aW/FywZy1aGRCeEQTh+XqaDvTLvzT4/j7gY0=
X-Received: by 2002:aca:bd8a:: with SMTP id n132mr323861oif.100.1601284727634; 
 Mon, 28 Sep 2020 02:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200928061201.1601-1-wangzhiqiang.bj@bytedance.com>
 <d6cf7464-a0bf-2748-7e4c-732208881711@kaod.org>
In-Reply-To: <d6cf7464-a0bf-2748-7e4c-732208881711@kaod.org>
From: =?UTF-8?B?546L5b+X5by6?= <wangzhiqiang.bj@bytedance.com>
Date: Mon, 28 Sep 2020 17:18:37 +0800
Message-ID: <CAH0XSJtDEPnf8qLNuT_Ev3TkGQw_68cZ5KGgY_aLBThMQwU9sQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] aspeed: Add support for the g220a-bmc board
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=wangzhiqiang.bj@bytedance.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Sep 2020 09:12:19 -0400
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 yulei.sh@bytedance.com,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 xuxiaohan@bytedance.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater,

Sorry, I did not reply to all, this email is the same as the previous one.


On Mon, Sep 28, 2020 at 3:55 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 9/28/20 8:12 AM, John Wang wrote:
> > G220A is a 2 socket x86 motherboard supported by OpenBMC.
> > Strapping configuration was obtained from hardware.
> >
> > Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>> ---
> >  hw/arm/aspeed.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index bdb981d2f8..1de61f7d4f 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -120,6 +120,20 @@ struct AspeedMachineState {
> >          SCU_AST2500_HW_STRAP_ACPI_ENABLE |                            =
  \
> >          SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
> >
> > +#define G220A_BMC_HW_STRAP1 (                                      \
> > +        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                   =
  \
> > +        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                      =
  \
> > +        SCU_AST2500_HW_STRAP_UART_DEBUG |                             =
  \
> > +        SCU_AST2500_HW_STRAP_RESERVED28 |                             =
  \
> > +        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                            =
  \
> > +        SCU_HW_STRAP_2ND_BOOT_WDT |                                   =
  \
> > +        SCU_HW_STRAP_VGA_CLASS_CODE |                                 =
  \
> > +        SCU_HW_STRAP_LPC_RESET_PIN |                                  =
  \
> > +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |              =
  \
> > +        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |   =
  \
> > +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_64M_DRAM) |                     =
  \
> > +        SCU_AST2500_HW_STRAP_RESERVED1)
> > +
> >  /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition)=
 */
> >  #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
> >
> > @@ -798,6 +812,23 @@ static void aspeed_machine_tacoma_class_init(Objec=
tClass *oc, void *data)
> >          aspeed_soc_num_cpus(amc->soc_name);
> >  };
> >
> > +static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *dat=
a)
> > +{
> > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > +    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
> > +
> > +    mc->desc       =3D "Bytedance G220A BMC (ARM1176)";
> > +    amc->soc_name  =3D "ast2500-a1";
> > +    amc->hw_strap1 =3D G220A_BMC_HW_STRAP1;
> > +    amc->fmc_model =3D "n25q512a";
> > +    amc->spi_model =3D "mx25l25635e";
> > +    amc->num_cs    =3D 2;
>
> 'macs_mask' is missing. You won't get network.

Will Fix


>
> > +    amc->i2c_init  =3D NULL;
>
> Isn't it possible to add some default I2C devices ? temperature sensors ?

hmm, G220A BMC uses emc1413 as the temperature sensor. I can not find
it in qemu.
I can't find an i2c chip that qemu has and that the g220a uses. :(

>
> Thanks,
>
> C.
>
> > +    mc->default_ram_size =3D 1024 * MiB;
> > +    mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D
> > +        aspeed_soc_num_cpus(amc->soc_name);
> > +};
> > +
> >  static const TypeInfo aspeed_machine_types[] =3D {
> >      {
> >          .name          =3D MACHINE_TYPE_NAME("palmetto-bmc"),
> > @@ -835,6 +866,10 @@ static const TypeInfo aspeed_machine_types[] =3D {
> >          .name          =3D MACHINE_TYPE_NAME("tacoma-bmc"),
> >          .parent        =3D TYPE_ASPEED_MACHINE,
> >          .class_init    =3D aspeed_machine_tacoma_class_init,
> > +    }, {
> > +        .name          =3D MACHINE_TYPE_NAME("g220a-bmc"),
> > +        .parent        =3D TYPE_ASPEED_MACHINE,
> > +        .class_init    =3D aspeed_machine_g220a_class_init,
> >      }, {
> >          .name          =3D TYPE_ASPEED_MACHINE,
> >          .parent        =3D TYPE_MACHINE,
> >
>

