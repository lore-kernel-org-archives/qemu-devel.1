Received: from eggs.gnu.org ([2001:4830:134:3::10]:58453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTU4I-00011X-CL
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTU3S-0007yc-QB
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:44:58 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:35449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTU3S-0007y2-Gx
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:44:06 -0500
Received: by mail-ua0-x229.google.com with SMTP id y9so103238528uae.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 05:44:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484204658-28058-3-git-send-email-wei@redhat.com>
References: <1484204658-28058-1-git-send-email-wei@redhat.com>
	<1484204658-28058-3-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 13:43:45 +0000
Message-ID: <CAFEAcA-DAbCj67g8K+zvAPf_m4V2cP2L9ZJM=Vu7gjdkd+4OvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V1 2/4] target-arm: Add support for AArch64
 PMU register PMXEVTYPER_EL0
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
> In order to support Linux perf, which uses PMXEVTYPER register,
> this patch adds access support for PMXEVTYPER_EL0.
>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  target/arm/helper.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 71adb0f..9044a33 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1233,10 +1233,17 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .fieldoffset = offsetof(CPUARMState, cp15.pmccfiltr_el0),
>        .resetvalue = 0, },
>      { .name = "PMXEVTYPER", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 1,
> -      .access = PL0_RW,
> +      .access = PL0_RW, .type = ARM_CP_ALIAS,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pmxevtyper),
>        .accessfn = pmreg_access, .writefn = pmxevtyper_write,
>        .raw_writefn = raw_write },
> +    { .name = "PMXEVTYPER_EL0", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 1,
> +      .access = PL0_RW, .accessfn = pmreg_access,
> +      .type = ARM_CP_IO,

Why is this marked as ARM_CP_IO ?

> +      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmxevtyper),
> +      .writefn = pmxevtyper_write, .raw_writefn = raw_write,
> +      .resetvalue = 0x0 },

As with patch 1, the c9_pmxevtyper field needs to become a uint64_t
so you can use it in a 64-bit regdef.
(Also the semantics of PMXEVTYPER need to change, see comments on
patch 1.)

>      /* Unimplemented, RAZ/WI. */
>      { .name = "PMXEVCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 2,
>        .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,

thanks
-- PMM
