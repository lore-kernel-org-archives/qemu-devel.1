Received: from eggs.gnu.org ([2001:4830:134:3::10]:55062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eakHH-00020K-HH
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 10:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eakHG-0000Tr-G6
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 10:32:55 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eakHG-0000TN-At
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 10:32:54 -0500
Received: by mail-ot0-x243.google.com with SMTP id g59so8754481otg.11
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 07:32:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180114025234.29436-1-f4bug@amsat.org>
References: <20180114025234.29436-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Jan 2018 15:32:32 +0000
Message-ID: <CAFEAcA-m+7Cr1R=oBNmuNC3XQbyYmjj2s_tGd5rHK2jmzRmHSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sysbus: convert init() to realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 14 January 2018 at 02:52, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/core/sysbus.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 5d0887f499..0531eb60ce 100644
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
> @@ -200,15 +201,15 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_=
t ioport, uint32_t size)
>      }
>  }
>
> -static int sysbus_device_init(DeviceState *dev)
> +static void sysbus_device_realize(DeviceState *dev, Error **errp)
>  {
>      SysBusDevice *sd =3D SYS_BUS_DEVICE(dev);
>      SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_GET_CLASS(sd);
>
> -    if (!sbc->init) {
> -        return 0;
> +    if (sbc->init && sbc->init(sd)) {
> +        error_setg(errp, "sysbus device initialization failed");
> +        return;
>      }
> -    return sbc->init(sd);
>  }
>
>  DeviceState *sysbus_create_varargs(const char *name,
> @@ -324,7 +325,7 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
>  static void sysbus_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k =3D DEVICE_CLASS(klass);
> -    k->init =3D sysbus_device_init;
> +    k->realize =3D sysbus_device_realize;
>      k->bus_type =3D TYPE_SYSTEM_BUS;
>      /*
>       * device_add plugs devices into a suitable bus.  For "real" buses,

This doesn't look right. SysBus::init is something we're trying
to deprecate, I think, so we should be looking to complete
that process, not changing its semantics so it isn't called
until Device::realize.

thanks
-- PMM
