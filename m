Received: from eggs.gnu.org ([2001:4830:134:3::10]:51600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJZ1-0004xV-K3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJYy-0007nv-D0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:28:31 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVJYy-0007nH-0n
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:28:28 -0400
Received: by mail-lf0-f43.google.com with SMTP id b207so20332062lfg.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:28:27 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-14-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-14-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 16:27:24 +0100
Message-ID: <87eftl8ylf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/22] tcg: take tb_ctx out of TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Before TCGContext is made thread-local.
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  include/exec/tb-context.h |  2 ++
>  tcg/tcg.h                 |  2 --
>  accel/tcg/cpu-exec.c      |  2 +-
>  accel/tcg/translate-all.c | 57 +++++++++++++++++++++++------------------------
>  linux-user/main.c         |  6 ++---
>  5 files changed, 34 insertions(+), 35 deletions(-)
>
> diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
> index 1fa8dcc..1d41202 100644
> --- a/include/exec/tb-context.h
> +++ b/include/exec/tb-context.h
> @@ -41,4 +41,6 @@ struct TBContext {
>      int tb_phys_invalidate_count;
>  };
>
> +extern TBContext tb_ctx;
> +
>  #endif
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index da78721..ad2d959 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -706,8 +706,6 @@ struct TCGContext {
>      /* Threshold to flush the translated code buffer.  */
>      void *code_gen_highwater;
>
> -    TBContext tb_ctx;
> -
>      /* Track which vCPU triggers events */
>      CPUState *cpu;                      /* *_trans */
>      TCGv_env tcg_env;                   /* *_exec  */
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 3581618..54ecae2 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -323,7 +323,7 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
>      phys_pc = get_page_addr_code(desc.env, pc);
>      desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
>      h = tb_hash_func(phys_pc, pc, flags);
> -    return qht_lookup(&tcg_ctx.tb_ctx.htable, tb_cmp, &desc, h);
> +    return qht_lookup(&tb_ctx.htable, tb_cmp, &desc, h);
>  }
>
>  static inline TranslationBlock *tb_find(CPUState *cpu,
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index aa71292..84e19d9 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -130,6 +130,7 @@ static void *l1_map[V_L1_MAX_SIZE];
>
>  /* code generation context */
>  TCGContext tcg_ctx;
> +TBContext tb_ctx;
>  bool parallel_cpus;
>
>  /* translation block context */
> @@ -161,7 +162,7 @@ static void page_table_config_init(void)
>  void tb_lock(void)
>  {
>      assert_tb_unlocked();
> -    qemu_mutex_lock(&tcg_ctx.tb_ctx.tb_lock);
> +    qemu_mutex_lock(&tb_ctx.tb_lock);
>      have_tb_lock++;
>  }
>
> @@ -169,13 +170,13 @@ void tb_unlock(void)
>  {
>      assert_tb_locked();
>      have_tb_lock--;
> -    qemu_mutex_unlock(&tcg_ctx.tb_ctx.tb_lock);
> +    qemu_mutex_unlock(&tb_ctx.tb_lock);
>  }
>
>  void tb_lock_reset(void)
>  {
>      if (have_tb_lock) {
> -        qemu_mutex_unlock(&tcg_ctx.tb_ctx.tb_lock);
> +        qemu_mutex_unlock(&tb_ctx.tb_lock);
>          have_tb_lock = 0;
>      }
>  }
> @@ -801,15 +802,15 @@ static inline void code_gen_alloc(size_t tb_size)
>          fprintf(stderr, "Could not allocate dynamic translator buffer\n");
>          exit(1);
>      }
> -    tcg_ctx.tb_ctx.tb_tree = g_tree_new(tc_ptr_cmp);
> -    qemu_mutex_init(&tcg_ctx.tb_ctx.tb_lock);
> +    tb_ctx.tb_tree = g_tree_new(tc_ptr_cmp);
> +    qemu_mutex_init(&tb_ctx.tb_lock);
>  }
>
>  static void tb_htable_init(void)
>  {
>      unsigned int mode = QHT_MODE_AUTO_RESIZE;
>
> -    qht_init(&tcg_ctx.tb_ctx.htable, CODE_GEN_HTABLE_SIZE, mode);
> +    qht_init(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE, mode);
>  }
>
>  /* Must be called before using the QEMU cpus. 'tb_size' is the size
> @@ -853,7 +854,7 @@ void tb_free(TranslationBlock *tb)
>  {
>      assert_tb_locked();
>
> -    g_tree_remove(tcg_ctx.tb_ctx.tb_tree, &tb->tc_ptr);
> +    g_tree_remove(tb_ctx.tb_tree, &tb->tc_ptr);
>  }
>
>  static inline void invalidate_page_bitmap(PageDesc *p)
> @@ -919,13 +920,13 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>      /* If it is already been done on request of another CPU,
>       * just retry.
>       */
> -    if (tcg_ctx.tb_ctx.tb_flush_count != tb_flush_count.host_int) {
> +    if (tb_ctx.tb_flush_count != tb_flush_count.host_int) {
>          goto done;
>      }
>
>  #if defined(DEBUG_TB_FLUSH)
> -    g_tree_foreach(tcg_ctx.tb_ctx.tb_tree, tb_host_size_iter, &host_size);
> -    nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
> +    g_tree_foreach(tb_ctx.tb_tree, tb_host_size_iter, &host_size);
> +    nb_tbs = g_tree_nnodes(tb_ctx.tb_tree);
>      printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%zu\n",
>             (unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer),
>             nb_tbs, nb_tbs > 0 ? host_size / nb_tbs : 0);
> @@ -940,17 +941,16 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>      }
>
>      /* Increment the refcount first so that destroy acts as a reset */
> -    g_tree_ref(tcg_ctx.tb_ctx.tb_tree);
> -    g_tree_destroy(tcg_ctx.tb_ctx.tb_tree);
> +    g_tree_ref(tb_ctx.tb_tree);
> +    g_tree_destroy(tb_ctx.tb_tree);
>
> -    qht_reset_size(&tcg_ctx.tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
> +    qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
>      page_flush_tb();
>
>      tcg_ctx.code_gen_ptr = tcg_ctx.code_gen_buffer;
>      /* XXX: flush processor icache at this point if cache flush is
>         expensive */
> -    atomic_mb_set(&tcg_ctx.tb_ctx.tb_flush_count,
> -                  tcg_ctx.tb_ctx.tb_flush_count + 1);
> +    atomic_mb_set(&tb_ctx.tb_flush_count, tb_ctx.tb_flush_count + 1);
>
>  done:
>      tb_unlock();
> @@ -959,7 +959,7 @@ done:
>  void tb_flush(CPUState *cpu)
>  {
>      if (tcg_enabled()) {
> -        unsigned tb_flush_count = atomic_mb_read(&tcg_ctx.tb_ctx.tb_flush_count);
> +        unsigned tb_flush_count = atomic_mb_read(&tb_ctx.tb_flush_count);
>          async_safe_run_on_cpu(cpu, do_tb_flush,
>                                RUN_ON_CPU_HOST_INT(tb_flush_count));
>      }
> @@ -986,7 +986,7 @@ do_tb_invalidate_check(struct qht *ht, void *p, uint32_t hash, void *userp)
>  static void tb_invalidate_check(target_ulong address)
>  {
>      address &= TARGET_PAGE_MASK;
> -    qht_iter(&tcg_ctx.tb_ctx.htable, do_tb_invalidate_check, &address);
> +    qht_iter(&tb_ctx.htable, do_tb_invalidate_check, &address);
>  }
>
>  static void
> @@ -1006,7 +1006,7 @@ do_tb_page_check(struct qht *ht, void *p, uint32_t hash, void *userp)
>  /* verify that all the pages have correct rights for code */
>  static void tb_page_check(void)
>  {
> -    qht_iter(&tcg_ctx.tb_ctx.htable, do_tb_page_check, NULL);
> +    qht_iter(&tb_ctx.htable, do_tb_page_check, NULL);
>  }
>
>  #endif
> @@ -1105,7 +1105,7 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
>      /* remove the TB from the hash list */
>      phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
>      h = tb_hash_func(phys_pc, tb->pc, tb->flags);
> -    qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
> +    qht_remove(&tb_ctx.htable, tb, h);
>
>      /* remove the TB from the page list */
>      if (tb->page_addr[0] != page_addr) {
> @@ -1134,7 +1134,7 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
>      /* suppress any remaining jumps to this TB */
>      tb_jmp_unlink(tb);
>
> -    tcg_ctx.tb_ctx.tb_phys_invalidate_count++;
> +    tb_ctx.tb_phys_invalidate_count++;
>  }
>
>  #ifdef CONFIG_SOFTMMU
> @@ -1250,7 +1250,7 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
>
>      /* add in the hash table */
>      h = tb_hash_func(phys_pc, tb->pc, tb->flags);
> -    qht_insert(&tcg_ctx.tb_ctx.htable, tb, h);
> +    qht_insert(&tb_ctx.htable, tb, h);
>
>  #ifdef DEBUG_TB_CHECK
>      tb_page_check();
> @@ -1393,7 +1393,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       * through the physical hash table and physical page list.
>       */
>      tb_link_page(tb, phys_pc, phys_page2);
> -    g_tree_insert(tcg_ctx.tb_ctx.tb_tree, &tb->tc_ptr, tb);
> +    g_tree_insert(tb_ctx.tb_tree, &tb->tc_ptr, tb);
>      return tb;
>  }
>
> @@ -1671,7 +1671,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
>  {
>      struct ptr_size s = { .ptr = (void *)tc_ptr };
>
> -    return g_tree_lookup(tcg_ctx.tb_ctx.tb_tree, &s);
> +    return g_tree_lookup(tb_ctx.tb_tree, &s);
>  }
>
>  #if !defined(CONFIG_USER_ONLY)
> @@ -1895,8 +1895,8 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
>
>      tb_lock();
>
> -    nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
> -    g_tree_foreach(tcg_ctx.tb_ctx.tb_tree, tb_tree_stats_iter, &tst);
> +    nb_tbs = g_tree_nnodes(tb_ctx.tb_tree);
> +    g_tree_foreach(tb_ctx.tb_tree, tb_tree_stats_iter, &tst);
>      /* XXX: avoid using doubles ? */
>      cpu_fprintf(f, "Translation buffer state:\n");
>      /*
> @@ -1922,15 +1922,14 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
>                  tst.direct_jmp2_count,
>                  nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
>
> -    qht_statistics_init(&tcg_ctx.tb_ctx.htable, &hst);
> +    qht_statistics_init(&tb_ctx.htable, &hst);
>      print_qht_statistics(f, cpu_fprintf, hst);
>      qht_statistics_destroy(&hst);
>
>      cpu_fprintf(f, "\nStatistics:\n");
>      cpu_fprintf(f, "TB flush count      %u\n",
> -            atomic_read(&tcg_ctx.tb_ctx.tb_flush_count));
> -    cpu_fprintf(f, "TB invalidate count %d\n",
> -            tcg_ctx.tb_ctx.tb_phys_invalidate_count);
> +                atomic_read(&tb_ctx.tb_flush_count));
> +    cpu_fprintf(f, "TB invalidate count %d\n", tb_ctx.tb_phys_invalidate_count);
>      cpu_fprintf(f, "TLB flush count     %zu\n", tlb_flush_count());
>      tcg_dump_info(f, cpu_fprintf);
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index ad03c9e..630c73d 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -114,7 +114,7 @@ int cpu_get_pic_interrupt(CPUX86State *env)
>  void fork_start(void)
>  {
>      cpu_list_lock();
> -    qemu_mutex_lock(&tcg_ctx.tb_ctx.tb_lock);
> +    qemu_mutex_lock(&tb_ctx.tb_lock);
>      mmap_fork_start();
>  }
>
> @@ -130,11 +130,11 @@ void fork_end(int child)
>                  QTAILQ_REMOVE(&cpus, cpu, node);
>              }
>          }
> -        qemu_mutex_init(&tcg_ctx.tb_ctx.tb_lock);
> +        qemu_mutex_init(&tb_ctx.tb_lock);
>          qemu_init_cpu_list();
>          gdbserver_fork(thread_cpu);
>      } else {
> -        qemu_mutex_unlock(&tcg_ctx.tb_ctx.tb_lock);
> +        qemu_mutex_unlock(&tb_ctx.tb_lock);
>          cpu_list_unlock();
>      }
>  }


--
Alex Bennée
