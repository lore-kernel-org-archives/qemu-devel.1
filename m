Received: from eggs.gnu.org ([2001:4830:134:3::10]:43612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl68Q-0000e3-DS
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl68N-0005Op-7z
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:22:18 -0400
Date: Fri, 25 Aug 2017 14:16:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825041644.GB2772@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <1503562911-2776-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/6] ppc: simplify cpu model
 lookup by PVR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 10:21:50AM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/ppc/translate_init.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index f1a559d..ca9f1e3 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -34,6 +34,7 @@
>  #include "hw/ppc/ppc.h"
>  #include "mmu-book3s-v3.h"
>  #include "sysemu/qtest.h"
> +#include "qemu/cutils.h"
> =20
>  //#define PPC_DUMP_CPU
>  //#define PPC_DEBUG_SPR
> @@ -10203,22 +10204,16 @@ static ObjectClass *ppc_cpu_class_by_name(const=
 char *name)
>      char *cpu_model, *typename;
>      ObjectClass *oc;
>      const char *p;
> -    int i, len;
> -
> -    /* Check if the given name is a PVR */
> -    len =3D strlen(name);
> -    if (len =3D=3D 10 && name[0] =3D=3D '0' && name[1] =3D=3D 'x') {
> -        p =3D name + 2;
> -        goto check_pvr;
> -    } else if (len =3D=3D 8) {
> -        p =3D name;
> -    check_pvr:
> -        for (i =3D 0; i < 8; i++) {
> -            if (!qemu_isxdigit(*p++))
> -                break;
> -        }
> -        if (i =3D=3D 8) {
> -            return OBJECT_CLASS(ppc_cpu_class_by_pvr(strtoul(name, NULL,=
 16)));
> +    unsigned long pvr;
> +
> +    /* Lookup by PVR if cpu_model is valid 8 digit hex number
> +     * (excl: 0x prefix if present)
> +     */
> +    if (!qemu_strtoul(name, &p, 16, &pvr)) {
> +        int len =3D p - name;
> +        len =3D (len =3D=3D 10) && (name[1] =3D=3D 'x') ? len - 2 : len;
> +        if (len =3D=3D 8) {
> +            return OBJECT_CLASS(ppc_cpu_class_by_pvr(pvr));

This doesn't look quite right.  A hex string of a PVR followed by
other stuff isn't a valid option, so if p (endptr) doesn't point to
the end of the string, then we shouldn't be using this path (from the
looks of qemu_strtoul() we can simply omit the endptr parameter to get
that behaviour).  I'm not sure what the messing around with len is
for, either.  If it's a valid hex string we can try this, I don't see
that we need further checks.

>          }
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmfpKwACgkQbDjKyiDZ
s5KUghAAo9O1R0cxVhC5rKMxGub32THRy5dETnWGm+bKubipL4HzUkPZ/zs+BwW5
lxK5/lli8NCwDr9rmbn09QsgrUw8VdVdBgsdCYFzHlkoaz3UKSZom/Udi7BQXdh+
y4mfInu+iklRZwXV5pNFoFV1JiRN2TzVZBUeSU/rkHRtZkwHpeQayUyaKsQ/W4V3
R837BTQjECVPkKKhH0E3Jk/+uEjFg3XNO1VB4OER3Kz09XV4K07zX1qRcSp/bWYw
g/BZMarpyx/wpIIhQGHKKP5DpVva9EdzFXfRcZ9HL6TiqIhkjlfcqTB4I/apUhDQ
f21TbuyTDQBN9g3apdFtnZZePule9JQhyvXd+E/fFM/3YiPQr5hHvWF47b3GM0bI
tn68tEskTVdii/HtJwDIx2do/9sv47uZhCYRBURHADUlYVPO01aD74pCpDuhKe23
Oxh2LOdKcI65CjMAM1xJn4z+k7JwZCZ8lfuc8nc0mQvL7gJAjD6Yn0IPF8EEPxkc
O1n/UaA/odaUMq4p0VwbM8sL4EzeTgZpYohcZWa2vNfFqy84OtPXJlvDVLS/6epn
47OK/5ZTDJ643oHR8YoYNhY6Rq6nDlyKZ9CGxocvM2btSKUKBjord/dzVxDn6tl0
KcDePizyHBsvoTCCCtabQWEkC9F0jd+CUiKMf+pz9DH+mnropak=
=gBM4
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
