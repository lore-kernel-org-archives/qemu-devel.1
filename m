Received: from eggs.gnu.org ([2001:4830:134:3::10]:40968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1TA-0000zC-Jl
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1T6-0001hT-HK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:14:28 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:34934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1T6-0001hF-Au
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:14:24 -0400
Received: by mail-qk0-x22f.google.com with SMTP id u21-v6so8926536qku.2
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:14:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530546340-4366-1-git-send-email-pbonzini@redhat.com>
	<1530546340-4366-5-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <744144cb-dd97-5a27-5b64-bcd3701276a0@amsat.org>
Date: Mon, 2 Jul 2018 13:14:19 -0300
MIME-Version: 1.0
In-Reply-To: <1530546340-4366-5-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 50/50] tcg: simplify !CONFIG_TCG handling of
 tb_invalidate_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 07/02/2018 12:45 PM, Paolo Bonzini wrote:
> There is no need for a stub, since tb_invalidate_phys_addr can be excised
> altogether when TCG is disabled.  This is a bit cleaner since it avoids
> using code that is clearly specific to user-mode emulation (it calls
> mmap_lock/unlock) for the !CONFIG_TCG case.

Cleaner :)

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/stubs/tcg-stub.c  | 6 ------
>  exec.c                  | 6 +++++-
>  include/exec/exec-all.h | 8 +++-----
>  3 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index 8ee85ed..76ae461 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -16,7 +16,6 @@
>  #include "tcg/tcg.h"
>  #include "exec/cpu-common.h"
>  #include "exec/exec-all.h"
> -#include "translate-all.h"
>  
>  void tb_flush(CPUState *cpu)
>  {
> @@ -25,8 +24,3 @@ void tb_flush(CPUState *cpu)
>  void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
>  {
>  }
> -
> -void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
> -                                   int is_cpu_write_access)
> -{
> -}
> diff --git a/exec.c b/exec.c
> index ee72688..4f5df07 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1027,7 +1027,7 @@ const char *parse_cpu_model(const char *cpu_model)
>      return cpu_type;
>  }
>  
> -#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_TCG)
> +#if defined(CONFIG_USER_ONLY)
>  void tb_invalidate_phys_addr(target_ulong addr)
>  {
>      mmap_lock();
> @@ -1046,6 +1046,10 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
>      MemoryRegion *mr;
>      hwaddr l = 1;
>  
> +    if (!tcg_enabled()) {
> +        return;
> +    }
> +
>      rcu_read_lock();
>      mr = address_space_translate(as, addr, &addr, &l, false, attrs);
>      if (!(memory_region_is_ram(mr)
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index cb497de..da73e3b 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -412,13 +412,11 @@ static inline uint32_t curr_cflags(void)
>  }
>  
>  /* TranslationBlock invalidate API */
> -#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
> -void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
> -#else
> -void tb_invalidate_phys_addr(target_ulong addr);
> -#endif
>  #if defined(CONFIG_USER_ONLY)
> +void tb_invalidate_phys_addr(target_ulong addr);
>  void tb_invalidate_phys_range(target_ulong start, target_ulong end);
> +#else
> +void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
>  #endif
>  void tb_flush(CPUState *cpu);
>  void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
> 
