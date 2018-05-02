Received: from eggs.gnu.org ([2001:4830:134:3::10]:42663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fDyxi-0000w1-SH
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fDyxf-0008V4-B4
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:06:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fDyxe-0008Tm-W9
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:06:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w42L5wWC126368
	for <qemu-devel@nongnu.org>; Wed, 2 May 2018 17:06:48 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hqmcy19r7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 17:06:47 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Wed, 2 May 2018 17:06:46 -0400
Date: Wed, 2 May 2018 18:06:38 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<20180419062917.31486-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419062917.31486-2-david@gibson.dropbear.id.au>
Message-Id: <20180502210637.GA27693@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [RFC for-2.13 1/7] spapr: Maximum (HPT) pagesize
 property
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

On Thu, Apr 19, 2018 at 04:29:11PM +1000, David Gibson wrote:
> The way the POWER Hash Page Table (HPT) MMU is virtualized by KVM HV means
> that every page that the guest puts in the pagetables must be truly
> physically contiguous, not just GPA-contiguous.  In effect this means that
> an HPT guest can't use any pagesizes greater than the host page size used
> to back its memory.
> 
> At present we handle this by changing what we advertise to the guest based
> on the backing pagesizes.  This is pretty bad, because it means the guest
> sees a different environment depending on what should be host configuration
> details.
> 
> As a start on fixing this, we add a new capability parameter to the pseries
> machine type which gives the maximum allowed pagesizes for an HPT guest (as
> a shift).  For now we just create and validate the parameter without making
> it do anything.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c         |  1 +
>  hw/ppc/spapr_caps.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  4 +++-
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bdf72e1e89..36e41aff71 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3876,6 +3876,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_HPT_MPS] = 16; /* Allow 64kiB pages */
>      spapr_caps_add_properties(smc, &error_abort);
>  }
>  
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 531e145114..cbc41f5b20 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -27,6 +27,7 @@
>  #include "qapi/visitor.h"
>  #include "sysemu/hw_accel.h"
>  #include "target/ppc/cpu.h"
> +#include "target/ppc/mmu-hash64.h"
>  #include "cpu-models.h"
>  #include "kvm_ppc.h"
>  
> @@ -142,6 +143,39 @@ out:
>      g_free(val);
>  }
>  
> +static void spapr_cap_get_int(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap = opaque;
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
> +    int64_t value = spapr_get_cap(spapr, cap->index);
> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void spapr_cap_set_int(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap = opaque;
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
> +    int64_t value;
> +    Error *local_err = NULL;
> +
> +    visit_type_int(v, name, &value, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if ((value < 0) || (value > 255)) {
> +        error_setg(errp, "Value for %s out of range (0..255)", name);
> +        return;
> +    }
> +
> +    spapr->cmd_line_caps[cap->index] = true;
> +    spapr->eff.caps[cap->index] = value;
> +}
> +

Hi, David.

Do you think uint8_t would fit better for spapr_[gs]et_int() functions?

Perhaps renaming them to spapr_[gs]set_int8() and calling
visit_type_int8() instead.

Cheers
Murilo

>  static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
>  {
>      if (!val) {
> @@ -265,6 +299,16 @@ static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
>  
>  #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
>  
> +static void cap_hpt_mps_apply(sPAPRMachineState *spapr,
> +                              uint8_t val, Error **errp)
> +{
> +    if (val < 12) {
> +        error_setg(errp, "Require at least 4kiB pages (cap-hpt-mps >= 12)");
> +    } else if (val < 16) {
> +        warn_report("Many PAPR guests require 64kiB pages (cap-hpt-mps >= 16)");
> +    }
> +}
> +
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>      [SPAPR_CAP_HTM] = {
>          .name = "htm",
> @@ -324,6 +368,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .possible = &cap_ibs_possible,
>          .apply = cap_safe_indirect_branch_apply,
>      },
> +    [SPAPR_CAP_HPT_MPS] = {
> +        .name = "hpt-mps",
> +        .description = "Maximum page shift for Hash Page Table guests (12, 16, 24, 34)",
> +        .index = SPAPR_CAP_HPT_MPS,
> +        .get = spapr_cap_get_int,
> +        .set = spapr_cap_set_int,
> +        .type = "int",
> +        .apply = cap_hpt_mps_apply,
> +    },
>  };
>  
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index d60b7c6d7a..60ed3a5657 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -66,8 +66,10 @@ typedef enum {
>  #define SPAPR_CAP_SBBC                  0x04
>  /* Indirect Branch Serialisation */
>  #define SPAPR_CAP_IBS                   0x05
> +/* HPT Maximum Page Shift */
> +#define SPAPR_CAP_HPT_MPS               0x06
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_HPT_MPS + 1)
>  
>  /*
>   * Capability Values
> -- 
> 2.14.3
> 
> 
