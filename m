Received: from eggs.gnu.org ([2001:4830:134:3::10]:33433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEWy0-0005Ac-2s
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEWxv-0002Os-65
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:53:12 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:41256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eEWxu-0002N8-Vi
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:53:07 -0500
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 009A4C7CEB
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 09:53:04 +0100 (CET)
Date: Tue, 14 Nov 2017 09:52:58 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171114095258.3833d1bf@bahia.lan>
In-Reply-To: <20171110152017.24324-4-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 03/11] spapr: introduce new
 XICSFabric operations for an IRQ allocator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 10 Nov 2017 15:20:09 +0000
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Currently, the ICSState 'ics' object of the sPAPR machine acts as the
> global interrupt source handler and also as the IRQ number allocator
> for the machine. Some IRQ numbers are allocated very early in the
> machine initialization sequence to populate the device tree, and this
> is a problem to introduce the new POWER XIVE interrupt model, as it
> needs to share the IRQ numbers with the older model.
>=20
> To prepare ground for XIVE, here is a set of new XICSFabric operations
> to let the machine handle directly the IRQ number allocation and to
> decorrelate the allocation from the interrupt source object :
>=20
>     bool (*irq_test)(XICSFabric *xi, int irq);
>     int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
>     void (*irq_free_block)(XICSFabric *xi, int irq, int num);
>=20
> In these prototypes, the 'irq' parameter refers to a number in the
> global IRQ number space. Indexes for arrays storing different state
> informations on the interrupts, like the ICSIRQState, are usually
> named 'srcno'.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c        | 19 +++++++++++++++++++
>  include/hw/ppc/xics.h |  4 ++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a2dcbee07214..84d68f2fdbae 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3536,6 +3536,21 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int=
 vcpu_id)
>      return cpu ? ICP(cpu->intc) : NULL;
>  }
> =20
> +static bool spapr_irq_test(XICSFabric *xi, int irq)
> +{
> +    return false;
> +}
> +
> +static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
> +{
> +    return -1;
> +}
> +
> +static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
> +{
> +    ;
> +}
> +
>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>                                   Monitor *mon)
>  {
> @@ -3630,6 +3645,10 @@ static void spapr_machine_class_init(ObjectClass *=
oc, void *data)
>      xic->ics_get =3D spapr_ics_get;
>      xic->ics_resend =3D spapr_ics_resend;
>      xic->icp_get =3D spapr_icp_get;
> +    xic->irq_test =3D spapr_irq_test;
> +    xic->irq_alloc_block =3D spapr_irq_alloc_block;
> +    xic->irq_free_block =3D spapr_irq_free_block;
> +
>      ispc->print_info =3D spapr_pic_print_info;
>      /* Force NUMA node memory size to be a multiple of
>       * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 28d248abad61..30e7f2e0a7dd 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -175,6 +175,10 @@ typedef struct XICSFabricClass {
>      ICSState *(*ics_get)(XICSFabric *xi, int irq);
>      void (*ics_resend)(XICSFabric *xi);
>      ICPState *(*icp_get)(XICSFabric *xi, int server);
> +    /* IRQ allocator helpers */
> +    bool (*irq_test)(XICSFabric *xi, int irq);
> +    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
> +    void (*irq_free_block)(XICSFabric *xi, int irq, int num);
>  } XICSFabricClass;
> =20
>  #define XICS_IRQS_SPAPR               1024
