Received: from eggs.gnu.org ([2001:4830:134:3::10]:49173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9PQs-0004v4-V4
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9PQo-0008Rm-Vn
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:22:06 -0400
Date: Fri, 20 Apr 2018 16:21:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420062150.GL2434@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-10-david@gibson.dropbear.id.au>
	<9a2e3789-aafa-44b5-e7e0-31713114fad9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4oF+6Ged69J0+4/e"
Content-Disposition: inline
In-Reply-To: <9a2e3789-aafa-44b5-e7e0-31713114fad9@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13 09/10] target/ppc:
 Don't bother with MSR_EP in cpu_ppc_set_papr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--4oF+6Ged69J0+4/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 08:08:59AM +0200, Thomas Huth wrote:
> On 17.04.2018 09:17, David Gibson wrote:
> > cpu_ppc_set_papr() removes the EP and HV bits from the MSR mask.  While
> > removing the HV bit makes sense (a cpu in PAPR mode should never be
> > emulated in hypervisor mode), the EP bit is just bizarre.  Although it's
> > true that a papr mode guest shouldn't be able to change the exception
> > prefix, the MSR[EP] bit doesn't even exist on the cpus supported for PA=
PR
> > mode, so it's pointless to do anything with it here.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  target/ppc/translate_init.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index 5e89901149..bb5559d799 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -8870,12 +8870,11 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtu=
alHypervisor *vhyp)
> > =20
> >      cpu->vhyp =3D vhyp;
> > =20
> > -    /* PAPR always has exception vectors in RAM not ROM. To ensure thi=
s,
> > -     * MSR[IP] should never be set.
> > -     *
> > -     * We also disallow setting of MSR_HV
> > +    /*
> > +     * With a virtual hypervisor mode we never allow the CPU to go
> > +     * hypervisor mode itself
> >       */
> > -    env->msr_mask &=3D ~((1ull << MSR_EP) | MSR_HVB);
> > +    env->msr_mask &=3D ~MSR_HVB;
> > =20
> >      /* Tell KVM that we're in PAPR mode */
> >      if (kvm_enabled()) {
>=20
> Looks right.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Turns out this one is pretty much independent of the rest of the
series, so I've merged it to ppc-for-2.13 already.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4oF+6Ged69J0+4/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZhv4ACgkQbDjKyiDZ
s5IOcA/7BQFYlROBjuGXoo5tycbnubgm+ACi3R+fVekUihOWmzHSiaao+OyXAm3L
KGdlPEcmP762fOSVbN06+w+++WIddMooc/BYt5ZREKwqJzrlQLK55nrjt/R2vE4H
An1VHxZOwD6tQtkwsstaBidsj5wOQlAaOWNGOPpYj+4WrJ7BAf6pbegsbHyjdxki
tR0Sw9kG+i+drYzavN+z1Ei3cImInk2Py7kA9hI+e7ZzOvBzpnpJlwr/Bm9m8Vg1
FWM1GDecjN/9bJVrD1Pm6C7ZElKZF4Z50c9wmyttxURGSZm20cMovvIhpT0coS78
iVhKz9lrlgpa4t076Yh4F2WzZCLPt15HqMA0DyOAjpg+nr6mkyFiH3/k+fNaeeUX
bBZ7YXuG9UVRk5wmwaFdCspMiWsNHW02DnxLabM22fg22xCuwFZCVviFpiaHlDq9
PRRXu1xzK3hwZQ+cN0QGJCvi212dDeII3rnDhQFjY+lU82vuHgkzv6xFjZrXSj0i
fYNKbV7WqI4Jq5LN08mG3yvC2Qk6vo6n9kj1IycHcBPisRi2f7XotZP2mOjAEYWT
ffb01bHKNnT+UeGADIYzNiZGiEnauEvEnR6yxzYGncIvSKHrdCrJ/leJdlG/4n6e
xIM5xNMn5AhiX84rOkrSlMue7MkmTxpCkx+VkEwb1pUcAo1FYJ8=
=6B6I
-----END PGP SIGNATURE-----

--4oF+6Ged69J0+4/e--
