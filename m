Received: from eggs.gnu.org ([2001:4830:134:3::10]:60625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT8kH-0000Ys-AS
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT8kG-0003Ab-BK
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:58:53 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:36715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cT8kG-0003AO-6t
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:58:52 -0500
Received: by mail-ua0-x22b.google.com with SMTP id 96so82680336uaq.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 06:58:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170105043430.3176-2-alastair@au1.ibm.com>
References: <20170105043430.3176-1-alastair@au1.ibm.com>
	<20170105043430.3176-2-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 14:58:31 +0000
Message-ID: <CAFEAcA-8XvxRtfd=r3gmmsCgNQEQz5LEmN2J6KS5+=iNt0UZrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 1/7] arm: Uniquely name imx25 I2C buses.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

On 5 January 2017 at 04:34, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> The imx25 chip provides 3 i2c buses, but they have all been named
> "i2c", which makes it difficult to predict which bus a device will
> be connected to when specified on the command line.
>
> This patch addresses the issue by naming the buses uniquely:
>   i2c-bus.0 i2c-bus.1 i2c-bus.2
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  hw/arm/imx25_pdk.c | 2 +-
>  hw/i2c/imx_i2c.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> index 025b608..44e741f 100644
> --- a/hw/arm/imx25_pdk.c
> +++ b/hw/arm/imx25_pdk.c
> @@ -139,7 +139,7 @@ static void imx25_pdk_init(MachineState *machine)
>           * of simple qtest. See "make check" for details.
>           */
>          i2c_create_slave((I2CBus *)qdev_get_child_bus(DEVICE(&s->soc.i2c[0]),
> -                                                      "i2c"),
> +                                                      "i2c-bus.0"),
>                           "ds1338", 0x68);
>      }
>  }
> diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
> index 37e5a62..6c81b98 100644
> --- a/hw/i2c/imx_i2c.c
> +++ b/hw/i2c/imx_i2c.c
> @@ -310,7 +310,7 @@ static void imx_i2c_realize(DeviceState *dev, Error **errp)
>                            IMX_I2C_MEM_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> -    s->bus = i2c_init_bus(DEVICE(dev), "i2c");
> +    s->bus = i2c_init_bus(DEVICE(dev), NULL);
>  }
>
>  static void imx_i2c_class_init(ObjectClass *klass, void *data)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

and applied to target-arm.next.

thanks
-- PMM
