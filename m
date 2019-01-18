Received: from eggs.gnu.org ([209.51.188.92]:49440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkUMQ-0006xE-Fj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkUMP-0003LZ-6X
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:39:02 -0500
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:40821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gkUMN-0003AQ-3Q
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:39:00 -0500
Received: from player750.ha.ovh.net (unknown [10.109.143.201])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id CF69710D5B3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 14:38:55 +0100 (CET)
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774536496.1208625.12823909967079119637.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f132cca0-c163-6791-75e0-25783578263a@kaod.org>
Date: Fri, 18 Jan 2019 14:38:31 +0100
MIME-Version: 1.0
In-Reply-To: <154774536496.1208625.12823909967079119637.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/19] spapr_xive: Cache device tree
 nodename in sPAPRXive
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
> PHB hotplug will need to know the name of the XIVE controller node. Since
> it is an invariant for the machine lifetime, compute it at realize and
> store it under the sPAPRXive structure.
Could you please gather all these changes [15-17] in one patch. It would 
be easier to track. 

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/spapr_xive.c        |    9 ++++-----
>  include/hw/ppc/spapr_xive.h |    3 +++
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index e542ae59d7fd..9732c3d89c77 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -316,6 +316,9 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>      /* Map all regions */
>      spapr_xive_map_mmio(xive);
>  
> +    xive->nodename = g_strdup_printf("interrupt-controller@%" PRIx64,
> +                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_SHIFT));

I would use a helper routine instead.
 
>      qemu_register_reset(spapr_xive_reset, dev);
>  }
>  
> @@ -1436,7 +1439,6 @@ int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt)
>          cpu_to_be32(7),    /* start */
>          cpu_to_be32(0xf8), /* count */
>      };
> -    gchar *nodename;
>  
>      /*
>       * The "ibm,plat-res-int-priorities" property defines the priority
> @@ -1453,10 +1455,7 @@ int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt)
>                             XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
>      timas[3] = cpu_to_be64(1ull << TM_SHIFT);
>  
> -    nodename = g_strdup_printf("interrupt-controller@%" PRIx64,
> -                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_SHIFT));
> -    _FDT(node = fdt_add_subnode(fdt, 0, nodename));
> -    g_free(nodename);
> +    _FDT(node = fdt_add_subnode(fdt, 0, xive->nodename));

and use the helper routine here.

>      _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
>      _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 29dafead9ba0..deea34b03ee5 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -26,6 +26,9 @@ typedef struct sPAPRXive {
>      XiveENDSource end_source;
>      hwaddr        end_base;
>  
> +    /* DT */
> +    gchar *nodename;

I don't think this is needed. See other patches for why.

Thanks,

C.
 
>
>      /* Routing table */
>      XiveEAS       *eat;
>      uint32_t      nr_irqs;
> 
