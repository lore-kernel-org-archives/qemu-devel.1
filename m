Received: from eggs.gnu.org ([2001:4830:134:3::10]:46898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fYnmG-0005AH-EV
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fYnmC-0001nV-Cj
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:25:08 -0400
Received: from mail.ispras.ru ([83.149.199.45]:54702)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fYnmB-0001jf-Ti
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:25:04 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180614193147.29680-15-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-15-richard.henderson@linaro.org>
Date: Fri, 29 Jun 2018 10:25:03 +0300
Message-ID: <000601d40f7a$4be320b0$e3a96210$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PULL,
 14/18] translate-all: discard TB when tb_link_page returns an
 existing matching TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Richard Henderson' <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "'Emilio G. Cota'" <cota@braap.org>

This patch breaks record/replay.

I run execution recording of the WindowsXP machine with the following script:

./bin/qemu-system-i386 -d in_asm,exec -D xp_save.log -global apic-common.vapic=off \
  -icount shift=7,rr=record,rrfile=xp0.replay \
  -drive file=./images/xp_sp2.qcow2,if=none,id=img-direct,snapshot \
  -drive driver=blkreplay,if=none,image=img-direct,id=img-replay \
  -device ide-hd,drive=img-replay -net none -m 512M

QEMU fails at some moment. Here are the contents of the log:

----------------
IN: 
0x806ee2d0:  33 c0                    xorl     %eax, %eax
0x806ee2d2:  8a c1                    movb     %cl, %al
0x806ee2d4:  33 c9                    xorl     %ecx, %ecx
0x806ee2d6:  8a 88 58 e2 6e 80        movb     -0x7f911da8(%eax), %cl
0x806ee2dc:  89 0d 80 00 fe ff        movl     %ecx, 0xfffe0080
0x806ee2e2:  a1 80 00 fe ff           movl     0xfffe0080, %eax
0x806ee2e7:  c3                       retl     

Trace 0: 0x7fdc103b16a0 [00000000/806ee2d0/0x4000b0]
qemu: fatal: cpu_io_recompile: could not find TB for pc=0x7fec24fde2de
EAX=00000001 EBX=00006901 ECX=0000003d EDX=00000ffc
ESI=040d78c0 EDI=0000031f EBP=f878fc60 ESP=f878fc54
EIP=806ee2d0 EFL=00000202 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
....


Pavel Dovgalyuk

> -----Original Message-----
> From: Richard Henderson [mailto:richard.henderson@linaro.org]
> Sent: Thursday, June 14, 2018 10:32 PM
> To: qemu-devel@nongnu.org
> Cc: peter.maydell@linaro.org; Emilio G. Cota
> Subject: [PULL, 14/18] translate-all: discard TB when tb_link_page returns an existing
> matching TB
> 
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Use the recently-gained QHT feature of returning the matching TB if it
> already exists. This allows us to get rid of the lookup we perform
> right after acquiring tb_lock.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cpu-exec.c            | 14 ++-------
>  accel/tcg/translate-all.c       | 50 +++++++++++++++++++++++++++------
>  docs/devel/multi-thread-tcg.txt |  3 ++
>  3 files changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index d75c35380a..45f6ebc65e 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -245,10 +245,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
>          if (tb == NULL) {
>              mmap_lock();
>              tb_lock();
> -            tb = tb_htable_lookup(cpu, pc, cs_base, flags, cf_mask);
> -            if (likely(tb == NULL)) {
> -                tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
> -            }
> +            tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
>              tb_unlock();
>              mmap_unlock();
>          }
> @@ -398,14 +395,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
>          tb_lock();
>          acquired_tb_lock = true;
> 
> -        /* There's a chance that our desired tb has been translated while
> -         * taking the locks so we check again inside the lock.
> -         */
> -        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cf_mask);
> -        if (likely(tb == NULL)) {
> -            /* if no translated code available, then translate it now */
> -            tb = tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
> -        }
> +        tb = tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
> 
>          mmap_unlock();
>          /* We add the TB in the virtual pc hash table for the fast lookup */
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index c75298d08a..2585e6fd3e 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1581,18 +1581,30 @@ static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
>   * (-1) to indicate that only one page contains the TB.
>   *
>   * Called with mmap_lock held for user-mode emulation.
> + *
> + * Returns a pointer @tb, or a pointer to an existing TB that matches @tb.
> + * Note that in !user-mode, another thread might have already added a TB
> + * for the same block of guest code that @tb corresponds to. In that case,
> + * the caller should discard the original @tb, and use instead the returned TB.
>   */
> -static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
> -                         tb_page_addr_t phys_page2)
> +static TranslationBlock *
> +tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
> +             tb_page_addr_t phys_page2)
>  {
>      PageDesc *p;
>      PageDesc *p2 = NULL;
> +    void *existing_tb = NULL;
>      uint32_t h;
> 
>      assert_memory_lock();
> 
>      /*
>       * Add the TB to the page list, acquiring first the pages's locks.
> +     * We keep the locks held until after inserting the TB in the hash table,
> +     * so that if the insertion fails we know for sure that the TBs are still
> +     * in the page descriptors.
> +     * Note that inserting into the hash table first isn't an option, since
> +     * we can only insert TBs that are fully initialized.
>       */
>      page_lock_pair(&p, phys_pc, &p2, phys_page2, 1);
>      tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
> @@ -1602,21 +1614,33 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
>          tb->page_addr[1] = -1;
>      }
> 
> +    /* add in the hash table */
> +    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
> +                     tb->trace_vcpu_dstate);
> +    qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
> +
> +    /* remove TB from the page(s) if we couldn't insert it */
> +    if (unlikely(existing_tb)) {
> +        tb_page_remove(p, tb);
> +        invalidate_page_bitmap(p);
> +        if (p2) {
> +            tb_page_remove(p2, tb);
> +            invalidate_page_bitmap(p2);
> +        }
> +        tb = existing_tb;
> +    }
> +
>      if (p2) {
>          page_unlock(p2);
>      }
>      page_unlock(p);
> 
> -    /* add in the hash table */
> -    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
> -                     tb->trace_vcpu_dstate);
> -    qht_insert(&tb_ctx.htable, tb, h, NULL);
> -
>  #ifdef CONFIG_USER_ONLY
>      if (DEBUG_TB_CHECK_GATE) {
>          tb_page_check();
>      }
>  #endif
> +    return tb;
>  }
> 
>  /* Called with mmap_lock held for user mode emulation.  */
> @@ -1625,7 +1649,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>                                uint32_t flags, int cflags)
>  {
>      CPUArchState *env = cpu->env_ptr;
> -    TranslationBlock *tb;
> +    TranslationBlock *tb, *existing_tb;
>      tb_page_addr_t phys_pc, phys_page2;
>      target_ulong virt_page2;
>      tcg_insn_unit *gen_code_buf;
> @@ -1773,7 +1797,15 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       * memory barrier is required before tb_link_page() makes the TB visible
>       * through the physical hash table and physical page list.
>       */
> -    tb_link_page(tb, phys_pc, phys_page2);
> +    existing_tb = tb_link_page(tb, phys_pc, phys_page2);
> +    /* if the TB already exists, discard what we just translated */
> +    if (unlikely(existing_tb != tb)) {
> +        uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
> +
> +        orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
> +        atomic_set(&tcg_ctx->code_gen_ptr, orig_aligned);
> +        return existing_tb;
> +    }
>      tcg_tb_insert(tb);
>      return tb;
>  }
> diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
> index faf8918b23..faf09c6069 100644
> --- a/docs/devel/multi-thread-tcg.txt
> +++ b/docs/devel/multi-thread-tcg.txt
> @@ -140,6 +140,9 @@ to atomically insert new elements.
>  The lookup caches are updated atomically and the lookup hash uses QHT
>  which is designed for concurrent safe lookup.
> 
> +Parallel code generation is supported. QHT is used at insertion time
> +as the synchronization point across threads, thereby ensuring that we only
> +keep track of a single TranslationBlock for each guest code block.
> 
>  Memory maps and TLBs
>  --------------------
