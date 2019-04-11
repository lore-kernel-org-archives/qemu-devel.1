Received: from eggs.gnu.org ([209.51.188.92]:49397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbd9-0000Pd-De
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbd8-0000qs-Eg
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:28:47 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEbd8-0000pn-5e
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:28:46 -0400
Received: by mail-ot1-x342.google.com with SMTP id k21so5613919otf.1
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-3-joel@jms.id.au>
In-Reply-To: <20190328062222.8409-3-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 16:28:34 +0100
Message-ID: <CAFEAcA9G9Xrt5nDRJrSCC1SdeR987YzK+etRLTSyokLE+yyJSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/aspeed: Add RTC to SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Mar 2019 at 06:22, Joel Stanley <joel@jms.id.au> wrote:
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed_soc.c         | 15 +++++++++++++++
>  include/hw/arm/aspeed_soc.h |  2 ++
>  2 files changed, 17 insertions(+)
>
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index a27233d4876b..628ec633c91a 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -32,6 +32,7 @@
>  #define ASPEED_SOC_SDMC_BASE        0x1E6E0000
>  #define ASPEED_SOC_SCU_BASE         0x1E6E2000
>  #define ASPEED_SOC_SRAM_BASE        0x1E720000
> +#define ASPEED_SOC_RTC_BASE         0x1E781000
>  #define ASPEED_SOC_TIMER_BASE       0x1E782000
>  #define ASPEED_SOC_WDT_BASE         0x1E785000
>  #define ASPEED_SOC_I2C_BASE         0x1E78A000
> @@ -135,6 +136,10 @@ static void aspeed_soc_init(Object *obj)
>      object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
>      qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
>
> +    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_ASPEED_RTC);
> +    object_property_add_child(obj, "rtc", OBJECT(&s->rtc), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->rtc), sysbus_get_default());

These three lines should be written
       sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
                             TYPE_ASPEED_RTC);

which is both shorter and also avoids leaking a reference to
the child object.

(We should also at some point fix the existing uses of this
pattern in this file.)


thanks
-- PMM
