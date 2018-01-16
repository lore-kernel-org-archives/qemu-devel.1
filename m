Received: from eggs.gnu.org ([2001:4830:134:3::10]:47893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJ9h-0007yl-CU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJ9g-0004mb-5j
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:25 -0500
Date: Tue, 16 Jan 2018 15:42:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116044258.GB30352@umbus.fritz.box>
References: <20180115072715.25921-1-david@gibson.dropbear.id.au>
	<20180115072715.25921-3-david@gibson.dropbear.id.au>
	<20180115104847.1cf7e666@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20180115104847.1cf7e666@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/2] spapr: Adjust default VSMT value for
 better migration compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: joserz@linux.vnet.ibm.com, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 10:48:47AM +0100, Greg Kurz wrote:
> On Mon, 15 Jan 2018 18:27:15 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > fa98fbfc "PC: KVM: Support machine option to set VSMT mode" introduced =
the
> > "vsmt" parameter for the pseries machine type, which controls the spaci=
ng
> > of the vcpu ids of thread 0 for each virtual core.  This was done to br=
ing
> > some consistency and stability to how that was done, while still allowi=
ng
> > backwards compatibility for migration and otherwise.
> >=20
> > The default value we used for vsmt was set to the max of the host's
> > advertised default number of threads and the number of vthreads per vco=
re
> > in the guest.  This was done to continue running without extra paramete=
rs
> > on older KVM versions which don't allow the VSMT value to be changed.
> >=20
> > Unfortunately, even that smaller than before leakage of host configurat=
ion
> > into guest visible configuration still breaks things.  Specifically a g=
uest
> > with 4 (or less) vthread/vcore will get a different vsmt value when
> > running on a POWER8 (vsmt=3D=3D8) and POWER9 (vsmt=3D=3D4) host.  That =
means the
> > vcpu ids don't line up so you can't migrate between them, though you sh=
ould
> > be able to.
> >=20
> > Long term we really want to make vsmt =3D=3D smp_threads for sufficient=
ly
> > new machine types.  However, that means that qemu will then require a
> > sufficiently recent KVM (one which supports changing VSMT) - that's sti=
ll
> > not widely enough deployed to be really comfortable to do.
> >=20
> > In the meantime we some default that will work as often as possible.
>=20
> s/we some/we need some/ ?

Corrected.

> > This patch changes that default to 8 in all circumstances.  This does
> > change guest visible behaviour (including for existing machine versions)
> > for many cases - just not the most common/important case.
> >=20
> > Following is case by case justification for why this is still the least
> > worst option.  Note that any of the old behaviours can still be duplica=
ted
> > after this patch, it's just that it requires manual intervention by
> > setting the vsmt property on the command line.
> >=20
>=20
> IIUC this unconditionally breaks existing setups that rely on static
> Micro-Threading on a POWER8 host (eg, subcores-per-core=3D2 on the host
> and smp_threads=3D4). I have no evidence this is a widely used setup,
> but FWIW it is documented in some IBM RedBooks:

Well.. it will break migration between old and new qemu on the
microthreaded setup,  but fix it between new qemu on microthreaded
setup and new qemu on non-microthreaded setup (old qemu on
microthreaded to old qemu on non-microthreaded was already broken for
the same reasons as p8<->p9).  It's not really obvious to me which is
preferable.

> "Performance Optimization and Tuning Techniques for IBM Power Systems
>  Processors Including IBM POWER8"
>=20
> http://www.redbooks.ibm.com/abstracts/sg248171.html?Open
>=20
> "IBM PowerKVM: Configuration and Use"
>=20
> http://www.redbooks.ibm.com/abstracts/sg248231.html?Open
>
> Maybe the new behaviour could be added for new machine types only ?

I'd really prefer not to.  It makes some existing cases work, but
breaks some other cases.  Given that the old behaviour is inherently
wrong, I'm more inclined to change it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpdgs8ACgkQbDjKyiDZ
s5JBHRAAuaeTdXw/SWtedudcXdCPqmEGB1z5PP93ZbjlhqKqGVw3e026psJm3JJg
qn1RZ4c52PUekvHHnO+nEypXRN03OoK2QjqlsMfeQE1MqsYhm/yvEUCUN/vfGWOE
Y/1SMoSTUL3miab3T5GjdG4rdnHPyqxqdOqVCH1yL+jxzIAYM18m7lSBJss9BgCy
wM5l1Qy2mERAcpcnX/1J3e7hjtW3ZM2YgPXSZSBuNbJlfj2uEblzmzPdaomRPAUa
dd7QpSNpeF95uC6YSPTqx0j9486aubkNygrur5YwZqpKWKpJaCD0ymrEJiVscc3H
AJ0skrjpiFmVZ1bEENPvAQ9v+7h4xNrbjMd8h7pSUxr4N049rWXji9QGYiRxbzum
WmHxyud8NyTI6fDwEgPeyZ3x2HRfm6u3zqb/CpCrZ/sAfbMS3rkxIr7N8mrfkEjB
zZWyYIqzjKTjnewGCMC9a4CPImlEFLmQdGe/Bsa/lJ1b1fn3H6bCapmt8VSaQ58Y
wjE/ukyRmxyL7sCUguGOonxMuIXdV/m7NdGR45glQjhDoV/SBpL+oqKArFYmYSBk
S201VwOu26uzU8FkZR2E2U3aWtIf4DegCYu9SVtxwR+HcAv2cm+BcSgeXJQpOv9K
88qvtLScOe6SmxP+IwfAw4vgt09FxNCFvMk59AF+sAobxcqxRdk=
=z5hn
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
