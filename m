Received: from eggs.gnu.org ([2001:4830:134:3::10]:48076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSq1-0006zx-3t
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSq0-0004qQ-6i
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:28:33 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffSpz-0004pj-OQ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:28:32 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so3193651ois.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:28:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-14-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-14-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 17:28:10 +0100
Message-ID: <CAFEAcA8v=c6Q-Ftoq-JWk2LLnv8hry2gyOrgsxAV5GSs_6eo1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 13/13] target/arm: Send interrupts on
 PMU counter overflow
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
> Setup a QEMUTimer to get a callback when we expect counters to next
> overflow and trigger an interrupt at that time.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.c    |  11 +++++
>  target/arm/cpu.h    |   7 +++
>  target/arm/helper.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 141 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 2f5b16a..7b3c137 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -743,6 +743,12 @@ static void arm_cpu_finalizefn(Object *obj)
>          QLIST_REMOVE(hook, node);
>          g_free(hook);
>      }
> +#ifndef CONFIG_USER_ONLY
> +    if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
> +        timer_deinit(cpu->pmu_timer);
> +        timer_free(cpu->pmu_timer);
> +    }
> +#endif
>  }
>
>  static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
> @@ -937,6 +943,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>              arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
>              arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
>          }
> +
> +#ifndef CONFIG_USER_ONLY
> +        cpu->pmu_timer = timer_new(QEMU_CLOCK_VIRTUAL, 1, arm_pmu_timer_cb,
> +                cpu);

This is a confusing way to write timer_new_ns().

> +#endif

>  #define SUPPORTED_EVENT_SENTINEL UINT16_MAX
>  static const pm_event pm_events[] = {
>      { .number = 0x000, /* SW_INCR */
>        .supported = event_always_supported,
> -      .get_count = swinc_get_count
> +      .get_count = swinc_get_count,
> +      .ns_per_count = swinc_ns_per

If you always put trailing commas on the end of the last line in
a struct initializer, then you don't need to modify the preceding
line in later patches which add a new line to the initializer.

The meat of the patch is beyond me at this time of the
afternoon :-)

thanks
-- PMM
