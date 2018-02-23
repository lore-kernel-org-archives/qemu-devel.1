Received: from eggs.gnu.org ([2001:4830:134:3::10]:47909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFXj-0003Dh-Rm
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFXi-00074k-TB
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:45:51 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:43895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epFXi-00072r-M9
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:45:50 -0500
Received: by mail-pg0-x243.google.com with SMTP id f6so3491824pgs.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:45:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-33-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 15:45:29 +0000
Message-ID: <CAFEAcA_3o+xVj-fUS1vAYjMQzR6YSo1EVLutoVHCWtZZhpP6jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 32/67] target/arm: Implement
 SVE copy to vector (predicated)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 13 +++++++++++++
>  target/arm/sve.decode      |  6 ++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 207a22a0bc..fc2a295ab7 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -2422,6 +2422,19 @@ static void trans_LASTB_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
>      do_last_general(s, a, true);
>  }
>
> +static void trans_CPY_m_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
> +{
> +    do_cpy_m(s, a->esz, a->rd, a->rd, a->pg, cpu_reg_sp(s, a->rn));
> +}
> +
> +static void trans_CPY_m_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
> +{
> +    int ofs = vec_reg_offset(s, a->rn, 0, a->esz);
> +    TCGv_i64 t = load_esz(cpu_env, ofs, a->esz);
> +    do_cpy_m(s, a->esz, a->rd, a->rd, a->pg, t);
> +    tcg_temp_free_i64(t);
> +}
> +
>  /*
>   *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
>   */
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 1370802c12..5e127de88c 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -451,6 +451,12 @@ LASTB_v            00000101 .. 10001 1 100 ... ..... .....         @rd_pg_rn
>  LASTA_r                00000101 .. 10000 0 101 ... ..... .....         @rd_pg_rn
>  LASTB_r                00000101 .. 10000 1 101 ... ..... .....         @rd_pg_rn
>
> +# SVE copy element from SIMD&FP scalar register
> +CPY_m_v                00000101 .. 100000 100 ... ..... .....          @rd_pg_rn
> +
> +# SVE copy element from general register to vector (predicated)
> +CPY_m_r                00000101 .. 101000 101 ... ..... .....          @rd_pg_rn
> +
>  ### SVE Predicate Logical Operations Group
>
>  # SVE predicate logical operations
> --
> 2.14.3

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(if only every patch in the series was this size...)

thanks
-- PMM
