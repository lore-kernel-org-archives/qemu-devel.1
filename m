Received: from eggs.gnu.org ([209.51.188.92]:59944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDaa-0006zx-0x
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDaY-0001TV-9k
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:25:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMDaW-0001Ir-Fx
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:25:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id h11so3149281wmb.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:25:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s145sm18802137wme.38.2019.05.02.08.25.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 08:25:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id F109C1FF87
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 16:25:28 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-20-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-20-richard.henderson@linaro.org>
Date: Thu, 02 May 2019 16:25:28 +0100
Message-ID: <874l6c6fpz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 19/29] tcg: Add support for integer
 absolute value
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

> Remove a function of the same name from target/arm/.
> Use a branchless implementation of abs gleaned from gcc.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op.h           |  5 +++++
>  target/arm/translate.c | 10 ----------
>  tcg/tcg-op.c           | 20 ++++++++++++++++++++
>  3 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 472b73cb38..660fe205d0 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -335,6 +335,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i=
32 arg2);
>  void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
> +void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
>
>  static inline void tcg_gen_discard_i32(TCGv_i32 arg)
>  {
> @@ -534,6 +535,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i=
64 arg2);
>  void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
> +void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
>
>  #if TCG_TARGET_REG_BITS =3D=3D 64
>  static inline void tcg_gen_discard_i64(TCGv_i64 arg)
> @@ -973,6 +975,7 @@ void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_=
vec a, TCGv_vec b);
>  void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>  void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
> +void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>  void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b=
);
>  void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b=
);
>  void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b=
);
> @@ -1019,6 +1022,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCG=
Arg offset, TCGType t);
>  #define tcg_gen_addi_tl tcg_gen_addi_i64
>  #define tcg_gen_sub_tl tcg_gen_sub_i64
>  #define tcg_gen_neg_tl tcg_gen_neg_i64
> +#define tcg_gen_abs_tl tcg_gen_abs_i64
>  #define tcg_gen_subfi_tl tcg_gen_subfi_i64
>  #define tcg_gen_subi_tl tcg_gen_subi_i64
>  #define tcg_gen_and_tl tcg_gen_and_i64
> @@ -1131,6 +1135,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCG=
Arg offset, TCGType t);
>  #define tcg_gen_addi_tl tcg_gen_addi_i32
>  #define tcg_gen_sub_tl tcg_gen_sub_i32
>  #define tcg_gen_neg_tl tcg_gen_neg_i32
> +#define tcg_gen_abs_tl tcg_gen_abs_i32
>  #define tcg_gen_subfi_tl tcg_gen_subfi_i32
>  #define tcg_gen_subi_tl tcg_gen_subi_i32
>  #define tcg_gen_and_tl tcg_gen_and_i32
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 35bd426a3d..b25781554f 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -604,16 +604,6 @@ static void gen_sar(TCGv_i32 dest, TCGv_i32 t0, TCGv=
_i32 t1)
>      tcg_temp_free_i32(tmp1);
>  }
>
> -static void tcg_gen_abs_i32(TCGv_i32 dest, TCGv_i32 src)
> -{
> -    TCGv_i32 c0 =3D tcg_const_i32(0);
> -    TCGv_i32 tmp =3D tcg_temp_new_i32();
> -    tcg_gen_neg_i32(tmp, src);
> -    tcg_gen_movcond_i32(TCG_COND_GT, dest, src, c0, src, tmp);
> -    tcg_temp_free_i32(c0);
> -    tcg_temp_free_i32(tmp);
> -}
> -
>  static void shifter_out_im(TCGv_i32 var, int shift)
>  {
>      if (shift =3D=3D 0) {
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index a00d1df37e..0ac291f1c4 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1091,6 +1091,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TC=
Gv_i32 b)
>      tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
>  }
>
> +void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
> +{
> +    TCGv_i32 t =3D tcg_temp_new_i32();
> +
> +    tcg_gen_sari_i32(t, a, 31);
> +    tcg_gen_xor_i32(ret, a, t);
> +    tcg_gen_sub_i32(ret, ret, t);
> +    tcg_temp_free_i32(t);
> +}
> +
>  /* 64-bit ops */
>
>  #if TCG_TARGET_REG_BITS =3D=3D 32
> @@ -2548,6 +2558,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TC=
Gv_i64 b)
>      tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
>  }
>
> +void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
> +{
> +    TCGv_i64 t =3D tcg_temp_new_i64();
> +
> +    tcg_gen_sari_i64(t, a, 63);
> +    tcg_gen_xor_i64(ret, a, t);
> +    tcg_gen_sub_i64(ret, ret, t);
> +    tcg_temp_free_i64(t);
> +}
> +
>  /* Size changing operations.  */
>
>  void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)


--
Alex Benn=C3=A9e
