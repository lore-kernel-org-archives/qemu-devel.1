Received: from eggs.gnu.org ([2001:4830:134:3::10]:58502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fIL-0004V3-Ow
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fIL-0001Gd-2U
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:41:57 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6fIK-0001GK-Sv
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:41:56 -0400
Received: by mail-oi0-x244.google.com with SMTP id z8-v6so5793102oix.2
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 09:41:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-12-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-12-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 17:41:35 +0100
Message-ID: <CAFEAcA8pBXYQjbqOdSt5g1kwHbiax6iuirLOZZ0LBNxH9Ne5WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 11/22] target/arm: Fix bitmask for
 PMCCFILTR writes
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
> It was shifted to the left one bit too few.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 50eaed7..0102357 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1123,7 +1123,7 @@ static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
>  {
>      uint64_t saved_cycles = pmccntr_op_start(env);
> -    env->cp15.pmccfiltr_el0 = value & 0x7E000000;
> +    env->cp15.pmccfiltr_el0 = value & 0xfc000000;
>      pmccntr_op_finish(env, saved_cycles);
>  }
>

I wonder why we got that one wrong.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Strictly speaking, bit 26 (M) should be visible only in
the AArch64 view of the register, not the AArch32 one,
but that's a separate issue.

thanks
-- PMM
