Received: from eggs.gnu.org ([2001:4830:134:3::10]:50751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdxD-0004XM-Ca
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdxC-0007N5-HW
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:31:07 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZdxC-0007MH-Ag
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:31:06 -0500
Received: by mail-wm0-x22c.google.com with SMTP id b65so29183711wmf.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 05:31:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485875745-27741-5-git-send-email-wei@redhat.com>
References: <1485875745-27741-1-git-send-email-wei@redhat.com>
	<1485875745-27741-5-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 13:30:44 +0000
Message-ID: <CAFEAcA8-Lt4z1uiN9dcuak3-hA3d_1fL7+iL2dOm9msrrq69NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V2 4/5] target-arm: Add support for PMU
 register PMINTENSET_EL1
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

On 31 January 2017 at 15:15, Wei Huang <wei@redhat.com> wrote:
> This patch adds access support for PMINTENSET_EL1.
>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  target/arm/cpu.h    |  2 +-
>  target/arm/helper.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ce02044..42aaea9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -310,7 +310,7 @@ typedef struct CPUARMState {
>          uint64_t c9_pmxevtyper; /* perf monitor event type */
>          uint32_t c9_pmuserenr; /* perf monitor user enable */
>          uint64_t c9_pmselr; /* perf monitor counter selection register */
> -        uint32_t c9_pminten; /* perf monitor interrupt enables */
> +        uint64_t c9_pminten; /* perf monitor interrupt enables */
>          union { /* Memory attribute redirection */
>              struct {
>  #ifdef HOST_WORDS_BIGENDIAN
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6b8460a..b028042 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1272,9 +1272,17 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .writefn = pmuserenr_write, .raw_writefn = raw_write },
>      { .name = "PMINTENSET", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 1,
>        .access = PL1_RW, .accessfn = access_tpm,
> -      .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
> +      .type = ARM_CP_ALIAS,
> +      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pminten),
>        .resetvalue = 0,
>        .writefn = pmintenset_write, .raw_writefn = raw_write },
> +    { .name = "PMINTENSET_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 1,
> +      .access = PL1_RW, .accessfn = access_tpm,
> +      .type = ARM_CP_IO,
> +      .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
> +      .writefn = pmintenset_write, .raw_writefn = raw_write,
> +      .resetvalue = 0x0 },
>      { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
>        .access = PL1_RW, .accessfn = access_tpm, .type = ARM_CP_ALIAS,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),

Add PMINTENCLR_EL1 as well, please.

thanks
-- PMM
