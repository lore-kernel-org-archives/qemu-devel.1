Received: from eggs.gnu.org ([2001:4830:134:3::10]:35267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpQ-0004f2-Vn
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpP-0005OC-RM
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:40 -0400
Date: Tue, 12 Sep 2017 13:27:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170912032753.GA2774@umbus.fritz.box>
References: <150516425752.1593.1536226898929735667.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <150516425752.1593.1536226898929735667.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2] spapr_cpu_core: cleaning up
 qdev_get_machine() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 11:10:57PM +0200, Greg Kurz wrote:
> This patch removes the qdev_get_machine() calls that are made
> in spapr_cpu_core.c in situations where we can get an existing
> pointer for the MachineState by either passing it as an argument
> to the function or by using other already available pointers.
>=20
> Credits to Daniel Henrique Barboza for the idea and the changelog
> text.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - fixed typo in spapr_cpu_reset()

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr_cpu_core.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index dc9df0d393d1..0f32532abe99 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -73,8 +73,8 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> =20
>  static void spapr_cpu_reset(void *opaque)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      PowerPCCPU *cpu =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(cpu->vhyp);
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
> @@ -162,10 +162,10 @@ static void spapr_cpu_core_unrealizefn(DeviceState =
*dev, Error **errp)
>      g_free(sc->threads);
>  }
> =20
> -static void spapr_cpu_core_realize_child(Object *child, Error **errp)
> +static void spapr_cpu_core_realize_child(Object *child,
> +                                         sPAPRMachineState *spapr, Error=
 **errp)
>  {
>      Error *local_err =3D NULL;
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      Object *obj;
> @@ -254,7 +254,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>      for (j =3D 0; j < cc->nr_threads; j++) {
>          obj =3D sc->threads + j * size;
> =20
> -        spapr_cpu_core_realize_child(obj, &local_err);
> +        spapr_cpu_core_realize_child(obj, spapr, &local_err);
>          if (local_err) {
>              goto err;
>          }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm3VDcACgkQbDjKyiDZ
s5K+ww//Xm3Fjyx11F4+qcyKWWwtHf1dMQP9NV7704ak3urI2wnGDWc1Vmvr+wnx
m0ti3hL72HWRDqs73lAVFAi1dR1xwcQ0jL98hscHWr0o6czpQ3Pre/yFqIZlmyes
qYkO7w7EYQ0WHRFCXKY7RrnmwNnLCVUEfwR9caztgcyELnTqYP4AEBl4dceC73f+
iYj3I+eL9UPkbbjnFw3Bs9khS3RpFZZGvfcNmXPwg75uK9IDY+TvuwzaTAdM5K4i
wmEVmZo5tKaWlV5GyQzBzJ12QaGu6qYO+l4zw9/qsGatCWNaKly2o0rT9t/GWVt+
yNOphT+3hMrIgp6O6gkmtiwXSHLYHkJnkRq6zcGKBWZQcpzpsxXbkxL7vSR6/N4m
cfXkjH/CkqmHXcBZe/nm8sZ4JDlZd1p9EM4gJJ8lD3ne0HG98lNy2uFzCyLv1S5v
oU3Loj8jZg1pGCG7Q+9uO0Dxv1YQiAOdOQKJZE9xnya+ZHwKVn53SrBNq7/jCaRD
/DUjh5QltJTHz8rYyM+2o5DDLY9IVkDEfwyYfHuA1TLLN7V7tDIsyLPkfZFLlsmz
VpND6ghW98/6t2LF8vE/OqkBydR0hHGz758e0sZvaH+hrXKVHosPcG1Zb2QRFzKL
xm2tS3hgmwmTYThEZwfE1TT7Z5jodwjHOXpobmI7718ymqBFcfk=
=8Fi7
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
