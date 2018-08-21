Received: from eggs.gnu.org ([2001:4830:134:3::10]:57736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs0XM-0003me-VK
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs0XJ-0007No-NM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:53:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-19-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5da29ed5-0003-a18f-65e0-a408b5f46b92@amsat.org>
Date: Tue, 21 Aug 2018 03:53:01 -0300
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/22] hw/ssi/pl022: Use
 DeviceState::realize rather than SysBusDevice::init
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
> Move from the legacy SysBusDevice::init method to using
> DeviceState::realize.

It would be nice to have a wiki page where each maintainer list his
deprecated/legacy API and which current API to use instead (and why,
some examples how to use or port, pointing to git commits).

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ssi/pl022.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
> index c9989537062..3ac57f4c96a 100644
> --- a/hw/ssi/pl022.c
> +++ b/hw/ssi/pl022.c
> @@ -270,26 +270,24 @@ static const VMStateDescription vmstate_pl022 = {
>      }
>  };
>  
> -static int pl022_init(SysBusDevice *sbd)
> +static void pl022_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(sbd);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      PL022State *s = PL022(dev);
>  
>      memory_region_init_io(&s->iomem, OBJECT(s), &pl022_ops, s, "pl022", 0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->irq);
>      s->ssi = ssi_create_bus(dev, "ssi");
> -    return 0;
>  }
>  
>  static void pl022_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    sdc->init = pl022_init;
>      dc->reset = pl022_reset;
>      dc->vmsd = &vmstate_pl022;
> +    dc->realize = pl022_realize;
>  }
>  
>  static const TypeInfo pl022_info = {
> 
