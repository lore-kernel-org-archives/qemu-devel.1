Received: from eggs.gnu.org ([209.51.188.92]:43154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gteLk-0000ZR-NZ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gteLj-0007OC-4h
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:08:12 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:37042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gteLi-0007IH-8n
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:08:10 -0500
Received: from player795.ha.ovh.net (unknown [10.109.160.143])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 97FC4EE2EB
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:08:06 +0100 (CET)
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999583999.690774.9854440646408554397.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <66446de7-ea20-4b55-8d99-04b27e26d789@kaod.org>
Date: Tue, 12 Feb 2019 21:07:41 +0100
MIME-Version: 1.0
In-Reply-To: <154999583999.690774.9854440646408554397.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/15] spapr_irq: Add an @xics_offset
 field to sPAPRIrq
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

On 2/12/19 7:24 PM, Greg Kurz wrote:
> Only pseries machines, either recent ones started with ic-mode=3Dxics
> or older ones using the legacy irq allocation scheme, need to set the
> @offset of the ICS to XICS_IRQ_BASE. Recent pseries started with
> ic-mode=3Ddual set it to 0 and powernv machines set it to some other
> value at runtime.
>=20
> It thus doesn't really help to set the default value of the ICS offset
> to XICS_IRQ_BASE in ics_base_instance_init().
>=20
> Drop that code from XICS and let the pseries code set the offset
> explicitely for clarity.

Looks OK to me. I would have call it 'offset' and not 'xics_offset'=20
though, because we might want to create an sPAPR IRQ XIVE device with
some offset one day. There is still some work to be done before that
is possible. Anyhow,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics.c             |    8 --------
>  hw/ppc/spapr_irq.c         |   33 ++++++++++++++++++++-------------
>  include/hw/ppc/spapr_irq.h |    1 +
>  3 files changed, 21 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 16e8ffa2aaf7..7cac138067e2 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -638,13 +638,6 @@ static void ics_base_realize(DeviceState *dev, Err=
or **errp)
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>  }
> =20
> -static void ics_base_instance_init(Object *obj)
> -{
> -    ICSState *ics =3D ICS_BASE(obj);
> -
> -    ics->offset =3D XICS_IRQ_BASE;
> -}
> -
>  static int ics_base_dispatch_pre_save(void *opaque)
>  {
>      ICSState *ics =3D opaque;
> @@ -720,7 +713,6 @@ static const TypeInfo ics_base_info =3D {
>      .parent =3D TYPE_DEVICE,
>      .abstract =3D true,
>      .instance_size =3D sizeof(ICSState),
> -    .instance_init =3D ics_base_instance_init,
>      .class_init =3D ics_base_class_init,
>      .class_size =3D sizeof(ICSStateClass),
>  };
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 80b0083b8e38..8217e0215411 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -68,10 +68,11 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr)
> =20
>  static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
>                                    const char *type_ics,
> -                                  int nr_irqs, Error **errp)
> +                                  int nr_irqs, int offset, Error **err=
p)
>  {
>      Error *local_err =3D NULL;
>      Object *obj;
> +    ICSState *ics;
> =20
>      obj =3D object_new(type_ics);
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort)=
;
> @@ -86,7 +87,10 @@ static ICSState *spapr_ics_create(sPAPRMachineState =
*spapr,
>          goto error;
>      }
> =20
> -    return ICS_BASE(obj);
> +    ics =3D ICS_BASE(obj);
> +    ics->offset =3D offset;
> +
> +    return ics;
> =20
>  error:
>      error_propagate(errp, local_err);
> @@ -104,6 +108,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *=
spapr, Error **errp)
>              !xics_kvm_init(spapr, &local_err)) {
>              spapr->icp_type =3D TYPE_KVM_ICP;
>              spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_ir=
qs,
> +                                          spapr->irq->xics_offset,
>                                            &local_err);
>          }
>          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> @@ -119,6 +124,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *=
spapr, Error **errp)
>          xics_spapr_init(spapr);
>          spapr->icp_type =3D TYPE_ICP;
>          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irq=
s,
> +                                      spapr->irq->xics_offset,
>                                        &local_err);
>      }
> =20
> @@ -246,6 +252,7 @@ sPAPRIrq spapr_irq_xics =3D {
>      .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
>      .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
>      .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
> +    .xics_offset =3D XICS_IRQ_BASE,
> =20
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
> @@ -451,17 +458,6 @@ static void spapr_irq_init_dual(sPAPRMachineState =
*spapr, Error **errp)
>          return;
>      }
> =20
> -    /*
> -     * Align the XICS and the XIVE IRQ number space under QEMU.
> -     *
> -     * However, the XICS KVM device still considers that the IRQ
> -     * numbers should start at XICS_IRQ_BASE (0x1000). Either we
> -     * should introduce a KVM device ioctl to set the offset or ignore
> -     * the lower 4K numbers when using the get/set ioctl of the XICS
> -     * KVM device. The second option seems the least intrusive.
> -     */
> -    spapr->ics->offset =3D 0;
> -
>      spapr_irq_xive.init(spapr, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -582,6 +578,16 @@ sPAPRIrq spapr_irq_dual =3D {
>      .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
>      .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
>      .ov5         =3D SPAPR_OV5_XIVE_BOTH,
> +    /*
> +     * Align the XICS and the XIVE IRQ number space under QEMU.
> +     *
> +     * However, the XICS KVM device still considers that the IRQ
> +     * numbers should start at XICS_IRQ_BASE (0x1000). Either we
> +     * should introduce a KVM device ioctl to set the offset or ignore
> +     * the lower 4K numbers when using the get/set ioctl of the XICS
> +     * KVM device. The second option seems the least intrusive.
> +     */
> +    .xics_offset =3D 0,
> =20
>      .init        =3D spapr_irq_init_dual,
>      .claim       =3D spapr_irq_claim_dual,
> @@ -712,6 +718,7 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
>      .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
>      .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
>      .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
> +    .xics_offset =3D XICS_IRQ_BASE,
> =20
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 14b02c3aca33..5e30858dc22a 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -34,6 +34,7 @@ typedef struct sPAPRIrq {
>      uint32_t    nr_irqs;
>      uint32_t    nr_msis;
>      uint8_t     ov5;
> +    uint32_t    xics_offset;
> =20
>      void (*init)(sPAPRMachineState *spapr, Error **errp);
>      int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **=
errp);
>=20
