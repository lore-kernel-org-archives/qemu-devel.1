Received: from eggs.gnu.org ([2001:4830:134:3::10]:34039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEh7-00073R-8z
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEh2-0003pm-MJ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:52:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:50351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gQEh0-0003lz-UU
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:52:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id 125so12536626wmh.0
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:52:34 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-17-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-17-cota@braap.org>
Date: Fri, 23 Nov 2018 16:52:31 +0000
Message-ID: <87tvk7hh2o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 16/48] tcg: add plugin_mask to TB hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

This commit message needs more description. What is this plugin mask
for? Are we extending the TB flags with a mask of loaded plugins so we
can correctly identify what code was generated under what plugins?

> ---
>  include/exec/exec-all.h   | 2 ++
>  include/exec/tb-hash.h    | 6 ++++--
>  include/exec/tb-lookup.h  | 1 +
>  accel/tcg/cpu-exec.c      | 6 +++++-
>  accel/tcg/translate-all.c | 6 ++++--
>  5 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 232e2f8966..a1f60404b6 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -358,6 +358,8 @@ struct TranslationBlock {
>      /* Per-vCPU dynamic tracing state used to generate this TB */
>      uint32_t trace_vcpu_dstate;
>
> +    uint32_t plugin_mask;
> +
>      struct tb_tc tc;
>
>      /* original tb when cflags has CF_NOCACHE */
> diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
> index 4f3a37d927..37292474b7 100644
> --- a/include/exec/tb-hash.h
> +++ b/include/exec/tb-hash.h
> @@ -59,9 +59,11 @@ static inline unsigned int tb_jmp_cache_hash_func(targ=
et_ulong pc)
>
>  static inline
>  uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t =
flags,
> -                      uint32_t cf_mask, uint32_t trace_vcpu_dstate)
> +                      uint32_t cf_mask, uint32_t trace_vcpu_dstate,
> +                      uint32_t plugin_mask)
>  {
> -    return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
> +    return qemu_xxhash8(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate,
> +                        plugin_mask);
>  }
>
>  #endif
> diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
> index 492cb68289..dd1572f481 100644
> --- a/include/exec/tb-lookup.h
> +++ b/include/exec/tb-lookup.h
> @@ -33,6 +33,7 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc, t=
arget_ulong *cs_base,
>                 tb->cs_base =3D=3D *cs_base &&
>                 tb->flags =3D=3D *flags &&
>                 tb->trace_vcpu_dstate =3D=3D *cpu->trace_dstate &&
> +               tb->plugin_mask =3D=3D *cpu->plugin_mask &&
>                 (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) =3D=3D cf_m=
ask)) {
>          return tb;
>      }
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index d590f1f6c0..27aa3451da 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -287,6 +287,7 @@ struct tb_desc {
>      uint32_t flags;
>      uint32_t cf_mask;
>      uint32_t trace_vcpu_dstate;
> +    uint32_t plugin_mask;
>  };
>
>  static bool tb_lookup_cmp(const void *p, const void *d)
> @@ -299,6 +300,7 @@ static bool tb_lookup_cmp(const void *p, const void *=
d)
>          tb->cs_base =3D=3D desc->cs_base &&
>          tb->flags =3D=3D desc->flags &&
>          tb->trace_vcpu_dstate =3D=3D desc->trace_vcpu_dstate &&
> +        tb->plugin_mask =3D=3D desc->plugin_mask &&
>          (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) =3D=3D desc->cf_ma=
sk) {
>          /* check next page if needed */
>          if (tb->page_addr[1] =3D=3D -1) {
> @@ -330,13 +332,15 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, t=
arget_ulong pc,
>      desc.flags =3D flags;
>      desc.cf_mask =3D cf_mask;
>      desc.trace_vcpu_dstate =3D *cpu->trace_dstate;
> +    desc.plugin_mask =3D *cpu->plugin_mask;
>      desc.pc =3D pc;
>      phys_pc =3D get_page_addr_code(desc.env, pc);
>      if (phys_pc =3D=3D -1) {
>          return NULL;
>      }
>      desc.phys_page1 =3D phys_pc & TARGET_PAGE_MASK;
> -    h =3D tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate);
> +    h =3D tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate,
> +                     *cpu->plugin_mask);
>      return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
>  }
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index db2d28f8d3..3423cf74db 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1129,6 +1129,7 @@ static bool tb_cmp(const void *ap, const void *bp)
>          a->flags =3D=3D b->flags &&
>          (tb_cflags(a) & CF_HASH_MASK) =3D=3D (tb_cflags(b) & CF_HASH_MAS=
K) &&
>          a->trace_vcpu_dstate =3D=3D b->trace_vcpu_dstate &&
> +        a->plugin_mask =3D=3D b->plugin_mask &&
>          a->page_addr[0] =3D=3D b->page_addr[0] &&
>          a->page_addr[1] =3D=3D b->page_addr[1];
>  }
> @@ -1444,7 +1445,7 @@ static void do_tb_phys_invalidate(TranslationBlock =
*tb, bool rm_from_page_list)
>      /* remove the TB from the hash list */
>      phys_pc =3D tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
>      h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb_cflags(tb) & CF_HA=
SH_MASK,
> -                     tb->trace_vcpu_dstate);
> +                     tb->trace_vcpu_dstate, tb->plugin_mask);
>      if (!(tb->cflags & CF_NOCACHE) &&
>          !qht_remove(&tb_ctx.htable, tb, h)) {
>          return;
> @@ -1640,7 +1641,7 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t p=
hys_pc,
>
>          /* add in the hash table */
>          h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_H=
ASH_MASK,
> -                         tb->trace_vcpu_dstate);
> +                         tb->trace_vcpu_dstate, tb->plugin_mask);
>          qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
>
>          /* remove TB from the page(s) if we couldn't insert it */
> @@ -1712,6 +1713,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      tb->cflags =3D cflags;
>      tb->trace_vcpu_dstate =3D *cpu->trace_dstate;
>      tcg_ctx->tb_cflags =3D cflags;
> +    tb->plugin_mask =3D *cpu->plugin_mask;
>
>  #ifdef CONFIG_PROFILER
>      /* includes aborted translations because of exceptions */


--
Alex Benn=C3=A9e
