Received: from eggs.gnu.org ([2001:4830:134:3::10]:54942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fDO-0001LN-DP
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fDN-0005Fm-7u
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:36:50 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6fDM-0005FI-Vd
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:36:49 -0400
Received: by mail-oi0-x241.google.com with SMTP id 188-v6so5755085oih.8
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 09:36:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-9-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-9-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 17:36:27 +0100
Message-ID: <CAFEAcA8cMNUQ9Tj+ft93Yv5fEnV-kGnhZoiTRZBnHKs=wfTz=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 08/22] target/arm: Support multiple EL
 change hooks
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
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.c       | 15 ++++++++++-----
>  target/arm/cpu.h       | 23 ++++++++++++-----------
>  target/arm/internals.h |  7 ++++---
>  3 files changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 072cbbf..5f782bf 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -55,13 +55,16 @@ static bool arm_cpu_has_work(CPUState *cs)
>           | CPU_INTERRUPT_EXITTB);
>  }
>
> -void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHook *hook,
> +void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
>                                   void *opaque)
>  {
> -    /* We currently only support registering a single hook function */
> -    assert(!cpu->el_change_hook);
> -    cpu->el_change_hook = hook;
> -    cpu->el_change_hook_opaque = opaque;
> +    ARMELChangeHook *entry;
> +    entry = g_malloc0(sizeof (*entry));

g_new0(ARMELChangeHook, 1) is nicer for initializing a thing of
known size.

> +
> +    entry->hook = hook;
> +    entry->opaque = opaque;
> +
> +    QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
>  }
>
>  static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
> @@ -744,6 +747,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>
> +    QLIST_INIT(&cpu->el_change_hooks);
> +

If you put this in arm_cpu_initfn() you don't have to wonder
whether anybody's calling arm_register_el_change_hook() after
the CPU object has been created but before it is realized...

>      /* Some features automatically imply others: */
>      if (arm_feature(env, ARM_FEATURE_V8)) {
>          set_feature(env, ARM_FEATURE_V7);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f17592b..3b45d3d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -633,11 +633,17 @@ typedef struct CPUARMState {
>
>  /**
>   * ARMELChangeHook:
> - * type of a function which can be registered via arm_register_el_change_hook()
> - * to get callbacks when the CPU changes its exception level or mode.
> + * Support registering functions with ARMELChangeHookFn's signature via
> + * arm_register_el_change_hook() to get callbacks when the CPU changes its
> + * exception level or mode.
>   */

This is supposed to be the doc comment for the type,
which I think was fine as it is, apart from the name change.
If you want to also have a doc comment for the struct type
that's fine but would be something different (and is less
necessary, because the struct type is internal to the CPU
whereas the function type is part of its API to the rest of
the system).

> -typedef void ARMELChangeHook(ARMCPU *cpu, void *opaque);
> -
> +typedef void ARMELChangeHookFn(ARMCPU *cpu, void *opaque);
> +typedef struct ARMELChangeHook ARMELChangeHook;
> +struct ARMELChangeHook {
> +    ARMELChangeHookFn *hook;
> +    void *opaque;
> +    QLIST_ENTRY(ARMELChangeHook) node;
> +};
>
>  /* These values map onto the return values for
>   * QEMU_PSCI_0_2_FN_AFFINITY_INFO */
> @@ -826,8 +832,7 @@ struct ARMCPU {
>       */
>      bool cfgend;
>
> -    ARMELChangeHook *el_change_hook;
> -    void *el_change_hook_opaque;
> +    QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
>
>      int32_t node_id; /* NUMA node this CPU belongs to */
>
> @@ -2895,12 +2900,8 @@ static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
>   * CPU changes exception level or mode. The hook function will be
>   * passed a pointer to the ARMCPU and the opaque data pointer passed
>   * to this function when the hook was registered.
> - *
> - * Note that we currently only support registering a single hook function,
> - * and will assert if this function is called twice.
> - * This facility is intended for the use of the GICv3 emulation.
>   */
> -void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHook *hook,
> +void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
>                                   void *opaque);
>
>  /**
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 47cc224..7df3eda 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -727,11 +727,12 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>                                     int mmu_idx, MemTxAttrs attrs,
>                                     MemTxResult response, uintptr_t retaddr);
>
> -/* Call the EL change hook if one has been registered */
> +/* Call any registered EL change hooks */
>  static inline void arm_call_el_change_hook(ARMCPU *cpu)
>  {
> -    if (cpu->el_change_hook) {
> -        cpu->el_change_hook(cpu, cpu->el_change_hook_opaque);
> +    ARMELChangeHook *hook, *next;
> +    QLIST_FOREACH_SAFE(hook, &cpu->el_change_hooks, node, next) {
> +        hook->hook(cpu, hook->opaque);
>      }
>  }
>

thanks
-- PMM
