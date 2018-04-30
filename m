Received: from eggs.gnu.org ([2001:4830:134:3::10]:43694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDB9F-0005ke-W2
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDB9C-0000EM-Ti
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:55:30 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDB9C-0000DA-J7
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:55:26 -0400
Received: by mail-wm0-x241.google.com with SMTP id t11so14031992wmt.0
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 08:55:26 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180425012300.14698-3-richard.henderson@linaro.org>
Date: Mon, 30 Apr 2018 16:55:23 +0100
Message-ID: <87lgd44rkk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/9] target/arm: Implement vector shifted
 FCVT for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> While we have some of the scalar paths for FCVT for fp16,
> we failed to decode the fp16 version of these instructions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 65 ++++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index c92e052686..e2d11998bd 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -7120,19 +7120,28 @@ static void handle_simd_shift_fpint_conv(DisasCon=
text *s, bool is_scalar,
>                                           bool is_q, bool is_u,
>                                           int immh, int immb, int rn, int=
 rd)
>  {
> -    bool is_double =3D extract32(immh, 3, 1);
>      int immhb =3D immh << 3 | immb;
> -    int fracbits =3D (is_double ? 128 : 64) - immhb;
> -    int pass;
> +    int pass, size, fracbits;
>      TCGv_ptr tcg_fpstatus;
>      TCGv_i32 tcg_rmode, tcg_shift;
>
> -    if (!extract32(immh, 2, 2)) {
> -        unallocated_encoding(s);
> -        return;
> -    }
> -
> -    if (!is_scalar && !is_q && is_double) {
> +    if (immh & 0x8) {
> +        size =3D MO_64;
> +        if (!is_scalar && !is_q) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +    } else if (immh & 0x4) {
> +        size =3D MO_32;
> +    } else if (immh & 0x2) {
> +        size =3D MO_16;
> +        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +    } else {
> +        /* Should have split out AdvSIMD modified immediate earlier.  */
> +        assert(immh =3D=3D 1);
>          unallocated_encoding(s);
>          return;
>      }
> @@ -7144,11 +7153,12 @@ static void handle_simd_shift_fpint_conv(DisasCon=
text *s, bool is_scalar,
>      assert(!(is_scalar && is_q));
>
>      tcg_rmode =3D tcg_const_i32(arm_rmode_to_sf(FPROUNDING_ZERO));
> -    tcg_fpstatus =3D get_fpstatus_ptr(false);
> +    tcg_fpstatus =3D get_fpstatus_ptr(size =3D=3D MO_16);
>      gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
> +    fracbits =3D (16 << size) - immhb;
>      tcg_shift =3D tcg_const_i32(fracbits);
>
> -    if (is_double) {
> +    if (size =3D=3D 3) {
>          int maxpass =3D is_scalar ? 1 : 2;
>
>          for (pass =3D 0; pass < maxpass; pass++) {
> @@ -7165,20 +7175,37 @@ static void handle_simd_shift_fpint_conv(DisasCon=
text *s, bool is_scalar,
>          }
>          clear_vec_high(s, is_q, rd);
>      } else {
> -        int maxpass =3D is_scalar ? 1 : is_q ? 4 : 2;
> +        void (*fn)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
> +        int maxpass =3D is_scalar ? 1 : (8 << is_q >> size);

brackets

> +
> +        switch (size) {
> +        case MO_16:
> +            if (is_u) {
> +                fn =3D gen_helper_vfp_toulh;
> +            } else {
> +                fn =3D gen_helper_vfp_toslh;
> +            }
> +            break;
> +        case MO_32:
> +            if (is_u) {
> +                fn =3D gen_helper_vfp_touls;
> +            } else {
> +                fn =3D gen_helper_vfp_tosls;
> +            }
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +
>          for (pass =3D 0; pass < maxpass; pass++) {
>              TCGv_i32 tcg_op =3D tcg_temp_new_i32();
>
> -            read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
> -            if (is_u) {
> -                gen_helper_vfp_touls(tcg_op, tcg_op, tcg_shift, tcg_fpst=
atus);
> -            } else {
> -                gen_helper_vfp_tosls(tcg_op, tcg_op, tcg_shift, tcg_fpst=
atus);
> -            }
> +            read_vec_element_i32(s, tcg_op, rn, pass, size);
> +            fn(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
>              if (is_scalar) {
>                  write_fp_sreg(s, rd, tcg_op);
>              } else {
> -                write_vec_element_i32(s, tcg_op, rd, pass, MO_32);
> +                write_vec_element_i32(s, tcg_op, rd, pass, size);
>              }
>              tcg_temp_free_i32(tcg_op);
>          }


--
Alex Benn=C3=A9e
