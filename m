Received: from eggs.gnu.org ([2001:4830:134:3::10]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fzdRc-00056k-AI
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fzdRY-0007AW-V9
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:50:44 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:58613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fzdRY-00079I-OY
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:50:40 -0400
Received: from player737.ha.ovh.net (unknown [10.109.160.54])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 398CF15CBA6
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 09:50:39 +0200 (CEST)
Date: Tue, 11 Sep 2018 09:50:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180911095030.09f24ee4@bahia.lan>
In-Reply-To: <20180911055503.2303-3-clg@kaod.org>
References: <20180911055503.2303-1-clg@kaod.org>
	<20180911055503.2303-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr: increase the size of the IRQ
 number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 11 Sep 2018 07:55:03 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The new layout using static IRQ number does not leave much space to
> the dynamic MSI range, only 0x100 IRQ numbers. Increase the total
> number of IRQS for newer machines and introduce a legacy XICS backend
> for pre-3.1 machines to maintain compatibility.
>=20
> For the old backend, provide a 'nr_msis' value covering the full IRQ
> number space as it does not use the bitmap allocator to allocate MSI
> interrupt numbers.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/spapr_irq.h |  1 +
>  hw/ppc/spapr.c             |  1 +
>  hw/ppc/spapr_irq.c         | 15 ++++++++++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 650f810ad2aa..a467ce696ee4 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -41,6 +41,7 @@ typedef struct sPAPRIrq {
>  } sPAPRIrq;
> =20
>  extern sPAPRIrq spapr_irq_xics;
> +extern sPAPRIrq spapr_irq_xics_legacy;
> =20
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4a9dd4d9bc14..eba7d60a30a7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3971,6 +3971,7 @@ static void spapr_machine_3_0_class_options(Machine=
Class *mc)
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_0);
> =20
>      smc->legacy_irq_allocation =3D true;
> +    smc->irq =3D &spapr_irq_xics_legacy;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index fe8be5f5217a..e77b94cc685e 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -195,7 +195,7 @@ static void spapr_irq_print_info_xics(sPAPRMachineSta=
te *spapr, Monitor *mon)
>      ics_pic_print_info(spapr->ics, mon);
>  }
> =20
> -#define SPAPR_IRQ_XICS_NR_IRQS     0x400
> +#define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> =20
> @@ -289,3 +289,16 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num=
, bool align, Error **errp)
> =20
>      return first + ics->offset;
>  }
> +
> +#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
> +
> +sPAPRIrq spapr_irq_xics_legacy =3D {
> +    .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> +    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> +
> +    .init        =3D spapr_irq_init_xics,
> +    .claim       =3D spapr_irq_claim_xics,
> +    .free        =3D spapr_irq_free_xics,
> +    .qirq        =3D spapr_qirq_xics,
> +    .print_info  =3D spapr_irq_print_info_xics,
> +};
