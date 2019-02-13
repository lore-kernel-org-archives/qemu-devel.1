Received: from eggs.gnu.org ([209.51.188.92]:59750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvq-0003Dn-CZ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvp-000595-6O
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:13:58 -0500
Date: Wed, 13 Feb 2019 12:33:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213013321.GV1884@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-13-clg@kaod.org>
	<20190212010643.GG1884@umbus.fritz.box>
	<adcd2479-7a31-ba7d-50c6-cfa9af909f2e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MLcyhLwX/7AHNQNx"
Content-Disposition: inline
In-Reply-To: <adcd2479-7a31-ba7d-50c6-cfa9af909f2e@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 12/13] spapr/xics: ignore the lower 4K in
 the IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--MLcyhLwX/7AHNQNx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 08:05:53AM +0100, C=E9dric Le Goater wrote:
> On 2/12/19 2:06 AM, David Gibson wrote:
> > On Mon, Jan 07, 2019 at 07:39:45PM +0100, C=E9dric Le Goater wrote:
> >> The IRQ number space of the XIVE and XICS interrupt mode are aligned
> >> when using the dual interrupt mode for the machine. This means that
> >> the ICS offset is set to zero in QEMU and that the KVM XICS device
> >> should be informed of this new value. Unfortunately, there is now way
> >> to do so and KVM still maintains the XICS_IRQ_BASE (0x1000) offset.
> >>
> >> Ignore the lower 4K which are not used under the XICS interrupt
> >> mode. These IRQ numbers are only claimed by XIVE for the CPU IPIs.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/xics_kvm.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> >> index 651bbfdf6966..1d21ff217b82 100644
> >> --- a/hw/intc/xics_kvm.c
> >> +++ b/hw/intc/xics_kvm.c
> >> @@ -238,6 +238,15 @@ static void ics_get_kvm_state(ICSState *ics)
> >>      for (i =3D 0; i < ics->nr_irqs; i++) {
> >>          ICSIRQState *irq =3D &ics->irqs[i];
> >> =20
> >> +        /*
> >> +         * The KVM XICS device considers that the IRQ numbers should
> >> +         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
> >> +         * numbers (only claimed by XIVE for the CPU IPIs).
> >> +         */
> >> +        if (i + ics->offset < XICS_IRQ_BASE) {
> >> +            continue;
> >> +        }
> >> +
> >=20
> > This seems bogus to me.  The guest-visible irq numbers need to line up
> > between xics and xive mode, yes, but that doesn't mean we need to keep
> > around a great big array of unused array of ICS irq states, even in
> > TCG mode.
>=20
> This is because the qirqs[] array is under the machine and shared between=
=20
> both interrupt modes, xics and xive.

I don't see how that follows.  ICSIRQState is indexed in terms of the
ICS source number, not the global irq number, so I don't see why it
has to match up with the qirq array.

>=20
> C.
>=20
> >=20
> >>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> >>                            i + ics->offset, &state, false, &error_fata=
l);
> >> =20
> >> @@ -303,6 +312,15 @@ static int ics_set_kvm_state(ICSState *ics, int v=
ersion_id)
> >>          ICSIRQState *irq =3D &ics->irqs[i];
> >>          int ret;
> >> =20
> >> +        /*
> >> +         * The KVM XICS device considers that the IRQ numbers should
> >> +         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
> >> +         * numbers (only claimed by XIVE for the CPU IPIs).
> >> +         */
> >> +        if (i + ics->offset < XICS_IRQ_BASE) {
> >> +            continue;
> >> +        }
> >> +
> >>          state =3D irq->server;
> >>          state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY=
_MASK)
> >>              << KVM_XICS_PRIORITY_SHIFT;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MLcyhLwX/7AHNQNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjc+EACgkQbDjKyiDZ
s5Jtkg/+OZ10Y19DcibodePeF2SjlTcVVPTOjk+2uS1Thq+mA1zWBIS99kaB6PCd
ZtvPUVQrlGOspakYIiwrRumCPtsiwQnEBGSlPTYJIh3ccE0YLnDhjgAdCd+u90TK
Ry17ymzaUdBj0BcdITP+fu8uoZ9V1M6rWw//Y13yiwcQbLWpCfmeLVeIuedsZSmg
YRzZw5jk75msJ3osmJD1DplSyfxRM77XiXlewVOTxWMBSCpQahs6TOaGfR6pDgGS
vAd8lUKXwuZe7j0/i2Zuubo2xO2x9IuDoY0PKTZON51YA6COADs+lEkqchMzh088
AebquS1JCEitdW6W7kGgzpSYIzj4uNV9peB9svkTpR6YLOlMijxoKCf5fo1iSZnA
+jxkIk7hnH4cP0OXS0PvIXFns09xt2SaElYVy2pRpqkPO3oEUV3eZ1XR59zDYDX2
qMEZZ3cl9NxE2q2vI1C3A5SJnsKj62p3Dz1ClmQme7ihHA4HBWoqI7CdNVdnQCqc
agbOAywt78NkUZm8RTJoerxSlRrbeKTZixHK5U0pScI0xDPnxxhkeeNqDvCplNRy
QwUvxf200a2sCgtvCZg84QLsQ7g5x6RtBaPj1bU/x/9fzgzSJcB7DeEpIjhgWQm1
itiMcDne9sFTx52KOsbq7GiAUgR/cRdhOjN7mpLsou5furyZol4=
=U9X3
-----END PGP SIGNATURE-----

--MLcyhLwX/7AHNQNx--
