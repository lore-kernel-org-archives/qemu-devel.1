Received: from eggs.gnu.org ([2001:4830:134:3::10]:56949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs0UA-0000z7-EV
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs0U6-0005Pm-El
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:49:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-17-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe7840db-f7ec-f804-5398-bc32018f08a7@amsat.org>
Date: Tue, 21 Aug 2018 03:49:40 -0300
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/22] hw/ssi/pl022: Set up reset function
 in class init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/20/2018 11:11 AM, Peter Maydell wrote:
> Currently the PL022 calls pl022_reset() from its class init
> function. Make it register a DeviceState reset method instead,
> so that we reset the device on system reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ssi/pl022.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
> index 379d3093987..0b5f90b857f 100644
> --- a/hw/ssi/pl022.c
> +++ b/hw/ssi/pl022.c
> @@ -203,8 +203,10 @@ static void pl022_write(void *opaque, hwaddr offset,
>      }
>  }
>  
> -static void pl022_reset(PL022State *s)
> +static void pl022_reset(DeviceState *dev)
>  {
> +    PL022State *s = PL022(dev);
> +
>      s->rx_fifo_len = 0;
>      s->tx_fifo_len = 0;
>      s->im = 0;
> @@ -277,7 +279,6 @@ static int pl022_init(SysBusDevice *sbd)
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->irq);
>      s->ssi = ssi_create_bus(dev, "ssi");
> -    pl022_reset(s);
>      vmstate_register(dev, -1, &vmstate_pl022, s);
>      return 0;
>  }
> @@ -285,8 +286,10 @@ static int pl022_init(SysBusDevice *sbd)
>  static void pl022_class_init(ObjectClass *klass, void *data)
>  {
>      SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      sdc->init = pl022_init;
> +    dc->reset = pl022_reset;
>  }
>  
>  static const TypeInfo pl022_info = {
> 
