Received: from eggs.gnu.org ([2001:4830:134:3::10]:43770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hWY-0004gj-A7
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hWU-0003CY-9D
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:19:42 -0400
Date: Sat, 7 Oct 2017 16:16:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171007051650.GI10050@umbus.fritz.box>
References: <20171005164959.26024-1-clg@kaod.org>
	<20171005164959.26024-2-clg@kaod.org>
	<20171006090722.GD10961@umbus.fritz.box>
	<63250b25-6c88-17a1-df4b-6a1e385ae7dd@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
Content-Disposition: inline
In-Reply-To: <63250b25-6c88-17a1-df4b-6a1e385ae7dd@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 11:15:31PM +0200, C=E9dric Le Goater wrote:
> On 10/06/2017 11:07 AM, David Gibson wrote:
> > On Thu, Oct 05, 2017 at 06:49:58PM +0200, C=E9dric Le Goater wrote:
> >> When a CPU is stopped with the 'stop-self' RTAS call, its state
> >> 'halted' is switched to 1 and, in this case, the MSR is not taken into
> >> account anymore in the cpu_has_work() routine. Only the pending
> >> hardware interrupts are checked with their LPCR:PECE* enablement bit.
> >>
> >> If the DECR timer fires after 'stop-self' is called and before the CPU
> >> 'stop' state is reached, the nearly-dead CPU will have some work to do
> >> and the guest will crash. This case happens very frequently with the
> >> not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
> >> occasionally fired but after 'stop' state, so no work is to be done
> >> and the guest survives.
> >>
> >> I suspect there is a race between the QEMU mainloop triggering the
> >> timers and the TCG CPU thread but I could not quite identify the root
> >> cause. To be safe, let's disable the decrementer interrupt in the LPCR
> >> when the CPU is halted and reenable it when the CPU is restarted.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/ppc/spapr_rtas.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index cdf0b607a0a0..2389220c9738 100644
> >> --- a/hw/ppc/spapr_rtas.c
> >> +++ b/hw/ppc/spapr_rtas.c
> >> @@ -174,6 +174,15 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAP=
RMachineState *spapr,
> >>          kvm_cpu_synchronize_state(cs);
> >> =20
> >>          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> >> +
> >> +        /* Enable DECR interrupt */
> >> +        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> >=20
> > Hm.  Checking mmu_model doesn't seem right to me.  I mean, it'll get
> > the right answer in practice, but the LPCR programming has nothing
> > whatsoever to do with the MMU.
> >=20
> > I think explicitly checking if cpu_ is a POWER9 instance with
> > object_dynamic_cast would be a better option.
>=20
> OK. So I guess we should change the switch statement in cpu_ppc_set_papr()
> also.

Yeah, I guess so.  No rush.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnYY0IACgkQbDjKyiDZ
s5JycBAAt4pnpYEM7aCQGapkmgx8bp3MQw4LRoSb940kfFYMgRrccDv8fYxay5jh
/SlztQLKsmleqpPcG7A82xqcmLAkd58a0bjPRVxP2ubJhaK9wjt3WXrGFii/4x2k
DHKeGeJWspOnDewNPRs1yOsQCKyBBuq36KzJB+4R2WZbCSVmB6EJjelcJgpBk15y
1gX6U/i1ecOWedh+/Itk1JVX5Duj5nXgJat2Pk6BUvWGdbomxpU7CoO/ccCkNvmJ
xa1CtLfaqr/2PNUZvgyxZZ4IxLINsfrSQdBbXHC7tZR061sZmPsYl5kwP0XyPxMw
ypqDG0OGb3vbyeVdPsd0TRDGQ8bc9x13JVH++9CcLavAnW6niD0XEE8MzsmOp3d+
qvxkPx4CjRn3GEFyRQyj5QVIl1dVToAnh6Pb05/oKkGOk3R+j6gmNALzYm3NzbtU
RETHVc9+VJyCHtyykIMFeYg2mnEHGY9evATSULFMx4M4mToZqYpIVXEnKDB30iYe
mTlJ9OX8vKFHVQa4ixQEAGvmwZPhNvoNPfefGybzqyUwBdfC04jWO46y8F1Lx9Pf
bdQF6JvspzcSVqatQKqTc0imOBQJWXqzaxO+uK2hsVrcnUS5SBiD8e2Kcw4bTYVp
UC2GLjQxPk3HVbSWfnQHSXQyjqI6FaUBvrY2e91myWEMhQ+9bnE=
=bnoi
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--
