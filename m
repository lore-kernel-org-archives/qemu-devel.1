Received: from eggs.gnu.org ([2001:4830:134:3::10]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHDZp-0002VX-QW
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHDZm-0002ZE-OK
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:42:49 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:32789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHDZm-0002Z1-Cz
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:42:46 -0500
Received: by mail-vk0-f49.google.com with SMTP id 137so39123727vkl.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 09:42:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161202054617.6749-2-alastair@au1.ibm.com>
References: <20161202054617.6749-1-alastair@au1.ibm.com>
	<20161202054617.6749-2-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 17:41:25 +0000
Message-ID: <CAFEAcA8nge_DCESG-4XLzKQG_K0AGjh8RBBMbekSOj7O8KB0ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 1/7] arm: Uniquely name imx25 I2C buses.
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

On 2 December 2016 at 05:46, Alastair D'Silva <alastair@au1.ibm.com> wrote:
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
>  hw/arm/imx25_pdk.c | 4 +---
>  hw/i2c/imx_i2c.c   | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> index 025b608..c6f04d3 100644
> --- a/hw/arm/imx25_pdk.c
> +++ b/hw/arm/imx25_pdk.c
> @@ -138,9 +138,7 @@ static void imx25_pdk_init(MachineState *machine)
>           * We add it here (only on qtest usage) to be able to do a bit
>           * of simple qtest. See "make check" for details.
>           */
> -        i2c_create_slave((I2CBus *)qdev_get_child_bus(DEVICE(&s->soc.i2c[0]),
> -                                                      "i2c"),
> -                         "ds1338", 0x68);
> +        i2c_create_slave(s->soc.i2c[0].bus, "ds1338", 0x68);

This bit doesn't look right. The board level code shouldn't be
poking around inside the IMXI2CState struct, as that is private
to the device implementation. That's why we're calling
qdev_get_child_bus().

>      }
>  }

thanks
-- PMM
