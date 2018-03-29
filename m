Received: from eggs.gnu.org ([2001:4830:134:3::10]:54823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1ZL7-0000Y5-5B
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1ZL3-0007RE-TE
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:19:45 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:52505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1ZL3-0007Q7-Ii
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:19:41 -0400
Received: by mail-wm0-x22f.google.com with SMTP id l9so11496179wmh.2
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 08:19:41 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-13-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-13-git-send-email-cota@braap.org>
Date: Thu, 29 Mar 2018 16:19:39 +0100
Message-ID: <87po3m7vuc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/16] translate-all: discard TB when
 tb_link_page returns an existing matching TB
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

> Use the recently-gained QHT feature of returning the matching TB if it
> already exists. This allows us to get rid of the lookup we perform
> right after acquiring tb_lock.
>
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/cpu-exec.c      | 14 ++------------
>  accel/tcg/translate-all.c | 47 ++++++++++++++++++++++++++++++++++++++---=
------
>  2 files changed, 40 insertions(+), 21 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 7c83887..8aed38c 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -243,10 +243,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
>          if (tb =3D=3D NULL) {
>              mmap_lock();
>              tb_lock();
> -            tb =3D tb_htable_lookup(cpu, pc, cs_base, flags, cf_mask);
> -            if (likely(tb =3D=3D NULL)) {
> -                tb =3D tb_gen_code(cpu, pc, cs_base, flags, cflags);
> -            }
> +            tb =3D tb_gen_code(cpu, pc, cs_base, flags, cflags);

tb_gen_code needs to be renamed to reflect it's semantics.
tb_get_or_gen_code? Or maybe tb_get_code with a sub-helper to do the
generation.

>              tb_unlock();
>              mmap_unlock();
>          }
> @@ -396,14 +393,7 @@ static inline TranslationBlock *tb_find(CPUState *cp=
u,
>          tb_lock();
>          acquired_tb_lock =3D true;
>
> -        /* There's a chance that our desired tb has been translated while
> -         * taking the locks so we check again inside the lock.
> -         */
> -        tb =3D tb_htable_lookup(cpu, pc, cs_base, flags, cf_mask);
> -        if (likely(tb =3D=3D NULL)) {
> -            /* if no translated code available, then translate it now */
> -            tb =3D tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
> -        }
> +        tb =3D tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
>
>          mmap_unlock();
>          /* We add the TB in the virtual pc hash table for the fast looku=
p */
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 82832ef..dbe6c12 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1503,12 +1503,16 @@ static inline void tb_page_add(PageDesc *p, Trans=
lationBlock *tb,
>   * (-1) to indicate that only one page contains the TB.
>   *
>   * Called with mmap_lock held for user-mode emulation.
> + *
> + * Returns @tb or an existing TB that matches @tb.

That's just confusing to read. So this returns a TB like the @tb we
passed in but actually a different one matching the same conditions?

>   */
> -static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
> -                         tb_page_addr_t phys_page2)
> +static TranslationBlock *
> +tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
> +             tb_page_addr_t phys_page2)
>  {
>      PageDesc *p;
>      PageDesc *p2 =3D NULL;
> +    void *existing_tb;
>      uint32_t h;
>
>      assert_memory_lock();
> @@ -1516,6 +1520,11 @@ static void tb_link_page(TranslationBlock *tb, tb_=
page_addr_t phys_pc,
>      /*
>       * Add the TB to the page list.
>       * To avoid deadlock, acquire first the lock of the lower-addressed =
page.
> +     * We keep the locks held until after inserting the TB in the hash t=
able,
> +     * so that if the insertion fails we know for sure that the TBs are =
still
> +     * in the page descriptors.
> +     * Note that inserting into the hash table first isn't an option, si=
nce
> +     * we can only insert TBs that are fully initialized.
>       */
>      p =3D page_find_alloc(phys_pc >> TARGET_PAGE_BITS, 1);
>      if (likely(phys_page2 =3D=3D -1)) {
> @@ -1535,21 +1544,33 @@ static void tb_link_page(TranslationBlock *tb, tb=
_page_addr_t phys_pc,
>          tb_page_add(p2, tb, 1, phys_page2);
>      }
>
> +    /* add in the hash table */
> +    h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_=
MASK,
> +                     tb->trace_vcpu_dstate);
> +    existing_tb =3D qht_insert(&tb_ctx.htable, tb, h);

modulo comments about qht_insert API earlier in the series.

> +
> +    /* remove TB from the page(s) if we couldn't insert it */
> +    if (unlikely(existing_tb)) {
> +        tb_page_remove(p, tb);
> +        invalidate_page_bitmap(p);
> +        if (p2) {
> +            tb_page_remove(p2, tb);
> +            invalidate_page_bitmap(p2);
> +        }
> +        tb =3D existing_tb;
> +    }
> +
>      if (p2) {
>          page_unlock(p2);
>      }
>      page_unlock(p);
>
> -    /* add in the hash table */
> -    h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_=
MASK,
> -                     tb->trace_vcpu_dstate);
> -    qht_insert(&tb_ctx.htable, tb, h);
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
> @@ -1558,7 +1579,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>                                uint32_t flags, int cflags)
>  {
>      CPUArchState *env =3D cpu->env_ptr;
> -    TranslationBlock *tb;
> +    TranslationBlock *tb, *existing_tb;
>      tb_page_addr_t phys_pc, phys_page2;
>      target_ulong virt_page2;
>      tcg_insn_unit *gen_code_buf;
> @@ -1706,7 +1727,15 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       * memory barrier is required before tb_link_page() makes the TB vis=
ible
>       * through the physical hash table and physical page list.
>       */
> -    tb_link_page(tb, phys_pc, phys_page2);
> +    existing_tb =3D tb_link_page(tb, phys_pc, phys_page2);
> +    /* if the TB already exists, discard what we just translated */

So are we in the position now that we could potentially do a translation
but be beaten by another thread generating the same code? I suspect we could
do with a bit of explanatory commentary for the tb_gen_code functions.

Also I think the "Translation Blocks" section needs updating in the
MTTCG design document to make this clear.

I'm curious if we should be counting unused translations somewhere in
the JIT stats. I'm guessing you need to work at a pathalogical case to
hit this much?

> +    if (unlikely(existing_tb !=3D tb)) {
> +        uintptr_t orig_aligned =3D (uintptr_t)gen_code_buf;
> +
> +        orig_aligned -=3D ROUND_UP(sizeof(*tb), qemu_icache_linesize);
> +        atomic_set(&tcg_ctx->code_gen_ptr, orig_aligned);
> +        return existing_tb;
> +    }
>      tcg_tb_insert(tb);
>      return tb;
>  }


--
Alex Benn=C3=A9e
