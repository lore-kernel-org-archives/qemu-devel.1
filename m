Received: from eggs.gnu.org ([2001:4830:134:3::10]:39906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9K0f-0007ns-OX
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9JzI-0001hB-7L
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:05:34 -0400
Date: Mon, 8 Oct 2018 11:57:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181008005703.GQ7004@umbus.fritz.box>
References: <1538647621-9376-1-git-send-email-thuth@redhat.com>
	<20181005042527.GN7004@umbus.fritz.box>
	<1322d08f-9612-99d6-7ace-7b470beafa9a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="By57YlnFViWR/M0S"
Content-Disposition: inline
In-Reply-To: <1322d08f-9612-99d6-7ace-7b470beafa9a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr_rng: Introduce
 CONFIG_SPAPR_RNG switch for spapr_rng.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--By57YlnFViWR/M0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 08:12:12AM +0200, Thomas Huth wrote:
> On 2018-10-05 06:25, David Gibson wrote:
> > On Thu, Oct 04, 2018 at 12:07:01PM +0200, Thomas Huth wrote:
> >> The spapr-rng device is suboptimal when compared to virtio-rng, so
> >> users might want to disable it in their builds. Thus let's introduce
> >> a proper CONFIG switch to allow us to compile QEMU without this device.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >=20
> > Uh, sure, I guess so.
>=20
> Yes, we definitely want this for the QEMU in RHEL :-)
>=20
> >> diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
> >> index d2acd61..dec8434 100644
> >> --- a/hw/ppc/spapr_rng.c
> >> +++ b/hw/ppc/spapr_rng.c
> >> @@ -27,6 +27,7 @@
> >>  #include "sysemu/rng.h"
> >>  #include "hw/ppc/spapr.h"
> >>  #include "kvm_ppc.h"
> >> +#include "spapr_rng.h"
> >> =20
> >>  #define SPAPR_RNG(obj) \
> >>      OBJECT_CHECK(sPAPRRngState, (obj), TYPE_SPAPR_RNG)
> >> @@ -132,29 +133,6 @@ static void spapr_rng_realize(DeviceState *dev, E=
rror **errp)
> >>      }
> >>  }
> >> =20
> >> -int spapr_rng_populate_dt(void *fdt)
> >> -{
> >> -    int node;
> >> -    int ret;
> >> -
> >> -    node =3D qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
> >> -    if (node <=3D 0) {
> >> -        return -1;
> >> -    }
> >> -    ret =3D fdt_setprop_string(fdt, node, "device_type",
> >> -                             "ibm,platform-facilities");
> >> -    ret |=3D fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
> >> -    ret |=3D fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
> >> -
> >> -    node =3D fdt_add_subnode(fdt, node, "ibm,random-v1");
> >> -    if (node <=3D 0) {
> >> -        return -1;
> >> -    }
> >> -    ret |=3D fdt_setprop_string(fdt, node, "compatible", "ibm,random"=
);
> >> -
> >> -    return ret ? -1 : 0;
> >> -}
> >> -
> >=20
> > Moving this to an inline doesn't seem right to me though - it's a more
> > complex function that we usually want in a .h inline, and I don't
> > really see a good reason for it to be there (rather than an #ifdeffed
> > stub).
>=20
> An #ifdef is not possible here - the CONFIG switches for the targets are
> *not* turned into pre-processor macros, only the CONFIG switches for the
> host settings.

Ah, right.

> So putting this function as static inline into a separate
> header seems to be the best option to me right now. Alternatively, I
> could also put it directly into spapr.c directly, but that file is
> already very big... well, I don't mind, let me know what you prefer.

I'd prefer spapr.c to the inline.

But.. couldn't you put a stub version in stubs?  That would make a
weak symbol that would be overridden when SPAPR_RNG is compiled in.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--By57YlnFViWR/M0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu6q1oACgkQbDjKyiDZ
s5JK0A/6AqpRLIFryFS7vtwM6PXUsdyw8SDxoCWRUJags6LFZeb50wyUXmNCwp4a
rBIyiQ+scBv29KBmm5UVK2wcbSKVzPTiKhO3Hbp+RHTA7D26NT86kHQdCljQmGtX
u01mr3qsK4Yz3QROKozoV1cQUOq8E6amTXDASd5s3GC5ptxptvCRx1dsf9KVzkPJ
igQykZKHmrsWNbUv2GAq7BLDTjBZdmS9a4CnsVGZHW6tCuZfRj0pIRwskBQ8/Wqi
jfdYn1GUF5qn6WniHfAoKeuh41CZROPAgez1tjOr7t58LeVVRBwPLb8tOFGX6ygk
57qTwg8fAbi1fKZZdFDVkM5yEIXKIs0VYMz5oZI4acm+yQzZ5yZFuPMor2eHuPBV
PDY3pQQZ5gaAKRiED5cIUos5xT2D752losVCIsJ275GcyqKQEu5Ov5KjR0ZZJYiy
FKL+56yuW8Fj0ZIo+Cfamcs6fnOJKzy2JqleKj8MV3R3/RJi1mU7JJwZV1/ySK2Q
rcvnT4edfx/iP/Ew2UvGJG+R61K70OLQd4SyDRaTj7m8HxbIid+FVcxD4ftcrC8T
EcSZHAgWLrYuwGsUjVWzq7UeoKR1CbihbnPmVR0Rhz4vYSAeVKzizB8F91bPnbG4
j5siXb2KTy7NhS3Rq0wLZpkrBoZNrjB1v4xGh2WqfXWcHfjdOn8=
=2/Th
-----END PGP SIGNATURE-----

--By57YlnFViWR/M0S--
