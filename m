Received: from eggs.gnu.org ([209.51.188.92]:38307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud18-0001Qa-Um
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud17-0005i1-Kr
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:54:58 -0500
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:34427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gud16-0005Xs-Ru
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:54:57 -0500
Received: from player776.ha.ovh.net (unknown [10.109.143.24])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9FA4E50429
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:54:53 +0100 (CET)
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023080638.1011724.792095453419098948.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0d864751-5827-943b-a16b-0d4c4d8fb32a@kaod.org>
Date: Fri, 15 Feb 2019 13:54:48 +0100
MIME-Version: 1.0
In-Reply-To: <155023080638.1011724.792095453419098948.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/10] spapr/irq: Use the base ICP class
 for KVM
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
> The base ICP class knows how to interact with KVM. Adapt sPAPR to use i=
t
> instead of the ICP KVM class.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

ah. Good one !=20



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/spapr_irq.c     |    4 +---
>  include/hw/ppc/spapr.h |    1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 48d6b2daed6e..e6893df61e76 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -102,7 +102,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *=
spapr, int nr_irqs,
>      if (kvm_enabled()) {
>          if (machine_kernel_irqchip_allowed(machine) &&
>              !xics_kvm_init(spapr, &local_err)) {
> -            spapr->icp_type =3D TYPE_KVM_ICP;
>              spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_ir=
qs,
>                                            &local_err);
>          }
> @@ -117,7 +116,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *=
spapr, int nr_irqs,
> =20
>      if (!spapr->ics) {
>          xics_spapr_init(spapr);
> -        spapr->icp_type =3D TYPE_ICP;
>          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irq=
s,
>                                        &local_err);
>      }
> @@ -199,7 +197,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMac=
hineState *spapr,
>      Object *obj;
>      sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> =20
> -    obj =3D icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr=
),
> +    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, XICS_FABRIC(spapr),
>                       &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index cbd276ed2b6a..631fc5103b7b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -178,7 +178,6 @@ struct sPAPRMachineState {
>      /*< public >*/
>      char *kvm_type;
> =20
> -    const char *icp_type;
>      int32_t irq_map_nr;
>      unsigned long *irq_map;
>      sPAPRXive  *xive;
>=20
