Received: from eggs.gnu.org ([209.51.188.92]:41694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLrbV-0007nh-0x
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLrbR-0001ne-Vh
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:57:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLrbR-0001mn-Nu
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:57:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id p21so7591179wmc.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:57:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	n63sm5381331wmn.38.2019.05.01.08.56.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 08:56:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 0EE1D1FF87
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 16:56:59 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-4-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 16:56:59 +0100
Message-ID: <87tvee5fsk.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/29] tcg: Allow add_vec, sub_vec,
 neg_vec, not_vec to be expanded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op-vec.c | 49 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index 27f65600c3..cfb18682b1 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -226,16 +226,6 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr b, TCGArg =
o, TCGType low_type)
>      vec_gen_3(INDEX_op_st_vec, low_type, 0, ri, bi, o);
>  }
>
> -void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> -{
> -    vec_gen_op3(INDEX_op_add_vec, vece, r, a, b);
> -}
> -
> -void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> -{
> -    vec_gen_op3(INDEX_op_sub_vec, vece, r, a, b);
> -}
> -
>  void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
>  {
>      vec_gen_op3(INDEX_op_and_vec, 0, r, a, b);
> @@ -296,11 +286,30 @@ void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCG=
v_vec a, TCGv_vec b)
>      tcg_gen_not_vec(0, r, r);
>  }
>
> +static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
> +{
> +    TCGTemp *rt =3D tcgv_vec_temp(r);
> +    TCGTemp *at =3D tcgv_vec_temp(a);
> +    TCGArg ri =3D temp_arg(rt);
> +    TCGArg ai =3D temp_arg(at);
> +    TCGType type =3D rt->base_type;
> +    int can;
> +
> +    tcg_debug_assert(at->base_type >=3D type);
> +    can =3D tcg_can_emit_vec_op(opc, type, vece);
> +    if (can > 0) {
> +        vec_gen_2(opc, type, vece, ri, ai);
> +    } else if (can < 0) {
> +        tcg_expand_vec_op(opc, type, vece, ri, ai);
> +    } else {
> +        return false;
> +    }
> +    return true;
> +}
> +
>  void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
>  {
> -    if (TCG_TARGET_HAS_not_vec) {
> -        vec_gen_op2(INDEX_op_not_vec, 0, r, a);
> -    } else {
> +    if (!TCG_TARGET_HAS_not_vec || !do_op2(vece, r, a, INDEX_op_not_vec)=
) {
>          TCGv_vec t =3D tcg_const_ones_vec_matching(r);
>          tcg_gen_xor_vec(0, r, a, t);
>          tcg_temp_free_vec(t);
> @@ -309,9 +318,7 @@ void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_=
vec a)
>
>  void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
>  {
> -    if (TCG_TARGET_HAS_neg_vec) {
> -        vec_gen_op2(INDEX_op_neg_vec, vece, r, a);
> -    } else {
> +    if (!TCG_TARGET_HAS_neg_vec || !do_op2(vece, r, a, INDEX_op_neg_vec)=
) {
>          TCGv_vec t =3D tcg_const_zeros_vec_matching(r);
>          tcg_gen_sub_vec(vece, r, t, a);
>          tcg_temp_free_vec(t);
> @@ -409,6 +416,16 @@ static void do_op3(unsigned vece, TCGv_vec r, TCGv_v=
ec a,
>      }
>  }
>
> +void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    do_op3(vece, r, a, b, INDEX_op_add_vec);
> +}
> +
> +void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    do_op3(vece, r, a, b, INDEX_op_sub_vec);
> +}
> +
>  void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
>  {
>      do_op3(vece, r, a, b, INDEX_op_mul_vec);


--
Alex Benn=C3=A9e
