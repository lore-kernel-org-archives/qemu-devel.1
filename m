Received: from eggs.gnu.org ([2001:4830:134:3::10]:43785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1UGZ-0002f8-Bq
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1UGV-0006vo-Ef
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:54:42 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1UGV-0006vR-2G
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:54:39 -0400
Received: by mail-wm0-x241.google.com with SMTP id r82so10504649wme.0
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 02:54:38 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-4-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-4-git-send-email-cota@braap.org>
Date: Thu, 29 Mar 2018 10:54:36 +0100
Message-ID: <874lkz8aw3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/16] tcg: track TBs with per-region BST's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> This paves the way for enabling scalable parallel generation of TCG code.
>
> Instead of tracking TBs with a single binary search tree (BST), use a
> BST for each TCG region, protecting it with a lock. This is as scalable
> as it gets, since each TCG thread operates on a separate region.
>
> The core of this change is the introduction of struct tcg_region_tree,
> which contains a pointer to a GTree and an associated lock to serialize
> accesses to it. We then allocate an array of tcg_region_tree's, adding
> the appropriate padding to avoid false sharing based on
> qemu_dcache_linesize.
>
> Given a tc_ptr, we first find the corresponding region_tree. This
> is done by special-casing the first and last regions first, since they
> might be of size !=3D region.size; otherwise we just divide the offset
> by region.stride. I was worried about this division (several dozen
> cycles of latency), but profiling shows that this is not a fast path.
> Note that region.stride is not required to be a power of two; it
> is only required to be a multiple of the host's page size.
>
> Note that with this design we can also provide consistent snapshots
> about all region trees at once; for instance, tcg_tb_foreach
> acquires/releases all region_tree locks before/after iterating over them.
> For this reason we now drop tb_lock in dump_exec_info().
>
> As an alternative I considered implementing a concurrent BST, but this
> can be tricky to get right, offers no consistent snapshots of the BST,
> and performance and scalability-wise I don't think it could ever beat
> having separate GTrees, given that our workload is insert-mostly (all
> concurrent BST designs I've seen focus, understandably, on making
> lookups fast, which comes at the expense of convoluted, non-wait-free
> insertions/removals).
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/cpu-exec.c      |   2 +-
>  accel/tcg/translate-all.c | 101 ++++--------------------
>  include/exec/exec-all.h   |   1 -
>  include/exec/tb-context.h |   1 -
>  tcg/tcg.c                 | 191 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  tcg/tcg.h                 |   6 ++
>  6 files changed, 213 insertions(+), 89 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index ec57564..8c68727 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -222,7 +222,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_c=
ycles,
>
>      tb_lock();
>      tb_phys_invalidate(tb, -1);
> -    tb_remove(tb);
> +    tcg_tb_remove(tb);
>      tb_unlock();
>  }
>  #endif
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 1cf10f8..3a51d49 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -205,8 +205,6 @@ void tb_lock_reset(void)
>      }
>  }
>
> -static TranslationBlock *tb_find_pc(uintptr_t tc_ptr);
> -
>  void cpu_gen_init(void)
>  {
>      tcg_context_init(&tcg_init_ctx);
> @@ -375,13 +373,13 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t hos=
t_pc)
>
>      if (check_offset < tcg_init_ctx.code_gen_buffer_size) {
>          tb_lock();
> -        tb =3D tb_find_pc(host_pc);
> +        tb =3D tcg_tb_lookup(host_pc);
>          if (tb) {
>              cpu_restore_state_from_tb(cpu, tb, host_pc);
>              if (tb->cflags & CF_NOCACHE) {
>                  /* one-shot translation, invalidate it immediately */
>                  tb_phys_invalidate(tb, -1);
> -                tb_remove(tb);
> +                tcg_tb_remove(tb);
>              }
>              r =3D true;
>          }
> @@ -731,48 +729,6 @@ static inline void *alloc_code_gen_buffer(void)
>  }
>  #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
>
> -/* compare a pointer @ptr and a tb_tc @s */
> -static int ptr_cmp_tb_tc(const void *ptr, const struct tb_tc *s)
> -{
> -    if (ptr >=3D s->ptr + s->size) {
> -        return 1;
> -    } else if (ptr < s->ptr) {
> -        return -1;
> -    }
> -    return 0;
> -}
> -
> -static gint tb_tc_cmp(gconstpointer ap, gconstpointer bp)
> -{
> -    const struct tb_tc *a =3D ap;
> -    const struct tb_tc *b =3D bp;
> -
> -    /*
> -     * When both sizes are set, we know this isn't a lookup.
> -     * This is the most likely case: every TB must be inserted; lookups
> -     * are a lot less frequent.
> -     */
> -    if (likely(a->size && b->size)) {
> -        if (a->ptr > b->ptr) {
> -            return 1;
> -        } else if (a->ptr < b->ptr) {
> -            return -1;
> -        }
> -        /* a->ptr =3D=3D b->ptr should happen only on deletions */
> -        g_assert(a->size =3D=3D b->size);
> -        return 0;
> -    }
> -    /*
> -     * All lookups have either .size field set to 0.
> -     * From the glib sources we see that @ap is always the lookup key. H=
owever
> -     * the docs provide no guarantee, so we just mark this case as likel=
y.
> -     */
> -    if (likely(a->size =3D=3D 0)) {
> -        return ptr_cmp_tb_tc(a->ptr, b);
> -    }
> -    return ptr_cmp_tb_tc(b->ptr, a);
> -}
> -
>  static inline void code_gen_alloc(size_t tb_size)
>  {
>      tcg_ctx->code_gen_buffer_size =3D size_code_gen_buffer(tb_size);
> @@ -781,7 +737,6 @@ static inline void code_gen_alloc(size_t tb_size)
>          fprintf(stderr, "Could not allocate dynamic translator buffer\n"=
);
>          exit(1);
>      }
> -    tb_ctx.tb_tree =3D g_tree_new(tb_tc_cmp);
>      qemu_mutex_init(&tb_ctx.tb_lock);
>  }
>
> @@ -842,14 +797,6 @@ static TranslationBlock *tb_alloc(target_ulong pc)
>      return tb;
>  }
>
> -/* Called with tb_lock held.  */
> -void tb_remove(TranslationBlock *tb)
> -{
> -    assert_tb_locked();
> -
> -    g_tree_remove(tb_ctx.tb_tree, &tb->tc);
> -}
> -
>  static inline void invalidate_page_bitmap(PageDesc *p)
>  {
>  #ifdef CONFIG_SOFTMMU
> @@ -914,10 +861,10 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_d=
ata tb_flush_count)
>      }
>
>      if (DEBUG_TB_FLUSH_GATE) {
> -        size_t nb_tbs =3D g_tree_nnodes(tb_ctx.tb_tree);
> +        size_t nb_tbs =3D tcg_nb_tbs();
>          size_t host_size =3D 0;
>
> -        g_tree_foreach(tb_ctx.tb_tree, tb_host_size_iter, &host_size);
> +        tcg_tb_foreach(tb_host_size_iter, &host_size);
>          printf("qemu: flush code_size=3D%zu nb_tbs=3D%zu avg_tb_size=3D%=
zu\n",
>                 tcg_code_size(), nb_tbs, nb_tbs > 0 ? host_size / nb_tbs =
: 0);
>      }
> @@ -926,10 +873,6 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_da=
ta tb_flush_count)
>          cpu_tb_jmp_cache_clear(cpu);
>      }
>
> -    /* Increment the refcount first so that destroy acts as a reset */
> -    g_tree_ref(tb_ctx.tb_tree);
> -    g_tree_destroy(tb_ctx.tb_tree);
> -
>      qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
>      page_flush_tb();
>
> @@ -1409,7 +1352,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       * through the physical hash table and physical page list.
>       */
>      tb_link_page(tb, phys_pc, phys_page2);
> -    g_tree_insert(tb_ctx.tb_tree, &tb->tc, tb);
> +    tcg_tb_insert(tb);
>      return tb;
>  }
>
> @@ -1513,7 +1456,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t s=
tart, tb_page_addr_t end,
>                  current_tb =3D NULL;
>                  if (cpu->mem_io_pc) {
>                      /* now we have a real cpu fault */
> -                    current_tb =3D tb_find_pc(cpu->mem_io_pc);
> +                    current_tb =3D tcg_tb_lookup(cpu->mem_io_pc);
>                  }
>              }
>              if (current_tb =3D=3D tb &&
> @@ -1629,7 +1572,7 @@ static bool tb_invalidate_phys_page(tb_page_addr_t =
addr, uintptr_t pc)
>      tb =3D p->first_tb;
>  #ifdef TARGET_HAS_PRECISE_SMC
>      if (tb && pc !=3D 0) {
> -        current_tb =3D tb_find_pc(pc);
> +        current_tb =3D tcg_tb_lookup(pc);
>      }
>      if (cpu !=3D NULL) {
>          env =3D cpu->env_ptr;
> @@ -1672,18 +1615,6 @@ static bool tb_invalidate_phys_page(tb_page_addr_t=
 addr, uintptr_t pc)
>  }
>  #endif
>
> -/*
> - * Find the TB 'tb' such that
> - * tb->tc.ptr <=3D tc_ptr < tb->tc.ptr + tb->tc.size
> - * Return NULL if not found.
> - */
> -static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
> -{
> -    struct tb_tc s =3D { .ptr =3D (void *)tc_ptr };
> -
> -    return g_tree_lookup(tb_ctx.tb_tree, &s);
> -}
> -
>  #if !defined(CONFIG_USER_ONLY)
>  void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
>  {
> @@ -1711,7 +1642,7 @@ void tb_check_watchpoint(CPUState *cpu)
>  {
>      TranslationBlock *tb;
>
> -    tb =3D tb_find_pc(cpu->mem_io_pc);
> +    tb =3D tcg_tb_lookup(cpu->mem_io_pc);
>      if (tb) {
>          /* We can use retranslation to find the PC.  */
>          cpu_restore_state_from_tb(cpu, tb, cpu->mem_io_pc);
> @@ -1745,7 +1676,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t reta=
ddr)
>      uint32_t n;
>
>      tb_lock();
> -    tb =3D tb_find_pc(retaddr);
> +    tb =3D tcg_tb_lookup(retaddr);
>      if (!tb) {
>          cpu_abort(cpu, "cpu_io_recompile: could not find TB for pc=3D%p",
>                    (void *)retaddr);
> @@ -1789,7 +1720,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t reta=
ddr)
>               * cpu_exec_nocache() */
>              tb_phys_invalidate(tb->orig_tb, -1);
>          }
> -        tb_remove(tb);
> +        tcg_tb_remove(tb);
>      }
>
>      /* TODO: If env->pc !=3D tb->pc (i.e. the faulting instruction was n=
ot
> @@ -1860,6 +1791,7 @@ static void print_qht_statistics(FILE *f, fprintf_f=
unction cpu_fprintf,
>  }
>
>  struct tb_tree_stats {
> +    size_t nb_tbs;
>      size_t host_size;
>      size_t target_size;
>      size_t max_target_size;
> @@ -1873,6 +1805,7 @@ static gboolean tb_tree_stats_iter(gpointer key, gp=
ointer value, gpointer data)
>      const TranslationBlock *tb =3D value;
>      struct tb_tree_stats *tst =3D data;
>
> +    tst->nb_tbs++;
>      tst->host_size +=3D tb->tc.size;
>      tst->target_size +=3D tb->size;
>      if (tb->size > tst->max_target_size) {
> @@ -1896,10 +1829,8 @@ void dump_exec_info(FILE *f, fprintf_function cpu_=
fprintf)
>      struct qht_stats hst;
>      size_t nb_tbs;
>
> -    tb_lock();
> -
> -    nb_tbs =3D g_tree_nnodes(tb_ctx.tb_tree);
> -    g_tree_foreach(tb_ctx.tb_tree, tb_tree_stats_iter, &tst);
> +    tcg_tb_foreach(tb_tree_stats_iter, &tst);
> +    nb_tbs =3D tst.nb_tbs;
>      /* XXX: avoid using doubles ? */
>      cpu_fprintf(f, "Translation buffer state:\n");
>      /*
> @@ -1934,8 +1865,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_f=
printf)
>      cpu_fprintf(f, "TB invalidate count %d\n", tb_ctx.tb_phys_invalidate=
_count);
>      cpu_fprintf(f, "TLB flush count     %zu\n", tlb_flush_count());
>      tcg_dump_info(f, cpu_fprintf);
> -
> -    tb_unlock();
>  }
>
>  void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
> @@ -2203,7 +2132,7 @@ int page_unprotect(target_ulong address, uintptr_t =
pc)
>               * set the page to PAGE_WRITE and did the TB invalidate for =
us.
>               */
>  #ifdef TARGET_HAS_PRECISE_SMC
> -            TranslationBlock *current_tb =3D tb_find_pc(pc);
> +            TranslationBlock *current_tb =3D tcg_tb_lookup(pc);
>              if (current_tb) {
>                  current_tb_invalidated =3D tb_cflags(current_tb) & CF_IN=
VALID;
>              }
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index e5afd2e..17e08b3 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -401,7 +401,6 @@ static inline uint32_t curr_cflags(void)
>           | (use_icount ? CF_USE_ICOUNT : 0);
>  }
>
> -void tb_remove(TranslationBlock *tb);
>  void tb_flush(CPUState *cpu);
>  void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
>  TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
> diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
> index 1d41202..d8472c8 100644
> --- a/include/exec/tb-context.h
> +++ b/include/exec/tb-context.h
> @@ -31,7 +31,6 @@ typedef struct TBContext TBContext;
>
>  struct TBContext {
>
> -    GTree *tb_tree;
>      struct qht htable;
>      /* any access to the tbs or the page table must use this lock */
>      QemuMutex tb_lock;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index bb24526..b471708 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -135,6 +135,12 @@ static TCGContext **tcg_ctxs;
>  static unsigned int n_tcg_ctxs;
>  TCGv_env cpu_env =3D 0;
>
> +struct tcg_region_tree {
> +    QemuMutex lock;
> +    GTree *tree;
> +    /* padding to avoid false sharing is computed at run-time */
> +};
> +
>  /*
>   * We divide code_gen_buffer into equally-sized "regions" that TCG threa=
ds
>   * dynamically allocate from as demand dictates. Given appropriate region
> @@ -158,6 +164,13 @@ struct tcg_region_state {
>  };
>
>  static struct tcg_region_state region;
> +/*
> + * This is an array of struct tcg_region_tree's, with padding.
> + * We use void * to simplify the computation of region_trees[i]; each
> + * struct is found every tree_size bytes.
> + */
> +static void *region_trees;
> +static size_t tree_size;
>  static TCGRegSet tcg_target_available_regs[TCG_TYPE_COUNT];
>  static TCGRegSet tcg_target_call_clobber_regs;
>
> @@ -295,6 +308,180 @@ TCGLabel *gen_new_label(void)
>
>  #include "tcg-target.inc.c"
>
> +/* compare a pointer @ptr and a tb_tc @s */
> +static int ptr_cmp_tb_tc(const void *ptr, const struct tb_tc *s)
> +{
> +    if (ptr >=3D s->ptr + s->size) {
> +        return 1;
> +    } else if (ptr < s->ptr) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static gint tb_tc_cmp(gconstpointer ap, gconstpointer bp)
> +{
> +    const struct tb_tc *a =3D ap;
> +    const struct tb_tc *b =3D bp;
> +
> +    /*
> +     * When both sizes are set, we know this isn't a lookup.
> +     * This is the most likely case: every TB must be inserted; lookups
> +     * are a lot less frequent.
> +     */
> +    if (likely(a->size && b->size)) {
> +        if (a->ptr > b->ptr) {
> +            return 1;
> +        } else if (a->ptr < b->ptr) {
> +            return -1;
> +        }
> +        /* a->ptr =3D=3D b->ptr should happen only on deletions */
> +        g_assert(a->size =3D=3D b->size);
> +        return 0;
> +    }
> +    /*
> +     * All lookups have either .size field set to 0.
> +     * From the glib sources we see that @ap is always the lookup key. H=
owever
> +     * the docs provide no guarantee, so we just mark this case as likel=
y.
> +     */
> +    if (likely(a->size =3D=3D 0)) {
> +        return ptr_cmp_tb_tc(a->ptr, b);
> +    }
> +    return ptr_cmp_tb_tc(b->ptr, a);
> +}
> +
> +static void tcg_region_trees_init(void)
> +{
> +    size_t i;
> +
> +    tree_size =3D ROUND_UP(sizeof(struct tcg_region_tree), qemu_dcache_l=
inesize);
> +    region_trees =3D qemu_memalign(qemu_dcache_linesize, region.n * tree=
_size);
> +    for (i =3D 0; i < region.n; i++) {
> +        struct tcg_region_tree *rt =3D region_trees + i * tree_size;
> +
> +        qemu_mutex_init(&rt->lock);
> +        rt->tree =3D g_tree_new(tb_tc_cmp);
> +    }
> +}
> +
> +static struct tcg_region_tree *tc_ptr_to_region_tree(void *p)
> +{
> +    size_t region_idx;
> +
> +    if (p < region.start_aligned) {
> +        region_idx =3D 0;
> +    } else {
> +        ptrdiff_t offset =3D p - region.start_aligned;
> +
> +        if (offset > region.stride * (region.n - 1)) {
> +            region_idx =3D region.n - 1;
> +        } else {
> +            region_idx =3D offset / region.stride;
> +        }
> +    }
> +    return region_trees + region_idx * tree_size;
> +}
> +
> +void tcg_tb_insert(TranslationBlock *tb)
> +{
> +    struct tcg_region_tree *rt =3D tc_ptr_to_region_tree(tb->tc.ptr);
> +
> +    qemu_mutex_lock(&rt->lock);
> +    g_tree_insert(rt->tree, &tb->tc, tb);
> +    qemu_mutex_unlock(&rt->lock);
> +}
> +
> +void tcg_tb_remove(TranslationBlock *tb)
> +{
> +    struct tcg_region_tree *rt =3D tc_ptr_to_region_tree(tb->tc.ptr);
> +
> +    qemu_mutex_lock(&rt->lock);
> +    g_tree_remove(rt->tree, &tb->tc);
> +    qemu_mutex_unlock(&rt->lock);
> +}
> +
> +/*
> + * Find the TB 'tb' such that
> + * tb->tc.ptr <=3D tc_ptr < tb->tc.ptr + tb->tc.size
> + * Return NULL if not found.
> + */
> +TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr)
> +{
> +    struct tcg_region_tree *rt =3D tc_ptr_to_region_tree((void *)tc_ptr);
> +    TranslationBlock *tb;
> +    struct tb_tc s =3D { .ptr =3D (void *)tc_ptr };
> +
> +    qemu_mutex_lock(&rt->lock);
> +    tb =3D g_tree_lookup(rt->tree, &s);
> +    qemu_mutex_unlock(&rt->lock);
> +    return tb;
> +}
> +
> +static void tcg_region_tree_lock_all(void)
> +{
> +    size_t i;
> +
> +    for (i =3D 0; i < region.n; i++) {
> +        struct tcg_region_tree *rt =3D region_trees + i * tree_size;
> +
> +        qemu_mutex_lock(&rt->lock);
> +    }
> +}
> +
> +static void tcg_region_tree_unlock_all(void)
> +{
> +    size_t i;
> +
> +    for (i =3D 0; i < region.n; i++) {
> +        struct tcg_region_tree *rt =3D region_trees + i * tree_size;
> +
> +        qemu_mutex_unlock(&rt->lock);
> +    }
> +}
> +
> +void tcg_tb_foreach(GTraverseFunc func, gpointer user_data)
> +{
> +    size_t i;
> +
> +    tcg_region_tree_lock_all();
> +    for (i =3D 0; i < region.n; i++) {
> +        struct tcg_region_tree *rt =3D region_trees + i * tree_size;
> +
> +        g_tree_foreach(rt->tree, func, user_data);
> +    }
> +    tcg_region_tree_unlock_all();
> +}
> +
> +size_t tcg_nb_tbs(void)
> +{
> +    size_t nb_tbs =3D 0;
> +    size_t i;
> +
> +    tcg_region_tree_lock_all();
> +    for (i =3D 0; i < region.n; i++) {
> +        struct tcg_region_tree *rt =3D region_trees + i * tree_size;
> +
> +        nb_tbs +=3D g_tree_nnodes(rt->tree);
> +    }
> +    tcg_region_tree_unlock_all();
> +    return nb_tbs;
> +}
> +
> +static void tcg_region_tree_reset_all(void)
> +{
> +    size_t i;
> +
> +    tcg_region_tree_lock_all();
> +    for (i =3D 0; i < region.n; i++) {
> +        struct tcg_region_tree *rt =3D region_trees + i * tree_size;
> +
> +        /* Increment the refcount first so that destroy acts as a reset =
*/
> +        g_tree_ref(rt->tree);
> +        g_tree_destroy(rt->tree);
> +    }
> +    tcg_region_tree_unlock_all();
> +}
> +
>  static void tcg_region_bounds(size_t curr_region, void **pstart, void **=
pend)
>  {
>      void *start, *end;
> @@ -380,6 +567,8 @@ void tcg_region_reset_all(void)
>          g_assert(!err);
>      }
>      qemu_mutex_unlock(&region.lock);
> +
> +    tcg_region_tree_reset_all();
>  }
>
>  #ifdef CONFIG_USER_ONLY
> @@ -496,6 +685,8 @@ void tcg_region_init(void)
>          g_assert(!rc);
>      }
>
> +    tcg_region_trees_init();
> +
>      /* In user-mode we support only one ctx, so do the initial allocatio=
n now */
>  #ifdef CONFIG_USER_ONLY
>      {
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 9e2d909..8bf29cc 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -850,6 +850,12 @@ void tcg_region_reset_all(void);
>  size_t tcg_code_size(void);
>  size_t tcg_code_capacity(void);
>
> +void tcg_tb_insert(TranslationBlock *tb);
> +void tcg_tb_remove(TranslationBlock *tb);
> +TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
> +void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
> +size_t tcg_nb_tbs(void);
> +
>  /* user-mode: Called with tb_lock held.  */
>  static inline void *tcg_malloc(int size)
>  {


--
Alex Benn=C3=A9e
