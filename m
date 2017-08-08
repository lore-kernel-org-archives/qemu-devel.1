Received: from eggs.gnu.org ([2001:4830:134:3::10]:35497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dfDMj-0005Jo-L9
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dfDMe-0004QU-EV
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:52:45 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:34413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dfDMe-0004Pk-9a
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:52:40 -0400
Received: by mail-vk0-x241.google.com with SMTP id d124so2958184vkf.1
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 15:52:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1502196172-13818-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a57e650e-d37e-e1fa-d257-c715931d8a74@twiddle.net>
Date: Tue, 8 Aug 2017 15:52:04 -0700
MIME-Version: 1.0
In-Reply-To: <1502196172-13818-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/alpha: Switch to
 do_transaction_failed() hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/08/2017 05:42 AM, Peter Maydell wrote:
> Switch the alpha target from the old unassigned_access hook
> to the new do_transaction_failed hook. This allows us to
> resolve a ??? in the old hook implementation.
> 
> The only part of the alpha target that does physical
> memory accesses is reading the page table -- add a
> TODO comment there to the effect that we should handle
> bus faults on page table walks. (Since the palcode
> doesn't actually do anything useful on a bus fault anyway
> it's a bit moot for now.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based-on: 1501867249-1924-1-git-send-email-peter.maydell@linaro.org
> This patch sits on top of the series adding the new hook.
> 
> The comment in the page walk code could probably be
> rephrased by somebody who knows what the palcode
> behaviour in the busfault-on-table-walk case is.
> 
> This patch isn't really tested (just 'make check' and
> checking that qemu-system-alpha can start up).
> ---
>  target/alpha/cpu.h        |  8 +++++---
>  target/alpha/cpu.c        |  2 +-
>  target/alpha/helper.c     |  8 ++++++++
>  target/alpha/mem_helper.c | 19 ++++++++++---------
>  4 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index e95be2b..389e1a4 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -488,9 +488,11 @@ void cpu_alpha_store_fpcr (CPUAlphaState *env, uint64_t val);
>  uint64_t cpu_alpha_load_gr(CPUAlphaState *env, unsigned reg);
>  void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val);
>  #ifndef CONFIG_USER_ONLY
> -QEMU_NORETURN void alpha_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
> -                                               bool is_write, bool is_exec,
> -                                               int unused, unsigned size);
> +void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> +                                     vaddr addr, unsigned size,
> +                                     MMUAccessType access_type,
> +                                     int mmu_idx, MemTxAttrs attrs,
> +                                     MemTxResult response, uintptr_t retaddr);
>  #endif
>  
>  static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, target_ulong *pc,
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 76150f4..4d49fd0 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -307,7 +307,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
>  #ifdef CONFIG_USER_ONLY
>      cc->handle_mmu_fault = alpha_cpu_handle_mmu_fault;
>  #else
> -    cc->do_unassigned_access = alpha_cpu_unassigned_access;
> +    cc->do_transaction_failed = alpha_cpu_do_transaction_failed;
>      cc->do_unaligned_access = alpha_cpu_do_unaligned_access;
>      cc->get_phys_page_debug = alpha_cpu_get_phys_page_debug;
>      dc->vmsd = &vmstate_alpha_cpu;
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 34121f4..36407f7 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -163,6 +163,14 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
>  
>      pt = env->ptbr;
>  
> +    /* TODO: rather than using ldq_phys() to read the page table we should
> +     * use address_space_ldq() so that we can handle the case when
> +     * the page table read gives a bus fault, rather than ignoring it.
> +     * For the existing code the zero data that ldq_phys will return for
> +     * an access to invalid memory will result in our treating the page
> +     * table as invalid, which may even be the right behaviour.
> +     */

FWIW, I believe the proper behaviour is to signal a machine check.
I'd have to re-read the MILO source to be sure.

That said, this looks good.  If I have a chance, I'll throw together a small
test case for this.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
