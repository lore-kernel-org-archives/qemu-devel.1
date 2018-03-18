Received: from eggs.gnu.org ([2001:4830:134:3::10]:39395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exgzT-0004n9-GK
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exgzQ-0004VP-Cy
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:41:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-9-git-send-email-alindsay@codeaurora.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c99641e-af00-e229-02a1-7d396b5132d1@amsat.org>
Date: Sun, 18 Mar 2018 23:41:16 +0100
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-9-git-send-email-alindsay@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 08/22] target/arm: Support
 multiple EL change hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-arm@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
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

imho g_malloc() is enough.

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

You missed to fill arm_cpu_unrealizefn() with:

    QLIST_FOREACH(...) {
        QLIST_REMOVE(...);
        g_free(...);
    }

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
> 
