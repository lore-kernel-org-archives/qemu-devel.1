Received: from eggs.gnu.org ([2001:4830:134:3::10]:34728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f6tak-0000bA-KR
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f6tag-0002R0-0g
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:57:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1f6taf-0002Q8-OE
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:57:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3D7uSUO029158
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 03:57:48 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2har3e1dfj-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 03:57:48 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 13 Apr 2018 08:57:45 +0100
Date: Fri, 13 Apr 2018 13:27:39 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
	<1523472120-56496-2-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523472120-56496-2-git-send-email-spopovyc@redhat.com>
Message-Id: <20180413075739.GC14855@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 v3 1/2] spapr: Add ibm,
 max-associativity-domains property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Wed, Apr 11, 2018 at 02:41:59PM -0400, Serhii Popovych wrote:
> Now recent kernels (i.e. since linux-stable commit a346137e9142
> ("powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes")
> support this property to mark initially memory-less NUMA nodes as "possible"
> to allow further memory hot-add to them.
> 
> Advertise this property for pSeries machines to let guest kernels detect
> maximum supported node configuration and benefit from kernel side change
> when hot-add memory to specific, possibly empty before, NUMA node.
> 
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> ---
>  hw/ppc/spapr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a81570e..c05bbad 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -910,6 +910,13 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
>          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
>          cpu_to_be32(max_cpus / smp_threads),
>      };
> +    uint32_t maxdomains[] = {
> +        cpu_to_be32(4),
> +        cpu_to_be32(0),
> +        cpu_to_be32(0),
> +        cpu_to_be32(0),
> +        cpu_to_be32(nb_numa_nodes - 1),
> +    };
> 
>      _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
> 
> @@ -946,6 +953,9 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
>                       refpoints, sizeof(refpoints)));
> 
> +    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
> +                     maxdomains, sizeof(maxdomains)));
> +
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
>                            RTAS_ERROR_LOG_MAX));
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
> -- 
> 1.8.3.1

This commit causes hash guest with latest guest kernel to hang at early boot.

Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000002000000 ...
[    0.000000] hash-mmu: Page sizes from device-tree:
[    0.000000] hash-mmu: base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
[    0.000000] hash-mmu: base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
[    0.000000] Using 1TB segments
[    0.000000] hash-mmu: Initializing hash mmu with SLB
[    0.000000] Linux version 4.16.0-rc7+ (root@localhost.localdomain) (gcc version 7.1.1 20170622 (Red Hat 7.1.1-3) (GCC)) #60 SMP Wed Apr 11 10:36:22 IST 2018
[    0.000000] Found initrd at 0xc000000003c00000:0xc000000004f9a34c
[    0.000000] Using pSeries machine description
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Partition configured for 32 cpus.
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    = 0x1a
[    0.000000] phys_mem_size     = 0x200000000
[    0.000000] dcache_bsize      = 0x80
[    0.000000] icache_bsize      = 0x80
[    0.000000] cpu_features      = 0x077c7a6c18500249
[    0.000000]   possible        = 0xffffffff18500649
[    0.000000]   always          = 0x0000000018100040
[    0.000000] cpu_user_features = 0xdc0065c2 0xae000000
[    0.000000] mmu_features      = 0x78006001
[    0.000000] firmware_features = 0x00000001415a445f
[    0.000000] htab_hash_mask    = 0x7ffff
[    0.000000] -----------------------------------------------------

No progess after this.
