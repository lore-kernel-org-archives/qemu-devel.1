Received: from eggs.gnu.org ([2001:4830:134:3::10]:35947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecbLQ-0000tT-Ov
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecbLM-0000SJ-TY
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:24:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecbLM-0000RR-KX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:24:48 -0500
Date: Fri, 19 Jan 2018 16:24:24 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119182424.GN15832@localhost.localdomain>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-8-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180116131555.14242-8-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/11] qdev: simplify the
 SysBusDeviceClass::init path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On Tue, Jan 16, 2018 at 10:15:51AM -0300, Philippe Mathieu-Daud=E9 wrote:
> The SysBusDevice is the last DeviceClass::init user.
>=20
> Instead of using
>   SysBusDeviceClass::realize
>    -> DeviceClass::realize
>        -> DeviceClass::init
>            -> sysbus_device_init
>               -> SysBusDeviceClass::init
>=20
> Simplify the path by directly calling SysBusDeviceClass::init
> in SysBusDeviceClass::realize:
>=20
>   SysBusDeviceClass::realize
>    -> SysBusDeviceClass::init
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/core/qdev.c   |  9 ---------
>  hw/core/sysbus.c | 21 +++++++++------------
>  2 files changed, 9 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 11112951a5..a4f76c8f5d 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -221,15 +221,6 @@ void device_listener_unregister(DeviceListener *li=
stener)
> =20
>  static void device_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
> -
> -    if (dc->init) {
> -        int rc =3D dc->init(dev);
> -        if (rc < 0) {
> -            error_setg(errp, "Device initialization failed.");
> -            return;
> -        }
> -    }
>  }

If you are removing the code that makes DeviceClass::init work,
you could remove the struct field as well.  I suggest either
squashing patches 07/11 and 08/11 together, or moving this hunk
to patch 08/11.

> =20
>  static void device_unrealize(DeviceState *dev, Error **errp)
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 04d6061f76..9edf43bc27 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -18,6 +18,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "monitor/monitor.h"
>  #include "exec/address-spaces.h"
> @@ -200,22 +201,19 @@ void sysbus_init_ioports(SysBusDevice *dev, uint3=
2_t ioport, uint32_t size)
>      }
>  }
> =20
> -/* TODO remove, once users are converted to realize */
> -static int sysbus_device_init(DeviceState *dev)
> +static void sysbus_realize(DeviceState *dev, Error **errp)
>  {
>      SysBusDevice *sd =3D SYS_BUS_DEVICE(dev);
>      SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_GET_CLASS(sd);
> =20
> -    if (!sbc->init) {
> -        return 0;
> +    /* TODO remove, once users are converted to realize */
> +    if (sbc->init) {
> +        int rc =3D sbc->init(sd);
> +        if (rc < 0) {
> +            error_setg(errp, "Device initialization failed.");
> +            return;
> +        }
>      }
> -    return sbc->init(sd);
> -}
> -
> -static void sysbus_realize(DeviceState *dev, Error **errp)
> -{
> -    SysBusDevice *sd =3D SYS_BUS_DEVICE(dev);
> -    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_GET_CLASS(sd);
> =20
>      if (sbc->realize) {
>          sbc->realize(sd, errp);
> @@ -345,7 +343,6 @@ MemoryRegion *sysbus_address_space(SysBusDevice *de=
v)
>  static void sysbus_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k =3D DEVICE_CLASS(klass);
> -    k->init =3D sysbus_device_init;
>      k->realize =3D sysbus_realize;
>      k->unrealize =3D sysbus_unrealize;
>      k->bus_type =3D TYPE_SYSTEM_BUS;
> --=20
> 2.15.1
>=20
>=20

--=20
Eduardo
