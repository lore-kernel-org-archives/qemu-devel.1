Received: from eggs.gnu.org ([2001:4830:134:3::10]:34567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fcn9j-00076f-Su
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fcn9e-0008T3-Ld
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:33:51 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:56059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fcn9e-0008R4-Es
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:33:46 -0400
Received: from player750.ha.ovh.net (unknown [10.109.122.43])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B5D6B1EC2A
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 09:33:37 +0200 (CEST)
Date: Tue, 10 Jul 2018 09:33:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180710093330.3ab2f32d@bahia.lan>
In-Reply-To: <20180710015257.12083-1-david@gibson.dropbear.id.au>
References: <20180710015257.12083-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: Correct inverted test in
 spapr_pc_dimm_node()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: imammedo@redhat.com, qemu-ppc@nongnu.org, ehabkost@redhat.com, qemu-devel@nongnu.org

On Tue, 10 Jul 2018 11:52:57 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This function was introduced between v2.11 and v2.12 to replace obsolete
> ways of specifying the NUMA nodes for DIMMs.  It's used to find the correct
> node for an LMB, by locating which DIMM object it lies within.
> 
> Unfortunately, one of the checks is inverted, so we check whether the
> address is less than two different things, rather than actually checking
> a range.  This introduced a regression, meaning that after a reboot qemu
> will advertise incorrect node information for memory to the guest.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3f5e1d3ec2..421b2dd09b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -665,7 +665,7 @@ static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_t addr)
>          if (value && value->type == MEMORY_DEVICE_INFO_KIND_DIMM) {
>              PCDIMMDeviceInfo *pcdimm_info = value->u.dimm.data;
>  
> -            if (pcdimm_info->addr >= addr &&
> +            if (addr >= pcdimm_info->addr &&
>                  addr < (pcdimm_info->addr + pcdimm_info->size)) {
>                  return pcdimm_info->node;
>              }
