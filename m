Received: from eggs.gnu.org ([209.51.188.92]:34079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLr8U-0005ll-O7
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLr8R-00026I-1j
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:27:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLr8P-00024f-64
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:27:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id h11so7327107wmb.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:27:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d10sm6156503wmb.15.2019.05.01.08.26.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 08:26:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E31B31FF87
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 16:26:57 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-3-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 16:26:57 +0100
Message-ID: <87v9yu5h6m.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/29] tcg: Do not recreate
 INDEX_op_neg_vec unless supported
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

> Use tcg_can_emit_vec_op instead of just TCG_TARGET_HAS_neg_vec,
> so that we check the type and vece for the actual operation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/optimize.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 5150c38a25..24faa06260 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -734,9 +734,13 @@ void tcg_optimize(TCGContext *s)
>                  } else if (opc =3D=3D INDEX_op_sub_i64) {
>                      neg_op =3D INDEX_op_neg_i64;
>                      have_neg =3D TCG_TARGET_HAS_neg_i64;
> -                } else {
> +                } else if (TCG_TARGET_HAS_neg_vec) {
> +                    TCGType type =3D TCGOP_VECL(op) + TCG_TYPE_V64;
> +                    unsigned vece =3D TCGOP_VECE(op);
>                      neg_op =3D INDEX_op_neg_vec;
> -                    have_neg =3D TCG_TARGET_HAS_neg_vec;
> +                    have_neg =3D tcg_can_emit_vec_op(neg_op, type, vece)=
 > 0;
> +                } else {
> +                    break;
>                  }
>                  if (!have_neg) {
>                      break;


--
Alex Benn=C3=A9e
