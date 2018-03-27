Received: from eggs.gnu.org ([2001:4830:134:3::10]:37644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0l8f-00056L-9G
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0l8c-0004j6-6I
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:43:33 -0400
References: <20180326153441.32641-1-f4bug@amsat.org>
	<20180326153441.32641-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0a8516df-4a42-9576-bc54-736debf928eb@redhat.com>
Date: Tue, 27 Mar 2018 11:43:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180326153441.32641-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/5] hw/dma/i82374: Avoid double
 creation of the 82374 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Otubo <otubo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:PReP" <qemu-ppc@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, David Gibson <david@gibson.dropbear.id.au>, Nageswara Sastry <nasastry@in.ibm.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 26.03.2018 17:34, Philippe Mathieu-Daud=C3=A9 wrote:
> QEMU fails when used with the following command line:
>=20
>     ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p -device i82374
>     qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!b=
us->dma[0] && !bus->dma[1]' failed.
>=20
> The 40p machine type already creates the device i82374. If specified in=
 the
> command line, it will try to create it again, hence generating the erro=
r. The
> function isa_bus_dma() isn't supposed to be called twice for the same b=
us.
> Check the bus doesn't already have a DMA controller registered before c=
reating
> the device.
>=20
> Fixes: https://bugs.launchpad.net/qemu/+bug/1721224
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/dma/i82374.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
> index 83c87d92e0..892f655a7e 100644
> --- a/hw/dma/i82374.c
> +++ b/hw/dma/i82374.c
> @@ -23,6 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/isa/isa.h"
>  #include "hw/dma/i8257.h"
> =20
> @@ -118,13 +119,19 @@ static const MemoryRegionPortio i82374_portio_lis=
t[] =3D {
>  static void i82374_realize(DeviceState *dev, Error **errp)
>  {
>      I82374State *s =3D I82374(dev);
> +    ISABus *isa_bus =3D isa_bus_from_device(ISA_DEVICE(dev));
> +
> +    if (isa_get_dma(isa_bus, 0)) {
> +        error_setg(errp, "DMA already initialized on ISA bus");
> +        return;
> +    }
> +    i8257_dma_init(isa_bus, true);
> =20
>      portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list, s,
>                       "i82374");
>      portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj=
),
>                      s->iobase);
> =20
> -    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), true);
>      memset(s->commands, 0, sizeof(s->commands));
>  }
> =20
>=20

Thanks, looks like a good way to fix this issue for QEMU 2.12 indeed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
