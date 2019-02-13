Received: from eggs.gnu.org ([209.51.188.92]:59752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvq-0003Do-DY
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvp-00058t-3v
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:13:58 -0500
Date: Wed, 13 Feb 2019 11:17:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213001714.GQ1884@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-12-clg@kaod.org>
	<20190212010151.GF1884@umbus.fritz.box>
	<9bee8eef-0389-de01-9b71-691124eecf5e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xYeFQzU4VZLrHqxU"
Content-Disposition: inline
In-Reply-To: <9bee8eef-0389-de01-9b71-691124eecf5e@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 11/13] spapr: check for the activation of
 the KVM IRQ device
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


--xYeFQzU4VZLrHqxU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 08:12:28AM +0100, C=E9dric Le Goater wrote:
> On 2/12/19 2:01 AM, David Gibson wrote:
> > On Mon, Jan 07, 2019 at 07:39:44PM +0100, C=E9dric Le Goater wrote:
> >> The activation of the KVM IRQ device depends on the interrupt mode
> >> chosen at CAS time by the machine and some methods used at reset or by
> >> the migration need to be protected.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/spapr_xive_kvm.c | 28 ++++++++++++++++++++++++++++
> >>  hw/intc/xics_kvm.c       | 25 ++++++++++++++++++++++++-
> >>  2 files changed, 52 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> >> index 93ea8e71047a..d35814c1992e 100644
> >> --- a/hw/intc/spapr_xive_kvm.c
> >> +++ b/hw/intc/spapr_xive_kvm.c
> >> @@ -95,9 +95,15 @@ static void kvmppc_xive_cpu_set_state(XiveTCTX *tct=
x, Error **errp)
> >> =20
> >>  void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
> >>  {
> >> +    sPAPRXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
> >>      uint64_t state[4] =3D { 0 };
> >>      int ret;
> >> =20
> >> +    /* The KVM XIVE device is not in use */
> >> +    if (xive->fd =3D=3D -1) {
> >> +        return;
> >> +    }
> >> +
> >>      ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_NVT_STATE, state);
> >>      if (ret !=3D 0) {
> >>          error_setg_errno(errp, errno,
> >> @@ -151,6 +157,11 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Erro=
r **errp)
> >>      unsigned long vcpu_id;
> >>      int ret;
> >> =20
> >> +    /* The KVM XIVE device is not in use */
> >> +    if (xive->fd =3D=3D -1) {
> >> +        return;
> >> +    }
> >> +
> >>      /* Check if CPU was hot unplugged and replugged. */
> >>      if (kvm_cpu_is_enabled(tctx->cs)) {
> >>          return;
> >> @@ -234,9 +245,13 @@ static void kvmppc_xive_source_get_state(XiveSour=
ce *xsrc)
> >>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
> >>  {
> >>      XiveSource *xsrc =3D opaque;
> >> +    sPAPRXive *xive =3D SPAPR_XIVE(xsrc->xive);
> >>      struct kvm_irq_level args;
> >>      int rc;
> >> =20
> >> +    /* The KVM XIVE device should be in use */
> >> +    assert(xive->fd !=3D -1);
> >> +
> >>      args.irq =3D srcno;
> >>      if (!xive_source_irq_is_lsi(xsrc, srcno)) {
> >>          if (!val) {
> >> @@ -580,6 +595,11 @@ int kvmppc_xive_pre_save(sPAPRXive *xive)
> >>      Error *local_err =3D NULL;
> >>      CPUState *cs;
> >> =20
> >> +    /* The KVM XIVE device is not in use */
> >> +    if (xive->fd =3D=3D -1) {
> >> +        return 0;
> >> +    }
> >> +
> >>      /* Grab the EAT */
> >>      kvmppc_xive_get_eas_state(xive, &local_err);
> >>      if (local_err) {
> >> @@ -612,6 +632,9 @@ int kvmppc_xive_post_load(sPAPRXive *xive, int ver=
sion_id)
> >>      Error *local_err =3D NULL;
> >>      CPUState *cs;
> >> =20
> >> +    /* The KVM XIVE device should be in use */
> >> +    assert(xive->fd !=3D -1);
> >=20
> > I'm guessing this is an assert() because the handler shouldn't be
> > registered when we're not in KVM mode.  But wouldn't that also be true
> > of the pre_save hook, which errors out rather than asserting?
>=20
> The handlers are not symetric.
>=20
> The pre_save is registered in the vmstate of the sPAPRXive model and the=
=20
> post_load is handled at the machine level after all XIVE state have been
> transferred.

Ah, ok.  Some comments on site explaining why that's so would be useful.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xYeFQzU4VZLrHqxU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjYgYACgkQbDjKyiDZ
s5Lsgw//Rwjyv/o39LrBRpZZqNWn6wzx6Ezcob9XMKzIgT1/NVQSXdsaLt8nVHaQ
Ja8TmBTEzCfdK2a5DDSpTFt1xw60vVHl/ArrHJyu6ZLKpKvjuVYkq+EKSoJvY1oU
FBuOaq/WpaiTI1FMav4VEXi4RfrowTrB6FpF5y1BuKE3Pj9kCGZKfFqqDXEzSEgR
azikGc1+u+Ty2FdhF+EL6ImJ9YsUFFazl56DKi1WrVNwc2J85lp5yi6uO1dRU/pH
itQpewdrSkPaw4glpUSNJ3i6qQ0ZYDQ6TucLh+Br90NIB1cyOHZ6mT3ZnO41B9Mi
9mOYRcH7tCV9lr/fmhbFhHbUkI3YuH4yCVQx5YFcvQ1kmlb4kNu9O919qFxNvlJv
DWWPZOkIhTyM8Fs9CsuVeAFfWxRKSpbw2XeYCqZXI5s3GCYGX17j38W6peh8cXHT
x1trAs8SnBdqAstvWvDZe85/dCgkTwbvLm4Fmpq0RJzit0ogmSmM1mysN+v1K6ht
xOjx+wsCGnJ5WDWeSvCugvLheBfAjBY7lMuSGhFsmjOPWf1Q91h0eAUUdsSeVn2p
qEbIgwZIRDVN8NkuriC3K+KIxWTdHrf1kz0sN2LyqnuoATecFS7EMpbMIy/aUfij
Z+pKdUmMXlEEe1moFkP6hLhNU0vKHiiJOQbHRpfXJUpzB6vkuGw=
=rWB7
-----END PGP SIGNATURE-----

--xYeFQzU4VZLrHqxU--
