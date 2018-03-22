Received: from eggs.gnu.org ([2001:4830:134:3::10]:34384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ez18S-0004Bl-8C
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 10:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ez18P-0000Vf-KO
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 10:24:08 -0400
Date: Thu, 22 Mar 2018 15:23:43 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180322142343.jvc6pxxvl5zhfjgy@hawk.localdomain>
References: <20180315133441.24149-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315133441.24149-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/intc/arm_gicv3: Fix secure-GIC
 NS ICC_PMR and ICC_RPR accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Thu, Mar 15, 2018 at 01:34:41PM +0000, Peter Maydell wrote:
> If the GIC has the security extension support enabled, then a
> non-secure access to ICC_PMR must take account of the non-secure
> view of interrupt priorities, where real priorities 0..0x7f
> are secure-only and not visible to the non-secure guest, and
> priorities 0x80..0xff are shown to the guest as if they were
> 0x00..0xff. We had the logic here wrong:

0x00..0x7f

>  * on reads, the priority is in the secure range if bit 7
>    is clear, not if it is set
>  * on writes, we want to set bit 7, not mask everything else
> 
> Our ICC_RPR read code had the same error as ICC_PMR.
> 
> (Compare the GICv3 spec pseudocode functions ICC_RPR_EL1
> and ICC_PMR_EL1.)
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1748434
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_cpuif.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index 5cbafaf497..26f5eeda94 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -836,7 +836,7 @@ static uint64_t icc_pmr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>          /* NS access and Group 0 is inaccessible to NS: return the
>           * NS view of the current priority
>           */
> -        if (value & 0x80) {
> +        if ((value & 0x80) == 0) {
>              /* Secure priorities not visible to NS */
>              value = 0;
>          } else if (value != 0xff) {
> @@ -871,7 +871,7 @@ static void icc_pmr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>              /* Current PMR in the secure range, don't allow NS to change it */
>              return;
>          }
> -        value = (value >> 1) & 0x80;
> +        value = (value >> 1) | 0x80;
>      }
>      cs->icc_pmr_el1 = value;
>      gicv3_cpuif_update(cs);
> @@ -1609,7 +1609,7 @@ static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      if (arm_feature(env, ARM_FEATURE_EL3) &&
>          !arm_is_secure(env) && (env->cp15.scr_el3 & SCR_FIQ)) {
>          /* NS GIC access and Group 0 is inaccessible to NS */
> -        if (prio & 0x80) {
> +        if ((prio & 0x80) == 0) {
>              /* NS mustn't see priorities in the Secure half of the range */
>              prio = 0;
>          } else if (prio != 0xff) {
> -- 
> 2.16.2
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
