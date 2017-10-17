Received: from eggs.gnu.org ([2001:4830:134:3::10]:55784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4Lbx-0006SF-8D
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4Lbs-0002ox-C8
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:44:21 -0400
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-39-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7cc6099-cb42-f3ec-d23f-135111ff306c@redhat.com>
Date: Tue, 17 Oct 2017 08:43:55 +0200
MIME-Version: 1.0
In-Reply-To: <20171017001209.32276-39-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 38/39] hw/dma/i82374: avoid multiple
 creations on the same ISA bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

On 17.10.2017 02:12, Philippe Mathieu-Daud=C3=A9 wrote:
> $ ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=3Dtcg -device=
 i82374
> qemu-system-ppc64: -device i82374: DMA already initialized on ISA bus
>=20
> Reported-by: Eduardo Otubo <otubo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/dma/i82374.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
> index 6c0f975df0..280e64f0fa 100644
> --- a/hw/dma/i82374.c
> +++ b/hw/dma/i82374.c
> @@ -23,6 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/isa/isa.h"
> =20
>  #define TYPE_I82374 "i82374"
> @@ -117,13 +118,19 @@ static const MemoryRegionPortio i82374_portio_lis=
t[] =3D {
>  static void i82374_realize(DeviceState *dev, Error **errp)
>  {
>      I82374State *s =3D I82374(dev);
> +    ISABus *isa_bus =3D isa_bus_from_device(ISA_DEVICE(dev));
> +
> +    if (isa_bus->dma[0] || isa_bus->dma[1]) {
> +        error_setg(errp, "DMA already initialized on ISA bus");
> +        return;
> +    }

I think it'd be somewhat cleaner to do this check within DMA_init() -
and DMA_init() then should be provided with an errp parameter, too.
Since you then have to touch all callers, it would then maybe also make
sense to merge this with the next patch where you've got to touch all
callers due to the renaming of the function anyway.

>      portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list, s,
>                       "i82374");
>      portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj=
),
>                      s->iobase);
> =20
> -    DMA_init(isa_bus_from_device(ISA_DEVICE(dev)), 1);
> +    DMA_init(isa_bus, 1);
>      memset(s->commands, 0, sizeof(s->commands));
>  }

 Thomas
