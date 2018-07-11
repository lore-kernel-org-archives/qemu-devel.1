Received: from eggs.gnu.org ([2001:4830:134:3::10]:48498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdGaw-0008Qo-N9
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdGar-0004Kr-Rn
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:59:54 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdGar-0004KO-Ho
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:59:49 -0400
Received: by mail-wm0-x244.google.com with SMTP id v25-v6so2751636wmc.0
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:59:49 -0700 (PDT)
Date: Wed, 11 Jul 2018 15:59:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711145946.GO31228@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-5-e.emanuelegiuseppe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+Rs1qz93vBJxC1z"
Content-Disposition: inline
In-Reply-To: <20180709091136.28849-5-e.emanuelegiuseppe@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 4/7] tests/qgraph: arm/raspi2 machine node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--R+Rs1qz93vBJxC1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 11:11:33AM +0200, Emanuele Giuseppe Esposito wrote:
> Add arm/raspi2 machine to the graph. This machine contains a generic-sdhc=
i, so
> its constructor must take care of setting it properly when called.
>=20
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/Makefile.include        |  3 +-
>  tests/libqos/raspi2-machine.c | 68 +++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 1 deletion(-)
>  create mode 100644 tests/libqos/raspi2-machine.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index acbf704a8a..de75a7394e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -770,7 +770,8 @@ libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-p=
c-obj-y) tests/libqos/usb.o
>  libqos-virtio-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/l=
ibqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/l=
ibqos/malloc-generic.o
> =20
>  libqgraph-obj-y =3D tests/libqos/qgraph.o
> -libqgraph-pc-obj-y =3D $(libqos-pc-obj-y) tests/libqos/sdhci.o
> +libqgraph-pc-obj-y =3D $(libqos-pc-obj-y) $(libqgraph-obj-y) tests/libqo=
s/sdhci.o
> +libqgraph-pc-obj-y +=3D tests/libqos/raspi2-machine.o
> =20
>  check-unit-y +=3D tests/test-qgraph$(EXESUF)
>  tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
> diff --git a/tests/libqos/raspi2-machine.c b/tests/libqos/raspi2-machine.c
> new file mode 100644
> index 0000000000..47f024076f
> --- /dev/null
> +++ b/tests/libqos/raspi2-machine.c
> @@ -0,0 +1,68 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gma=
il.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qgraph.h"
> +#include "sdhci.h"
> +
> +typedef struct QRaspi2Machine QRaspi2Machine;
> +
> +struct QRaspi2Machine {
> +    QOSGraphObject obj;
> +    QSDHCI_MemoryMapped sdhci;
> +};
> +
> +static void raspi2_destroy(QOSGraphObject *obj)
> +{
> +    g_free(obj);
> +}
> +
> +static QOSGraphObject *raspi2_get_device(void *obj, const char *device)
> +{
> +    QRaspi2Machine *machine =3D obj;
> +    if (!g_strcmp0(device, "generic-sdhci")) {
> +        return &machine->sdhci.obj;
> +    }
> +
> +    printf("%s not present in arm/raspi2", device);
> +    abort();
> +}
> +
> +static void *qos_create_machine_arm_raspi2(void)
> +{
> +    QRaspi2Machine *machine =3D g_new0(QRaspi2Machine, 1);
> +
> +    machine->obj.get_device =3D raspi2_get_device;
> +    machine->obj.destructor =3D raspi2_destroy;
> +    qos_create_sdhci_mm(&machine->sdhci, 0x3f300000, &(QSDHCIProperties)=
 {
> +        .version =3D 3,
> +        .baseclock =3D 52,
> +        .capab.sdma =3D false,
> +        .capab.reg =3D 0x052134b4
> +    });
> +    return &machine->obj;
> +}
> +
> +static void raspi2(void)
> +{
> +    qos_node_create_machine("arm/raspi2", qos_create_machine_arm_raspi2);
> +    qos_node_contains("arm/raspi2", "generic-sdhci");
> +}
> +
> +libqos_init(raspi2);

Hmm...I didn't realize it would be necessary to manually define each
machine type.  I thought qgraph would use qemu-system-x86_64
-machine/-device/info qtree to introspect QEMU and instantiate the
appropriate drivers.

My concern is that this manual approach of defining machines complicates
qtests.  This file will need to be modified by multiple people - each of
them will be interested in a specific driver and not interested in the
driver that other people have added.

This makes things more complicated where previous qtests simply had an
if (x86) { add_test(test_x86_foo); } else if (arm) {
add_test(test_arm_foo); } in their source file.  It's ugly but it's
obvious.

Stefan

--R+Rs1qz93vBJxC1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRhtiAAoJEJykq7OBq3PI+18H/020iCnZ16FwdULZuf3/KVKb
aaakl/lUZwKmZOwwvtoXvrxzEI0nh1FIuZDprlgqHebZy4Ozr2yklKHs71CzUup+
4ew7Aq9bB2euAxaI28yRz9WB67nTnJCNf5kTQ1kZg2UJrOXraDmzeoIDwHcvytpk
oP5UlwjjE96mmbUMXttk6P4SnxIhgDCKzMXFE5cT1Ln5dQWVwtpkfZsZUS7AlUu6
i5CDzrGXbKJ4WBjrdIqpOl5kG6EaZ4i2I4+/hRNlvOtklTypTel4olGuO6JvQcdx
/MA+7LDcHBBweAX52YWUmtthN3XfCnTri8z3ekCzBJaqTaurB7Uc/OxneJR0vbw=
=e08t
-----END PGP SIGNATURE-----

--R+Rs1qz93vBJxC1z--
