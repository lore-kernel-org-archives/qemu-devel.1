Received: from eggs.gnu.org ([2001:4830:134:3::10]:43104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9T79-0006Xs-Fv
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9T78-0008Eb-Hu
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:17:59 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9T78-0008E4-C2
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:17:58 -0400
Received: by mail-ot0-x244.google.com with SMTP id i5-v6so9067899oth.1
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:17:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523997485-1905-4-git-send-email-alindsay@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
	<1523997485-1905-4-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 11:17:36 +0100
Message-ID: <CAFEAcA_g1Bb=-cj+QToHDypZPiqw_U5YioRWfDSs0Ano3PqDTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 03/21] target/arm: Reorganize PMCCNTR
 accesses
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

On 17 April 2018 at 21:37, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> pmccntr_read and pmccntr_write contained duplicate code that was already
> being handled by pmccntr_sync. Consolidate the duplicated code into two
> functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
> c15_ccnt in CPUARMState so that we can simultaneously save both the
> architectural register value and the last underlying cycle count - this
> ensure time isn't lost and will also allow us to access the 'old'
> architectural register value in order to detect overflows in later
> patches.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.h    |  28 ++++++++++-----
>  target/arm/helper.c | 100 ++++++++++++++++++++++++++++------------------------
>  2 files changed, 73 insertions(+), 55 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 19a0c03..04041db 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -454,10 +454,20 @@ typedef struct CPUARMState {
>          uint64_t oslsr_el1; /* OS Lock Status */
>          uint64_t mdcr_el2;
>          uint64_t mdcr_el3;
> -        /* If the counter is enabled, this stores the last time the counter
> -         * was reset. Otherwise it stores the counter value
> +        /* Stores the architectural value of the counter *the last time it was
> +         * updated* by pmccntr_op_start. Accesses should always be surrounded
> +         * by pmccntr_op_start/pmccntr_op_finish to guarantee the latest
> +         * architecturally-corect value is being read/set.
>           */
>          uint64_t c15_ccnt;
> +        /* Stores the delta between the architectural value and the underlying
> +         * cycle count during normal operation. It is used to update c15_ccnt
> +         * to be the correct architectural value before accesses. During
> +         * accesses, c15_ccnt_delta contains the underlying count being used
> +         * for the access, after which it reverts to the delta value in
> +         * pmccntr_op_finish.
> +         */
> +        uint64_t c15_ccnt_delta;

So the key question here is: how does this work for VM migration?

thanks
-- PMM
