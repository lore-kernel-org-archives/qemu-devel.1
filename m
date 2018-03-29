Received: from eggs.gnu.org ([2001:4830:134:3::10]:47024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1URj-0002Ta-QY
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1URd-0003Xz-NP
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:06:15 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1URd-0003Ww-H1
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:06:09 -0400
Received: by mail-wr0-x243.google.com with SMTP id o8so4873993wra.1
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:06:09 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-5-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-5-git-send-email-cota@braap.org>
Date: Thu, 29 Mar 2018 11:06:07 +0100
Message-ID: <871sg38acw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/16] tcg: move
 tb_ctx.tb_phys_invalidate_count to tcg_ctx
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

> Thereby making it per-TCGContext. Once we remove tb_lock, this will
> avoid an atomic increment every time a TB is invalidated.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c |  5 +++--
>  include/exec/tb-context.h |  1 -
>  tcg/tcg.c                 | 14 ++++++++++++++
>  tcg/tcg.h                 |  3 +++
>  4 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 3a51d49..20ad3fc 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1072,7 +1072,8 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_pa=
ge_addr_t page_addr)
>      /* suppress any remaining jumps to this TB */
>      tb_jmp_unlink(tb);
>
> -    tb_ctx.tb_phys_invalidate_count++;
> +    atomic_set(&tcg_ctx->tb_phys_invalidate_count,
> +               tcg_ctx->tb_phys_invalidate_count + 1);

We do have an atomic_inc helper for this or we need comment that we only
have atomic_reads() to worry about hence no races.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>  }
>
>  #ifdef CONFIG_SOFTMMU
> @@ -1862,7 +1863,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_f=
printf)
>      cpu_fprintf(f, "\nStatistics:\n");
>      cpu_fprintf(f, "TB flush count      %u\n",
>                  atomic_read(&tb_ctx.tb_flush_count));
> -    cpu_fprintf(f, "TB invalidate count %d\n", tb_ctx.tb_phys_invalidate=
_count);
> +    cpu_fprintf(f, "TB invalidate count %zu\n", tcg_tb_phys_invalidate_c=
ount());
>      cpu_fprintf(f, "TLB flush count     %zu\n", tlb_flush_count());
>      tcg_dump_info(f, cpu_fprintf);
>  }
> diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
> index d8472c8..8c9b49c 100644
> --- a/include/exec/tb-context.h
> +++ b/include/exec/tb-context.h
> @@ -37,7 +37,6 @@ struct TBContext {
>
>      /* statistics */
>      unsigned tb_flush_count;
> -    int tb_phys_invalidate_count;
>  };
>
>  extern TBContext tb_ctx;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index b471708..a7b596e 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -791,6 +791,20 @@ size_t tcg_code_capacity(void)
>      return capacity;
>  }
>
> +size_t tcg_tb_phys_invalidate_count(void)
> +{
> +    unsigned int n_ctxs =3D atomic_read(&n_tcg_ctxs);
> +    unsigned int i;
> +    size_t total =3D 0;
> +
> +    for (i =3D 0; i < n_ctxs; i++) {
> +        const TCGContext *s =3D atomic_read(&tcg_ctxs[i]);
> +
> +        total +=3D atomic_read(&s->tb_phys_invalidate_count);
> +    }
> +    return total;
> +}
> +
>  /* pool based memory allocation */
>  void *tcg_malloc_internal(TCGContext *s, int size)
>  {
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 8bf29cc..9dd9448 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -694,6 +694,8 @@ struct TCGContext {
>      /* Threshold to flush the translated code buffer.  */
>      void *code_gen_highwater;
>
> +    size_t tb_phys_invalidate_count;
> +
>      /* Track which vCPU triggers events */
>      CPUState *cpu;                      /* *_trans */
>
> @@ -852,6 +854,7 @@ size_t tcg_code_capacity(void);
>
>  void tcg_tb_insert(TranslationBlock *tb);
>  void tcg_tb_remove(TranslationBlock *tb);
> +size_t tcg_tb_phys_invalidate_count(void);
>  TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
>  void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
>  size_t tcg_nb_tbs(void);


--
Alex Benn=C3=A9e
