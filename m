Received: from eggs.gnu.org ([209.51.188.92]:51345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkUSJ-0004ni-3t
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkUSH-0008Hi-L7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:45:07 -0500
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:37161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gkUSH-0008Bp-7u
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:45:05 -0500
Received: from player759.ha.ovh.net (unknown [10.109.143.216])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id C699C10D66E
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 14:45:00 +0100 (CET)
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774537154.1208625.5549578310287539996.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ec1fc62d-6037-2b2c-5de1-969da276be98@kaod.org>
Date: Fri, 18 Jan 2019 14:44:40 +0100
MIME-Version: 1.0
In-Reply-To: <154774537154.1208625.5549578310287539996.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 16/19] spapr: Expose the name of the
 interrupt controller node
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
> This will be needed by PHB hotplug in order to access the "phandle"
> property of the interrupt controller node.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics_spapr.c        |    2 +-
>  include/hw/ppc/spapr_xive.h |    5 +++++
>  include/hw/ppc/xics_spapr.h |    7 +++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 375cb883c86d..ec50e21b8607 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -252,7 +252,7 @@ int spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt)
>      };
>      int node;
>  
> -    _FDT(node = fdt_add_subnode(fdt, 0, "interrupt-controller"));
> +    _FDT(node = fdt_add_subnode(fdt, 0, XICS_NODENAME));
>  
>      _FDT(fdt_setprop_string(fdt, node, "device_type",
>                              "PowerPC-External-Interrupt-Presentation"));
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index deea34b03ee5..e769c2f9a018 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -51,4 +51,9 @@ int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt);
>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
>  
> +static inline const char *spapr_xive_get_nodename(sPAPRXive *xive)
> +{
> +    return xive->nodename;
> +}

There I would compute the nodename here in a static char * and return it. 

>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 9f51f8621f75..fd66cf7bbba3 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -29,6 +29,13 @@
>  
>  #include "hw/ppc/spapr.h"
>  
> +#define XICS_NODENAME "interrupt-controller"
> +
> +static inline const char *xics_spapr_get_nodename(void)
> +{
> +    return XICS_NODENAME;
> +}

I don't see much point in that helper. 

>  int spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt);
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
>  void xics_spapr_init(sPAPRMachineState *spapr);
> 
