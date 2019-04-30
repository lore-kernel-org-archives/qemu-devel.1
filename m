Received: from eggs.gnu.org ([209.51.188.92]:38104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLS4D-00038B-9B
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLS4C-0006AB-2f
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:41:01 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLS4B-00069d-SM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:41:00 -0400
Received: by mail-ot1-x341.google.com with SMTP id b18so2734598otq.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190223023957.18865-1-richard.henderson@linaro.org>
	<20190223023957.18865-6-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:40:47 +0100
Message-ID: <CAFEAcA_60sosZCU8VNg6dd1toZON6D5sC8xgZU1tWpaspu=gHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 5/6] target/arm: Conditionalize DBGDIDR vs
 ID_AA64DFR0_EL1 assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Sat, 23 Feb 2019 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Only perform the assert when both registers exist.
> Extract the variables from ID_AA64DFR0_EL1 for AArch64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +    if (have_aa32) {
> +        ARMCPRegInfo dbgdidr = {
> +            .name = "DBGDIDR", .cp = 14, .crn = 0, .crm = 0,
> +            .opc1 = 0, .opc2 = 0, .access = PL0_R, .accessfn = access_tda,
> +            .type = ARM_CP_CONST, .resetvalue = cpu->dbgdidr,
> +        };
> +        define_one_arm_cp_reg(cpu, &dbgdidr);
> +    }

So if only EL0 has AArch32 it doesn't architecturally require
that this AArch32 system register doesn't exist, because the
register is still readable from EL0. The Arm ARM says that
"implementation of this register is optional and deprecated".
I would suggest that we should probably go with "implement the
register if cpu->dbgdidr is non-zero", since at least bit 15
must be set so zero isn't a valid real value for it.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
