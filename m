Received: from eggs.gnu.org ([2001:4830:134:3::10]:34244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et4Nf-0004LQ-5P
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et4Nc-0002eg-1K
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:39:15 -0500
Date: Tue, 6 Mar 2018 15:06:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180306040617.GV2650@umbus.fritz.box>
References: <20180305211928.466-1-f4bug@amsat.org>
	<20180305211928.466-13-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uFO8jlCBh1yRPqfb"
Content-Disposition: inline
In-Reply-To: <20180305211928.466-13-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 12/22] hw/isa/superio: Add a
 keyboard/mouse controller (8042)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Alexander Graf <agraf@suse.de>, "open list:PReP" <qemu-ppc@nongnu.org>


--uFO8jlCBh1yRPqfb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 06:19:18PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Since the PC87312 inherits this abstract model, we remove the I8042
> instance in the PREP machine.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/isa/superio.h | 1 +
>  hw/isa/isa-superio.c     | 3 +++
>  hw/ppc/prep.c            | 1 -
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
> index e8007b9eee..2fc33bf3d3 100644
> --- a/include/hw/isa/superio.h
> +++ b/include/hw/isa/superio.h
> @@ -30,6 +30,7 @@ typedef struct ISASuperIODevice {
>      ISADevice *parallel[MAX_PARALLEL_PORTS];
>      ISADevice *serial[MAX_SERIAL_PORTS];
>      ISADevice *floppy;
> +    ISADevice *kbc;
>  } ISASuperIODevice;
> =20
>  typedef struct ISASuperIOFuncs {
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index 22bf79d3c3..6a24ac0259 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -17,6 +17,7 @@
>  #include "sysemu/blockdev.h"
>  #include "chardev/char.h"
>  #include "hw/isa/superio.h"
> +#include "hw/input/i8042.h"
>  #include "hw/char/serial.h"
>  #include "trace.h"
> =20
> @@ -139,6 +140,8 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
>                                      k->floppy.get_irq(sio, 0) : -1);
>      }
> =20
> +    /* Keyboard, mouse */
> +    sio->kbc =3D isa_create_simple(bus, TYPE_I8042);
>  }
> =20
>  static void isa_superio_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 610ec7ec32..96d319b87c 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -642,7 +642,6 @@ static void ppc_prep_init(MachineState *machine)
>                       hd[2 * i],
>  		     hd[2 * i + 1]);
>      }
> -    isa_create_simple(isa_bus, TYPE_I8042);
> =20
>      cpu =3D POWERPC_CPU(first_cpu);
>      sysctrl->reset_irq =3D cpu->env.irq_inputs[PPC6xx_INPUT_HRESET];

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uFO8jlCBh1yRPqfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqeE7kACgkQbDjKyiDZ
s5KmnRAAwCGMnjfc8/bxKjkhu8nKsM3ijmYgZxy76o55jgxIQOkO74+0R5qoxNRG
qA+Zn35fpfKcQcDWve4BGqLDa+BLQool96II4JRdTIWgF2ZTB9hjgxZkwqG6tMX3
ZUkdIVXD+JvyDnbJLTSCyPXoTr3U6SzlwAY2v2v4ifH9ik/9AZBKqo1dzQsU7zn7
z6FUD+x3IDd9MTIuTdMknllDKVWsJS8Xva2tN7mIiCA9KwfU0MBxHAPlJez4Kj8b
yySw/1OIxQei49qgCs9K6uOcqu5i3H7bEiXKOhnlJFSoPmBmjCJvYyPmuI5nS9lH
HtsOMVRSFyk3crDGlI5usBZ3MJW3+7QvqgYz4jTFH10v3s3+C6lUb7feYn6gqb1d
iExMWlQQ2zzE9UohFOyMxb0Ig4CS+EVnOFf4QXm2UAG2sp6gNnDZ+lo9AkW0uKeV
zWcZf72DjMh36g8ZsiGpsyHX0fajC5ACf+3Y44YQZ6NHfBpg1zkQ12fEijyS5mgw
YJnVCUQyepsu+DiVhnmX66qBTm5/4T0pfLJAvfwXy2vhvP4a81SqdZ6o9QCAMa6n
Kfa7IcCPaMgkC3vj3oXCqYq7lthYxYlrQ7pZNpqMOHsuKTdQRsurexVfwqBTLnwC
aZSIxqrn2+iAdW7q679RVNHBRj3XLSy7VGstXutGIp447Db3Nrc=
=31I2
-----END PGP SIGNATURE-----

--uFO8jlCBh1yRPqfb--
