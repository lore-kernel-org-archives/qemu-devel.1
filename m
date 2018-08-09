Received: from eggs.gnu.org ([2001:4830:134:3::10]:46209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnigX-00088u-RW
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnigT-0007k1-4I
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:00:53 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnigS-0007jQ-KY
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:00:49 -0400
Received: by mail-wm0-x242.google.com with SMTP id s9-v6so5919991wmh.3
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 04:00:48 -0700 (PDT)
References: <20180809034033.10579-1-richard.henderson@linaro.org>
	<20180809034033.10579-7-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180809034033.10579-7-richard.henderson@linaro.org>
Date: Thu, 09 Aug 2018 12:00:45 +0100
Message-ID: <87eff7pzxe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/11] target/arm: Fix sign-extension in
 sve do_ldr/do_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-stable@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> The expression (int) imm + (uint32_t) len_align turns into uint32_t
> and thus with negative imm produces a memory operation at the wrong
> offset.  None of the numbers involved are particularly large, so
> change everything to use int.
>
> Cc: qemu-stable@nongnu.org (3.0.1)
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-sve.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 89efc80ee7..9e63b5f8e5 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -4372,12 +4372,11 @@ static bool trans_UCVTF_dd(DisasContext *s, arg_r=
pr_esz *a, uint32_t insn)
>   * The load should begin at the address Rn + IMM.
>   */
>
> -static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
> -                   int rn, int imm)
> +static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int =
imm)
>  {
> -    uint32_t len_align =3D QEMU_ALIGN_DOWN(len, 8);
> -    uint32_t len_remain =3D len % 8;
> -    uint32_t nparts =3D len / 8 + ctpop8(len_remain);
> +    int len_align =3D QEMU_ALIGN_DOWN(len, 8);
> +    int len_remain =3D len % 8;
> +    int nparts =3D len / 8 + ctpop8(len_remain);
>      int midx =3D get_mem_index(s);
>      TCGv_i64 addr, t0, t1;
>
> @@ -4458,12 +4457,11 @@ static void do_ldr(DisasContext *s, uint32_t vofs=
, uint32_t len,
>  }
>
>  /* Similarly for stores.  */
> -static void do_str(DisasContext *s, uint32_t vofs, uint32_t len,
> -                   int rn, int imm)
> +static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int =
imm)
>  {
> -    uint32_t len_align =3D QEMU_ALIGN_DOWN(len, 8);
> -    uint32_t len_remain =3D len % 8;
> -    uint32_t nparts =3D len / 8 + ctpop8(len_remain);
> +    int len_align =3D QEMU_ALIGN_DOWN(len, 8);
> +    int len_remain =3D len % 8;
> +    int nparts =3D len / 8 + ctpop8(len_remain);
>      int midx =3D get_mem_index(s);
>      TCGv_i64 addr, t0;


--
Alex Benn=C3=A9e
