Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJHS-0004H5-Im
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJHP-0005ns-Kz
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:10:22 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:32969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVJHP-0005mq-9s
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:10:19 -0400
Received: by mail-wr0-x22f.google.com with SMTP id r103so37538321wrb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:10:19 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-12-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-12-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 16:10:15 +0100
Message-ID: <87h8yh8ze0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/22] translate-all: use a binary search
 tree to track TBs in TBContext
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

> This is a prerequisite for having threads generate code on separate
> buffers, which will help scalability when booting multiple cores
> under MTTCG.
>
> For this we need a new field (.tc_size) in TranslationBlock to keep
> track of the size of the translated code. This field is added into
> a 4-byte hole that the previous commit created.
>
<snip>
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index fd20bca..673b26d 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -320,14 +320,25 @@ struct TranslationBlock {
>      uint16_t size;      /* size of target code for this block (1 <=
>                             size <= TARGET_PAGE_SIZE) */
>      uint16_t icount;
> -    uint32_t cflags;    /* compile flags */
> +    /*
> +     * @tc_size must be kept right after @tc_ptr to facilitate TB lookups in a
> +     * binary search tree -- see struct ptr_size.
> +     * We use an anonymous struct here to avoid updating all calling code,
> +     * which would be quite a lot of churn.
> +     * The only reason to bring @cflags into the anonymous struct is to
> +     * avoid inducing a hole in TranslationBlock.
> +     */
> +    struct {
> +        void *tc_ptr;    /* pointer to the translated code */
> +        uint32_t tc_size; /* size of translated code for this block */
> +
> +        uint32_t cflags;    /* compile flags */
>  #define CF_COUNT_MASK  0x7fff
>  #define CF_LAST_IO     0x8000 /* Last insn may be an IO access.  */
>  #define CF_NOCACHE     0x10000 /* To be freed after execution */
>  #define CF_USE_ICOUNT  0x20000
>  #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
> -
> -    void *tc_ptr;    /* pointer to the translated code */
> +    };

Why not just have a named structure for this so there isn't ambiguity
between struct ptrsize and this thing.

>      uint8_t *tc_search;  /* pointer to search data */
>      /* original tb when cflags has CF_NOCACHE */
>      struct TranslationBlock *orig_tb;
> diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
> index 25c2afe..1fa8dcc 100644
> --- a/include/exec/tb-context.h
> +++ b/include/exec/tb-context.h
> @@ -31,10 +31,8 @@ typedef struct TBContext TBContext;
>
>  struct TBContext {
>
> -    TranslationBlock **tbs;
> +    GTree *tb_tree;
>      struct qht htable;
> -    size_t tbs_size;
> -    int nb_tbs;
>      /* any access to the tbs or the page table must use this lock */
>      QemuMutex tb_lock;
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 2fa9f65..aa3a08b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -752,6 +752,47 @@ static inline void *alloc_code_gen_buffer(void)
>  }
>  #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
>
> +struct ptr_size {
> +    void *ptr;
> +    uint32_t size;
> +};

If we must have this you need a comment here alluding to the layout of
TranslationBlock.

> +
> +/* compare a single @ptr and a ptr_size @s */
> +static int ptr_size_cmp(const void *ptr, const struct ptr_size *s)
> +{
> +    if (ptr >= s->ptr + s->size) {
> +        return 1;
> +    } else if (ptr < s->ptr) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static gint tc_ptr_cmp(gconstpointer ap, gconstpointer bp)
> +{
> +    const struct ptr_size *a = ap;
> +    const struct ptr_size *b = bp;
> +
> +    /*
> +     * When both sizes are set, we know this isn't a lookup and therefore
> +     * the two buffers are non-overlapping: a pointer comparison will do.
> +     * This is the most likely case: every TB must be inserted; lookups
> +     * are a lot less frequent.
> +     */
> +    if (likely(a->size && b->size)) {
> +        return a->ptr - b->ptr;
> +    }
> +    /*
> +     * All lookups have either .size field set to 0.
> +     * From the glib sources we see that @ap is always the lookup key. However
> +     * the docs provide no guarantee, so we just mark this case as likely.
> +     */
> +    if (likely(a->size == 0)) {
> +        return ptr_size_cmp(a->ptr, b);
> +    }
> +    return ptr_size_cmp(b->ptr, a);
> +}
> +
>  static inline void code_gen_alloc(size_t tb_size)
>  {
>      tcg_ctx.code_gen_buffer_size = size_code_gen_buffer(tb_size);
> @@ -760,15 +801,7 @@ static inline void code_gen_alloc(size_t tb_size)
>          fprintf(stderr, "Could not allocate dynamic translator buffer\n");
>          exit(1);
>      }
> -
> -    /* size this conservatively -- realloc later if needed */
> -    tcg_ctx.tb_ctx.tbs_size =
> -        tcg_ctx.code_gen_buffer_size / CODE_GEN_AVG_BLOCK_SIZE / 8;
> -    if (unlikely(!tcg_ctx.tb_ctx.tbs_size)) {
> -        tcg_ctx.tb_ctx.tbs_size = 64 * 1024;
> -    }
> -    tcg_ctx.tb_ctx.tbs = g_new(TranslationBlock *, tcg_ctx.tb_ctx.tbs_size);
> -
> +    tcg_ctx.tb_ctx.tb_tree = g_tree_new(tc_ptr_cmp);
>      qemu_mutex_init(&tcg_ctx.tb_ctx.tb_lock);
>  }
>
> @@ -805,7 +838,6 @@ void tcg_exec_init(unsigned long tb_size)
>  static TranslationBlock *tb_alloc(target_ulong pc)
>  {
>      TranslationBlock *tb;
> -    TBContext *ctx;
>
>      assert_tb_locked();
>
> @@ -813,12 +845,6 @@ static TranslationBlock *tb_alloc(target_ulong pc)
>      if (unlikely(tb == NULL)) {
>          return NULL;
>      }
> -    ctx = &tcg_ctx.tb_ctx;
> -    if (unlikely(ctx->nb_tbs == ctx->tbs_size)) {
> -        ctx->tbs_size *= 2;
> -        ctx->tbs = g_renew(TranslationBlock *, ctx->tbs, ctx->tbs_size);
> -    }
> -    ctx->tbs[ctx->nb_tbs++] = tb;
>      return tb;
>  }
>
> @@ -827,16 +853,7 @@ void tb_free(TranslationBlock *tb)
>  {
>      assert_tb_locked();
>
> -    /* In practice this is mostly used for single use temporary TB
> -       Ignore the hard cases and just back up if this TB happens to
> -       be the last one generated.  */
> -    if (tcg_ctx.tb_ctx.nb_tbs > 0 &&
> -            tb == tcg_ctx.tb_ctx.tbs[tcg_ctx.tb_ctx.nb_tbs - 1]) {
> -        size_t struct_size = ROUND_UP(sizeof(*tb), qemu_icache_linesize);
> -
> -        tcg_ctx.code_gen_ptr = tb->tc_ptr - struct_size;
> -        tcg_ctx.tb_ctx.nb_tbs--;
> -    }
> +    g_tree_remove(tcg_ctx.tb_ctx.tb_tree, &tb->tc_ptr);
>  }

This function should be renamed as we never attempt to free (and it was
pretty half hearted before). Maybe tb_remove or tb_deref?

>
>  static inline void invalidate_page_bitmap(PageDesc *p)
> @@ -884,6 +901,8 @@ static void page_flush_tb(void)
>  /* flush all the translation blocks */
>  static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>  {
> +    int nb_tbs __attribute__((unused));
> +
>      tb_lock();
>
>      /* If it is already been done on request of another CPU,
> @@ -894,11 +913,12 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>      }
>
>  #if defined(DEBUG_TB_FLUSH)
> +    nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
>      printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%ld\n",
>             (unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer),
> -           tcg_ctx.tb_ctx.nb_tbs, tcg_ctx.tb_ctx.nb_tbs > 0 ?
> +           nb_tbs, nb_tbs > 0 ?
>             ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)) /
> -           tcg_ctx.tb_ctx.nb_tbs : 0);
> +           nb_tbs : 0);
>  #endif
>      if ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)
>          > tcg_ctx.code_gen_buffer_size) {
> @@ -909,7 +929,10 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>          cpu_tb_jmp_cache_clear(cpu);
>      }
>
> -    tcg_ctx.tb_ctx.nb_tbs = 0;
> +    /* Increment the refcount first so that destroy acts as a reset */
> +    g_tree_ref(tcg_ctx.tb_ctx.tb_tree);
> +    g_tree_destroy(tcg_ctx.tb_ctx.tb_tree);
> +
>      qht_reset_size(&tcg_ctx.tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
>      page_flush_tb();
>
> @@ -1309,6 +1332,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      if (unlikely(search_size < 0)) {
>          goto buffer_overflow;
>      }
> +    tb->tc_size = gen_code_size;
>
>  #ifdef CONFIG_PROFILER
>      tcg_ctx.code_time += profile_getclock() - ti;
> @@ -1359,6 +1383,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       * through the physical hash table and physical page list.
>       */
>      tb_link_page(tb, phys_pc, phys_page2);
> +    g_tree_insert(tcg_ctx.tb_ctx.tb_tree, &tb->tc_ptr, tb);
>      return tb;
>  }
>
> @@ -1627,37 +1652,16 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
>  }
>  #endif
>
> -/* find the TB 'tb' such that tb[0].tc_ptr <= tc_ptr <
> -   tb[1].tc_ptr. Return NULL if not found */
> +/*
> + * Find the TB 'tb' such that
> + * tb->tc_ptr <= tc_ptr < tb->tc_ptr + tb->tc_size
> + * Return NULL if not found.
> + */
>  static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
>  {
> -    int m_min, m_max, m;
> -    uintptr_t v;
> -    TranslationBlock *tb;
> +    struct ptr_size s = { .ptr = (void *)tc_ptr };
>
> -    if (tcg_ctx.tb_ctx.nb_tbs <= 0) {
> -        return NULL;
> -    }
> -    if (tc_ptr < (uintptr_t)tcg_ctx.code_gen_buffer ||
> -        tc_ptr >= (uintptr_t)tcg_ctx.code_gen_ptr) {
> -        return NULL;
> -    }
> -    /* binary search (cf Knuth) */
> -    m_min = 0;
> -    m_max = tcg_ctx.tb_ctx.nb_tbs - 1;
> -    while (m_min <= m_max) {
> -        m = (m_min + m_max) >> 1;
> -        tb = tcg_ctx.tb_ctx.tbs[m];
> -        v = (uintptr_t)tb->tc_ptr;
> -        if (v == tc_ptr) {
> -            return tb;
> -        } else if (tc_ptr < v) {
> -            m_max = m - 1;
> -        } else {
> -            m_min = m + 1;
> -        }
> -    }
> -    return tcg_ctx.tb_ctx.tbs[m_max];
> +    return g_tree_lookup(tcg_ctx.tb_ctx.tb_tree, &s);

Other than the anonymous struct ickiness I'm all for using library code here.

>  }
>
>  #if !defined(CONFIG_USER_ONLY)
> @@ -1842,63 +1846,67 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
>      g_free(hgram);
>  }
>
> +struct tb_tree_stats {
> +    size_t target_size;
> +    size_t max_target_size;
> +    size_t direct_jmp_count;
> +    size_t direct_jmp2_count;
> +    size_t cross_page;
> +};
> +
> +static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
> +{
> +    const TranslationBlock *tb = value;
> +    struct tb_tree_stats *tst = data;
> +
> +    tst->target_size += tb->size;
> +    if (tb->size > tst->max_target_size) {
> +        tst->max_target_size = tb->size;
> +    }
> +    if (tb->page_addr[1] != -1) {
> +        tst->cross_page++;
> +    }
> +    if (tb->jmp_reset_offset[0] != TB_JMP_RESET_OFFSET_INVALID) {
> +        tst->direct_jmp_count++;
> +        if (tb->jmp_reset_offset[1] != TB_JMP_RESET_OFFSET_INVALID) {
> +            tst->direct_jmp2_count++;
> +        }
> +    }
> +    return false;
> +}
> +
>  void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
>  {
> -    int i, target_code_size, max_target_code_size;
> -    int direct_jmp_count, direct_jmp2_count, cross_page;
> -    TranslationBlock *tb;
> +    struct tb_tree_stats tst = {};
>      struct qht_stats hst;
> +    int nb_tbs;
>
>      tb_lock();
>
> -    target_code_size = 0;
> -    max_target_code_size = 0;
> -    cross_page = 0;
> -    direct_jmp_count = 0;
> -    direct_jmp2_count = 0;
> -    for (i = 0; i < tcg_ctx.tb_ctx.nb_tbs; i++) {
> -        tb = tcg_ctx.tb_ctx.tbs[i];
> -        target_code_size += tb->size;
> -        if (tb->size > max_target_code_size) {
> -            max_target_code_size = tb->size;
> -        }
> -        if (tb->page_addr[1] != -1) {
> -            cross_page++;
> -        }
> -        if (tb->jmp_reset_offset[0] != TB_JMP_RESET_OFFSET_INVALID) {
> -            direct_jmp_count++;
> -            if (tb->jmp_reset_offset[1] != TB_JMP_RESET_OFFSET_INVALID) {
> -                direct_jmp2_count++;
> -            }
> -        }
> -    }
> +    nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
> +    g_tree_foreach(tcg_ctx.tb_ctx.tb_tree, tb_tree_stats_iter, &tst);
>      /* XXX: avoid using doubles ? */
>      cpu_fprintf(f, "Translation buffer state:\n");
>      cpu_fprintf(f, "gen code size       %td/%zd\n",
>                  tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer,
>                  tcg_ctx.code_gen_highwater - tcg_ctx.code_gen_buffer);
> -    cpu_fprintf(f, "TB count            %d\n", tcg_ctx.tb_ctx.nb_tbs);
> -    cpu_fprintf(f, "TB avg target size  %d max=%d bytes\n",
> -            tcg_ctx.tb_ctx.nb_tbs ? target_code_size /
> -                    tcg_ctx.tb_ctx.nb_tbs : 0,
> -            max_target_code_size);
> +    cpu_fprintf(f, "TB count            %d\n", nb_tbs);
> +    cpu_fprintf(f, "TB avg target size  %zu max=%zu bytes\n",
> +                nb_tbs ? tst.target_size / nb_tbs : 0,
> +                tst.max_target_size);
>      cpu_fprintf(f, "TB avg host size    %td bytes (expansion ratio: %0.1f)\n",
> -            tcg_ctx.tb_ctx.nb_tbs ? (tcg_ctx.code_gen_ptr -
> -                                     tcg_ctx.code_gen_buffer) /
> -                                     tcg_ctx.tb_ctx.nb_tbs : 0,
> -                target_code_size ? (double) (tcg_ctx.code_gen_ptr -
> -                                             tcg_ctx.code_gen_buffer) /
> -                                             target_code_size : 0);
> -    cpu_fprintf(f, "cross page TB count %d (%d%%)\n", cross_page,
> -            tcg_ctx.tb_ctx.nb_tbs ? (cross_page * 100) /
> -                                    tcg_ctx.tb_ctx.nb_tbs : 0);
> -    cpu_fprintf(f, "direct jump count   %d (%d%%) (2 jumps=%d %d%%)\n",
> -                direct_jmp_count,
> -                tcg_ctx.tb_ctx.nb_tbs ? (direct_jmp_count * 100) /
> -                        tcg_ctx.tb_ctx.nb_tbs : 0,
> -                direct_jmp2_count,
> -                tcg_ctx.tb_ctx.nb_tbs ? (direct_jmp2_count * 100) /
> -                        tcg_ctx.tb_ctx.nb_tbs : 0);
> +                nb_tbs ? (tcg_ctx.code_gen_ptr -
> +                          tcg_ctx.code_gen_buffer) / nb_tbs : 0,
> +                tst.target_size ? (double) (tcg_ctx.code_gen_ptr -
> +                                            tcg_ctx.code_gen_buffer) /
> +                                            tst.target_size : 0);
> +    cpu_fprintf(f, "cross page TB count %zu (%zu%%)\n", tst.cross_page,
> +            nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
> +    cpu_fprintf(f, "direct jump count   %zu (%zu%%) (2 jumps=%zu %zu%%)\n",
> +                tst.direct_jmp_count,
> +                nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
> +                tst.direct_jmp2_count,
> +                nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
>
>      qht_statistics_init(&tcg_ctx.tb_ctx.htable, &hst);
>      print_qht_statistics(f, cpu_fprintf, hst);


--
Alex Bennée
