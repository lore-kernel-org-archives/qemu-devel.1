Received: from eggs.gnu.org ([2001:4830:134:3::10]:40114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6g1b-0004sV-05
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6g1a-0007se-4b
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:28:43 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6g1Z-0007sP-Uz
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:28:42 -0400
Received: by mail-oi0-x241.google.com with SMTP id f63-v6so5923811oic.4
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 10:28:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-17-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-17-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 18:28:20 +0100
Message-ID: <CAFEAcA8Z0hiFD+VZpvje_76rG+W4NKuEJhNp6cUxUK9eA6+=1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 16/22] target/arm: Implement PMOVSSET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 16 March 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Adding an array for v7VE+ CP registers was necessary so that PMOVSSET
> wasn't defined for all v7 processors.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d4f06e6..f5e800e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1241,9 +1241,17 @@ static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                           uint64_t value)
>  {
> +    value &= PMU_COUNTER_MASK(env);
>      env->cp15.c9_pmovsr &= ~value;
>  }
>
> +static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                         uint64_t value)
> +{
> +    value &= PMU_COUNTER_MASK(env);
> +    env->cp15.c9_pmovsr |= value;
> +}
> +
>  static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> @@ -1406,7 +1414,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcnten),
>        .writefn = pmcntenclr_write },
>      { .name = "PMOVSR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 3,
> -      .access = PL0_RW, .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
> +      .access = PL0_RW, .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
>        .accessfn = pmreg_access,
>        .writefn = pmovsr_write,
>        .raw_writefn = raw_write },

This change is half of a bug fix (the other half being to make the
field in the CPU struct be uint64_t rather than uint32_t). That
bug fix should be in a patch of its own.

pmuserenr has the same bug (uint32_t state field accessed by
a STATE_AA64 sysreg).

thanks
-- PMM
