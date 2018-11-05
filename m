Received: from eggs.gnu.org ([2001:4830:134:3::10]:59890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gJkaC-0003GZ-2t
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 14:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gJka4-0002a6-En
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 14:30:41 -0500
Date: Mon, 5 Nov 2018 20:30:12 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20181105193012.GB1148@toto>
References: <20181016093703.10637-1-peter.maydell@linaro.org>
	<20181016093703.10637-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016093703.10637-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] target/arm: Fix ATS1Hx
 instructions
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

On Tue, Oct 16, 2018 at 10:37:03AM +0100, Peter Maydell wrote:
> ATS1HR and ATS1HW (which allow AArch32 EL2 to do address translations
> on the EL2 translation regime) were implemented in commit 14db7fe09a2c8.
> However, we got them wrong: these should do stage 1 address translations
> as defined for NS-EL2, which is ARMMMUIdx_S1E2. We were incorrectly
> making them perform stage 2 translations.
> 
> A few years later in commit 1313e2d7e2cd we forgot entirely that
> we'd implemented ATS1Hx, and added a comment that ATS1Hx were
> "not supported yet". Remove the comment; there is no extra code
> needed to handle these operations in do_ats_write(), because
> arm_s1_regime_using_lpae_format() returns true for ARMMMUIdx_S1E2,
> which forces 64-bit PAR format.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Oops, yes:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> ---
>  target/arm/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dc849b09893..903a832f1fa 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2316,7 +2316,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
>           *
>           * (Note that HCR.DC makes HCR.VM behave as if it is 1.)
>           *
> -         * ATS1Hx always uses the 64bit format (not supported yet).
> +         * ATS1Hx always uses the 64bit format.
>           */
>          format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
>  
> @@ -2441,7 +2441,7 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
>      uint64_t par64;
>  
> -    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_S2NS);
> +    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_S1E2);
>  
>      A32_BANKED_CURRENT_REG_SET(env, par, par64);
>  }
> -- 
> 2.19.0
> 
> 
