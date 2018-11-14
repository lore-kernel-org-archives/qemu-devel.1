Received: from eggs.gnu.org ([2001:4830:134:3::10]:49521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMyHa-0006rx-RA
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMyHR-0005Lq-51
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:44:46 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMyHP-0005Gz-8g
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:44:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so5160988wrt.13
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 08:44:33 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-9-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-9-cota@braap.org>
Date: Wed, 14 Nov 2018 16:44:30 +0000
Message-ID: <87r2fnd2xd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 08/48] tcg: export tcg_gen_runtime_helper
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

> This takes the TCGHelperInfo directly, which will allow us to generate
> helpers at run-time.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg.h |  2 ++
>  tcg/tcg.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 47 insertions(+), 5 deletions(-)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 9f9643b470..3fa434d891 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -1077,6 +1077,8 @@ do {\
>  bool tcg_op_supported(TCGOpcode op);
>
>  void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
> +void tcg_gen_runtime_helper(const TCGHelperInfo *orig, TCGTemp *ret, int=
 nargs,
> +                            TCGTemp **args);
>
>  TCGOp *tcg_emit_op(TCGOpcode opc);
>  void tcg_op_remove(TCGContext *s, TCGOp *op);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 08b6926894..87e02da740 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1642,15 +1642,13 @@ bool tcg_op_supported(TCGOpcode op)
>  /* Note: we convert the 64 bit args to 32 bit and do some alignment
>     and endian swap. Maybe it would be better to do the alignment
>     and endian swap in tcg_reg_alloc_call(). */
> -void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
> +static void do_tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, int narg=
s,
> +                             TCGTemp **args)
>  {
>      int i, real_args, nb_rets, pi;
>      unsigned sizemask, flags;
> -    TCGHelperInfo *info;
> -    uint32_t hash =3D tcg_helper_func_hash(func);
>      TCGOp *op;
>
> -    info =3D qht_lookup_custom(&helper_table, func, hash, tcg_helper_loo=
kup_cmp);
>      flags =3D info->flags;
>      sizemask =3D info->sizemask;
>
> @@ -1774,7 +1772,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int na=
rgs, TCGTemp **args)
>          op->args[pi++] =3D temp_arg(args[i]);
>          real_args++;
>      }
> -    op->args[pi++] =3D (uintptr_t)func;
> +    op->args[pi++] =3D (uintptr_t)info->func;
>      op->args[pi++] =3D flags;
>      TCGOP_CALLI(op) =3D real_args;
>
> @@ -1812,6 +1810,48 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int n=
args, TCGTemp **args)
>  #endif /* TCG_TARGET_EXTEND_ARGS */
>  }
>
> +void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
> +{
> +    TCGHelperInfo *info;
> +    uint32_t hash =3D tcg_helper_func_hash(func);
> +
> +    /*
> +     * Here we can get away with tcg_helper_lookup_cmp, which only looks
> +     * at the function pointer, since we have the compile-time guarantee
> +     * that @func can only be in one TCGHelperInfo.
> +     */
> +    info =3D qht_lookup_custom(&helper_table, func, hash, tcg_helper_loo=
kup_cmp);
> +    do_tcg_gen_callN(info, ret, nargs, args);
> +}
> +
> +void tcg_gen_runtime_helper(const TCGHelperInfo *orig, TCGTemp *ret, int=
 nargs,
> +                            TCGTemp **args)
> +{
> +    TCGHelperInfo *info;
> +    uint32_t hash =3D tcg_helper_func_hash(orig->func);
> +
> +    /*
> +     * Use the full TCGHelperInfo lookup, since there is no guarantee th=
at func
> +     * will be unique to each TCGHelperInfo. For instance, we could have=
 the
> +     * same helper function registered in several TCGHelperInfo's, each =
of them
> +     * with different flags.
> +     */
> +    info =3D qht_lookup(&helper_table, orig, hash);
> +    if (info =3D=3D NULL) {
> +        void *existing =3D NULL;
> +
> +        /* @orig might be in the stack, so we need to allocate a new str=
uct */
> +        info =3D g_new(TCGHelperInfo, 1);
> +        memcpy(info, orig, sizeof(TCGHelperInfo));
> +        qht_insert(&helper_table, info, hash, &existing);
> +        if (unlikely(existing)) {
> +            g_free(info);
> +            info =3D existing;
> +        }
> +    }
> +    do_tcg_gen_callN(info, ret, nargs, args);
> +}
> +
>  static void tcg_reg_alloc_start(TCGContext *s)
>  {
>      int i, n;


--
Alex Benn=C3=A9e
