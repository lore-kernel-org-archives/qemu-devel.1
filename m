Received: from eggs.gnu.org ([209.51.188.92]:53830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbF-0005NO-FK
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbE-0003Tv-0B
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:09 -0500
Date: Wed, 20 Feb 2019 14:24:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220032428.GF9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059668360.1466090.5969630516627776426.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qpqR4wE1CEr+Roqx"
Content-Disposition: inline
In-Reply-To: <155059668360.1466090.5969630516627776426.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 06/17] xics: Write source state to KVM
 at claim time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--qpqR4wE1CEr+Roqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 06:18:03PM +0100, Greg Kurz wrote:
> The pseries machine only uses LSIs to support legacy PCI devices. Every
> PHB claims 4 LSIs at realize time. When using in-kernel XICS (or upcoming
> in-kernel XIVE), QEMU synchronizes the state of all irqs, including these
> LSIs, later on at machine reset.
>=20
> In order to support PHB hotplug, we need a way to tell KVM about the LSIs
> that doesn't require a machine reset. An easy way to do that is to always
> inform KVM when an interrupt is claimed, which really isn't a performance
> path.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics.c        |    4 +++
>  hw/intc/xics_kvm.c    |   74 ++++++++++++++++++++++++++++---------------=
------
>  include/hw/ppc/xics.h |    1 +
>  3 files changed, 48 insertions(+), 31 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 767fdeb82900..af7dc709abab 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -758,6 +758,10 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool=
 lsi)
> =20
>      ics->irqs[srcno].flags |=3D
>          lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        ics_set_kvm_state_one(ics, srcno);
> +    }
>  }
> =20
>  static void xics_register_types(void)
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index a00d0a7962e1..c6e1b630a404 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -213,45 +213,57 @@ void ics_synchronize_state(ICSState *ics)
>      ics_get_kvm_state(ics);
>  }
> =20
> -int ics_set_kvm_state(ICSState *ics)
> +int ics_set_kvm_state_one(ICSState *ics, int srcno)
>  {
>      uint64_t state;
> -    int i;
>      Error *local_err =3D NULL;
> +    ICSIRQState *irq =3D &ics->irqs[srcno];
> +    int ret;
> =20
> -    for (i =3D 0; i < ics->nr_irqs; i++) {
> -        ICSIRQState *irq =3D &ics->irqs[i];
> -        int ret;
> -
> -        state =3D irq->server;
> -        state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MA=
SK)
> -            << KVM_XICS_PRIORITY_SHIFT;
> -        if (irq->priority !=3D irq->saved_priority) {
> -            assert(irq->priority =3D=3D 0xff);
> -            state |=3D KVM_XICS_MASKED;
> -        }
> +    state =3D irq->server;
> +    state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
> +        << KVM_XICS_PRIORITY_SHIFT;
> +    if (irq->priority !=3D irq->saved_priority) {
> +        assert(irq->priority =3D=3D 0xff);
> +        state |=3D KVM_XICS_MASKED;
> +    }
> =20
> -        if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
> -            state |=3D KVM_XICS_LEVEL_SENSITIVE;
> -            if (irq->status & XICS_STATUS_ASSERTED) {
> -                state |=3D KVM_XICS_PENDING;
> -            }
> -        } else {
> -            if (irq->status & XICS_STATUS_MASKED_PENDING) {
> -                state |=3D KVM_XICS_PENDING;
> -            }
> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
> +        state |=3D KVM_XICS_LEVEL_SENSITIVE;
> +        if (irq->status & XICS_STATUS_ASSERTED) {
> +            state |=3D KVM_XICS_PENDING;
>          }
> -        if (irq->status & XICS_STATUS_PRESENTED) {
> -                state |=3D KVM_XICS_PRESENTED;
> -        }
> -        if (irq->status & XICS_STATUS_QUEUED) {
> -                state |=3D KVM_XICS_QUEUED;
> +    } else {
> +        if (irq->status & XICS_STATUS_MASKED_PENDING) {
> +            state |=3D KVM_XICS_PENDING;
>          }
> +    }
> +    if (irq->status & XICS_STATUS_PRESENTED) {
> +        state |=3D KVM_XICS_PRESENTED;
> +    }
> +    if (irq->status & XICS_STATUS_QUEUED) {
> +        state |=3D KVM_XICS_QUEUED;
> +    }
> +
> +    ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> +                            srcno + ics->offset, &state, true, &local_er=
r);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +int ics_set_kvm_state(ICSState *ics)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ics->nr_irqs; i++) {
> +        int ret;
> =20
> -        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURC=
ES,
> -                                i + ics->offset, &state, true, &local_er=
r);
> -        if (local_err) {
> -            error_report_err(local_err);
> +        ret =3D ics_set_kvm_state_one(ics, i);
> +        if (ret) {
>              return ret;
>          }
>      }
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index d36bbe11ee2e..eb65ad7e43b7 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -195,6 +195,7 @@ void icp_synchronize_state(ICPState *icp);
>  void icp_kvm_realize(DeviceState *dev, Error **errp);
> =20
>  void ics_get_kvm_state(ICSState *ics);
> +int ics_set_kvm_state_one(ICSState *ics, int srcno);
>  int ics_set_kvm_state(ICSState *ics);
>  void ics_synchronize_state(ICSState *ics);
>  void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qpqR4wE1CEr+Roqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsyGsACgkQbDjKyiDZ
s5L+EQ/+M37/nbZEbkLhsb4qH3QBCboCdJ3m0cnSvzp9op1mbs2YI0xMlvUbLowi
BFiW+TDXsrJoc40qaiLBGFpDFobEWsDi3VymdHppHpbNtldq294/616eTNNLS820
EMQzwK2vLMgffIiUpizK49++zf6ReBzL3+eawP1RlONQabNdBtys6MstirQHhL8j
3JgXiJkxfbENEy5OeWdKRLKYuPAajiVr2p8eWWO6LyPyGrXa5VoasGqttM0LeEzg
enCl388u5cwcYN40IVIF7Yxfp/fAWelGSjEF/WrEgM8UcxN3wPgcebGCBpxjNkvc
047HXsAVcCg1LkdVgaP8cazrBnlZWp7l/wPStk5iA3gcHga5/jVyoPW2SHbdcBSG
2MC7yQ0fs6CXC98ChtVPMvNSbxBxjbOjcnsnFh26uQ3tOAGtFKVC/P6Lhnh8ipOC
gjdXlOtJ+LTUbL02rUVINkys1tG3GN1j4JpuAlwHCrGqwg2sKoN+EbIhjEg4e7By
6Gsimm1Vc8AfLXhExgYC+2xniEyy/TKPy8Z6uYp7L0HrtWTkU9sL/FGJEToggksp
yR2j+EEfBd76VpcDYfhxjW83qXVAshY5JpGQp4HbSE6nRWmUMjGOncagAIw9bf0u
O8QSYAA+6dECv1vjz4vpyfvmwWI63nlIAFQwG33WgL7oIoq0qMQ=
=hcMK
-----END PGP SIGNATURE-----

--qpqR4wE1CEr+Roqx--
