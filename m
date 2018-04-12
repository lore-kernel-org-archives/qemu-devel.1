Received: from eggs.gnu.org ([2001:4830:134:3::10]:37681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ew2-0006tF-9z
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ew1-0004Xz-Ak
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:18:54 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:43195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6ew1-0004Xo-5T
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:18:53 -0400
Received: by mail-ot0-x243.google.com with SMTP id d9-v6so6634148oth.10
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 09:18:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-6-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-6-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 17:18:32 +0100
Message-ID: <CAFEAcA9Hd5dsfPM=ggepk2MxFJdxHB1uiJzwpDy5628D7JF5ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 05/22] target/arm: Reorganize PMCCNTR
 read, write, sync
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
> pmccntr_read and pmccntr_write contained duplicate code that was already
> being handled by pmccntr_sync. Split pmccntr_sync into pmccntr_op_start
> and pmccntr_op_finish, passing the clock value between the two, to avoid
> losing time between the two calls.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 101 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 56 insertions(+), 45 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5634561..6480b80 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1000,28 +1000,58 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
>
>      return true;
>  }
> -
> -void pmccntr_sync(CPUARMState *env)

If you configure your git to use the 'histogram' diff algorithm
("git config --global diff.algorithm histogram", or edit ~/.gitconfig
equivalently), does it make git format-patch make less of a mess
of this commit ?

> +/*
> + * Ensure c15_ccnt is the guest-visible count so that operations such as
> + * enabling/disabling the counter or filtering, modifying the count itself,
> + * etc. can be done logically. This is essentially a no-op if the counter is
> + * not enabled at the time of the call.
> + *
> + * The current cycle count is returned so that it can be passed into the paired
> + * pmccntr_op_finish() call which must follow each call to pmccntr_op_start().
> + */
> +uint64_t pmccntr_op_start(CPUARMState *env)
>  {
> -    uint64_t temp_ticks;
> -
> -    temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +    uint64_t cycles = 0;
> +#ifndef CONFIG_USER_ONLY
> +    cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>                            ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> +#endif

Is this ifdef necessary? You have a do-nothing version of
pmccntr_op_start() for CONFIG_USER_ONLY later on, so presumably
this one is already inside a suitable ifndef.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
