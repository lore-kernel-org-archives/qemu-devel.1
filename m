Received: from eggs.gnu.org ([2001:4830:134:3::10]:36352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Pil-0005aJ-R8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Pik-0005f6-7r
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:19:07 -0400
Date: Fri, 6 Oct 2017 21:14:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006101418.GL10961@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-13-git-send-email-imammedo@redhat.com>
	<20171006035447.GP3260@umbus.fritz.box>
	<20171006110352.64b7a814@nial.brq.redhat.com>
	<20171006091741.GI10961@umbus.fritz.box>
	<20171006115244.725aabd9@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2EnvhqpWJq810sZn"
Content-Disposition: inline
In-Reply-To: <20171006115244.725aabd9@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/23] ppc: move '-cpu foo,
 compat=xxx' parsing into ppc_cpu_parse_featurestr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--2EnvhqpWJq810sZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 11:52:44AM +0200, Igor Mammedov wrote:
> On Fri, 6 Oct 2017 20:17:41 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Oct 06, 2017 at 11:03:52AM +0200, Igor Mammedov wrote:
> > > On Fri, 6 Oct 2017 14:54:47 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Thu, Oct 05, 2017 at 06:24:39PM +0200, Igor Mammedov wrote: =20
> > > > > there is a dedicated callback CPUClass::parse_features
> > > > > which purpose is to convert -cpu features into a set of
> > > > > global properties AND deal with compat/legacy features
> > > > > that couldn't be directly translated into CPU's properties.
> > > > >=20
> > > > > Create ppc variant of it (ppc_cpu_parse_featurestr) and
> > > > > move 'compat=3Dval' handling from spapr_cpu_core.c into it.
> > > > > That removes a dependency of board/core code on cpu_model
> > > > > parsing and would let to reuse common -cpu parsing
> > > > > introduced by 6063d4c0
> > > > >=20
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>   =20
> > > >=20
> > > > Hrm.  I'm a bit unsure about this.  The fact that the board code is
> > > > involved in the parsing here is deliberate.  Basically 'compat=3D' =
never
> > > > made sense as a cpu property, it always should have been a machine
> > > > property.
> > > >=20
> > > > With this patch we'll still (correctly) fail on a non spapr machine=
 at
> > > > the point where we do:
> > > >=20
> > > > +            object_property_set_str(machine, v, "max-cpu-compat", =
&local_err);
> > > >=20
> > > > Though probably with a rather cryptic error. =20
> > > I's possible to guard it and apply to only SPAPR machine
> > > or trying to find property first before setting it. =20
> >=20
> > Yeah, I think we should do that.  Or possibly we could do something
> > with the vhyp interface.  If there was ever a vhyp machine other than
> > spapr (unlikely) then compat modes would also make sense for it (vhyp
> > being non-NULL basically means that our vcpu is never allowed to enter
> > hypervisor mode, so hypervisor privileged registers like LPCR need to
> > be handled by the machine instead).
> I'll use cast to spapr machine here for now, and leave it up to you
> to change it in future to something else if it make sense.

Makes sense.  As long as we get the behaviour right for now, we can
clean up the implementation later.

> btw: when pvn + power9 crushes it does so due to null vhyp
> if I recall correctly

Yeah, pnv is very much a work in progress, it barely works for POWER8
and is hardly tested for POWER9.  It's also entirely possible we're
misisng bits in the POWER9 code to handle the !vhyp case, since
pseries is the only machine that's really been tested with POWER9 at
all so far.

> > > > It still pollutes the cpu code with spapr's past mistake though.  I=
'm
> > > > not sure if this is a good tradeoff. =20
> > > CPUClass::parse_features callback was introduced to deal with=20
> > > legacy and compatibility nuances of "-cpu" CLI option, so I'm moving
> > > compat mistake back where it belongs so it will pollute code dealing
> > > with hacks. =20
> >=20
> > Hm, ok.  Still seems a bit odd to me, but I'll take your word for it.
> all targets that have special handling for -cpu options like
> parse '+-foo' format or 'foo' or fixup value of property or rename proper=
ty
> to new name do provide target specific CPUClass::parse_features callback
> to deal with it, the rest of the targets use generic
> cpu_common_parse_features().

Yeah, still smacks of the machine ~=3D target assumption that x86 people
tend to make.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2EnvhqpWJq810sZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXV3kACgkQbDjKyiDZ
s5IebA/+Mg7E/XJIrHQOySGl0yDpx4I8bek7hlg+OEDxt1iWFhSiqcArCmRQRM29
syuGmZk6xlCkLgPPbIS5tfegM2JKG5kQyZQInH/gRWkAfkrfP9/zDi2N041qQWZj
g76GgVeFgH968u6uaHXqviPIdc1hgxKDVdBXgowLEe6clUpL5GlSj9DXHB0ee/g1
8FgiSXzZ+s7Rz+QHLthk7P9IB125/6Sdb01tb3nswhu9LLWXaKYkUyGik7VYqM6q
iRdBLVg9fiuR4CnY1BwtiHALLS3l2YF5O7mXuMC/4qHclfnlprDAT0Yrp75/5Wzd
7LGJCCKADmeFu5BrSNTY3K0qio40UO0qtSGlTKAsXJ6/SywhLT8DJoNUw5Ul3zYc
OhL43a+vsoG0B3PSSmp8/YifEj0rBCXv2nsUmI1pc1bc8sWrjPHIeY5bCTkAgsNb
YCIHgvxIFkeu3PXMaOgNbnLYZ2ibXlef9X6yNQd/wYOrJ5sN7jfCOBdlLqSzB/96
x0gLt/xSKhlbkBfj7gr6+yHiYgPHrmZcTp93nz7M4bnBMA/SqRRK/wWF27i4tgZj
orB2+LRAzCBq9dOJRHs6ndQ1rAol3qKSgzlsGIY5KU6X9AE8jNXXzbwXTcSDnY/D
PyUWaen/KAEIZx/sOjCw/AE48r2a0/RWGSnOZua7re0TeJ2AM/w=
=2r/B
-----END PGP SIGNATURE-----

--2EnvhqpWJq810sZn--
