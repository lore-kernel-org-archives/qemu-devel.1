Received: from eggs.gnu.org ([209.51.188.92]:41591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFc-00075l-W7
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFb-0006s1-GZ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:48 -0500
Date: Tue, 26 Feb 2019 12:27:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226012758.GI6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X0cz4bGbQuRbxrVl"
Content-Disposition: inline
In-Reply-To: <20190222131322.26079-12-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 11/13] spapr: check for the activation
 of the KVM IRQ device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--X0cz4bGbQuRbxrVl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:13:20PM +0100, C=E9dric Le Goater wrote:
> The activation of the KVM IRQ device depends on the interrupt mode
> chosen at CAS time by the machine and some methods used at reset or by
> the migration need to be protected.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/spapr_xive_kvm.c | 28 ++++++++++++++++++++++++++++
>  hw/intc/xics_kvm.c       | 26 +++++++++++++++++++++++++-
>  2 files changed, 53 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index e31035c90260..cd81cdb23a5e 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -96,9 +96,15 @@ static void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, =
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
> @@ -152,6 +158,11 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error *=
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
> @@ -330,9 +341,13 @@ static void kvmppc_xive_source_get_state(XiveSource =
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
> @@ -519,6 +534,11 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
> =20
>  void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp)
>  {
> +    /* The KVM XIVE device is not in use */
> +    if (xive->fd =3D=3D -1) {
> +        return;
> +    }
> +
>      /*
>       * When the VM is stopped, the sources are masked and the previous
>       * state is saved in anticipation of a migration. We should not
> @@ -544,6 +564,11 @@ int kvmppc_xive_pre_save(sPAPRXive *xive)
>  {
>      Error *local_err =3D NULL;
> =20
> +    /* The KVM XIVE device is not in use */
> +    if (xive->fd =3D=3D -1) {
> +        return 0;
> +    }
> +
>      /* EAT: there is no extra state to query from KVM */
> =20
>      /* ENDT */
> @@ -568,6 +593,9 @@ int kvmppc_xive_post_load(sPAPRXive *xive, int versio=
n_id)
>      CPUState *cs;
>      int i;
> =20
> +    /* The KVM XIVE device should be in use */
> +    assert(xive->fd !=3D -1);
> +
>      /* Restore the ENDT first. The targetting depends on it. */
>      for (i =3D 0; i < xive->nr_ends; i++) {
>          kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 373de3155f6b..9855316e4831 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -69,6 +69,11 @@ void icp_get_kvm_state(ICPState *icp)
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
> @@ -105,6 +110,11 @@ int icp_set_kvm_state(ICPState *icp)
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
> @@ -133,8 +143,9 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
>      unsigned long vcpu_id;
>      int ret;
> =20
> +    /* The KVM XICS device is not in use */
>      if (kernel_xics_fd =3D=3D -1) {
> -        abort();
> +        return;
>      }
> =20
>      cs =3D icp->cs;
> @@ -170,6 +181,11 @@ void ics_get_kvm_state(ICSState *ics)
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
> @@ -269,6 +285,11 @@ int ics_set_kvm_state(ICSState *ics)
>  {
>      int i;
> =20
> +    /* The KVM XICS device is not in use */
> +    if (kernel_xics_fd =3D=3D -1) {
> +        return 0;
> +    }
> +
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          int ret;
> =20
> @@ -286,6 +307,9 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int va=
l)
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

--X0cz4bGbQuRbxrVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0lhsACgkQbDjKyiDZ
s5J53A/9HDzrH50YrTkcaWbCYbM4ObIbHsOWT8dx68hiYqQznt5OsttRkPsV4OYu
QXgkMtT31TPb9AqR/D75QhjiwpSAB77YQAA0IneYu2egy/T3vhR6qJfhiAwLkBAD
y7I299YmRzahx4UxYR7GdYf9Dtc4WCEWDisg0JHpFeH7MlO+7vJVXD45Ijh8A6cM
8kfiu/p7CsCjiYzbb8H+ui1QqMr96g2Uq3BnuA1C6N1Dhct09EqvCw9X11ZpxEyS
Qc7+m4niPCicQZy84Ki/ln7zE+CVgTdwygzqGeo05hM+fRBTs0aLGAvKzWsxPfmo
bks6wlJaAoTPT3n0s6kueZ0RkyY9fRTE0z80s9TF664H+zAlPaTqKSWOrezSfaqk
NKjVDix6QJYCFYSb9YvdcTFDNnKfxDH8NSBqhclqc5fQtbM9LThvhKTUN/gua4h3
W+OsGLdGBnxEZ8fWstn/Jm0LxWx5msg4/0iv6JZ0RaY78n6jYwcJsFAUkvLBbpNC
8dFZ19I1ajXxxgyfEkqsH1tcimrxPExNRLjce9SpaL+yT1ksPTFzdrvkuP9z3m28
5lDjlrN9vDcWgnqbbXqOJhiJsGykPDOkl8/cfj6oicFHBPWmC7CJVPQEE0DwUIrv
mRRaKHu0yDh9WYBnp45agNFSmIZYf7JFAfqzTCsEENXL6jqO31A=
=6bTY
-----END PGP SIGNATURE-----

--X0cz4bGbQuRbxrVl--
