Received: from eggs.gnu.org ([209.51.188.92]:52010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkUUN-0007U3-1z
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkUUL-000259-3l
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:47:14 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:50737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gkUUE-0001nU-7T
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:47:09 -0500
Received: from player714.ha.ovh.net (unknown [10.109.146.19])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2743F17B37F
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 14:47:02 +0100 (CET)
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774537811.1208625.5130988447516010112.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <93efc5e4-26e2-b917-dbe5-0ae819b376d9@kaod.org>
Date: Fri, 18 Jan 2019 14:46:42 +0100
MIME-Version: 1.0
In-Reply-To: <154774537811.1208625.5130988447516010112.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 17/19] spapr_irq: Expose the phandle of
 the interrupt controller
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

On 1/17/19 6:16 PM, Greg Kurz wrote:
> This will be used by PHB hotplug in order to create the "interrupt-map"
> property of the PHB node.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_irq.c         |   44 +++++++++++++++++++++++++++++++++++++++++++-
>  include/hw/ppc/spapr_irq.h |    3 +++
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index b3e0713428ed..93243cfd0644 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -243,6 +243,11 @@ static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
>      /* TODO: create the KVM XICS device */
>  }
>  
> +static const char *spapr_irq_get_nodename_xics(sPAPRMachineState *spapr)
> +{
> +    return xics_spapr_get_nodename();

can't we just return XICS_NODENAME ?

> +}
> +
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> @@ -263,6 +268,7 @@ sPAPRIrq spapr_irq_xics = {
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
>      .set_irq     = spapr_irq_set_irq_xics,
> +    .get_nodename = spapr_irq_get_nodename_xics,
>  };
>  
>  /*
> @@ -401,6 +407,11 @@ static void spapr_irq_set_irq_xive(void *opaque, int srcno, int val)
>      xive_source_set_irq(&spapr->xive->source, srcno, val);
>  }
>  
> +static const char *spapr_irq_get_nodename_xive(sPAPRMachineState *spapr)
> +{
> +    return spapr_xive_get_nodename(spapr->xive);
> +}
> +
>  /*
>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>   * with XICS.
> @@ -425,6 +436,7 @@ sPAPRIrq spapr_irq_xive = {
>      .post_load   = spapr_irq_post_load_xive,
>      .reset       = spapr_irq_reset_xive,
>      .set_irq     = spapr_irq_set_irq_xive,
> +    .get_nodename = spapr_irq_get_nodename_xive,
>  };
>  
>  /*
> @@ -588,6 +600,11 @@ static void spapr_irq_set_irq_dual(void *opaque, int srcno, int val)
>      spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
>  }
>  
> +static const char *spapr_irq_get_nodename_dual(sPAPRMachineState *spapr)
> +{
> +    return spapr_irq_current(spapr)->get_nodename(spapr);
> +}
> +
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -609,7 +626,8 @@ sPAPRIrq spapr_irq_dual = {
>      .cpu_intc_create = spapr_irq_cpu_intc_create_dual,
>      .post_load   = spapr_irq_post_load_dual,
>      .reset       = spapr_irq_reset_dual,
> -    .set_irq     = spapr_irq_set_irq_dual
> +    .set_irq     = spapr_irq_set_irq_dual,
> +    .get_nodename = spapr_irq_get_nodename_dual,
>  };
>  
>  /*
> @@ -680,6 +698,29 @@ void spapr_irq_dt_populate(sPAPRMachineState *spapr, uint32_t nr_servers,
>      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
>  }
>  
> +uint32_t spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
> +                               Error **errp)
> +{
> +    const char *nodename = spapr->irq->get_nodename(spapr);
> +    int phandle, offset;
> +
> +    offset = fdt_subnode_offset(fdt, 0, nodename);

if I am correct, you changed dt_populate() to return the same offset.

> +    if (offset < 0) {
> +        error_setg(errp, "Can't find node \"%s\": %s", nodename,
> +                   fdt_strerror(offset));
> +        return -1;
> +    }
> +
> +    phandle = fdt_get_phandle(fdt, offset);

if we stored the phandle when spapr_irq_dt_populate() is called, I think
things would be easier. May be under the backend ? 

C.


> +    if (phandle < 0) {
> +        error_setg(errp, "Can't get phandle of node \"%s\": %s",
> +                   nodename, fdt_strerror(phandle));
> +        return -1;
> +    }
> +
> +    return phandle;
> +}
> +
>  /*
>   * XICS legacy routines - to deprecate one day
>   */
> @@ -752,4 +793,5 @@ sPAPRIrq spapr_irq_xics_legacy = {
>      .cpu_intc_create = spapr_irq_cpu_intc_create_xics,
>      .post_load   = spapr_irq_post_load_xics,
>      .set_irq     = spapr_irq_set_irq_xics,
> +    .get_nodename = spapr_irq_get_nodename_xics,
>  };
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index dfed6b7e9976..d44d659231a6 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -48,6 +48,7 @@ typedef struct sPAPRIrq {
>      int (*post_load)(sPAPRMachineState *spapr, int version_id);
>      void (*reset)(sPAPRMachineState *spapr, Error **errp);
>      void (*set_irq)(void *opaque, int srcno, int val);
> +    const char *(*get_nodename)(sPAPRMachineState *spapr);
>  } sPAPRIrq;
>  
>  extern sPAPRIrq spapr_irq_xics;
> @@ -65,6 +66,8 @@ int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
>  void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
>  void spapr_irq_dt_populate(sPAPRMachineState *spapr, uint32_t nr_servers,
>                             void *fdt, uint32_t phandle);
> +uint32_t spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
> +                               Error **errp);
>  
>  /*
>   * XICS legacy routines
> 
