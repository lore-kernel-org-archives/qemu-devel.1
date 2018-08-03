Received: from eggs.gnu.org ([2001:4830:134:3::10]:37281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fldtZ-0003CI-PP
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fldtZ-0005pj-0f
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:29:45 -0400
Date: Fri, 3 Aug 2018 18:29:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180803172936.GF2802@work-vm>
References: <20180803163646.31068-1-peter.maydell@linaro.org>
	<20180803163646.31068-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803163646.31068-2-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/intc/arm_gicv3_common: Give
 no-migration-shift-bug subsection a needed function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Juan Quintela <quintela@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> Currently the migration code incorrectly treats a subsection with
> no .needed function pointer as if it was the subsection list
> terminator -- it is ignored and so is everything after it.
> Work around this by giving vmstate_gicv3_gicd_no_migration_shift_bug
> a 'needed' function that always returns true.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> This should go into 3.0 to avoid awkward migration compat problems:
> the no-migration-shift-bug subsection is new in 3.0.
> ---
>  hw/intc/arm_gicv3_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index ff326b374ad..e58bc8b8105 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -203,10 +203,16 @@ static int gicv3_gicd_no_migration_shift_bug_post_load(void *opaque,
>      return 0;
>  }
>  
> +static bool needed_always(void *opaque)
> +{
> +    return true;
> +}
> +
>  const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
>      .name = "arm_gicv3/gicd_no_migration_shift_bug",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .needed = needed_always,
>      .pre_load = gicv3_gicd_no_migration_shift_bug_pre_load,
>      .post_load = gicv3_gicd_no_migration_shift_bug_post_load,
>      .fields = (VMStateField[]) {
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
