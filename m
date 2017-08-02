Received: from eggs.gnu.org ([2001:4830:134:3::10]:43370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dcxXJ-0000Dc-6v
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dcxXI-0005Uu-Ag
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:34:21 -0400
Date: Wed, 2 Aug 2017 19:34:11 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170802173411.GH4859@toto>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-3-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501692241-23310-3-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 02/15] target/arm: Don't trap WFI/WFE for M
 profile
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

On Wed, Aug 02, 2017 at 05:43:48PM +0100, Peter Maydell wrote:
> M profile cores can never trap on WFI or WFE instructions. Check for
> M profile in check_wfx_trap() to ensure this.
> 
> The existing code will do the right thing for v7M cores because
> the hcr_el2 and scr_el3 registers will be all-zeroes and so we
> won't attempt to trap, but when we start setting ARM_FEATURE_V8
> for v8M cores the v8A handling of SCTLR.nTWE and .nTWI will not
> give the right results.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/op_helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 2a85666..5a94a5f 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -370,6 +370,11 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
>      int cur_el = arm_current_el(env);
>      uint64_t mask;
>  
> +    if (arm_feature(env, ARM_FEATURE_M)) {
> +        /* M profile cores can never trap WFI/WFE. */
> +        return 0;
> +    }
> +
>      /* If we are currently in EL0 then we need to check if SCTLR is set up for
>       * WFx instructions being trapped to EL1. These trap bits don't exist in v7.
>       */
> -- 
> 2.7.4
> 
> 
