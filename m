Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E59EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 01:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E835207C3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 01:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="0NkInpLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E835207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQLBH-0007H0-6p
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 21:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kQLAQ-0006ps-5B
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 21:56:26 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kQLAI-0000Hk-FI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 21:56:23 -0400
Received: by mail-oi1-x243.google.com with SMTP id x62so4662468oix.11
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 18:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oa3gvBDsnQPUaYpvQt0315bU6kg939CNxvlhWTQHlo0=;
 b=0NkInpLgFi8oFI7kG+2Pl7A1HBZeUfu5h/vcH7aOm8Eyf7o6crQtiXm/W7HpYS5CWx
 vnFykvTz7EKVnmFx9Inuwh/UtWW9dqP6qCz3H0+YbZs25tlfwvRAVc+pOBnZVtxpq94E
 Kd42/fR5v30/EOJktQ0z3GXZlhjIA/y7Zy7zrXrFNizAbiXGS2lKskCBxUVClewy0Jrj
 FFSeT+fhxRTTpGkdyF9bRKyA33/xY0+GQSIhbrkbfL6EaqgAOreccuXe/ZIAqAkkmvqI
 1JjubqsqLIDGdwZmgYq3IWHgCQ3MNFp5zKrRzFZMGwUPlihwqgnvbjNo5pjIFAwPGRJq
 h2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oa3gvBDsnQPUaYpvQt0315bU6kg939CNxvlhWTQHlo0=;
 b=REINxl7ajAqxfsrwSbkCO7jNyo2VyVYPdUX8V8rH7lydQqSi5/SBEABAul74xV1VI3
 i41+htS1DbLhYsrsKNUmXuEwH1FY+hZNbfixxVboUdyzdltcZiZMLAEVzOqXAitGG6eo
 ihQLGpCJe/RlgfK25ZO711PDJaXqaFnTmzA7GuBHh8XhSTKaWUAz5EATPVakXU0sdPg6
 2QMSawgVwhlUegYk7I0QxmOpTV0alZV3XgmwHqo8GfkzaLI1HyCOodfeB3Uol5VSYpE2
 1Y3t7rhOItsuRVevKCljJPq6UGOn76rQsFuqLBsf4QZrdB9g0a6WwoBL8+i8xNc54Kvf
 xrFQ==
X-Gm-Message-State: AOAM5323oujdAa3c2sghiDPk6YY9TbtsssS1p05qcxwqvdrowyhtVI40
 NB4a5nKtlc+xmYU80s+KKxPCp3q9K6z1ghkQ5j61Ow==
X-Google-Smtp-Source: ABdhPJxNh6xB5z4iHFBpiva9M2k+bVCRolwPkbqBBo88DUSW1u1TJ9/8PIYPu2lcM2S3JN6/z1R8N+4r7e9XJhpB3QI=
X-Received: by 2002:aca:4911:: with SMTP id w17mr3552836oia.80.1602122175706; 
 Wed, 07 Oct 2020 18:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200929055309.509-1-wangzhiqiang.bj@bytedance.com>
 <20200929055309.509-2-wangzhiqiang.bj@bytedance.com>
 <a4ff4f18-34fa-d3bd-9a63-dfbc8fb41f84@kaod.org>
In-Reply-To: <a4ff4f18-34fa-d3bd-9a63-dfbc8fb41f84@kaod.org>
From: John Wang <wangzhiqiang.bj@bytedance.com>
Date: Thu, 8 Oct 2020 09:56:13 +0800
Message-ID: <CAH0XSJu6+byt-CMCKP_-pJCXHj-bb27_BqC_nvnFJTox96wjJw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/2] aspeed: Add support for the g220a-bmc
 board
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Lotus Xu <xuxiaohan@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 1, 2020 at 10:56 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 9/29/20 7:53 AM, John Wang wrote:
> > G220A is a 2 socket x86 motherboard supported by OpenBMC.
> > Strapping configuration was obtained from hardware.
> >
> > Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
>
> One quick question below.
>
> > ---
> >  hw/arm/aspeed.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index bdb981d2f8..04c8ad2bcd 100644
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
> > @@ -559,6 +573,30 @@ static void witherspoon_bmc_i2c_init(AspeedMachine=
State *bmc)
> >      /* Bus 11: TODO ucd90160@64 */
> >  }
> >
> > +static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
> > +{
> > +    AspeedSoCState *soc =3D &bmc->soc;
> > +    DeviceState *dev;
> > +
> > +    dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2=
c, 3),
> > +                                         "emc1413", 0x4c));
> > +    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error=
_abort);
> > +    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error=
_abort);
> > +    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error=
_abort);
> > +
> > +    dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2=
c, 12),
> > +                                         "emc1413", 0x4c));
> > +    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error=
_abort);
> > +    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error=
_abort);
> > +    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error=
_abort);
> > +
> > +    dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2=
c, 13),
> > +                                         "emc1413", 0x4c));
> > +    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error=
_abort);
> > +    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error=
_abort);
> > +    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error=
_abort);
> > +}
> > +
> >  static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
> >  {
> >      return ASPEED_MACHINE(obj)->mmio_exec;
> > @@ -798,6 +836,24 @@ static void aspeed_machine_tacoma_class_init(Objec=
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
>
> On real HW, is it a mx25l25635e or a mx25l25635f ?

I'm not sure, maybe mx25l25635f , at the lab, we have multiple models
of flash chips. :)

>
> Thanks
>
> C.
>
> > +    amc->num_cs    =3D 2;
> > +    amc->macs_mask  =3D ASPEED_MAC1_ON | ASPEED_MAC2_ON;
> > +    amc->i2c_init  =3D g220a_bmc_i2c_init;
> > +    mc->default_ram_size =3D 1024 * MiB;
> > +    mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D
> > +        aspeed_soc_num_cpus(amc->soc_name);
> > +};
> > +
> >  static const TypeInfo aspeed_machine_types[] =3D {
> >      {
> >          .name          =3D MACHINE_TYPE_NAME("palmetto-bmc"),
> > @@ -835,6 +891,10 @@ static const TypeInfo aspeed_machine_types[] =3D {
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

