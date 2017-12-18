Received: from eggs.gnu.org ([2001:4830:134:3::10]:36744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQte0-0002X5-7j
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQtdx-0002oe-FS
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:31:40 -0500
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:40257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eQtdx-0002mu-69
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:31:37 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 0DCE7B2661
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 12:31:34 +0100 (CET)
Date: Mon, 18 Dec 2017 12:31:26 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171218123126.7580bb28@bahia.lan>
In-Reply-To: <20171218092024.21645-4-david@gibson.dropbear.id.au>
References: <20171218092024.21645-1-david@gibson.dropbear.id.au>
	<20171218092024.21645-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] spapr: Validate capabilities on
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: surajjs@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, abologna@redhat.com

On Mon, 18 Dec 2017 20:20:21 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Now that the "pseries" machine type implements optional capabilities (well,
> one so far) there's the possibility of having different capabilities
> available at either end of a migration.  Although arguably a user error,
> it would be nice to catch this situation and fail as gracefully as we can.
> 
> This adds code to migrate the capabilities flags.  These aren't pulled
> directly into the destination's configuration since what the user has
> specified on the destination command line should take precedence.  However,
> they are checked against the destination capabilities.
> 
> If the source was using a capability which is absent on the destination,
> we fail the migration, since that could easily cause a guest crash or other
> bad behaviour.  If the source lacked a capability which is present on the
> destination we warn, but allow the migration to proceed.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c         |  6 ++++
>  hw/ppc/spapr_caps.c    | 96 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  include/hw/ppc/spapr.h |  6 ++++
>  3 files changed, 105 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f8fee8ebcf..86fc83f9c2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1589,6 +1589,11 @@ static int spapr_post_load(void *opaque, int version_id)
>      sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
>      int err = 0;
>  
> +    err = spapr_caps_post_migration(spapr);
> +    if (err) {
> +        return err;
> +    }
> +
>      if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
>          CPUState *cs;
>          CPU_FOREACH(cs) {
> @@ -1755,6 +1760,7 @@ static const VMStateDescription vmstate_spapr = {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
>          &vmstate_spapr_pending_events,
> +        &vmstate_spapr_caps,
>          NULL
>      }
>  };
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 2f0ef98670..a8c726a88b 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "sysemu/hw_accel.h"
> @@ -83,6 +84,93 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
>      return caps;
>  }
>  
> +static bool spapr_caps_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    return (spapr->forced_caps.mask != 0) || (spapr->forbidden_caps.mask != 0);
> +}
> +
> +/* This has to be called from the top-level spapr post_load, not the
> + * caps specific one.  Otherwise it wouldn't be called when the source
> + * caps are all defaults, which could still conflict with overridden
> + * caps on the destination */
> +int spapr_caps_post_migration(sPAPRMachineState *spapr)
> +{
> +    uint64_t allcaps = 0;
> +    int i;
> +    bool ok = true;
> +    sPAPRCapabilities dstcaps = spapr->effective_caps;
> +    sPAPRCapabilities srccaps;
> +
> +    srccaps = default_caps_with_cpu(spapr, first_cpu);
> +    srccaps.mask |= spapr->mig_forced_caps.mask;
> +    srccaps.mask &= ~spapr->mig_forbidden_caps.mask;
> +
> +    for (i = 0; i < ARRAY_SIZE(capability_table); i++) {
> +        sPAPRCapabilityInfo *info = &capability_table[i];
> +
> +        allcaps |= info->flag;
> +
> +        if ((srccaps.mask & info->flag) && !(dstcaps.mask & info->flag)) {
> +            error_report("cap-%s=on in incoming stream, but off in destination",
> +                         info->name);
> +            ok = false;
> +        }
> +
> +        if (!(srccaps.mask & info->flag) && (dstcaps.mask & info->flag)) {
> +            warn_report("cap-%s=off in incoming stream, but on in destination",
> +                         info->name);
> +        }
> +    }
> +
> +    if (spapr->mig_forced_caps.mask & ~allcaps) {
> +        error_report(
> +            "Unknown capabilities 0x%"PRIx64" enabled in incoming stream",
> +            spapr->mig_forced_caps.mask & ~allcaps);
> +        ok = false;
> +    }
> +    if (spapr->mig_forbidden_caps.mask & ~allcaps) {
> +        warn_report(
> +            "Unknown capabilities 0x%"PRIx64" disabled in incoming stream",
> +            spapr->mig_forbidden_caps.mask & ~allcaps);
> +    }
> +
> +    return ok ? 0 : -EINVAL;
> +}
> +
> +static int spapr_caps_pre_save(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    spapr->mig_forced_caps = spapr->forced_caps;
> +    spapr->mig_forbidden_caps = spapr->forbidden_caps;
> +    return 0;
> +}
> +
> +static int spapr_caps_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    spapr->mig_forced_caps = spapr_caps(0);
> +    spapr->mig_forbidden_caps = spapr_caps(0);
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_spapr_caps = {
> +    .name = "spapr/caps",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = spapr_caps_needed,
> +    .pre_save = spapr_caps_pre_save,
> +    .pre_load = spapr_caps_pre_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(mig_forced_caps.mask, sPAPRMachineState),
> +        VMSTATE_UINT64(mig_forbidden_caps.mask, sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  void spapr_caps_reset(sPAPRMachineState *spapr)
>  {
>      Error *local_err = NULL;
> @@ -92,6 +180,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
>      /* First compute the actual set of caps we're running with.. */
>      caps = default_caps_with_cpu(spapr, first_cpu);
>  
> +    /* Remove unnecessary forced/forbidden bits (this will help us
> +     * with migration) */
> +    spapr->forced_caps.mask &= ~caps.mask;
> +    spapr->forbidden_caps.mask &= caps.mask;
> +
>      caps.mask |= spapr->forced_caps.mask;
>      caps.mask &= ~spapr->forbidden_caps.mask;
>  
> @@ -176,9 +269,6 @@ void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp)
>          error_setg(errp, "Some sPAPR capabilities set both on and off");
>          return;
>      }
> -
> -    /* Check for any caps incompatible with other caps.  Nothing to do
> -     * yet */
>  }
>  
>  void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index dc64f4ebcb..5c85f39c3b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -54,6 +54,8 @@ typedef enum {
>   * Capabilities
>   */
>  
> +/* These bits go in the migration stream, so they can't be reassigned */
> +
>  /* Hardware Transactional Memory */
>  #define SPAPR_CAP_HTM               0x0000000000000001ULL
>  
> @@ -142,6 +144,7 @@ struct sPAPRMachineState {
>      const char *icp_type;
>  
>      sPAPRCapabilities forced_caps, forbidden_caps;
> +    sPAPRCapabilities mig_forced_caps, mig_forbidden_caps;
>      sPAPRCapabilities effective_caps;
>  };
>  
> @@ -743,6 +746,8 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>  /*
>   * Handling of optional capabilities
>   */
> +extern const VMStateDescription vmstate_spapr_caps;
> +
>  static inline sPAPRCapabilities spapr_caps(uint64_t mask)
>  {
>      sPAPRCapabilities caps = { mask };
> @@ -757,5 +762,6 @@ static inline bool spapr_has_cap(sPAPRMachineState *spapr, uint64_t cap)
>  void spapr_caps_reset(sPAPRMachineState *spapr);
>  void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp);
>  void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
> +int spapr_caps_post_migration(sPAPRMachineState *spapr);
>  
>  #endif /* HW_SPAPR_H */
