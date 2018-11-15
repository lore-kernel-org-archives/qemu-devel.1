Received: from eggs.gnu.org ([2001:4830:134:3::10]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNLqw-0003pT-7L
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNLqv-0000SQ-6q
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:54:54 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNLqu-000087-Kk
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:54:53 -0500
Received: by mail-ot1-x341.google.com with SMTP id u3so13713101ota.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 09:54:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102134112.26370-5-richard.henderson@linaro.org>
References: <20181102134112.26370-1-richard.henderson@linaro.org>
	<20181102134112.26370-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 17:54:31 +0000
Message-ID: <CAFEAcA8C1x8HRDd5JiV8sUgBM48CE+YcLH3HU2=3Vu6mSz_ACw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 4/4] target/arm: Implement the
 ARMv8.2-AA32HPD extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2 November 2018 at 13:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The bulk of the work here, beyond base HPD, is defining the TTBCR2 register.
> In addition we must check TTBCR.T2E, which is not present (RES0) for AArch64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |  8 ++++++++
>  target/arm/cpu.c    |  4 ++++
>  target/arm/helper.c | 37 +++++++++++++++++++++++++++++--------
>  3 files changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f12a6afddc..a253cdebde 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1517,6 +1517,14 @@ FIELD(ID_ISAR6, FHM, 8, 4)
>  FIELD(ID_ISAR6, SB, 12, 4)
>  FIELD(ID_ISAR6, SPECRES, 16, 4)
>
> +FIELD(ID_MMFR4, SPECSEI, 0, 4)
> +FIELD(ID_MMFR4, AC2, 4, 4)
> +FIELD(ID_MMFR4, XNX, 8, 4)
> +FIELD(ID_MMFR4, CNP, 12, 4)
> +FIELD(ID_MMFR4, HPDS, 16, 4)
> +FIELD(ID_MMFR4, LSM, 20, 4)
> +FIELD(ID_MMFR4, CCIDX, 24, 4)

Maybe add the v8.5 field too?
FIELD(ID_MMFR4, EVT, 28, 4)

> +/* Note that unlike TTBCR, writing to TTBCR2 does not require flushing
> + * qemu tlbs nor adjusting cached masks.
> + */
> +static const ARMCPRegInfo ttbcr2_reginfo = {
> +    .name = "TTBCR2", .cp = 15, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 3,

Our usual order for these fields is cp, opc1, crn, crm, opc2.

> +    .access = PL1_RW, .type = ARM_CP_ALIAS,
> +    .bank_fieldoffsets = { offsetofhigh32(CPUARMState, cp15.tcr_el[3]),
> +                           offsetofhigh32(CPUARMState, cp15.tcr_el[1]) },
> +};

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
