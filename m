Received: from eggs.gnu.org ([2001:4830:134:3::10]:54131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dVCz1-0007uW-WF
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dVCyy-00077Q-3D
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:26:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dVCyx-000770-PK
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:26:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6C8OF87069976
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 04:26:49 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj87sbn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 04:26:49 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 12 Jul 2017 18:26:46 +1000
Date: Wed, 12 Jul 2017 13:56:37 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
	<20170711043917.1757-10-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711043917.1757-10-david@gibson.dropbear.id.au>
Message-Id: <20170712082637.GA5377@in.ibm.com>
Subject: Re: [Qemu-devel] [PULL 09/17] spapr: Remove unnecessary differences
 between hotplug and coldplug paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, Jul 11, 2017 at 02:39:09PM +1000, David Gibson wrote:
> spapr_drc_attach() has a 'coldplug' parameter which sets the DRC into
> configured state initially, instead of the usual ISOLATED/UNUSABLE state.
> It turns out this is unnecessary: although coldplugged devices do need to
> be in CONFIGURED state once the guest starts, that will already be
> accomplished by the reset code which will move DRCs for already plugged
> devices into a coldplug equivalent state.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c             | 13 +++----------
>  hw/ppc/spapr_drc.c         |  5 ++---
>  hw/ppc/spapr_pci.c         |  3 +--
>  include/hw/ppc/spapr_drc.h |  2 +-
>  4 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4fa982d..70b3fd3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2611,7 +2611,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>          fdt_offset = spapr_populate_memory_node(fdt, node, addr,
>                                                  SPAPR_MEMORY_BLOCK_SIZE);
> 
> -        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
> +        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
>          addr += SPAPR_MEMORY_BLOCK_SIZE;
>      }
>      /* send hotplug notification to the
> @@ -2956,17 +2956,10 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> 
>      g_assert(drc || !mc->has_hotpluggable_cpus);
> 
> -    /*
> -     * Setup CPU DT entries only for hotplugged CPUs. For boot time or
> -     * coldplugged CPUs DT entries are setup in spapr_build_fdt().
> -     */
> -    if (dev->hotplugged) {
> -        fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> -    }
> +    fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);

A harmless (but still good to get rid of) side effect of this change is
that we are now building the CPU device tree for boot time and cold-plugged
CPUs twice:

first from spapr_core_plug() -> spapr_populate_hotplug_cpu_dt()
second from spapr_build_fdt() -> spapr_populate_cpus_dt_node()

The first one is not used while the 2nd one acutally ends up building
the CPUs DT entries for the boot time and cold-plugged CPUs.

Regards,
Bharata.
