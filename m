Received: from eggs.gnu.org ([2001:4830:134:3::10]:37491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfTL-0006hI-6T
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfTK-00058p-BH
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:51:51 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNfTK-0004jr-6m
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:51:50 -0500
Received: by mail-oi1-x244.google.com with SMTP id 192-v6so19832245oii.6
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 06:51:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181105185046.2802-3-aaron@os.amperecomputing.com>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
	<20181105185046.2802-3-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 14:50:58 +0000
Message-ID: <CAFEAcA-ryywQJsequ9F2Yhb2So0U5XuojF5B2o6ttPA3hN732Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 02/12] target/arm: Reorganize PMCCNTR
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 5 November 2018 at 18:51, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
> pmccntr_read and pmccntr_write contained duplicate code that was already
> being handled by pmccntr_sync. Consolidate the duplicated code into two
> functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
> c15_ccnt in CPUARMState so that we can simultaneously save both the
> architectural register value and the last underlying cycle count - this
> ensures time isn't lost and will also allow us to access the 'old'
> architectural register value in order to detect overflows in later
> patches.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>


>  /**
> - * pmccntr_sync
> + * pmccntr_op_start/finish
> + * @env: CPUARMState
> + *
> + * Convert the counter in the PMCCNTR between its delta form (the typical mode
> + * when it's enabled) and the guest-visible value. These two calls must always
> + * surround any action which might affect the counter.
> + */
> +void pmccntr_op_start(CPUARMState *env);
> +void pmccntr_op_finish(CPUARMState *env);
> +
> +/**
> + * pmu_op_start/finish
>   * @env: CPUARMState
>   *
> - * Synchronises the counter in the PMCCNTR. This must always be called twice,
> - * once before any action that might affect the timer and again afterwards.
> - * The function is used to swap the state of the register if required.
> - * This only happens when not in user mode (!CONFIG_USER_ONLY)
> + * Convert all PMU counters between their delta form (the typical mode when
> + * they are enabled) and the guest-visible values. These two calls must
> + * surround any action which might affect the counters, and the return value
> + * from pmu_op_start must be supplied as the second argument to pmu_op_finish.
>   */
> -void pmccntr_sync(CPUARMState *env);
> +void pmu_op_start(CPUARMState *env);
> +void pmu_op_finish(CPUARMState *env);

The comment says that pmu_op_start returns a value and pmu_op_finish
has a second argument, but the prototypes disagree...

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
so if this turns out to be the only problem I can fix it up when
I apply it to my tree, if you provide suitable new comment text.

thanks
-- PMM
