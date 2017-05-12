Received: from eggs.gnu.org ([2001:4830:134:3::10]:52016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94uB-0007jU-0Z
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94u7-0007wT-Rc
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:22:27 -0400
Date: Fri, 12 May 2017 17:08:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512070843.GA15313@umbus.fritz.box>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-3-david@gibson.dropbear.id.au>
	<1493917751.4214.12.camel@redhat.com>
	<20170504205047.161b45ca@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20170504205047.161b45ca@bahia>
Subject: Re: [Qemu-devel] [PATCHv3 2/4] pseries: Move CPU compatibility
 property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Andrea Bolognani <abologna@redhat.com>, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 08:50:47PM +0200, Greg Kurz wrote:
> On Thu, 04 May 2017 19:09:11 +0200
> Andrea Bolognani <abologna@redhat.com> wrote:
>=20
> > On Thu, 2017-04-27 at 17:28 +1000, David Gibson wrote:
> > > @@ -2480,6 +2480,10 @@ static void spapr_machine_initfn(Object *obj)
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" place of standard EPOW event=
s when possible"
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" (required for memory hot-unp=
lug support)",
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0NULL);
> > > +
> > > +=A0=A0=A0=A0object_property_add(obj, "max-cpu-compat", "str",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0ppc_compat_prop_get, ppc_compat_prop_set,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0NULL, &spapr->max_compat_pvr, &error_fatal); =20
> >=20
> > I'm not familiar with QEMU's object system, but shouldn't
> > you be using object_property_add_str() instead? It looks
> > like you're doing more than the straightforward wrapper
> > would do, so maybe that's just not possible.
> >=20
> >=20
> > In any case, all other string properties look like
> >=20
> > =A0 pseries-2.10.kvm-type=3Dstring
> >=20
> > whereas this one ends up looking like
> >=20
> > =A0 pseries-2.10.max-cpu-compat=3Dstr
> >=20
> > which I think should be fixed - object_property_add_str()
> > passes "string" instead of "str" to object_property_add().
> >=20
> > You should also add a sensible description for the property,
> > preferably spelling out all the accepted values.
> >=20
> >=20
> > Speaking of properties...
> >=20
> > =A0 $ qemu-system-ppc64 -cpu host,compat=3Dwhatever
> > =A0 Segmentation fault
> >=20
> > You might want to look into that ;)
> >=20
>=20
> This happens because patch 2 is missing a change for the recently added P=
OWER9:
>=20
>          .max_threads =3D 8,
>      },
>      { /* POWER9, ISA3.00 */
> +        .name =3D "power9",
>          .pvr =3D CPU_POWERPC_LOGICAL_3_00,
>          .pcr =3D PCR_COMPAT_3_00,
>          .pcr_level =3D PCR_COMPAT_3_00,
>=20

Right, I have that fixed in my tree so it will be in the next spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFV94AAoJEGw4ysog2bOSi6UP/jUR7jOijSS8cjoP/gImWU0o
2/vmjhxocGmONRxwkdPVxIiGI8PyZ8pzcKJ0omOVLeLyZTNjueSP39vqIlbP0kUq
KYVTyzDLPuX2MIaV42wd4T7PEG29Pirl/jPtwnk+JDwEDxWY6eur0ysWwkP7AY70
4HX2phj79C/krTM4PgagXq8yjcnaFrc+q+eJGhkJ+G28I8Cnr2yeR+PJrcFuZKLd
35w8Jw34V3mHVO2Y91ZgcFRZHUDjLbfmG7RP/Vp9UqZ7xuYdLh+H9zVlNTkNWn8Q
CJq51Uek7K9hKCdjgR2dcy812Ygkx+pTAaHIW7Rhdze4V+YyGzSClnqmBeKrVGI8
W9YbJIQuVpeoTnRolMQE2kzWjXX1aU09gQVuaHt4Glq4wgYuwoZaT0PqFUVCuvJq
wfbaY7rdPZ7s8ndQRFZ1zHyVSFnyS0wwDeHC+pAVcT9VG0kRB84tP7B4iAY8a56k
HRm8MZpGnumdVTQib/QdcwU6I79kmdvCNjxlFILOIUhOSDf5wxCdv230YVDxToR2
Da8qrL4X8PSajyA4HiAJMnbs0U9YSMetLuGOv1iswuP5Xyk2oRgMmUOXh0BHG4fO
xPwfydz/MGDYBFEwKLVs0C/y9l2b91oBNrSmpAMsvdjz0xZcSLT0jYl868V2kvuD
SN2dZknhZGxDMKoeUID9
=aSAo
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
