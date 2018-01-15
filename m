Received: from eggs.gnu.org ([2001:4830:134:3::10]:55937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eb2CJ-00058Z-L0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eb2CG-0006pd-EM
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:40:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eb2CG-0006or-4x
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:40:56 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FAdGtZ141669
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:40:54 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fgt9rh7m6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:40:54 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 05:40:53 -0500
Date: Mon, 15 Jan 2018 08:40:40 -0200
From: joserz@linux.vnet.ibm.com
References: <20180115072715.25921-1-david@gibson.dropbear.id.au>
	<20180115072715.25921-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180115072715.25921-2-david@gibson.dropbear.id.au>
Message-Id: <20180115104040.GB6946@pacoca>
Subject: Re: [Qemu-devel] [PATCH 1/2] target/ppc: Clarify compat mode
 max_threads value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, Jan 15, 2018 at 06:27:14PM +1100, David Gibson wrote:
> We recently had some discussions that were sidetracked for a while, because
> nearly everyone misapprehended the purpose of the 'max_threads' field in
> the compatiblity modes table.  It's all about guest expectations, not host
> expectations or support (that's handled elsewhere).
> 
> In an attempt to avoid a repeat of that confusion, rename the field to
> 'max_vthreads' and add an explanatory comment.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c      |  4 ++--
>  target/ppc/compat.c | 25 +++++++++++++++++--------
>  target/ppc/cpu.h    |  2 +-
>  3 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3e528fe91e..e35214bfc3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -345,7 +345,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
>          DeviceClass *dc = DEVICE_GET_CLASS(cs);
>          int index = spapr_vcpu_id(cpu);
> -        int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
> +        int compat_smt = MIN(smp_threads, ppc_compat_max_vthreads(cpu));
> 
>          if ((index % smt) != 0) {
>              continue;
> @@ -503,7 +503,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>      size_t page_sizes_prop_size;
>      uint32_t vcpus_per_socket = smp_threads * smp_cores;
>      uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
> -    int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
> +    int compat_smt = MIN(smp_threads, ppc_compat_max_vthreads(cpu));
>      sPAPRDRConnector *drc;
>      int drc_index;
>      uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index 276b5b52c2..807c906f68 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -32,7 +32,16 @@ typedef struct {
>      uint32_t pvr;
>      uint64_t pcr;
>      uint64_t pcr_level;
> -    int max_threads;
> +
> +    /*
> +     * Maximum allowed virtual threads per virtual core
> +     *
> +     * This is to stop older guests getting confused by seeing more
> +     * threads than they think the cpu can support.  Usually it's
> +     * equal to the number of threads supported on bare metal
> +     * hardware, but not always (see POWER9).
> +     */
> +    int max_vthreads;
>  } CompatInfo;
> 
>  static const CompatInfo compat_table[] = {
> @@ -45,28 +54,28 @@ static const CompatInfo compat_table[] = {
>          .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
>                 PCR_COMPAT_2_05 | PCR_TM_DIS | PCR_VSX_DIS,
>          .pcr_level = PCR_COMPAT_2_05,
> -        .max_threads = 2,
> +        .max_vthreads = 2,
>      },
>      { /* POWER7, ISA2.06 */
>          .name = "power7",
>          .pvr = CPU_POWERPC_LOGICAL_2_06,
>          .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
>          .pcr_level = PCR_COMPAT_2_06,
> -        .max_threads = 4,
> +        .max_vthreads = 4,
>      },
>      {
>          .name = "power7+",
>          .pvr = CPU_POWERPC_LOGICAL_2_06_PLUS,
>          .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
>          .pcr_level = PCR_COMPAT_2_06,
> -        .max_threads = 4,
> +        .max_vthreads = 4,
>      },
>      { /* POWER8, ISA2.07 */
>          .name = "power8",
>          .pvr = CPU_POWERPC_LOGICAL_2_07,
>          .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07,
>          .pcr_level = PCR_COMPAT_2_07,
> -        .max_threads = 8,
> +        .max_vthreads = 8,
>      },
>      { /* POWER9, ISA3.00 */
>          .name = "power9",
> @@ -80,7 +89,7 @@ static const CompatInfo compat_table[] = {
>           * confusing if half of the threads disappear from the guest
>           * if it announces it's POWER9 aware at CAS time.
>           */
> -        .max_threads = 8,
> +        .max_vthreads = 8,
>      },
>  };
> 
> @@ -192,14 +201,14 @@ void ppc_set_compat_all(uint32_t compat_pvr, Error **errp)
>      }
>  }
> 
> -int ppc_compat_max_threads(PowerPCCPU *cpu)
> +int ppc_compat_max_vthreads(PowerPCCPU *cpu)
>  {
>      const CompatInfo *compat = compat_by_pvr(cpu->compat_pvr);
>      int n_threads = CPU(cpu)->nr_threads;
> 
>      if (cpu->compat_pvr) {
>          g_assert(compat);
> -        n_threads = MIN(n_threads, compat->max_threads);
> +        n_threads = MIN(n_threads, compat->max_vthreads);
>      }
> 
>      return n_threads;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a5e49f23e9..dc6820c5eb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1395,7 +1395,7 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
>  #if !defined(CONFIG_USER_ONLY)
>  void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
>  #endif
> -int ppc_compat_max_threads(PowerPCCPU *cpu);
> +int ppc_compat_max_vthreads(PowerPCCPU *cpu);
>  void ppc_compat_add_property(Object *obj, const char *name,
>                               uint32_t *compat_pvr, const char *basedesc,
>                               Error **errp);
> -- 
> 2.14.3
> 

Reviewed-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
