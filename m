Received: from eggs.gnu.org ([2001:4830:134:3::10]:35903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drVwM-0006OK-G8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drVwI-0007n6-GD
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:08:22 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:45912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drVwI-0007mX-9t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:08:18 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id C7FE0931A5
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 23:08:16 +0200 (CEST)
Date: Mon, 11 Sep 2017 23:08:11 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170911230811.7215103f@bahia.lan>
In-Reply-To: <150516317201.28067.2144053652052053337.stgit@bahia.lan>
References: <150516317201.28067.2144053652052053337.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/ZqO7Of9KnZcC9SueTpMUtT+";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr_cpu_core: cleaning up
 qdev_get_machine() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/ZqO7Of9KnZcC9SueTpMUtT+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Sep 2017 22:52:52 +0200
Greg Kurz <groug@kaod.org> wrote:

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
>  hw/ppc/spapr_cpu_core.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index dc9df0d393d1..e26279116736 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -73,8 +73,8 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> =20
>  static void spapr_cpu_reset(void *opaque)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      PowerPCCPU *cpu =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(&cpu->vhyp);
                                                ^
                                              Ouch! :-\

I'll send a v2.

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
>=20


--Sig_/ZqO7Of9KnZcC9SueTpMUtT+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbb7OwAKCRAC/DrrAQHb
wsZbAJ9EFR95IxDLBlvA9/d/Ma//evvSCwCePbMzZALsjV0/vwf199eBsnBQ7Vs=
=QnlS
-----END PGP SIGNATURE-----

--Sig_/ZqO7Of9KnZcC9SueTpMUtT+--
