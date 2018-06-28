Received: from eggs.gnu.org ([2001:4830:134:3::10]:51530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZyZ-0004Zb-Pi
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZyY-0004HT-Dh
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:40:55 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYZyX-0004Gb-WA
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:40:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id k81-v6so5790536oib.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:40:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-2-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-2-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:40:32 +0100
Message-ID: <CAFEAcA8601LbuOOARb0KoNLjJep3-ND=Kf44OqW6NXdVtnNocw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 01/13] target/arm: Reorganize PMCCNTR
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
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
> index 8488273..ba2c876 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -467,10 +467,20 @@ typedef struct CPUARMState {
>          uint64_t oslsr_el1; /* OS Lock Status */
>          uint64_t mdcr_el2;
>          uint64_t mdcr_el3;
> -        /* If the counter is enabled, this stores the last time the counter
> -         * was reset. Otherwise it stores the counter value
> +        /* Stores the architectural value of the counter *the last time it was
> +         * updated* by pmccntr_op_start. Accesses should always be surrounded
> +         * by pmccntr_op_start/pmccntr_op_finish to guarantee the latest
> +         * architecturally-corect value is being read/set.

"correct"

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

I had a look through the patchset, and I still can't see
anything here which indicates how we're handling migration.

If this field is only ever used as a temporary while we're
between op_start and op_finish, then we can just return it from
start and take it as an argument to finish, and we're fine
(migration of the PMCCNTR_EL0 register will be done by calling
its readfn on the source and its writefn on the destination).

If there's a reason for having this be a field in the state struct
(I think you said counter overflow)? then we need to be sure that
migration is going to do the right thing and that we don't for instance
lose overflow indications during a migration.

>          uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
>          uint64_t vpidr_el2; /* Virtualization Processor ID Register */
>          uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register */
> @@ -924,15 +934,17 @@ int cpu_arm_signal_handler(int host_signum, void *pinfo,
>                             void *puc);
>
>  /**
> - * pmccntr_sync
> + * pmccntr_op_start/finish
>   * @env: CPUARMState
>   *
> - * Synchronises the counter in the PMCCNTR. This must always be called twice,
> - * once before any action that might affect the timer and again afterwards.
> - * The function is used to swap the state of the register if required.
> - * This only happens when not in user mode (!CONFIG_USER_ONLY)
> + * Convert the counter in the PMCCNTR between its delta form (the typical mode
> + * when it's enabled) and the guest-visible value. These two calls must always
> + * surround any action which might affect the counter, and the return value
> + * from pmccntr_op_start must be supplied as the second argument to
> + * pmccntr_op_finish.
>   */
> -void pmccntr_sync(CPUARMState *env);
> +void pmccntr_op_start(CPUARMState *env);
> +void pmccntr_op_finish(CPUARMState *env);

The comment says pmccntr_op_start() returns a value but the
prototype says it doesn't...

thanks
-- PMM
