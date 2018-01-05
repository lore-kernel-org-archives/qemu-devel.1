Received: from eggs.gnu.org ([2001:4830:134:3::10]:51618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eXIpp-0005d7-4s
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 22:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eXIpk-0006Rv-RZ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 22:38:21 -0500
Date: Fri, 5 Jan 2018 14:37:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180105033703.GF24581@umbus.fritz.box>
References: <20180104042405.29773-1-david@gibson.dropbear.id.au>
	<20180104184718.568473a7@bahia.lan>
	<151510026307.2579.5877378669181689283@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0h4+rw7qdMK7T5x1"
Content-Disposition: inline
In-Reply-To: <151510026307.2579.5877378669181689283@sif>
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, satheera@in.ibm.com


--0h4+rw7qdMK7T5x1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2018 at 03:11:03PM -0600, Michael Roth wrote:
> Quoting Greg Kurz (2018-01-04 11:47:18)
> > On Thu,  4 Jan 2018 15:24:05 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > Currently the pseries machine sets the compatibility mode for the
> > > guest's cpus in two places: 1) at machine reset and 2) after CAS
> > > negotiation.
> > >=20
> > > This means that if we set or negotiate a compatiblity mode, then
> > > hotplug a cpu, the hotplugged cpu doesn't get the right mode set and
> > > will incorrectly have the full native features.
> > >=20
> > > To correct this, we set the compatibility mode on a cpu when it is
> > > brought online with the 'start-cpu' RTAS call.  Given that we no
> > > longer need to set the compatibility mode on all CPUs at machine
> > > reset, so we change that to only set the mode for the boot cpu.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr.c      | 2 +-
> > >  hw/ppc/spapr_rtas.c | 8 ++++++++
> > >  2 files changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index e22888ba06..d1acfe8858 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1510,7 +1510,7 @@ static void spapr_machine_reset(void)
> > >          spapr_ovec_cleanup(spapr->ov5_cas);
> > >          spapr->ov5_cas =3D spapr_ovec_new();
> > > =20
> > > -        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> > > +        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_=
fatal);
> > >      }
> > > =20
> > >      fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > index 4bb939d3d1..2ed00548c1 100644
> > > --- a/hw/ppc/spapr_rtas.c
> > > +++ b/hw/ppc/spapr_rtas.c
> > > @@ -163,6 +163,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAP=
RMachineState *spapr,
> > >          CPUState *cs =3D CPU(cpu);
> > >          CPUPPCState *env =3D &cpu->env;
> > >          PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > > +        Error *local_err =3D NULL;
> > > =20
> > >          if (!cs->halted) {
> > >              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > > @@ -174,6 +175,13 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPA=
PRMachineState *spapr,
> > >           * new cpu enters */
> > >          kvm_cpu_synchronize_state(cs);
> > > =20
> > > +        /* Set compatibility mode to match existing cpus */
> > > +        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &loc=
al_err);
> >=20
> > Is it okay to report a simple HW error to the guest here instead of abo=
rting
> > like we do with first_cpu at reset time ?
>=20
> And if we don't opt for &error_fatal, we need an error_free() below.

Or better yet an error_report_err() which will display it and free
it.  I'll make that change.


>=20
> >=20
> > > +        if (local_err) {
> > > +            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > > +            return;
> > > +        }
> > > +
> > >          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> > > =20
> > >          /* Enable Power-saving mode Exit Cause exceptions for the ne=
w CPU */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0h4+rw7qdMK7T5x1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpO8tsACgkQbDjKyiDZ
s5K6sBAAmTiNn/VJoGYpR3/8NCCM6Zawb6UMLPGF+EJ3ZMQSgKEW6kkjBRTkoRfc
tZ0n35hvwbzvXzv67YRovoVJlJvST2OqDWbPPgasS9cYQ+Ie1kEi2MKAZGl1wvfI
vPM719shNrApU3mYEQ8Y9QbIbU82O13bI/hQbYU91KAjrJYYirdlF75YIHqOrBTX
2PG+Q1OkD8QiYkMlqXUYd7RXnFovzu7F65YtcKny7u0DyrIIgJ+YNvRSPu4/rjyQ
Aixe/oDUe1o5zbhjzTxr0QXv1CCX6pxiQaiXVrQDH5zCzsFsgwRjB8dghujbIQJE
ukC7KiyPpepqpaNb4UwZuLGFn4gxLgpnqJw0dKOECM7iuHh5q31ZzJLt4DUReU5e
s1T6aj9R96MMPYiJIfVC+eZnkh5tIt93YOsh37ykiyoTXVx3zpZeBsEKbLbP5PKv
qZXbvLgmaRg5hRXfkgWlESv0y52Ba0h2ro1mA3IC/jxQ4vQu0H0+2NacJ3hcXBE8
igskr4RprP/v35Yong4sW+OXbJOERgos8U+ihBRtN7EXnbhrCqz9/pGMocKTY6qI
BLgK21Vcuc2L4+/96KemUB4wDmSY9Mz398Fk9wyaXHX4ZNM+aG8KwnhgmN3r/bai
usdav6o8UWyLvrbaJJT5/Tvz8FMwmUgXGFfT5abmpK6PKqUKh/g=
=KSQt
-----END PGP SIGNATURE-----

--0h4+rw7qdMK7T5x1--
