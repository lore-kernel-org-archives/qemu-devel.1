Received: from eggs.gnu.org ([209.51.188.92]:40230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud8o-0006ZX-A7
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud8n-0005hc-Ek
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:02:54 -0500
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:34701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gud8n-0005f9-8y
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:02:53 -0500
Received: from player687.ha.ovh.net (unknown [10.109.146.106])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B89B81D686A
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 14:02:50 +0100 (CET)
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023084177.1011724.14693955932559990358.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d45ce305-40e5-6bbc-4622-ff2fc2ddb25b@kaod.org>
Date: Fri, 15 Feb 2019 14:02:45 +0100
MIME-Version: 1.0
In-Reply-To: <155023084177.1011724.14693955932559990358.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] xics: Drop the KVM ICS class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 2/15/19 12:40 PM, Greg Kurz wrote:
> The KVM ICS class isn't used anymore. Drop it.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics_kvm.c    |   40 ----------------------------------------
>  hw/ppc/spapr_irq.c    |    2 +-
>  include/hw/ppc/xics.h |    3 ---
>  3 files changed, 1 insertion(+), 44 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index f34eacda03e7..a00d0a7962e1 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -279,39 +279,6 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int=
 val)
>      }
>  }
> =20
> -static void ics_kvm_realize(DeviceState *dev, Error **errp)
> -{
> -    ICSState *ics =3D ICS_KVM(dev);
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
> -    Error *local_err =3D NULL;
> -
> -    icsc->parent_realize(dev, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -}
> -
> -static void ics_kvm_class_init(ObjectClass *klass, void *data)
> -{
> -    ICSStateClass *icsc =3D ICS_BASE_CLASS(klass);
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -
> -    device_class_set_parent_realize(dc, ics_kvm_realize,
> -                                    &icsc->parent_realize);
> -}
> -
> -static const TypeInfo ics_kvm_info =3D {
> -    .name =3D TYPE_ICS_KVM,
> -    .parent =3D TYPE_ICS_BASE,
> -    .instance_size =3D sizeof(ICSState),
> -    .class_init =3D ics_kvm_class_init,
> -};
> -
> -/*
> - * XICS-KVM
> - */
> -
>  static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                         uint32_t token,
>                         uint32_t nargs, target_ulong args,
> @@ -381,10 +348,3 @@ fail:
>      kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
>      return -1;
>  }
> -
> -static void xics_kvm_register_types(void)
> -{
> -    type_register_static(&ics_kvm_info);
> -}
> -
> -type_init(xics_kvm_register_types)
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 4aa8165307c7..4297eed600f9 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -208,7 +208,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMac=
hineState *spapr,
> =20
>  static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int vers=
ion_id)
>  {
> -    if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
> +    if (!kvm_irqchip_in_kernel()) {
>          CPUState *cs;
>          CPU_FOREACH(cs) {
>              PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 61bd0fb9784f..d36bbe11ee2e 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -95,9 +95,6 @@ struct PnvICPState {
>  #define TYPE_ICS_SIMPLE "ics"
>  #define ICS_SIMPLE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SIMPLE)
> =20
> -#define TYPE_ICS_KVM "icskvm"
> -#define ICS_KVM(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_KVM)
> -
>  #define ICS_BASE_CLASS(klass) \
>       OBJECT_CLASS_CHECK(ICSStateClass, (klass), TYPE_ICS_BASE)
>  #define ICS_BASE_GET_CLASS(obj) \
>=20
