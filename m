Received: from eggs.gnu.org ([2001:4830:134:3::10]:52833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fmhUn-0002oK-7d
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fmhUm-0000ZK-87
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:32:33 -0400
Date: Mon, 6 Aug 2018 16:32:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180806153220.GE2473@work-vm>
References: <20180806123445.1459-1-peter.maydell@linaro.org>
	<20180806123445.1459-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806123445.1459-5-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 4/5] hw/intc/arm_gicv3_common:
 Move post_load hooks to top-level VMSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Juan Quintela <quintela@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> Contrary to the the impression given in docs/devel/migration.rst,
> the migration code does not run the pre_load hook for a
> subsection unless the subsection appears on the wire, and so
> this is not a place where you can set the default value for
> state for the "subsection not present" case. Instead this needs
> to be done in a pre_load hook for whatever is the parent VMSD
> of the subsection.
> 
> We got this wrong in two of the subsection definitions in
> the GICv3 migration structs; fix this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/intc/arm_gicv3_common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index e1a8999cf5b..8175889f1e7 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -73,7 +73,7 @@ static const VMStateDescription vmstate_gicv3_cpu_virt = {
>      }
>  };
>  
> -static int icc_sre_el1_reg_pre_load(void *opaque)
> +static int vmstate_gicv3_cpu_pre_load(void *opaque)
>  {
>      GICv3CPUState *cs = opaque;
>  
> @@ -97,7 +97,6 @@ const VMStateDescription vmstate_gicv3_cpu_sre_el1 = {
>      .name = "arm_gicv3_cpu/sre_el1",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .pre_load = icc_sre_el1_reg_pre_load,
>      .needed = icc_sre_el1_reg_needed,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT64(icc_sre_el1, GICv3CPUState),
> @@ -109,6 +108,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>      .name = "arm_gicv3_cpu",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .pre_load = vmstate_gicv3_cpu_pre_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(level, GICv3CPUState),
>          VMSTATE_UINT32(gicr_ctlr, GICv3CPUState),
> @@ -139,7 +139,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>      }
>  };
>  
> -static int gicv3_gicd_no_migration_shift_bug_pre_load(void *opaque)
> +static int gicv3_pre_load(void *opaque)
>  {
>      GICv3State *cs = opaque;
>  
> @@ -210,7 +210,6 @@ const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = needed_always,
> -    .pre_load = gicv3_gicd_no_migration_shift_bug_pre_load,
>      .post_load = gicv3_gicd_no_migration_shift_bug_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_BOOL(gicd_no_migration_shift_bug, GICv3State),
> @@ -222,6 +221,7 @@ static const VMStateDescription vmstate_gicv3 = {
>      .name = "arm_gicv3",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .pre_load = gicv3_pre_load,
>      .pre_save = gicv3_pre_save,
>      .post_load = gicv3_post_load,
>      .priority = MIG_PRI_GICV3,
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
