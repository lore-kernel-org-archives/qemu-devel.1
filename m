Received: from eggs.gnu.org ([2001:4830:134:3::10]:36600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fPh-0002ck-6w
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fPg-0006Jh-6J
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:49:33 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6fPf-0006JF-Qw
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:49:32 -0400
Received: by mail-ot0-x243.google.com with SMTP id v64-v6so6739519otb.13
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 09:49:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-10-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-10-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 17:49:10 +0100
Message-ID: <CAFEAcA9UpNW8q+vBKDskhAMVxHh4QUOJ5diP8AR6mpMRk+enBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 09/22] target/arm: Add pre-EL change
 hooks
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
> Because the design of the PMU requires that the counter values be
> converted between their delta and guest-visible forms for mode
> filtering, an additional hook which occurs before the EL is changed is
> necessary.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.c       | 13 +++++++++++++
>  target/arm/cpu.h       | 12 ++++++++----
>  target/arm/helper.c    | 14 ++++++++------
>  target/arm/internals.h |  7 +++++++
>  target/arm/op_helper.c |  8 ++++++++
>  5 files changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5f782bf..a2cb21e 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -55,6 +55,18 @@ static bool arm_cpu_has_work(CPUState *cs)
>           | CPU_INTERRUPT_EXITTB);
>  }
>
> +void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
> +                                 void *opaque)
> +{
> +    ARMELChangeHook *entry;
> +    entry = g_malloc0(sizeof (*entry));

g_new0().

> +
> +    entry->hook = hook;
> +    entry->opaque = opaque;
> +
> +    QLIST_INSERT_HEAD(&cpu->pre_el_change_hooks, entry, node);
> +}
> +
>  void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
>                                   void *opaque)
>  {
> @@ -747,6 +759,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>
> +    QLIST_INIT(&cpu->pre_el_change_hooks);
>      QLIST_INIT(&cpu->el_change_hooks);
>
>      /* Some features automatically imply others: */
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 3b45d3d..b0ef727 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -832,6 +832,7 @@ struct ARMCPU {
>       */
>      bool cfgend;
>
> +    QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
>      QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
>
>      int32_t node_id; /* NUMA node this CPU belongs to */
> @@ -2895,12 +2896,15 @@ static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
>  #endif
>
>  /**
> + * arm_register_pre_el_change_hook:
>   * arm_register_el_change_hook:
> - * Register a hook function which will be called back whenever this
> - * CPU changes exception level or mode. The hook function will be
> - * passed a pointer to the ARMCPU and the opaque data pointer passed
> - * to this function when the hook was registered.
> + * Register a hook function which will be called back before or after this CPU
> + * changes exception level or mode. The hook function will be passed a pointer
> + * to the ARMCPU and the opaque data pointer passed to this function when the
> + * hook was registered.
>   */

I would just have one doc comment for each function, rather than
trying to share. (Some day we may actually autogenerate HTML docs
from these comments...)

Do we make the guarantee that if we call the pre-change hook
then we will definitely subsequently call the post-change hook?
(ie does the PMU hook rely on that?)

Otherwise looks OK.

thanks
-- PMM
