Received: from eggs.gnu.org ([2001:4830:134:3::10]:52118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJaH-00062S-OM
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJaE-00009n-KP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:29:49 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVJaE-00009E-Cy
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:29:46 -0400
Received: by mail-wr0-f178.google.com with SMTP id c11so38101174wrc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:29:46 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-15-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-15-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 16:28:43 +0100
Message-ID: <87d1958yj8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/22] tcg: take .helpers out of TCGContext
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
> The hash table becomes read-only after it is filled in,
> so we can save space by keeping just a global pointer to it.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/tcg.h |  2 --
>  tcg/tcg.c | 10 +++++-----
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index ad2d959..4f57878 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -663,8 +663,6 @@ struct TCGContext {
>
>      tcg_insn_unit *code_ptr;
>
> -    GHashTable *helpers;
> -
>  #ifdef CONFIG_PROFILER
>      /* profiling info */
>      int64_t tb_count1;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 3559829..d9b083a 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -319,6 +319,7 @@ typedef struct TCGHelperInfo {
>  static const TCGHelperInfo all_helpers[] = {
>  #include "exec/helper-tcg.h"
>  };
> +static GHashTable *helper_table;
>
>  static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
>  static void process_op_defs(TCGContext *s);
> @@ -329,7 +330,6 @@ void tcg_context_init(TCGContext *s)
>      TCGOpDef *def;
>      TCGArgConstraint *args_ct;
>      int *sorted_args;
> -    GHashTable *helper_table;
>
>      memset(s, 0, sizeof(*s));
>      s->nb_globals = 0;
> @@ -357,7 +357,7 @@ void tcg_context_init(TCGContext *s)
>
>      /* Register helpers.  */
>      /* Use g_direct_hash/equal for direct pointer comparisons on func.  */
> -    s->helpers = helper_table = g_hash_table_new(NULL, NULL);
> +    helper_table = g_hash_table_new(NULL, NULL);
>
>      for (i = 0; i < ARRAY_SIZE(all_helpers); ++i) {
>          g_hash_table_insert(helper_table, (gpointer)all_helpers[i].func,
> @@ -761,7 +761,7 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
>      unsigned sizemask, flags;
>      TCGHelperInfo *info;
>
> -    info = g_hash_table_lookup(s->helpers, (gpointer)func);
> +    info = g_hash_table_lookup(helper_table, (gpointer)func);
>      flags = info->flags;
>      sizemask = info->sizemask;
>
> @@ -990,8 +990,8 @@ static char *tcg_get_arg_str_idx(TCGContext *s, char *buf,
>  static inline const char *tcg_find_helper(TCGContext *s, uintptr_t val)
>  {
>      const char *ret = NULL;
> -    if (s->helpers) {
> -        TCGHelperInfo *info = g_hash_table_lookup(s->helpers, (gpointer)val);
> +    if (helper_table) {
> +        TCGHelperInfo *info = g_hash_table_lookup(helper_table, (gpointer)val);
>          if (info) {
>              ret = info->name;
>          }


--
Alex Bennée
