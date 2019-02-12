Received: from eggs.gnu.org ([209.51.188.92]:42893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG6-0007XD-JR
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG4-0000Lo-Cr
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:14 -0500
Date: Tue, 12 Feb 2019 12:01:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212010151.GF1884@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <20190107183946.7230-12-clg@kaod.org>
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


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:39:44PM +0100, C=E9dric Le Goater wrote:
> The activation of the KVM IRQ device depends on the interrupt mode
> chosen at CAS time by the machine and some methods used at reset or by
> the migration need to be protected.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive_kvm.c | 28 ++++++++++++++++++++++++++++
>  hw/intc/xics_kvm.c       | 25 ++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 93ea8e71047a..d35814c1992e 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -95,9 +95,15 @@ static void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, =
Error **errp)
> =20
>  void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
>  {
> +    sPAPRXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
>      uint64_t state[4] =3D { 0 };
>      int ret;
> =20
> +    /* The KVM XIVE device is not in use */
> +    if (xive->fd =3D=3D -1) {
> +        return;
> +    }
> +
>      ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_NVT_STATE, state);
>      if (ret !=3D 0) {
>          error_setg_errno(errp, errno,
> @@ -151,6 +157,11 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error *=
*errp)
>      unsigned long vcpu_id;
>      int ret;
> =20
> +    /* The KVM XIVE device is not in use */
> +    if (xive->fd =3D=3D -1) {
> +        return;
> +    }
> +
>      /* Check if CPU was hot unplugged and replugged. */
>      if (kvm_cpu_is_enabled(tctx->cs)) {
>          return;
> @@ -234,9 +245,13 @@ static void kvmppc_xive_source_get_state(XiveSource =
*xsrc)
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
>  {
>      XiveSource *xsrc =3D opaque;
> +    sPAPRXive *xive =3D SPAPR_XIVE(xsrc->xive);
>      struct kvm_irq_level args;
>      int rc;
> =20
> +    /* The KVM XIVE device should be in use */
> +    assert(xive->fd !=3D -1);
> +
>      args.irq =3D srcno;
>      if (!xive_source_irq_is_lsi(xsrc, srcno)) {
>          if (!val) {
> @@ -580,6 +595,11 @@ int kvmppc_xive_pre_save(sPAPRXive *xive)
>      Error *local_err =3D NULL;
>      CPUState *cs;
> =20
> +    /* The KVM XIVE device is not in use */
> +    if (xive->fd =3D=3D -1) {
> +        return 0;
> +    }
> +
>      /* Grab the EAT */
>      kvmppc_xive_get_eas_state(xive, &local_err);
>      if (local_err) {
> @@ -612,6 +632,9 @@ int kvmppc_xive_post_load(sPAPRXive *xive, int versio=
n_id)
>      Error *local_err =3D NULL;
>      CPUState *cs;
> =20
> +    /* The KVM XIVE device should be in use */
> +    assert(xive->fd !=3D -1);

I'm guessing this is an assert() because the handler shouldn't be
registered when we're not in KVM mode.  But wouldn't that also be true
of the pre_save hook, which errors out rather than asserting?

>      /* Restore the ENDT first. The targetting depends on it. */
>      CPU_FOREACH(cs) {
>          kvmppc_xive_set_eq_state(xive, cs, &local_err);
> @@ -649,6 +672,11 @@ void kvmppc_xive_synchronize_state(sPAPRXive *xive, =
Error **errp)
>      CPUState *cs;
>      Error *local_err =3D NULL;
> =20
> +    /* The KVM XIVE device is not in use */
> +    if (xive->fd =3D=3D -1) {
> +        return;
> +    }
> +
>      /*
>       * When the VM is stopped, the sources are masked and the previous
>       * state is saved in anticipation of a migration. We should not
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index da6a00bc88cc..651bbfdf6966 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -68,6 +68,11 @@ static void icp_get_kvm_state(ICPState *icp)
>      uint64_t state;
>      int ret;
> =20
> +    /* The KVM XICS device is not in use */
> +    if (kernel_xics_fd =3D=3D -1) {
> +        return;
> +    }
> +
>      /* ICP for this CPU thread is not in use, exiting */
>      if (!icp->cs) {
>          return;
> @@ -104,6 +109,11 @@ static int icp_set_kvm_state(ICPState *icp, int vers=
ion_id)
>      uint64_t state;
>      int ret;
> =20
> +    /* The KVM XICS device is not in use */
> +    if (kernel_xics_fd =3D=3D -1) {
> +        return 0;
> +    }
> +
>      /* ICP for this CPU thread is not in use, exiting */
>      if (!icp->cs) {
>          return 0;
> @@ -140,8 +150,8 @@ static void icp_kvm_connect(ICPState *icp, Error **er=
rp)
>      unsigned long vcpu_id;
>      int ret;
> =20
> +    /* The KVM XICS device is not in use */
>      if (kernel_xics_fd =3D=3D -1) {
> -        abort();
>          return;
>      }
> =20
> @@ -220,6 +230,11 @@ static void ics_get_kvm_state(ICSState *ics)
>      uint64_t state;
>      int i;
> =20
> +    /* The KVM XICS device is not in use */
> +    if (kernel_xics_fd =3D=3D -1) {
> +        return;
> +    }
> +
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D &ics->irqs[i];
> =20
> @@ -279,6 +294,11 @@ static int ics_set_kvm_state(ICSState *ics, int vers=
ion_id)
>      int i;
>      Error *local_err =3D NULL;
> =20
> +    /* The KVM XICS device is not in use */
> +    if (kernel_xics_fd =3D=3D -1) {
> +        return 0;
> +    }
> +
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D &ics->irqs[i];
>          int ret;
> @@ -325,6 +345,9 @@ void ics_kvm_set_irq(void *opaque, int srcno, int val)
>      struct kvm_irq_level args;
>      int rc;
> =20
> +    /* The KVM XICS device should be in use */
> +    assert(kernel_xics_fd !=3D -1);
> +
>      args.irq =3D srcno + ics->offset;
>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MSI) {
>          if (!val) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiGv8ACgkQbDjKyiDZ
s5JQUQ/7BuIwyrqphRKef4NAAZ5lipPMDuE6HRQT/BZ2XePuaOtZHisY9NhZYtpr
GAet/J+u9HsuV21Q+d8Olc1JA7tMHuFydNdY8alDvjcIEJbGo38QBLgTzWzzH7Wo
24jUDdjdN7kxDlN2J50F4Fzb+a3RxX1o2uo0hAkhnLtvUR6jcB6IALaac4LNLFkR
KdgXqPnpySFYe09RVV+Z+MI9BLHyWliaL5GZ9qNfK8Kgg3+AmqOgHwomk59hintE
kCuG2OV2gElIXVxsAvsKFS0NtK42Wos4qlvex7s+G8KdZc3eKqvilzozyxhbIGpF
QbQ0l3FRqy7suO92ovmMiR0LA2oYClhEHN2vyIFR0xHtTP+F2wg3gSvgx5XAyuyH
FcDykpsu0H39omDyxVtCzL+wKPpvig5oLlciVp8jsPgYjJCWmrrKNHxuxYKx3uvE
4/7L4Lrc49H7vm8femuHrdrxZaRAPsup3ejqpRTTC3+o2821MPp005Jy3jP5kiAe
wjQJoNdM5rQHvIzidZIzkVr0G3ftKGoHKpsrBXv7RaMdfL4YD18BrdceYRIy0k1l
PkNWqlroT3a+hWKGUzXD3cb6cdTcWexRZ/LfDYwbBkhfVF/cMnMQlmKoyVTEF4n9
7U8cPLUfOk8WQZpcnQJPa/poE9VJmwgbO0RG1KIS2hjJ5YeyN2c=
=sFSW
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
