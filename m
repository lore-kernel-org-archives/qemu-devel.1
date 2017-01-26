Received: from eggs.gnu.org ([2001:4830:134:3::10]:38171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWgad-000217-7j
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWgac-0007HE-Cm
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:43:35 -0500
References: <1485255993-6322-1-git-send-email-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <17aeed6e-77e8-4261-e697-28a26841ee60@redhat.com>
Date: Thu, 26 Jan 2017 10:43:26 +0100
MIME-Version: 1.0
In-Reply-To: <1485255993-6322-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] arm_gicv3: Fix broken logic in ELRSR
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 24.01.2017 12:06, Peter Maydell wrote:
> Fix a broken expression in the calculation of ELRSR
> register bits: instead of "(lr & ICH_LR_EL2_HW) == 1"
> we want to check for != 0, because the HW bit is not
> bit 0 so a test for == 1 is always false.
> 
> Fixes: https://bugs.launchpad.net/bugs/1658506
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_cpuif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index a9ee7fd..c25ee03 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -2430,7 +2430,7 @@ static uint64_t ich_elrsr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>          uint64_t lr = cs->ich_lr_el2[i];
>  
>          if ((lr & ICH_LR_EL2_STATE_MASK) == 0 &&
> -            ((lr & ICH_LR_EL2_HW) == 1 || (lr & ICH_LR_EL2_EOI) == 0)) {
> +            ((lr & ICH_LR_EL2_HW) != 0 || (lr & ICH_LR_EL2_EOI) == 0)) {
>              value |= (1 << i);
>          }
>      }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
