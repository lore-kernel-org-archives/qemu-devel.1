Received: from eggs.gnu.org ([2001:4830:134:3::10]:40832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMwMi-0001xx-I7
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMwMe-0000Yy-3S
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:42:00 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMwMd-0000YN-Tl
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:41:56 -0500
Received: by mail-wm1-x344.google.com with SMTP id w7-v6so15684382wmc.1
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 06:41:55 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-7-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-7-cota@braap.org>
Date: Wed, 14 Nov 2018 14:41:53 +0000
Message-ID: <87zhubd8lq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 06/48] tcg: use QHT for helper_table
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

> This will allow us to add TCG helpers at run-time.
>
> While at it, rename tcg_find_helper to tcg_helper_find for consistency
> with the added tcg_helper_foo functions.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tcg/tcg.c | 59 +++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 49 insertions(+), 10 deletions(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index e85133ef05..65da3c5dbf 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -33,6 +33,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/cutils.h"
>  #include "qemu/host-utils.h"
> +#include "qemu/xxhash.h"
>  #include "qemu/timer.h"
>
>  /* Note: the long term plan is to reduce the dependencies on the QEMU
> @@ -879,13 +880,46 @@ typedef struct TCGHelperInfo {
>  static const TCGHelperInfo all_helpers[] =3D {
>  #include "exec/helper-tcg.h"
>  };
> -static GHashTable *helper_table;
> +static struct qht helper_table;
> +static bool helper_table_inited;

Having a flag for initialisation seems a little excessive considering
we've moved that initialisation into tcg_context_init() which has to be
called before we do anything TCG related.

>  static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_orde=
r)];
>  static void process_op_defs(TCGContext *s);
>  static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
>                                              TCGReg reg, const char *name=
);
>
> +static inline uint32_t tcg_helper_func_hash(const void *func)
> +{
> +    return qemu_xxhash2((uint64_t)func);
> +}
> +
> +static bool tcg_helper_cmp(const void *ap, const void *bp)
> +{
> +    const TCGHelperInfo *a =3D ap;
> +    const TCGHelperInfo *b =3D bp;
> +
> +    return a->func =3D=3D b->func &&
> +        a->flags =3D=3D b->flags &&
> +        a->sizemask =3D=3D b->sizemask &&
> +        !strcmp(a->name, b->name);
> +}
> +
> +static bool tcg_helper_lookup_cmp(const void *obj, const void *func)
> +{
> +    const TCGHelperInfo *info =3D obj;
> +
> +    return info->func =3D=3D func;
> +}
> +
> +static void tcg_helper_insert(const TCGHelperInfo *info)
> +{
> +    uint32_t hash =3D tcg_helper_func_hash(info->func);
> +    bool inserted;
> +
> +    inserted =3D qht_insert(&helper_table, (void *)info, hash, NULL);
> +    g_assert(inserted);
> +}
> +
>  void tcg_context_init(TCGContext *s)
>  {
>      int op, total_args, n, i;
> @@ -919,13 +953,13 @@ void tcg_context_init(TCGContext *s)
>      }
>
>      /* Register helpers.  */
> -    /* Use g_direct_hash/equal for direct pointer comparisons on func.  =
*/
> -    helper_table =3D g_hash_table_new(NULL, NULL);
> +    qht_init(&helper_table, tcg_helper_cmp, ARRAY_SIZE(all_helpers),
> +             QHT_MODE_AUTO_RESIZE);
>
>      for (i =3D 0; i < ARRAY_SIZE(all_helpers); ++i) {
> -        g_hash_table_insert(helper_table, (gpointer)all_helpers[i].func,
> -                            (gpointer)&all_helpers[i]);
> +        tcg_helper_insert(&all_helpers[i]);
>      }
> +    helper_table_inited =3D true;

so I think we can drop this and...

>
>      tcg_target_init(s);
>      process_op_defs(s);
> @@ -1620,9 +1654,10 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int n=
args, TCGTemp **args)
>      int i, real_args, nb_rets, pi;
>      unsigned sizemask, flags;
>      TCGHelperInfo *info;
> +    uint32_t hash =3D tcg_helper_func_hash(func);
>      TCGOp *op;
>
> -    info =3D g_hash_table_lookup(helper_table, (gpointer)func);
> +    info =3D qht_lookup_custom(&helper_table, func, hash, tcg_helper_loo=
kup_cmp);
>      flags =3D info->flags;
>      sizemask =3D info->sizemask;
>
> @@ -1825,11 +1860,15 @@ static char *tcg_get_arg_str(TCGContext *s, char =
*buf,
>  }
>
>  /* Find helper name.  */
> -static inline const char *tcg_find_helper(TCGContext *s, uintptr_t val)
> +static inline const char *tcg_helper_find(TCGContext *s, uintptr_t val)
>  {
>      const char *ret =3D NULL;
> -    if (helper_table) {
> -        TCGHelperInfo *info =3D g_hash_table_lookup(helper_table, (gpoin=
ter)val);
> +    if (helper_table_inited) {

change this to a assert(helper_table.cmp) if you really want to.

> +        uint32_t hash =3D tcg_helper_func_hash((void *)val);
> +        TCGHelperInfo *info;
> +
> +        info =3D qht_lookup_custom(&helper_table, (void *)val, hash,
> +                                 tcg_helper_lookup_cmp);
>          if (info) {
>              ret =3D info->name;
>          }
> @@ -1919,7 +1958,7 @@ void tcg_dump_ops(TCGContext *s)
>
>              /* function name, flags, out args */
>              col +=3D qemu_log(" %s %s,$0x%" TCG_PRIlx ",$%d", def->name,
> -                            tcg_find_helper(s, op->args[nb_oargs + nb_ia=
rgs]),
> +                            tcg_helper_find(s, op->args[nb_oargs + nb_ia=
rgs]),
>                              op->args[nb_oargs + nb_iargs + 1], nb_oargs);
>              for (i =3D 0; i < nb_oargs; i++) {
>                  col +=3D qemu_log(",%s", tcg_get_arg_str(s, buf, sizeof(=
buf),

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
