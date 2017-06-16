Received: from eggs.gnu.org ([2001:4830:134:3::10]:48199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLn9u-0007h0-AZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLn9r-0000tc-1L
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:03:14 -0400
Date: Fri, 16 Jun 2017 16:34:45 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170616083445.GF30484@umbus>
References: <1497495164-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
	<20170615093238.65532c77@bahia.ttt.fr.ibm.com>
	<20170616013753.GA9658@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
In-Reply-To: <20170616013753.GA9658@in.ibm.com>
Subject: Re: [Qemu-devel] [FIX PATCH] spapr: prevent QEMU crash when CPU
 realization fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 07:07:53AM +0530, Bharata B Rao wrote:
> On Thu, Jun 15, 2017 at 09:32:38AM +0200, Greg Kurz wrote:
> > On Thu, 15 Jun 2017 08:22:44 +0530
> > Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> >=20
> > > ICPState objects were being allocated before CPU thread realization.
> > > However commit 9ed656631d73 (xics: setup cpu at realize time) reverse=
d it
> > > by allocating ICPState objects after CPU thread is realized. But it
> > > didn't take care to fix the error path because of which we observe
> > > a SIGSEGV when CPU thread realization fails during cold/hotplug.
> > >=20
> > > Fix this by ensuring that we do object_unparent() of ICPState object
> > > only in case when is was created earlier.
> > >=20
> >=20
> > Oops, my bad... my initial intent was to conditionally call object_unpa=
rent()
> > and I simply forgot to put the "if (obj) { }". But your patch is valid =
as well
> > of course. Maybe you can drop the initialization of obj to NULL on the =
way,
> > since it really doesn't make sense anymore.
>=20
> Here is the version w/o initializing obj to NULL.
>=20
> >From cb9cc946df0d1c430cccb1463d78fa4b41e9f0ee Mon Sep 17 00:00:00 2001
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Date: Wed, 14 Jun 2017 19:24:43 +0530
> Subject: [FIX PATCH v1] spapr: prevent QEMU crash when CPU realization
>  fails
>=20
> ICPState objects were being allocated before CPU thread realization.
> However commit 9ed656631d73 (xics: setup cpu at realize time) reversed it
> by allocating ICPState objects after CPU thread is realized. But it
> didn't take care to fix the error path because of which we observe
> a SIGSEGV when CPU thread realization fails during cold/hotplug.
>=20
> Fix this by ensuring that we do object_unparent() of ICPState object
> only in case when is was created earlier.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

I've replaced the version in my tree with this newer one.

> ---
>  hw/ppc/spapr_cpu_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index d6719d5..ea278ce 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -178,7 +178,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
d, Error **errp)
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    Object *obj =3D NULL;
> +    Object *obj;
> =20
>      object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
> @@ -198,13 +198,14 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild, Error **errp)
>      object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abor=
t);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
> -        goto error;
> +        goto free_icp;
>      }
> =20
>      return;
> =20
> -error:
> +free_icp:
>      object_unparent(obj);
> +error:
>      error_propagate(errp, local_err);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQ5gjAAoJEGw4ysog2bOSWr4P/RdAnzqBMlBS9WeHMjldIVQM
6Iy2mRL4TnuAdUOJnVMWTaROEkV8BMtuh1a0UR8d+s62fP0nb65noQOvBawukmfP
vwQ3j61It1qn7Xl5FTie0XR7Uw+2xrRq28DF9dEz0uJjM7b/Z0g7hxBCCw4QPb8w
ZsbRrnj2ncDaYts2EnXCtXeG7pXLzwdEOcW18DXGJzQaCM97YaGaZ60Y7DSKnNqJ
sthZIUIm2JWUUTedC8b/g73OOKKjAarPz261PB/mQTEph3pqVbn3BYZMogLJyFA8
tzkerhexRel0wloetJamCTWeNU8XjdneUgH06RRLQ2+9zqg3mTrGKoVvYsxmKup2
wkMZ/gTi8JM6cdeftfwd3eeJVUy3NaGdUfKgiBYxfp/2tqwntSJUTkrXXLpR+lPz
L6WGpC89Ksl4rjd+aeUjitUQjcTtvZdTirRbUvirRJzSXnLNleG8VysuRlIMrhZ7
jHOAM4Z8bGk+DQ5ey3eHIyhRUO0Wn/RSCXAtcXOWiuwRqeItRRBxhLgIhUgDUb5t
Gs1za9dQJbY3hiCtmAfpcvM35HgMVibmI84vPmCU2V8Qgh2Yozt6tJVLCpsWy6QC
ibEMrtgo+0Qe5b8Xo5qKfN8ckptChII6oKBZUDqGpVUCVk1aW5lkR4QV+ij6HQxJ
bTqAXfw6Y9kfbxWbLEmI
=wPBh
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
