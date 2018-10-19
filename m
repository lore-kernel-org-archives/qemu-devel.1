Received: from eggs.gnu.org ([2001:4830:134:3::10]:54218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVgA-0007Vp-5f
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVg9-0001Vt-F3
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:23:06 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDVg9-0001UZ-9G
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:23:05 -0400
Received: by mail-ot1-x342.google.com with SMTP id c23so31560119otl.9
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 07:23:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181019015617.22583-3-richard.henderson@linaro.org>
References: <20181019015617.22583-1-richard.henderson@linaro.org>
	<20181019015617.22583-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 15:22:43 +0100
Message-ID: <CAFEAcA_SsZE8y7UxGqemfshT6+UzGqLP6C-ZGWb_vvPDaR=Oqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] target/arm: Only flush tlb if ASID
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2018 at 02:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Since QEMU does not implement ASIDs, changes to the ASID must flush the
> tlb.  However, if the ASID does not change there is no reason to flush.
>
> In testing a boot of the Ubuntu installer to the first menu, this reduces
> the number of flushes by 30%, or nearly 600k instances.
>
> Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 24bbde4f76..ed70ac645e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2709,12 +2709,10 @@ static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
>  {
> -    /* 64 bit accesses to the TTBRs can change the ASID and so we
> -     * must flush the TLB.
> -     */
> -    if (cpreg_field_is_64bit(ri)) {
> +    /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
> +    if (cpreg_field_is_64bit(ri) &&
> +        extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
>          ARMCPU *cpu = arm_env_get_cpu(env);
> -
>          tlb_flush(CPU(cpu));
>      }
>      raw_write(env, ri, value);
> --
> 2.17.2

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
