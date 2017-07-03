Received: from eggs.gnu.org ([2001:4830:134:3::10]:59314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dS4ku-0004n5-RV
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dS4kr-0008T8-Ok
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:03:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dS4kr-0008SV-Fm
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:03:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v63Gx45Q038398
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 13:03:19 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bf27ba58r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:03:19 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 14:03:16 -0300
References: <149909367669.21100.17690903693542179077.stgit@bahia.lan>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 3 Jul 2017 14:03:07 -0300
MIME-Version: 1.0
In-Reply-To: <149909367669.21100.17690903693542179077.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <69bd5d32-3f59-b28a-38e8-25952fecee10@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: fix memory hotplug
 error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>



On 07/03/2017 11:54 AM, Greg Kurz wrote:
> QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
> Let's propagate the error instead, like it is done everywhere else
> where spapr_drc_attach() is called.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> Changes in v2: - added rollback code
> ---
>   hw/ppc/spapr.c |   26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 70b3fd374e2b..ba8f57a5a054 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>       int i, fdt_offset, fdt_size;
>       void *fdt;
>       uint64_t addr = addr_start;
> +    Error *local_err = NULL;
>
>       for (i = 0; i < nr_lmbs; i++) {
>           drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> @@ -2611,7 +2612,18 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>           fdt_offset = spapr_populate_memory_node(fdt, node, addr,
>                                                   SPAPR_MEMORY_BLOCK_SIZE);
>
> -        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
> +        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> +        if (local_err) {
> +            while (addr > addr_start) {
> +                addr -= SPAPR_MEMORY_BLOCK_SIZE;
> +                drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> +                                      addr / SPAPR_MEMORY_BLOCK_SIZE);
> +                spapr_drc_detach(drc, dev, NULL);

Question: why pass NULL instead of '&local_err' in detach() ? Can we 
ignore any
any error that happens in detach() because you're propagating the 
local_err set
in spapr_drc_attach() already?

ps: I am aware that ATM detach() does not propagate anything to the errp 
being
passed. I don't think it's wise to write new code based on this 
assumption though.


Thanks,


Daniel

> +            }
> +            g_free(fdt);
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>           addr += SPAPR_MEMORY_BLOCK_SIZE;
>       }
>       /* send hotplug notification to the
> @@ -2651,14 +2663,20 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       addr = object_property_get_uint(OBJECT(dimm),
>                                       PC_DIMM_ADDR_PROP, &local_err);
>       if (local_err) {
> -        pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
> -        goto out;
> +        goto out_unplug;
>       }
>
>       spapr_add_lmbs(dev, addr, size, node,
>                      spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> -                   &error_abort);
> +                   &local_err);
> +    if (local_err) {
> +        goto out_unplug;
> +    }
> +
> +    return;
>
> +out_unplug:
> +    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
>   out:
>       error_propagate(errp, local_err);
>   }
>
>
