Received: from eggs.gnu.org ([2001:4830:134:3::10]:51292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4SIR-00044G-9s
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4SIQ-0006p3-1K
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:52:39 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:54417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4SIP-0006mi-PZ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:52:37 -0400
Received: by mail-wm0-x230.google.com with SMTP id i124so4114398wmf.3
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 06:52:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506737310-21880-6-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-6-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 14:52:15 +0100
Message-ID: <CAFEAcA8iTXQC6JtimEwS1ZpU5TYc3XyfSnX=W2J2orJ25ugpZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/13] target/arm: Allow AArch32 access for
 PMCCFILTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Also fix the existing bitmask for writes.

"Also" in a commit message can often be translated as
"This should really go in a separate commit, but" :-)

> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 54070a3..fcc2fcf 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1059,10 +1059,25 @@ static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
>  {
>      pmccntr_sync(env);
> -    env->cp15.pmccfiltr_el0 = value & 0x7E000000;
> +    env->cp15.pmccfiltr_el0 = value & 0xfc000000;
>      pmccntr_sync(env);
>  }
>
> +static void pmccfiltr_write_a32(CPUARMState *env, const ARMCPRegInfo *ri,
> +                            uint64_t value)
> +{
> +    pmccntr_sync(env);
> +    env->cp15.pmccfiltr_el0 = (env->cp15.pmccfiltr_el0 & 0x04000000) |
> +        (value & 0xf8000000); /* M is not visible in AArch32 */

I think the comment would look better on its own line.

> +    pmccntr_sync(env);
> +}

I think we could probably benefit from defining constants for
the bit names in this register.

> +
> +static uint64_t pmccfiltr_read_a32(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /* M is not visible in AArch32 */
> +    return env->cp15.pmccfiltr_el0 & 0xf8000000;
> +}
> +
>  static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
>  {
> @@ -1280,6 +1295,12 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .type = ARM_CP_IO,
>        .readfn = pmccntr_read, .writefn = pmccntr_write, },
>  #endif
> +    { .name = "PMCCFILTR", .cp = 15, .opc1 = 0, .crn = 14, .crm = 15, .opc2 = 7,
> +      .writefn = pmccfiltr_write_a32, .readfn = pmccfiltr_read_a32,
> +      .access = PL0_RW, .accessfn = pmreg_access,
> +      .type = ARM_CP_ALIAS,
> +      .fieldoffset = offsetoflow32(CPUARMState, cp15.pmccfiltr_el0),
> +      .resetvalue = 0, },
>      { .name = "PMCCFILTR_EL0", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 15, .opc2 = 7,
>        .writefn = pmccfiltr_write,

If you're defining both a .readfn and a .writefn for a register
you don't need to provide a .fieldoffset.

thanks
-- PMM
