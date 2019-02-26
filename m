Received: from eggs.gnu.org ([209.51.188.92]:41577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFc-00075i-JU
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFb-0006rl-9X
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:48 -0500
Date: Tue, 26 Feb 2019 11:39:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226003935.GE6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline
In-Reply-To: <20190222131322.26079-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 05/13] spapr/xive: introduce a VM state
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:13:14PM +0100, C=E9dric Le Goater wrote:
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr_xive.h |  1 +
>  hw/intc/spapr_xive_kvm.c    | 77 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index ebd65e7fe36b..298d204d54ef 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -42,6 +42,7 @@ typedef struct sPAPRXive {
>      /* KVM support */
>      int           fd;
>      void          *tm_mmap;
> +    VMChangeStateEntry *change;
>  } sPAPRXive;
> =20
>  /*
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 4b1ffb9835f9..44d80175b1b5 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -419,9 +419,81 @@ static void kvmppc_xive_get_queues(sPAPRXive *xive, =
Error **errp)
>      }
>  }
> =20
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
> +     * notification that should be enqueued in the EQs and mark the
> +     * XIVE EQ pages dirty to collect all updates.
> +     */
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
> +                      KVM_DEV_XIVE_EQ_SYNC, NULL, true, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return;
> +    }
> +}
> +
>  void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp)
>  {
> -    kvmppc_xive_source_get_state(&xive->source);
> +    /*
> +     * When the VM is stopped, the sources are masked and the previous
> +     * state is saved in anticipation of a migration. We should not
> +     * synchronize the source state in that case else we will override
> +     * the saved state.
> +     */
> +    if (runstate_is_running()) {
> +        kvmppc_xive_source_get_state(&xive->source);
> +    }
> =20
>      /* EAT: there is no extra state to query from KVM */
> =20
> @@ -501,6 +573,9 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **err=
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

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0isUACgkQbDjKyiDZ
s5KfZQ//a3EAt3b5KSlMMnJzt8NWqBNq9lYlxNP1S22eGBNJ4/G7Mf1tgAueVFeS
OYdFHwS0h8X1dE3lotcDA9T5T1oK1vxk1iW4U8StXD36008Q3dhYFPiCZFewNQUR
q4k8+N/jfGA9SYzh67/CLv1XNsIUvfO9boBz2CiQ29P2Oq2LXeyYfIyB4iR7VNHI
2vV7fD5UPBjS11X3MOh4Gj9DoFOItWB/IKSK5Dmrd8dlAZU1WIcNZ9Qd2Zcvrxzt
QENaKVohc3cO9I1VzHNVcG1Dd4NHKZTMHxelFqFRqRI0Cece3hgt/0X7awCQMTAq
aCc72U53Peoxa9mZh75cgUxcYLST9FKlYcreafJ9oqpHxXtbPzbsF2vrhIx52vr8
J1bQZZ9BsB6mMqj/7n/W7N94MtUZufEYYhjLAd5NJw60Ee95qJz5Mbnb+I+rYxFl
rNmgmVR11/+eM+mr6sqvXICSmjANUcOSilz0eaDneyaAaKwEQQjXOh1upZP2G8WW
L/bkEDafROP1BULKu+t1Jrk2RdDH+S4xKN9sFlsDUYAVUUkdp14yjHCL3KdiVIjc
Ag1uI25e+kiMm71WHdvdUdDUwTR3hBb7rSj1Qia46LP1bfaO12QsNPIRq8NSaPlV
ozGh5I8vGGenzVhGm99qYYkEoH+VEKK7k/6pmourBpKFGiYjuMI=
=XRhI
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
