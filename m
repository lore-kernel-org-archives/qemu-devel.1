Received: from eggs.gnu.org ([2001:4830:134:3::10]:55444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMyXm-0000zE-Dy
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMyXU-0001iw-Cs
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:01:24 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMyXT-0001iL-RX
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:01:16 -0500
Received: by mail-wm1-x344.google.com with SMTP id f2-v6so15379038wme.3
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 09:01:15 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-10-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-10-cota@braap.org>
Date: Wed, 14 Nov 2018 17:01:13 +0000
Message-ID: <87pnv7d25i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 09/48] tcg: reset runtime helpers when
 flushing the code cache
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

> In preparation for adding plugin support. One of the clean-up
> actions when uninstalling plugins will be to flush the code
> cache. We'll also have to clear the runtime helpers, since
> some of those runtime helpers may belong to the plugin
> being uninstalled.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tcg/tcg.h                 |  1 +
>  accel/tcg/translate-all.c |  1 +
>  tcg/tcg.c                 | 21 +++++++++++++++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 3fa434d891..2c378415d2 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -1079,6 +1079,7 @@ bool tcg_op_supported(TCGOpcode op);
>  void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
>  void tcg_gen_runtime_helper(const TCGHelperInfo *orig, TCGTemp *ret, int=
 nargs,
>                              TCGTemp **args);
> +void tcg_reset_runtime_helpers(void);

I know tcg.h doesn't have and API doc blocks but perhaps we should
start?

  /**
   * tcg_reset_runtime_helpers:
   *
   * Remove all runtime registered helpers. Should only be called from a
   * quiescent system while flushing old code.
   */

>
>  TCGOp *tcg_emit_op(TCGOpcode opc);
>  void tcg_op_remove(TCGContext *s, TCGOp *op);
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 038d82fdb5..c8b3e0a491 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1255,6 +1255,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_d=
ata tb_flush_count)
>
>      qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
>      page_flush_tb();
> +    tcg_reset_runtime_helpers();
>
>      tcg_region_reset_all();
>      /* XXX: flush processor icache at this point if cache flush is
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 87e02da740..a6824145b0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -874,6 +874,7 @@ static const TCGHelperInfo all_helpers[] =3D {
>  #include "exec/helper-tcg.h"
>  };
>  static struct qht helper_table;
> +static struct qht runtime_helper_table;
>  static bool helper_table_inited;
>
>  static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_orde=
r)];
> @@ -913,6 +914,22 @@ static void tcg_helper_insert(const TCGHelperInfo *i=
nfo)
>      g_assert(inserted);
>  }
>
> +static void
> +rm_from_helper_table_and_free(void *p, uint32_t h, void *userp)
> +{
> +    bool success;
> +
> +    success =3D qht_remove(&helper_table, p, h);
> +    g_assert(success);
> +    g_free(p);
> +}
> +
> +void tcg_reset_runtime_helpers(void)
> +{
> +    qht_iter(&runtime_helper_table, rm_from_helper_table_and_free, NULL);
> +    qht_reset(&runtime_helper_table);
> +}
> +
>  void tcg_context_init(TCGContext *s)
>  {
>      int op, total_args, n, i;
> @@ -948,6 +965,7 @@ void tcg_context_init(TCGContext *s)
>      /* Register helpers.  */
>      qht_init(&helper_table, tcg_helper_cmp, ARRAY_SIZE(all_helpers),
>               QHT_MODE_AUTO_RESIZE);
> +    qht_init(&runtime_helper_table, tcg_helper_cmp, 1, QHT_MODE_AUTO_RES=
IZE);
>
>      for (i =3D 0; i < ARRAY_SIZE(all_helpers); ++i) {
>          tcg_helper_insert(&all_helpers[i]);
> @@ -1847,6 +1865,9 @@ void tcg_gen_runtime_helper(const TCGHelperInfo *or=
ig, TCGTemp *ret, int nargs,
>          if (unlikely(existing)) {
>              g_free(info);
>              info =3D existing;
> +        } else {
> +            qht_insert(&runtime_helper_table, info, hash, &existing);
> +            g_assert(existing =3D=3D NULL);
>          }
>      }
>      do_tcg_gen_callN(info, ret, nargs, args);

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
