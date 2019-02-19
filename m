Received: from eggs.gnu.org ([209.51.188.92]:45460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gw9ak-00023k-Uo
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gw9aj-0002YV-Pu
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:54:02 -0500
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:55632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gw9aj-0002Pi-Jj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:54:01 -0500
Received: from player772.ha.ovh.net (unknown [10.109.146.163])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id D4441156A39
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 18:53:46 +0100 (CET)
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059668360.1466090.5969630516627776426.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2e74d919-70b6-635c-7703-281ecf76e17b@kaod.org>
Date: Tue, 19 Feb 2019 18:53:28 +0100
MIME-Version: 1.0
In-Reply-To: <155059668360.1466090.5969630516627776426.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On 2/19/19 6:18 PM, Greg Kurz wrote:
> The pseries machine only uses LSIs to support legacy PCI devices. Every
> PHB claims 4 LSIs at realize time. When using in-kernel XICS (or upcomi=
ng
> in-kernel XIVE), QEMU synchronizes the state of all irqs, including the=
se
> LSIs, later on at machine reset.
>=20
> In order to support PHB hotplug, we need a way to tell KVM about the LS=
Is
> that doesn't require a machine reset. An easy way to do that is to alwa=
ys
> inform KVM when an interrupt is claimed, which really isn't a performan=
ce
> path.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/xics.c        |    4 +++
>  hw/intc/xics_kvm.c    |   74 ++++++++++++++++++++++++++++-------------=
--------
>  include/hw/ppc/xics.h |    1 +
>  3 files changed, 48 insertions(+), 31 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 767fdeb82900..af7dc709abab 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -758,6 +758,10 @@ void ics_set_irq_type(ICSState *ics, int srcno, bo=
ol lsi)
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
> -        state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_=
MASK)
> -            << KVM_XICS_PRIORITY_SHIFT;
> -        if (irq->priority !=3D irq->saved_priority) {
> -            assert(irq->priority =3D=3D 0xff);
> -            state |=3D KVM_XICS_MASKED;
> -        }
> +    state =3D irq->server;
> +    state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK=
)
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
> +    ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES=
,
> +                            srcno + ics->offset, &state, true, &local_=
err);
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
> -        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOU=
RCES,
> -                                i + ics->offset, &state, true, &local_=
err);
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
