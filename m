Received: from eggs.gnu.org ([2001:4830:134:3::10]:52254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjwO-0008LD-CL
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjnq-00037i-U2
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:40:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEjnq-00034l-Lb
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:40:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id q7-v6so18913001wrr.8
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 16:40:04 -0700 (PDT)
References: <20181022074050.19638-1-maozhongyi@cmss.chinamobile.com>
	<20181022074050.19638-3-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51bd992c-6f6c-23db-662a-c3e50dea7084@redhat.com>
Date: Tue, 23 Oct 2018 01:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <20181022074050.19638-3-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/3] audio: use object link instead of
 qdev property to pass wm8750 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>

On 22/10/18 9:40, Mao Zhongyi wrote:
> According to qdev-properties.h, properties of pointer type should
> be avoided, it seems a link type property is a good substitution.
> 
> Cc: Jan Kiszka <jan.kiszka@web.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/arm/musicpal.c          |  3 ++-
>   hw/audio/marvell_88w8618.c | 13 ++++++-------
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 3dafb41b0b..ac266f9253 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1695,7 +1695,8 @@ static void musicpal_init(MachineState *machine)
>       wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
>       dev = qdev_create(NULL, "mv88w8618_audio");
>       s = SYS_BUS_DEVICE(dev);
> -    qdev_prop_set_ptr(dev, TYPE_WM8750, wm8750_dev);
> +    object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
> +                             TYPE_WM8750, NULL);
>       qdev_init_nofail(dev);
>       sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
>       sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
> diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
> index cf6ce6979b..1c7080e844 100644
> --- a/hw/audio/marvell_88w8618.c
> +++ b/hw/audio/marvell_88w8618.c
> @@ -15,6 +15,7 @@
>   #include "hw/i2c/i2c.h"
>   #include "hw/audio/wm8750.h"
>   #include "audio/audio.h"
> +#include "qapi/error.h"
>   
>   #define MP_AUDIO_SIZE           0x00001000
>   
> @@ -252,6 +253,11 @@ static void mv88w8618_audio_init(Object *obj)
>       memory_region_init_io(&s->iomem, obj, &mv88w8618_audio_ops, s,
>                             "audio", MP_AUDIO_SIZE);
>       sysbus_init_mmio(dev, &s->iomem);
> +
> +    object_property_add_link(OBJECT(dev), "wm8750", TYPE_WM8750,
> +                             (Object **) &s->wm,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             0, &error_abort);
>   }
>   
>   static void mv88w8618_audio_realize(DeviceState *dev, Error **errp)
> @@ -279,11 +285,6 @@ static const VMStateDescription mv88w8618_audio_vmsd = {
>       }
>   };
>   
> -static Property mv88w8618_audio_properties[] = {
> -    DEFINE_PROP_PTR(TYPE_WM8750, mv88w8618_audio_state, wm),
> -    {/* end of list */},
> -};
> -
>   static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -291,8 +292,6 @@ static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
>       dc->realize = mv88w8618_audio_realize;
>       dc->reset = mv88w8618_audio_reset;
>       dc->vmsd = &mv88w8618_audio_vmsd;
> -    dc->props = mv88w8618_audio_properties;
> -    /* Reason: pointer property "wm8750" */
>       dc->user_creatable = false;
>   }
>   
> 
