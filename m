Received: from eggs.gnu.org ([2001:4830:134:3::10]:56414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVmF-0001s5-6h
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVmB-00058b-8O
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:29:23 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDVm5-00055U-KY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:29:15 -0400
Received: by mail-oi1-x243.google.com with SMTP id u74-v6so26942073oia.11
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 07:29:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181019015617.22583-4-richard.henderson@linaro.org>
References: <20181019015617.22583-1-richard.henderson@linaro.org>
	<20181019015617.22583-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 15:28:52 +0100
Message-ID: <CAFEAcA81rDucGOEVYi1LCw=1eiHisuM8+yXGzaw2dMktdU99cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/arm: Flush only the TLBs
 affected by TTBR*_EL1
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
> Only the EL0 and EL1 TLBs are affected by the EL1 register,
> so flush only 2 of the 8 TLBs.
>
> In testing a boot of the Ubuntu installer to the first menu, this
> accounts for nearly all of the full tlb flushes: all but 11k of
> the 1.2M instances without the patch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ed70ac645e..3ba8e66487 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2706,14 +2706,16 @@ static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      tcr->raw_tcr = value;
>  }
>
> -static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> -                            uint64_t value)
> +static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                uint64_t value)
>  {
>      /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
>      if (cpreg_field_is_64bit(ri) &&
>          extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
>          ARMCPU *cpu = arm_env_get_cpu(env);
> -        tlb_flush(CPU(cpu));
> +        tlb_flush_by_mmuidx(CPU(cpu),
> +                            ARMMMUIdxBit_S12NSE1 |
> +                            ARMMMUIdxBit_S12NSE0);

This isn't taking account of the possibility of secure mode.
ARMMMUIdxBit_S1SE0 and ARMMMUIdxBit_S1SE1 might also be affected.

And for AArch32, this writefn is used for the secure-banked versions
of TTBR0/TTBR1, which means ARMMMUIdxBit_S1E3 may also need flushing.

thanks
-- PMM
