Received: from eggs.gnu.org ([2001:4830:134:3::10]:60503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9HG2-0003EL-9S
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9HFz-0000wv-3W
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:38:22 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9HFy-0000wd-UP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:38:19 -0400
Received: by mail-qt0-x243.google.com with SMTP id b13-v6so7453919qtp.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:38:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180419212727.26095-1-f4bug@amsat.org>
	<20180419212727.26095-4-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b79057ab-d36e-21f9-236c-33c45051b273@amsat.org>
Date: Thu, 19 Apr 2018 18:38:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180419212727.26095-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qdev: Simplify the
 SysBusDeviceClass::init path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/19/2018 06:27 PM, Philippe Mathieu-Daudé wrote:
> The SysBusDevice is the last DeviceClass::init user.
> 
> Instead of using
>   SysBusDeviceClass::realize
>    -> DeviceClass::realize
>        -> DeviceClass::init
>            -> sysbus_device_init
>               -> SysBusDeviceClass::init
> 
> Simplify the path by directly calling SysBusDeviceClass::init
> in SysBusDeviceClass::realize:
> 
>   SysBusDeviceClass::realize
>    -> SysBusDeviceClass::init
> 
> Finally, remove the DeviceClass::init, there are no more users.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/qdev-core.h |  2 --
>  hw/core/qdev.c         | 14 --------------
>  hw/core/sysbus.c       | 15 ++++++++++-----
>  3 files changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9453588160..6f60748043 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -29,7 +29,6 @@ typedef enum DeviceCategory {
>      DEVICE_CATEGORY_MAX
>  } DeviceCategory;
>  
> -typedef int (*qdev_initfn)(DeviceState *dev);
>  typedef int (*qdev_event)(DeviceState *dev);
>  typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
>  typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
> @@ -124,7 +123,6 @@ typedef struct DeviceClass {
>      const struct VMStateDescription *vmsd;
>  
>      /* Private to qdev / bus.  */
> -    qdev_initfn init; /* TODO remove, once users are converted to realize */

The DeviceClass documentation (top of this file) is now out of date :(

If the maintainer taking this series prefer a respin, I plan to only
remove the 'init' references in the big comment.

>      qdev_event exit; /* TODO remove, once users are converted to unrealize */
>      const char *bus_type;
>  } DeviceClass;
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f6f92473b8..4153b733c8 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -208,19 +208,6 @@ void device_listener_unregister(DeviceListener *listener)
>      QTAILQ_REMOVE(&device_listeners, listener, link);
>  }
>  
> -static void device_realize(DeviceState *dev, Error **errp)
> -{
> -    DeviceClass *dc = DEVICE_GET_CLASS(dev);
> -
> -    if (dc->init) {
> -        int rc = dc->init(dev);
> -        if (rc < 0) {
> -            error_setg(errp, "Device initialization failed.");
> -            return;
> -        }
> -    }
> -}
> -
>  static void device_unrealize(DeviceState *dev, Error **errp)
>  {
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
> @@ -1065,7 +1052,6 @@ static void device_class_init(ObjectClass *class, void *data)
>      DeviceClass *dc = DEVICE_CLASS(class);
>  
>      class->unparent = device_unparent;
> -    dc->realize = device_realize;
>      dc->unrealize = device_unrealize;
>  
>      /* by default all devices were considered as hotpluggable,
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 5d0887f499..11f6d14b84 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "monitor/monitor.h"
>  #include "exec/address-spaces.h"
> @@ -200,15 +201,19 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
>      }
>  }
>  
> -static int sysbus_device_init(DeviceState *dev)
> +static void sysbus_realize(DeviceState *dev, Error **errp)
>  {
>      SysBusDevice *sd = SYS_BUS_DEVICE(dev);
>      SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
>  
> -    if (!sbc->init) {
> -        return 0;
> +    /* TODO remove, once users are converted to realize */
> +    if (sbc->init) {
> +        int rc = sbc->init(sd);
> +        if (rc < 0) {
> +            error_setg(errp, "Device initialization failed.");
> +            return;
> +        }
>      }
> -    return sbc->init(sd);
>  }
>  
>  DeviceState *sysbus_create_varargs(const char *name,
> @@ -324,7 +329,7 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
>  static void sysbus_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k = DEVICE_CLASS(klass);
> -    k->init = sysbus_device_init;
> +    k->realize = sysbus_realize;
>      k->bus_type = TYPE_SYSTEM_BUS;
>      /*
>       * device_add plugs devices into a suitable bus.  For "real" buses,
> 
