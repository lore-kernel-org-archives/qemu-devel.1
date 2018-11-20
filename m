Received: from eggs.gnu.org ([2001:4830:134:3::10]:45919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7KN-0004r1-SL
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7KN-0000Qj-6c
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:48:35 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP7KN-0000Qd-2h
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:48:35 -0500
Received: by mail-ot1-x344.google.com with SMTP id a11so1849970otr.10
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:48:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181119120820.29878-5-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-5-maozhongyi@cmss.chinamobile.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:48:13 +0000
Message-ID: <CAFEAcA_ay8i64rjv8GZ_7+n7dDibMcP8O_hv-YcRLn6B76UJfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/22] core/empty_slot: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 19 November 2018 at 12:08, Mao Zhongyi
<maozhongyi@cmss.chinamobile.com> wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> empty_slot_class_init().
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> ---
>  hw/core/empty_slot.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
> index c1b9c2b104..239f78e2a7 100644
> --- a/hw/core/empty_slot.c
> +++ b/hw/core/empty_slot.c
> @@ -71,21 +71,20 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
>      }
>  }
>
> -static int empty_slot_init1(SysBusDevice *dev)
> +static void empty_slot_realize(DeviceState *dev, Error **errp)
>  {
>      EmptySlot *s = EMPTY_SLOT(dev);
>
>      memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
>                            "empty-slot", s->size);
> -    sysbus_init_mmio(dev, &s->iomem);
> -    return 0;
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>  }
>
>  static void empty_slot_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>
> -    k->init = empty_slot_init1;
> +    dc->realize = empty_slot_realize;
>  }
>
>  static const TypeInfo empty_slot_info = {

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
