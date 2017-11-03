Received: from eggs.gnu.org ([2001:4830:134:3::10]:43337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1eAftg-0002tK-Ke
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1eAftf-0000Gl-Qg
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:36:48 -0400
Date: Fri, 3 Nov 2017 10:36:37 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1509719814-6191-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <alpine.DEB.2.10.1711031035500.8975@sstabellini-ThinkPad-X260>
References: <1509719814-6191-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] arm: check regime, not current state,
 for ATS write PAR format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Julien Grall <julien.grall@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, patches@linaro.org

On Fri, 3 Nov 2017, Peter Maydell wrote:
> In do_ats_write(), rather than using extended_addresses_enabled() to
> decide whether the value we get back from get_phys_addr() is a 64-bit
> format PAR or a 32-bit one, use arm_s1_regime_using_lpae_format().
> 
> This is not really the correct answer, because the PAR format
> depends on the AT instruction being used, not just on the
> translation regime. However getting this correct requires a
> significant refactoring, so that get_phys_addr() returns raw
> information about the fault which the caller can then assemble
> into a suitable FSR/PAR/syndrome for its purposes, rather than
> get_phys_addr() returning a pre-formatted FSR.
> 
> However this change at least improves the situation by making
> the PAR work correctly for address translation operations done
> at AArch64 EL2 on the EL2 translation regime. In particular,
> this is necessary for Xen to be able to run in our emulation,
> so this seems like a safer interim fix given that we are in freeze.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Tested-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> I guess I should have a go at the "correct answer" I sketch
> above, but no promises about when I'll get time for that :-(
> 
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 96113fe..37af750 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2162,7 +2162,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
>  
>      ret = get_phys_addr(env, value, access_type, mmu_idx,
>                          &phys_addr, &attrs, &prot, &page_size, &fsr, &fi);
> -    if (extended_addresses_enabled(env)) {
> +    if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {
>          /* fsr is a DFSR/IFSR value for the long descriptor
>           * translation table format, but with WnR always clear.
>           * Convert it to a 64-bit PAR.
> -- 
> 2.7.4
> 
> 
