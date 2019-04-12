Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DA8C10F13
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84D920674
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="OlgAJjD6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kgmlQrEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84D920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58041 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEmXo-0005YG-21
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 23:08:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmWx-00059G-17
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmWv-0002XT-5t
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:07:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrew@aj.id.au>)
	id 1hEmWp-0002TX-Cc; Thu, 11 Apr 2019 23:07:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 171C920CA5;
	Thu, 11 Apr 2019 23:06:56 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
	by compute4.internal (MEProxy); Thu, 11 Apr 2019 23:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
	mime-version:message-id:in-reply-to:references:date:from:to:cc
	:subject:content-type:content-transfer-encoding; s=fm2; bh=D5vWA
	C4v9zCuBb6yyGrl7Q5d2ugLcrnlwveDYOln9tA=; b=OlgAJjD6FfycNpGJuDffZ
	oTXayVSSXxQ5RmBwOuNe5iJuDucLEK/7wlDlUZ5t9SsrNAGuo21Wx6IEOt5ZsXKb
	JVm8ofmfZfYJVNriqYjnKjkZdwNSys4yIaBqiZoet4q26i7rcV9m0JYCYGbjTmLG
	wuPIEnB30T/U2fQ5xRumH9vKiL0MZXUYSs6Z1mQkIpCd5tSeWCb5XMLFI191OsYy
	8Dyy9/kgM9BqeddBNl+pBqnKcW9iiLL1dIqe6ytwKTwbWCx14W7He60KNGwDp88T
	3Fs4+2JpwprmbHmDgV70bqvquVIcWZuXaIftwxxrMn2wG8hJfxH5sIAAMo6oEzRD
	Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; bh=D5vWAC4v9zCuBb6yyGrl7Q5d2ugLcrnlwveDYOln9
	tA=; b=kgmlQrEzewQCZtsCh0sQ8yTQRdUZaTTrENL/bbH6FzL94mqKkqMPxPv9h
	5QYetoHbzJW+8+fLKE6IqpOKOPENV/EY4mZYH61I6b46XiQgB25FPGFDmfyvyyjD
	aOq5/HFhoP8j85XS4vPodKgCvwLd3TQpVARv2sTd5NbFSqo8tQ6ndYafrYrSNA7D
	GlJ3eC1VeSfcd8ST2z0qNUhc7Ad3jnXDik1Fa1vacXEsbvt8Ei19w/iCtxFo1P1S
	ZLIwf8m+/1emPoTp1UE/37d8JXVsyVkMIeJYqMAIZRIK5u+F9M56xVvmhkRNE6tD
	vlt/TGMB9Ji6frUr1SFas3fjF1g1Q==
X-ME-Sender: <xms:zgCwXKegWV4Z15P7Ey0R3AjVKKSIiujKkiyVbEeYEUkhE_r5p1H60Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrvddtgdeigecutefuodetggdotefrodftvf
	curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
	uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
	fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
	rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
	grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
	rhfuihiivgeptd
X-ME-Proxy: <xmx:zgCwXKqSPajpbl5MlYdBN943w_1JxBKtPelU5bL02Yl4gSAaMYs9OQ>
	<xmx:zgCwXJDiwl5PFly0wqvIMMKfRcwiDo4cI4IGk8aPi5fUu77c3znDjg>
	<xmx:zgCwXAXlAaw7nP8IQl0EQF-0L23AGD7TyCElWdgBEYtNsLGJiRyGHQ>
	<xmx:0ACwXLeAr1ccyR34fVlDdYuXApkLCq_DEhJbuJJQNKlmUO385axsdg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BC0647C132; Thu, 11 Apr 2019 23:06:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <4a619905-7486-4833-8f86-e4e42c9714f5@www.fastmail.com>
In-Reply-To: <0b244f3c-e941-cb2f-f830-1f60badb8bd1@redhat.com>
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-2-clg@kaod.org>
	<0b244f3c-e941-cb2f-f830-1f60badb8bd1@redhat.com>
Date: Thu, 11 Apr 2019 23:06:28 -0400
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	"Peter Maydell" <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.28
Subject: Re: [Qemu-devel] 
 =?utf-8?q?=5BPATCH_1/3=5D_aspeed=3A_add_a_per_SoC_m?=
 =?utf-8?q?apping_for_the_interrupt_space?=
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412030628.nmNeL0PqPVR8ndmVNUItCOtQck4wo6mJ6OXtxwGHD2M@z>



On Fri, 12 Apr 2019, at 02:13, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> On 4/11/19 6:10 PM, C=C3=A9dric Le Goater wrote:
> > This will simplify the definition of new SoCs, like the AST2600 whic=
h
> > should use a different CPU and a different IRQ number layout.
> >=20
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
> >  include/hw/arm/aspeed_soc.h |  1 +
> >  hw/arm/aspeed_soc.c         | 93 +++++++++++++++++++++++++++++++++-=
---
> >  2 files changed, 86 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc=
.h
> > index 11ec0179db50..b0d266434288 100644
> > --- a/include/hw/arm/aspeed_soc.h
> > +++ b/include/hw/arm/aspeed_soc.h
> > @@ -57,6 +57,7 @@ typedef struct AspeedSoCInfo {
> >      const char *fmc_typename;
> >      const char **spi_typename;
> >      int wdts_num;
> > +    const int *irqmap;
> >  } AspeedSoCInfo;
> > =20
> >  typedef struct AspeedSoCClass {
> > diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> > index a27233d4876b..5bbd1fb87d18 100644
> > --- a/hw/arm/aspeed_soc.c
> > +++ b/hw/arm/aspeed_soc.c
> > @@ -22,6 +22,42 @@
> >  #include "hw/i2c/aspeed_i2c.h"
> >  #include "net/net.h"
> > =20
> > +enum {
> > +    ASPEED_IOMEM,
> > +    ASPEED_UART1,
> > +    ASPEED_UART2,
> > +    ASPEED_UART3,
> > +    ASPEED_UART4,
> > +    ASPEED_UART5,
> > +    ASPEED_VUART,
> > +    ASPEED_FMC,
> > +    ASPEED_SPI1,
> > +    ASPEED_SPI2,
> > +    ASPEED_VIC,
> > +    ASPEED_SDMC,
> > +    ASPEED_SCU,
> > +    ASPEED_ADC,
> > +    ASPEED_SRAM,
> > +    ASPEED_GPIO,
> > +    ASPEED_RTC,
> > +    ASPEED_TIMER1,
> > +    ASPEED_TIMER2,
> > +    ASPEED_TIMER3,
> > +    ASPEED_TIMER4,
> > +    ASPEED_TIMER5,
> > +    ASPEED_TIMER6,
> > +    ASPEED_TIMER7,
> > +    ASPEED_TIMER8,
>=20
> You use an enum to define const values. It is recommended to also defi=
ne
> the value, to avoid problems if someone add/remove a value in the list=

> (unlikely, but we never know... imagine someone wants to try this SoC
> with 9 timers and add ASPEED_TIMER9) ;)

The enum's not used outside of aspeed_soc.c though, so it should all be
self-consistent? Adding ASPEED_TIMER9 would just adjust the designated
initialiser index values in aspeed_soc_ast2400_irqmap declaration below.=

Am I missing something?

Specifying enum values seems tedious in this case.

Andrew

>=20
> > +    ASPEED_WDT,
> > +    ASPEED_PWM,
> > +    ASPEED_LPC,
> > +    ASPEED_IBT,
> > +    ASPEED_I2C,
> > +    ASPEED_ETH1,
> > +    ASPEED_ETH2,
> > +    ASPEED_SDRAM,
> > +};
> > +
> >  #define ASPEED_SOC_UART_5_BASE      0x00184000
> >  #define ASPEED_SOC_IOMEM_SIZE       0x00200000
> >  #define ASPEED_SOC_IOMEM_BASE       0x1E600000
> > @@ -38,12 +74,42 @@
> >  #define ASPEED_SOC_ETH1_BASE        0x1E660000
> >  #define ASPEED_SOC_ETH2_BASE        0x1E680000
> > =20
> > -static const int uart_irqs[] =3D { 9, 32, 33, 34, 10 };
> > -static const int timer_irqs[] =3D { 16, 17, 18, 35, 36, 37, 38, 39,=
 };
> > +static const int aspeed_soc_ast2400_irqmap[] =3D {
> > +    [ASPEED_UART1]  =3D 9,
> > +    [ASPEED_UART2]  =3D 32,
> > +    [ASPEED_UART3]  =3D 33,
> > +    [ASPEED_UART4]  =3D 34,
> > +    [ASPEED_UART5]  =3D 10,
> > +    [ASPEED_VUART]  =3D 8,
> > +    [ASPEED_FMC]    =3D 19,
> > +    [ASPEED_SDMC]   =3D 0,
> > +    [ASPEED_SCU]    =3D 21,
> > +    [ASPEED_ADC]    =3D 31,
> > +    [ASPEED_GPIO]   =3D 20,
> > +    [ASPEED_RTC]    =3D 22,
> > +    [ASPEED_TIMER1] =3D 16,
> > +    [ASPEED_TIMER2] =3D 17,
> > +    [ASPEED_TIMER3] =3D 18,
> > +    [ASPEED_TIMER4] =3D 35,
> > +    [ASPEED_TIMER5] =3D 36,
> > +    [ASPEED_TIMER6] =3D 37,
> > +    [ASPEED_TIMER7] =3D 38,
> > +    [ASPEED_TIMER8] =3D 39,
> > +    [ASPEED_WDT]    =3D 27,
> > +    [ASPEED_PWM]    =3D 28,
> > +    [ASPEED_LPC]    =3D 8,
> > +    [ASPEED_IBT]    =3D 8, /* LPC */
> > +    [ASPEED_I2C]    =3D 12,
> > +    [ASPEED_ETH1]   =3D 2,
> > +    [ASPEED_ETH2]   =3D 3,
> > +};
> > =20
> >  #define AST2400_SDRAM_BASE       0x40000000
> >  #define AST2500_SDRAM_BASE       0x80000000
> > =20
> > +/* AST2500 uses the same IRQs as the AST2400 */
> > +#define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
> > +
> >  static const hwaddr aspeed_soc_ast2400_spi_bases[] =3D { ASPEED_SOC=
_SPI_BASE };
> >  static const char *aspeed_soc_ast2400_typenames[] =3D { "aspeed.smc=
.spi" };
> > =20
> > @@ -64,6 +130,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
> >          .fmc_typename =3D "aspeed.smc.fmc",
> >          .spi_typename =3D aspeed_soc_ast2400_typenames,
> >          .wdts_num     =3D 2,
> > +        .irqmap       =3D aspeed_soc_ast2400_irqmap,
> >      }, {
> >          .name         =3D "ast2400-a1",
> >          .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
> > @@ -75,6 +142,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
> >          .fmc_typename =3D "aspeed.smc.fmc",
> >          .spi_typename =3D aspeed_soc_ast2400_typenames,
> >          .wdts_num     =3D 2,
> > +        .irqmap       =3D aspeed_soc_ast2400_irqmap,
> >      }, {
> >          .name         =3D "ast2400",
> >          .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
> > @@ -86,6 +154,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
> >          .fmc_typename =3D "aspeed.smc.fmc",
> >          .spi_typename =3D aspeed_soc_ast2400_typenames,
> >          .wdts_num     =3D 2,
> > +        .irqmap       =3D aspeed_soc_ast2400_irqmap,
> >      }, {
> >          .name         =3D "ast2500-a1",
> >          .cpu_type     =3D ARM_CPU_TYPE_NAME("arm1176"),
> > @@ -97,9 +166,17 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
> >          .fmc_typename =3D "aspeed.smc.ast2500-fmc",
> >          .spi_typename =3D aspeed_soc_ast2500_typenames,
> >          .wdts_num     =3D 3,
> > +        .irqmap       =3D aspeed_soc_ast2500_irqmap,
> >      },
> >  };
> > =20
> > +static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
> > +{
> > +    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
> > +
> > +    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]=
);
> > +}
> > +
> >  static void aspeed_soc_init(Object *obj)
> >  {
> >      AspeedSoCState *s =3D ASPEED_SOC(obj);
> > @@ -226,14 +303,14 @@ static void aspeed_soc_realize(DeviceState *de=
v, Error **errp)
> >          return;
> >      }
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TI=
MER_BASE);
> > -    for (i =3D 0; i < ARRAY_SIZE(timer_irqs); i++) {
> > -        qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&s->vic), timer_ir=
qs[i]);
> > +    for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
> > +        qemu_irq irq =3D aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
> >          sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
> >      }
> > =20
> >      /* UART - attach an 8250 to the IO space as our UART5 */
> >      if (serial_hd(0)) {
> > -        qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic), uart_i=
rqs[4]);
> > +        qemu_irq uart5 =3D aspeed_soc_get_irq(s, ASPEED_UART5);
> >          serial_mm_init(get_system_memory(),
> >                         ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BA=
SE, 2,
> >                         uart5, 38400, serial_hd(0), DEVICE_LITTLE_EN=
DIAN);
> > @@ -247,7 +324,7 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
> >      }
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE=
);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
> > -                       qdev_get_gpio_in(DEVICE(&s->vic), 12));
> > +                       aspeed_soc_get_irq(s, ASPEED_I2C));
> > =20
> >      /* FMC, The number of CS is set at the board level */
> >      object_property_set_bool(OBJECT(&s->fmc), true, "realized", &er=
r);
> > @@ -259,7 +336,7 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
> >                      s->fmc.ctrl->flash_window_base);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
> > -                       qdev_get_gpio_in(DEVICE(&s->vic), 19));
> > +                       aspeed_soc_get_irq(s, ASPEED_FMC));
> > =20
> >      /* SPI */
> >      for (i =3D 0; i < sc->info->spis_num; i++) {
> > @@ -307,7 +384,7 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
> >      }
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ET=
H1_BASE);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
> > -                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
> > +                       aspeed_soc_get_irq(s, ASPEED_ETH1));
> >  }
> > =20
> >  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
> >=20
>

