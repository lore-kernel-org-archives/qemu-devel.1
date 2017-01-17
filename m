Received: from eggs.gnu.org ([2001:4830:134:3::10]:55947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTU1e-0007Zi-Cj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTU1d-0006Ov-CJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:42:14 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:35794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTU1c-0006NB-UR
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:42:13 -0500
Received: by mail-ua0-x22f.google.com with SMTP id y9so103201499uae.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 05:42:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484204658-28058-2-git-send-email-wei@redhat.com>
References: <1484204658-28058-1-git-send-email-wei@redhat.com>
	<1484204658-28058-2-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 13:41:50 +0000
Message-ID: <CAFEAcA-XKFXFUnpm2anZ3nG0SqzK3wdqJLgcXX79NEhQDuQSPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V1 1/4] target-arm: Add support for PMU
 register PMSELR_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 12 January 2017 at 07:04, Wei Huang <wei@redhat.com> wrote:
> This patch adds support for AArch64 register PMSELR_EL0. The existing
> PMSELR definition is revised accordingly.
>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  target/arm/cpu.h    |  1 +
>  target/arm/helper.c | 24 +++++++++++++++++++-----
>  2 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ab119e6..bd80658 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -307,6 +307,7 @@ typedef struct CPUARMState {
>          uint32_t c9_pmovsr; /* perf monitor overflow status */
>          uint32_t c9_pmxevtyper; /* perf monitor event type */
>          uint32_t c9_pmuserenr; /* perf monitor user enable */
> +        uint32_t c9_pmselr; /* perf monitor counter selection register */
>          uint32_t c9_pminten; /* perf monitor interrupt enables */
>          union { /* Memory attribute redirection */
>              struct {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8dcabbf..71adb0f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -975,6 +975,15 @@ static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      return total_ticks - env->cp15.c15_ccnt;
>  }
>
> +static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                         uint64_t value)
> +{
> +    /* only cycle counter selection is supported */
> +    if (value == 0x1f) {
> +        env->cp15.c9_pmselr = value;
> +    }

This looks like it's trying to add PMUv2 (and ARMv8) semantics
for PMSELR, but it doesn't quite get them right.

In the old PMUv1 (which is what we currently implement),
0x1f was reserved and thus effectively writing anything to
PMSELR in a system with no implemented counters was UNPREDICTABLE.
>From PMUv2 (and including v8) 0x1f is supported for selecting
the cycle counter and must cause:
 * PMXEVTYPER reads and writes to access PMCCFILTR
 * PMXEVCNTR access to be CONSTRAINED UNPREDICTABLE (we already
   get this right because 'RAZ/WI' is one of the permitted choices)

The SEL field is 5 bits and the rest is RAZ/WI so we should
mask value with 0x1f first.

Writing something to PMSELR which isn't 0x1f but is greater than
or equal to the number of implemented counters (so for QEMU, anything
but 0x1f) is permitted, but makes PMXEVTYPER/PMXEVCNTR accesses
CONSTRAINED UNPREDICTABLE. So you need to allow pmselr to read
back as the non-0x1f value, and have the handling of "is this
0x1f or not" happen in the read/write functions for PMXEVTYPER,
I think.

(Also I think it's nice when we're making an UNPREDICTABLE
or CONSTRAINED UNPREDICTABLE choice of behaviour to note it
in a comment.)

> +}
> +
>  static void pmccntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                          uint64_t value)
>  {
> @@ -1194,12 +1203,17 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>      /* Unimplemented so WI. */
>      { .name = "PMSWINC", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 4,
>        .access = PL0_W, .accessfn = pmreg_access, .type = ARM_CP_NOP },
> -    /* Since we don't implement any events, writing to PMSELR is UNPREDICTABLE.
> -     * We choose to RAZ/WI.
> -     */
>      { .name = "PMSELR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 5,
> -      .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
> -      .accessfn = pmreg_access },
> +      .access = PL0_RW, .type = ARM_CP_ALIAS,
> +      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmselr),
> +      .accessfn = pmreg_access, .writefn = pmselr_write,
> +      .raw_writefn = raw_write},
> +    { .name = "PMSELR_EL0", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 5,
> +      .access = PL0_RW, .accessfn = pmreg_access,
> +      .type = ARM_CP_IO,
> +      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmselr),

For a 64-bit register the field in the CPU struct has to be
a uint64_t, so you need to change it from the uint32_t it is
at the moment. The AArch32 regdef struct then needs to change
to use offsetoflow32() where it currently has offsetof().

> +      .writefn = pmselr_write, .raw_writefn = raw_write, },
>  #ifndef CONFIG_USER_ONLY
>      { .name = "PMCCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
>        .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_IO,
> --
> 1.8.3.1

thanks
-- PMM
