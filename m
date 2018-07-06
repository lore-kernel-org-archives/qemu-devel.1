Received: from eggs.gnu.org ([2001:4830:134:3::10]:54516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbLsj-00021R-7n
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbLse-0002bY-8D
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:14:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fbLsd-0002Zi-VQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:14:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id c13-v6so3225337wrt.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 01:14:15 -0700 (PDT)
References: <20180705191929.30773-1-richard.henderson@linaro.org>
	<20180705191929.30773-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180705191929.30773-3-richard.henderson@linaro.org>
Date: Fri, 06 Jul 2018 09:14:13 +0100
Message-ID: <87in5s93xm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Fix do_predset for large VL
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

> Use MAKE_64BIT_MASK instead of open-coding.  Remove an odd
> vector size check that is unlikely to be more profitable
> than 3 64-bit integer stores.  Correct the iteration for WORD
> to avoid writing too much data.
>
> Fixes RISU tests of PTRUE for VL 256.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-sve.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index d41f1155f9..374051cd20 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -1438,7 +1438,7 @@ static bool do_predset(DisasContext *s, int esz, in=
t rd, int pat, bool setflag)
>          setsz =3D numelem << esz;
>          lastword =3D word =3D pred_esz_masks[esz];
>          if (setsz % 64) {
> -            lastword &=3D ~(-1ull << (setsz % 64));
> +            lastword &=3D MAKE_64BIT_MASK(0, setsz % 64);
>          }
>      }
>
> @@ -1457,19 +1457,13 @@ static bool do_predset(DisasContext *s, int esz, =
int rd, int pat, bool setflag)
>              tcg_gen_gvec_dup64i(ofs, oprsz, maxsz, word);
>              goto done;
>          }
> -        if (oprsz * 8 =3D=3D setsz + 8) {
> -            tcg_gen_gvec_dup64i(ofs, oprsz, maxsz, word);
> -            tcg_gen_movi_i64(t, 0);
> -            tcg_gen_st_i64(t, cpu_env, ofs + oprsz - 8);
> -            goto done;
> -        }
>      }
>
>      setsz /=3D 8;
>      fullsz /=3D 8;
>
>      tcg_gen_movi_i64(t, word);
> -    for (i =3D 0; i < setsz; i +=3D 8) {
> +    for (i =3D 0; i < QEMU_ALIGN_DOWN(setsz, 8); i +=3D 8) {
>          tcg_gen_st_i64(t, cpu_env, ofs + i);
>      }
>      if (lastword !=3D word) {


--
Alex Benn=C3=A9e
