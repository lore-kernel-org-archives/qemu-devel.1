Received: from eggs.gnu.org ([2001:4830:134:3::10]:56645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZois-0004dw-72
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZoip-0000l0-0Y
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:05:34 -0500
Date: Fri, 12 Jan 2018 12:47:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180112014734.GJ24770@umbus.fritz.box>
References: <20180104042405.29773-1-david@gibson.dropbear.id.au>
	<20180104184718.568473a7@bahia.lan>
	<20180105030729.GE24581@umbus.fritz.box>
	<20180111132430.5f0f66c3@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mPTHnM80CEnHQ2WJ"
Content-Disposition: inline
In-Reply-To: <20180111132430.5f0f66c3@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: Correct compatibility mode setting
 for hotplugged CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: mdroth@linux.vnet.ibm.com, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, satheera@in.ibm.com


--mPTHnM80CEnHQ2WJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 01:24:30PM +0100, Greg Kurz wrote:
> On Fri, 5 Jan 2018 14:07:29 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jan 04, 2018 at 06:47:18PM +0100, Greg Kurz wrote:
> > > On Thu,  4 Jan 2018 15:24:05 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > Currently the pseries machine sets the compatibility mode for the
> > > > guest's cpus in two places: 1) at machine reset and 2) after CAS
> > > > negotiation.
> > > >=20
> > > > This means that if we set or negotiate a compatiblity mode, then
> > > > hotplug a cpu, the hotplugged cpu doesn't get the right mode set and
> > > > will incorrectly have the full native features.
> > > >=20
> > > > To correct this, we set the compatibility mode on a cpu when it is
> > > > brought online with the 'start-cpu' RTAS call.  Given that we no
> > > > longer need to set the compatibility mode on all CPUs at machine
> > > > reset, so we change that to only set the mode for the boot cpu.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > ---
> > > >  hw/ppc/spapr.c      | 2 +-
> > > >  hw/ppc/spapr_rtas.c | 8 ++++++++
> > > >  2 files changed, 9 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index e22888ba06..d1acfe8858 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -1510,7 +1510,7 @@ static void spapr_machine_reset(void)
> > > >          spapr_ovec_cleanup(spapr->ov5_cas);
> > > >          spapr->ov5_cas =3D spapr_ovec_new();
> > > > =20
> > > > -        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> > > > +        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &erro=
r_fatal);
> > > >      }
> > > > =20
> > > >      fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> > > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > > index 4bb939d3d1..2ed00548c1 100644
> > > > --- a/hw/ppc/spapr_rtas.c
> > > > +++ b/hw/ppc/spapr_rtas.c
> > > > @@ -163,6 +163,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sP=
APRMachineState *spapr,
> > > >          CPUState *cs =3D CPU(cpu);
> > > >          CPUPPCState *env =3D &cpu->env;
> > > >          PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > > > +        Error *local_err =3D NULL;
> > > > =20
> > > >          if (!cs->halted) {
> > > >              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > > > @@ -174,6 +175,13 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, s=
PAPRMachineState *spapr,
> > > >           * new cpu enters */
> > > >          kvm_cpu_synchronize_state(cs);
> > > > =20
> > > > +        /* Set compatibility mode to match existing cpus */
> > > > +        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &l=
ocal_err); =20
> > >=20
> > > Is it okay to report a simple HW error to the guest here instead of a=
borting
> > > like we do with first_cpu at reset time ? =20
> >=20
> > Should be: this happens before we turn the cpu on, so the effect will
> > be that the guest fails to online the cpu.  That seems like a better
> > failure mode than killing the already running guest.
> >=20
>=20
> Of course, I generally agree with the "better failure mode". My point was
> just that if we managed to set the compat mode with the first cpu but we
> fail to propagate the same compat mode to subsequent cpus, then this is
> a bug in QEMU or KVM.

Ah, I see your point.  Yes, I guess that's true.  Nonetheless, I think
the better failure mode is still a better idea, even if something goes
wrong elsewhere.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mPTHnM80CEnHQ2WJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpYE7MACgkQbDjKyiDZ
s5LpORAAugEksOMOOxH/Qdj4SXSxDkCJo7ZNgtU7IEqu0SxyjlW3qxh4dC5bia43
w5S6dzu1CQfT2WY7KyGYa2NKBOwS8R+nGKantFrxZXDoGwdGum6/lSsjq/9Ylyzq
SUbVFVIEouMk6kKeNOiaT5/A1vSWOeoljHgEv3ks3XowTCryMsk4golwOFHu4IR7
+ARhi92WoTobuFyqS+IDbFww18qzMSZot7pvnFk2BZ0Si6S1CDjNrCkEntiP0w5N
bfQ/16vwrqUY6WcwloWgNoO2sBZzq+w08H/X2wOesdDHv9o+nqQN4HJd/u7P8gA8
I6+xstP2NewMpGRAPbe185RqHRvOdiaIw7QjfK8cRJmsAASMOZOvGHchivosZzv1
Lx5Dl24a4SGTGReAFk9PJA901lrB/90Lnp/hek4JoEfYjy/WJ0DTY+mV+UbOr5h/
lHeyrYIxzMtEsNPKsoTrketk8/WoICKU5BgaSBnf7pybIOo4FKQtymxDwS+tyKlZ
qbvNnTye55ZGU3dpJCtRXveP9nHGwGiwm4Ht/wjdaJRKViAEv3S4c1j7Vczz0S6E
h9KeXYKZaBPGCUYzgfWWf8RG2DdyQmORbk/birf90o7DZ7IxqM2ujLbYHtIU6tR+
1IqcA4QOMZjrmoVMjDeGr7EHrGrhZte+7zbSxxO8U7o0EgQOSAE=
=HzL9
-----END PGP SIGNATURE-----

--mPTHnM80CEnHQ2WJ--
