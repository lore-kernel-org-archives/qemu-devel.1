Received: from eggs.gnu.org ([2001:4830:134:3::10]:40675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcnhG-0007wf-QG
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcnhD-0006Or-KG
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:08:30 -0400
Date: Tue, 10 Jul 2018 10:08:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180710100824.28c862a6@redhat.com>
In-Reply-To: <20180710015257.12083-1-david@gibson.dropbear.id.au>
References: <20180710015257.12083-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: Correct inverted test in
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
Cc: ehabkost@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
