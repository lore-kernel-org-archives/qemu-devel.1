Received: from eggs.gnu.org ([2001:4830:134:3::10]:51854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eXINo-0001pF-3j
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 22:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eXINm-0004u3-H3
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 22:09:24 -0500
Date: Fri, 5 Jan 2018 14:07:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180105030729.GE24581@umbus.fritz.box>
References: <20180104042405.29773-1-david@gibson.dropbear.id.au>
	<20180104184718.568473a7@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dZH1BijwiAv2CwKz"
Content-Disposition: inline
In-Reply-To: <20180104184718.568473a7@bahia.lan>
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


--dZH1BijwiAv2CwKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2018 at 06:47:18PM +0100, Greg Kurz wrote:
> On Thu,  4 Jan 2018 15:24:05 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Currently the pseries machine sets the compatibility mode for the
> > guest's cpus in two places: 1) at machine reset and 2) after CAS
> > negotiation.
> >=20
> > This means that if we set or negotiate a compatiblity mode, then
> > hotplug a cpu, the hotplugged cpu doesn't get the right mode set and
> > will incorrectly have the full native features.
> >=20
> > To correct this, we set the compatibility mode on a cpu when it is
> > brought online with the 'start-cpu' RTAS call.  Given that we no
> > longer need to set the compatibility mode on all CPUs at machine
> > reset, so we change that to only set the mode for the boot cpu.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c      | 2 +-
> >  hw/ppc/spapr_rtas.c | 8 ++++++++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index e22888ba06..d1acfe8858 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1510,7 +1510,7 @@ static void spapr_machine_reset(void)
> >          spapr_ovec_cleanup(spapr->ov5_cas);
> >          spapr->ov5_cas =3D spapr_ovec_new();
> > =20
> > -        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> > +        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fa=
tal);
> >      }
> > =20
> >      fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index 4bb939d3d1..2ed00548c1 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -163,6 +163,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRM=
achineState *spapr,
> >          CPUState *cs =3D CPU(cpu);
> >          CPUPPCState *env =3D &cpu->env;
> >          PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > +        Error *local_err =3D NULL;
> > =20
> >          if (!cs->halted) {
> >              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > @@ -174,6 +175,13 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPR=
MachineState *spapr,
> >           * new cpu enters */
> >          kvm_cpu_synchronize_state(cs);
> > =20
> > +        /* Set compatibility mode to match existing cpus */
> > +        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &local=
_err);
>=20
> Is it okay to report a simple HW error to the guest here instead of abort=
ing
> like we do with first_cpu at reset time ?

Should be: this happens before we turn the cpu on, so the effect will
be that the guest fails to online the cpu.  That seems like a better
failure mode than killing the already running guest.

>=20
> > +        if (local_err) {
> > +            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > +            return;
> > +        }
> > +
> >          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> > =20
> >          /* Enable Power-saving mode Exit Cause exceptions for the new =
CPU */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dZH1BijwiAv2CwKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpO6/EACgkQbDjKyiDZ
s5IRQxAApK+goBNOX/Ygtxo5IPiLtyEdP+Ufc2ePhTto5bm3c7ybYRk/lvEZ/Juu
IT2RnPGWrw9FcDNNMhNtvMtd2aF0WPr1gmIXVDk+pN3ZT4uNHdDCndn2dxKYZTPw
mymzWNsTXzduqajsce6rRyRrftSQ9t6im31v1vxjoNMIMWx8PUKeqzj48pTBhFk+
sTkJOzcNvFvxooxHCk7DgjSgFn/eziZ4/LB9D+jbVa3L3K3XURpPy4ccb+K3ReuY
G1dZY/xJcC3B5Y0L07NXv95g6QRGLHXP7MLvIiZBC8dFCp+T+vCQ5nMpkmWvQca1
Qoz2X6q5RuGbwmFQZqr/YHkrisat1kR+nkhXNJxW2qqeqnkC7UKSCbG0jLZv9Bb3
Skxt2wFFh7k3MsSSxgh8qK2M1i3705EFg7k47xH5Wd6hbDm2CVKI0LFQtLXMYUy5
JWpuvuS7b3n1KKcNkjj6KCSCz55I9Fyx+Por9lg0yKft+YwqTsc1/bXq/TOvuESy
9yVpB82keZrbokbi52mZoWOj5XTEUBG1zrm1sUqWe+1ZXPgplyGypR7R7RN0bH/O
m4reN5OcVvz2aCDAFKh7Hse8YNX+4CXDZptUDfuMXpad8Kg5OespcFLvYpyp0umC
lgTOnVX6uaHP5MCIKypbPk9UlFuPzHCXQcBsh4+pFwHSJLETzC0=
=mCsZ
-----END PGP SIGNATURE-----

--dZH1BijwiAv2CwKz--
