Received: from eggs.gnu.org ([2001:4830:134:3::10]:53776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fEGbm-0006nc-Vx
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fEGbh-0007mT-Vo
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:57:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53716
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fEGbh-0007mI-Ow
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:57:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w43FtVNZ095108
	for <qemu-devel@nongnu.org>; Thu, 3 May 2018 11:57:19 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hr3s7wem1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:57:18 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Thu, 3 May 2018 11:57:17 -0400
Date: Thu, 3 May 2018 12:57:09 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<20180419062917.31486-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419062917.31486-4-david@gibson.dropbear.id.au>
Message-Id: <20180503155709.GA32363@kermit-br-ibm-com.br.ibm.com>
Subject: Re: [Qemu-devel] [RFC for-2.13 3/7] target/ppc: Add
 ppc_hash64_filter_pagesizes()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, abologna@redhat.com, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org

On Thu, Apr 19, 2018 at 04:29:13PM +1000, David Gibson wrote:
> The paravirtualized PAPR platform sometimes needs to restrict the guest to
> using only some of the page sizes actually supported by the host's MMU.
> At the moment this is handled in KVM specific code, but for consistency we
> want to apply the same limitations to all accelerators.
> 
> This makes a start on this by providing a helper function in the cpu code
> to allow platform code to remove some of the cpu's page size definitions
> via a caller supplied callback.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/mmu-hash64.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
>  target/ppc/mmu-hash64.h |  3 +++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index a1db20e3a8..b6e62864fd 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1165,3 +1165,62 @@ const PPCHash64Options ppc_hash64_opts_POWER7 = {
>          },
>      }
>  };
> +
> +void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
> +                                 bool (*cb)(void *, uint32_t, uint32_t),
> +                                 void *opaque)
> +{
> +    PPCHash64Options *opts = cpu->hash64_opts;
> +    int i;
> +    int n = 0;
> +    bool ci_largepage = false;
> +
> +    assert(opts);
> +
> +    n = 0;
> +    for (i = 0; i < ARRAY_SIZE(opts->sps); i++) {
> +        PPCHash64SegmentPageSizes *sps = &opts->sps[i];
> +        int j;
> +        int m = 0;
> +
> +        assert(n <= i);
> +
> +        if (!sps->page_shift) {
> +            break;
> +        }
> +
> +        for (j = 0; j < ARRAY_SIZE(sps->enc); j++) {
> +            PPCHash64PageSize *ps = &sps->enc[j];
> +
> +            assert(m <= j);
> +            if (!ps->page_shift) {
> +                break;
> +            }
> +
> +            if (cb(opaque, sps->page_shift, ps->page_shift)) {
> +                if (ps->page_shift == 16) {
> +                    ci_largepage = true;
> +                }
> +                sps->enc[m++] = *ps;
> +            }

Hi, David.

Is it possible that both sps->page_shift and ps->page_shift value 24?
This seems to be a true case for spapr_pagesize_cb(), if I'm reading
correctly.

Shouldn't ci_largepage also be set to true when ps->page_shift == 24?

Cheers
Murilo

> +        }
> +
> +        /* Clear rest of the row */
> +        for (j = m; j < ARRAY_SIZE(sps->enc); j++) {
> +            memset(&sps->enc[j], 0, sizeof(sps->enc[j]));
> +        }
> +
> +        if (m) {
> +            n++;
> +        }
> +    }
> +
> +    /* Clear the rest of the table */
> +    for (i = n; i < ARRAY_SIZE(opts->sps); i++) {
> +        memset(&opts->sps[i], 0, sizeof(opts->sps[i]));
> +    }
> +
> +    if (!ci_largepage) {
> +        opts->flags &= ~PPC_HASH64_CI_LARGEPAGE;
> +    }
> +}
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index f23b78d787..1aa2453497 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -20,6 +20,9 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
>  void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
>  void ppc_hash64_init(PowerPCCPU *cpu);
>  void ppc_hash64_finalize(PowerPCCPU *cpu);
> +void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
> +                                 bool (*cb)(void *, uint32_t, uint32_t),
> +                                 void *opaque);
>  #endif
>  
>  /*
> -- 
> 2.14.3
> 
> 
