Received: from eggs.gnu.org ([209.51.188.92]:58352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grDld-0005FC-01
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grDlb-0003yw-Ak
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:20:52 -0500
Date: Wed, 6 Feb 2019 13:49:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190206024938.GW22661@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1Wg5Vd7si6EhrIHA"
Content-Disposition: inline
In-Reply-To: <20190107183946.7230-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 04/13] spapr/xive: introduce a VM state
 change handler
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


--1Wg5Vd7si6EhrIHA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:39:37PM +0100, C=E9dric Le Goater wrote:
> This handler is in charge of stabilizing the flow of event notifications
> in the XIVE controller before migrating a guest. This is a requirement
> before transferring the guest EQ pages to a destination.
>=20
> When the VM is stopped, the handler masks the sources (PQ=3D01) to stop
> the flow of events and saves their previous state. The XIVE controller
> is then synced through KVM to flush any in-flight event notification
> and to stabilize the EQs. At this stage, the EQ pages are marked dirty
> to make sure the EQ pages are transferred if a migration sequence is
> in progress.
>=20
> The previous configuration of the sources is restored when the VM
> resumes, after a migration or a stop.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Looks fine apart from interface details discussed on the kernel series.

> ---
>  include/hw/ppc/spapr_xive.h |   1 +
>  hw/intc/spapr_xive_kvm.c    | 111 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 111 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 02f2de20111c..8815ed5aa372 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -39,6 +39,7 @@ typedef struct sPAPRXive {
>      /* KVM support */
>      int           fd;
>      void          *tm_mmap;
> +    VMChangeStateEntry *change;
>  } sPAPRXive;
> =20
>  bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index f52bddc92a2a..c7639ffe7758 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -350,13 +350,119 @@ static void kvmppc_xive_get_eas_state(sPAPRXive *x=
ive, Error **errp)
>      }
>  }
> =20
> +/*
> + * Sync the XIVE controller through KVM to flush any in-flight event
> + * notification and stabilize the EQs.
> + */
> + static void kvmppc_xive_sync_all(sPAPRXive *xive, Error **errp)
> +{
> +    XiveSource *xsrc =3D &xive->source;
> +    Error *local_err =3D NULL;
> +    int i;
> +
> +    /* Sync the KVM source. This reaches the XIVE HW through OPAL */
> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +        XiveEAS *eas =3D &xive->eat[i];
> +
> +        if (!xive_eas_is_valid(eas)) {
> +            continue;
> +        }
> +
> +        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SYNC, i, NULL, true,
> +                          &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +}
> +
> +/*
> + * The primary goal of the XIVE VM change handler is to mark the EQ
> + * pages dirty when all XIVE event notifications have stopped.
> + *
> + * Whenever the VM is stopped, the VM change handler masks the sources
> + * (PQ=3D01) to stop the flow of events and saves the previous state in
> + * anticipation of a migration. The XIVE controller is then synced
> + * through KVM to flush any in-flight event notification and stabilize
> + * the EQs.
> + *
> + * At this stage, we can mark the EQ page dirty and let a migration
> + * sequence transfer the EQ pages to the destination, which is done
> + * just after the stop state.
> + *
> + * The previous configuration of the sources is restored when the VM
> + * runs again.
> + */
> +static void kvmppc_xive_change_state_handler(void *opaque, int running,
> +                                             RunState state)
> +{
> +    sPAPRXive *xive =3D opaque;
> +    XiveSource *xsrc =3D &xive->source;
> +    Error *local_err =3D NULL;
> +    int i;
> +
> +    /*
> +     * Restore the sources to their initial state. This is called when
> +     * the VM resumes after a stop or a migration.
> +     */
> +    if (running) {
> +        for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +            uint8_t pq =3D xive_source_esb_get(xsrc, i);
> +            if (xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8)) !=
=3D 0x1) {
> +                error_report("XIVE: IRQ %d has an invalid state", i);
> +            }
> +        }
> +
> +        return;
> +    }
> +
> +    /*
> +     * Mask the sources, to stop the flow of event notifications, and
> +     * save the PQs locally in the XiveSource object. The XiveSource
> +     * state will be collected later on by its vmstate handler if a
> +     * migration is in progress.
> +     */
> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_01);
> +        xive_source_esb_set(xsrc, i, pq);
> +    }
> +
> +    /*
> +     * Sync the XIVE controller in KVM, to flush in-flight event
> +     * notification that should be enqueued in the EQs.
> +     */
> +    kvmppc_xive_sync_all(xive, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return;
> +    }
> +
> +    /*
> +     * Mark the XIVE EQ pages dirty to collect all updates.
> +     */
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
> +                      KVM_DEV_XIVE_SAVE_EQ_PAGES, NULL, true, &local_err=
);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
> +}
> +
>  void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp)
>  {
>      XiveSource *xsrc =3D &xive->source;
>      CPUState *cs;
>      Error *local_err =3D NULL;
> =20
> -    kvmppc_xive_source_get_state(xsrc);
> +    /*
> +     * When the VM is stopped, the sources are masked and the previous
> +     * state is saved in anticipation of a migration. We should not
> +     * synchronize the source state in that case else we will override
> +     * the saved state.
> +     */
> +    if (runstate_is_running()) {
> +        kvmppc_xive_source_get_state(xsrc);
> +    }
> =20
>      kvmppc_xive_get_eas_state(xive, &local_err);
>      if (local_err) {
> @@ -468,6 +574,9 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **err=
p)
>                                        "xive.tima", tima_len, xive->tm_mm=
ap);
>      sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
> =20
> +    xive->change =3D qemu_add_vm_change_state_handler(
> +        kvmppc_xive_change_state_handler, xive);
> +
>      kvm_kernel_irqchip =3D true;
>      kvm_msi_via_irqfd_allowed =3D true;
>      kvm_gsi_direct_mapping =3D true;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1Wg5Vd7si6EhrIHA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxaS0IACgkQbDjKyiDZ
s5JU9w//X7Z4oa2f0zTdFpG/MfouZpDpLVvg2MH4LIyEvIFiYZU71utEuYzSL9Z2
CBIRCgHlBuFZBnmKQPAMUvJZpdCSGv7V6E6YtH3vNOlAuEQLvvoBwuW4TkLfn5Sc
+o6jAAQyjPxeP7ibBV7VKA0oKsVPGPotNqIyVTrWmUXO/m9ZPLPyCpUqTJyckQaU
pTCjXbYMUDQkaPK+aRV/UH/oo/WrNNqrhJJA8mM0ojTfvpQ+7lgB3zD7XkMOxrvw
kLTeV9rq1i23Cz5t9KVbLHd0/WoFrTWPERfAoGyroxADp/39avcZnzuTWbdTjX2p
360jGIVEvM5ErFxYZoxkr9ki4dpV9BxOJL+OHzXT0unfjwp5ZcTcyM160OdZ/RPw
akC8P0gdSifOCg8BzmVSIJer1TG7AxwpmbO9HJ3xTSVjGjy0JxeNtQIMo93b43G7
IRxal+wcHJQi0uIx8jcPxnUvoALzewhz0/1sBuVOzmMcdzm4QW/BMpM6dkAl6Fx1
iVML+Eych/pHXatNTYFnp6OKEFhZKkopJ7LIoSJSc4DRfAl8cBjrhmXvukK1tk+Z
xbL11mNO3LSULB2DF9e35ppDaKlnLHTtaFx3R8tV5ZxsTTGJq/H6HgCIL5/gmyvn
O62LsQM68e09IoXfGZ/fE0kD3UIXpBJixDkQTj+XLXi65OVKxkI=
=6K1t
-----END PGP SIGNATURE-----

--1Wg5Vd7si6EhrIHA--
