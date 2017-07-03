Received: from eggs.gnu.org ([2001:4830:134:3::10]:55891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dS1dW-00069y-08
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dS1dS-0003D7-RL
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:43:33 -0400
Date: Mon, 3 Jul 2017 15:43:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170703154326.030e08bc@nial.brq.redhat.com>
In-Reply-To: <149908449117.14256.2821600309813941055.stgit@bahia.lan>
References: <149908449117.14256.2821600309813941055.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: fix memory hotplug error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

On Mon, 03 Jul 2017 14:21:31 +0200
Greg Kurz <groug@kaod.org> wrote:

> QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
> Let's propagate the error instead, like it is done everywhere else
> where spapr_drc_attach() is called.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 70b3fd374e2b..e103be500189 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>      int i, fdt_offset, fdt_size;
>      void *fdt;
>      uint64_t addr = addr_start;
> +    Error *local_err = NULL;
>  
>      for (i = 0; i < nr_lmbs; i++) {
>          drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> @@ -2611,7 +2612,12 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>          fdt_offset = spapr_populate_memory_node(fdt, node, addr,
>                                                  SPAPR_MEMORY_BLOCK_SIZE);
>  
> -        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
> +        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> +        if (local_err) {
> +            g_free(fdt);
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>          addr += SPAPR_MEMORY_BLOCK_SIZE;
>      }
>      /* send hotplug notification to the
> @@ -2657,7 +2663,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  
>      spapr_add_lmbs(dev, addr, size, node,
>                     spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> -                   &error_abort);
> +                   &local_err);
where is code that handles error condition?
 i.e. undo what pc_dimm_memory_plug() has done

>  
>  out:
>      error_propagate(errp, local_err);
> 
> 
