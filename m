Received: from eggs.gnu.org ([209.51.188.92]:54514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gjjbb-0002g9-Eb
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gjjbO-0007nP-Rq
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:43:28 -0500
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:46325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gjjbO-0007KP-Dm
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:43:22 -0500
Received: from player731.ha.ovh.net (unknown [10.109.143.18])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 6CDE239E03
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 12:43:17 +0100 (CET)
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-3-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7d949380-e8e5-c5bd-1fd4-e87f3106e7f2@kaod.org>
Date: Wed, 16 Jan 2019 12:43:07 +0100
MIME-Version: 1.0
In-Reply-To: <1547194672-24169-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/3] ppc: Fix duplicated typedefs to be
 able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, pbonzini@redhat.com, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On 1/11/19 9:17 AM, Thomas Huth wrote:
> When compiling the ppc code with clang and -std=gnu99, there are a
> couple of warnings/errors like this one:
> 
>   CC      ppc64-softmmu/hw/intc/xics.o
> In file included from hw/intc/xics.c:35:
> include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPState' is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> typedef struct ICPState ICPState;
>                         ^
> target/ppc/cpu.h:1181:25: note: previous definition is here
> typedef struct ICPState ICPState;
>                         ^
> Work around the problems by including the proper headers instead.

Thomas,


After a closer look, I think we should use 'void *' under PowerPCCPU 
as it was the case before I introduced the second interrupt presenter.

That's a bigger change reverting bits of already merged patches. I can
take care of it if you prefer. 

I use a f29 for dev. Which compiler should I install ? 

C.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/ppc/spapr.h      |  5 +++--
>  include/hw/ppc/spapr_xive.h |  2 --
>  target/ppc/cpu.h            | 13 +++++++++----
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9e01a5a..a947a0a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -8,15 +8,16 @@
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include "hw/ppc/spapr_irq.h"
> +#include "hw/ppc/spapr_xive.h"  /* For sPAPRXive */
> +#include "hw/ppc/xics.h"        /* For ICSState */
>  
>  struct VIOsPAPRBus;
>  struct sPAPRPHBState;
>  struct sPAPRNVRAM;
> +
>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>  typedef struct sPAPREventSource sPAPREventSource;
>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> -typedef struct ICSState ICSState;
> -typedef struct sPAPRXive sPAPRXive;
>  
>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>  #define SPAPR_ENTRY_POINT       0x100
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 7fdc250..9bec919 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -41,8 +41,6 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
>  bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
>  
> -typedef struct sPAPRMachineState sPAPRMachineState;
> -
>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
>                     uint32_t phandle);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 486abaf..bde4dff 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -23,6 +23,11 @@
>  #include "qemu-common.h"
>  #include "qemu/int128.h"
>  
> +#ifndef CONFIG_USER_ONLY
> +#include "hw/ppc/xive.h" /* for XiveTCTX */
> +#include "hw/ppc/xics.h" /* for ICPState */
> +#endif
> +
>  //#define PPC_EMULATE_32BITS_HYPV
>  
>  #if defined (TARGET_PPC64)
> @@ -1177,8 +1182,6 @@ do {                                            \
>  
>  typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
>  typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
> -typedef struct XiveTCTX XiveTCTX;
> -typedef struct ICPState ICPState;
>  
>  /**
>   * PowerPCCPU:
> @@ -1197,11 +1200,13 @@ struct PowerPCCPU {
>      int vcpu_id;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> -    ICPState *icp;
> -    XiveTCTX *tctx;
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
> +#ifndef CONFIG_USER_ONLY
> +    ICPState *icp;
> +    XiveTCTX *tctx;
> +#endif
>  
>      /* Fields related to migration compatibility hacks */
>      bool pre_2_8_migration;
> 
