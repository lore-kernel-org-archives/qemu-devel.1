Received: from eggs.gnu.org ([2001:4830:134:3::10]:51205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekjh-0003O0-Pk
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekjh-0004Uv-2d
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:50:49 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eekjg-0004Ul-T4
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:50:48 -0500
Received: by mail-oi0-x243.google.com with SMTP id w135so5678892oie.3
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 08:50:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-15-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 16:50:27 +0000
Message-ID: <CAFEAcA_3b=qLH9-PeNb0UHboJXY7gy4axaJwXPnSr0OS=k+G4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10.5 14/20] target/arm: Use vector
 infrastructure for aa64 dup/movi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2018 at 16:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 83 +++++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 49 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 219cc1e19d..2495414603 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5863,38 +5863,24 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
>   *
>   * size: encoded in imm5 (see ARM ARM LowestSetBit())
>   */
> +

Stray whitespace change

>  static void handle_simd_dupe(DisasContext *s, int is_q, int rd, int rn,
>                               int imm5)
>  {
>      int size = ctz32(imm5);
> -    int esize = 8 << size;
> -    int elements = (is_q ? 128 : 64) / esize;
> -    int index, i;
> -    TCGv_i64 tmp;
> +    int index = imm5 >> (size + 1);
>
>      if (size > 3 || (size == 3 && !is_q)) {
>          unallocated_encoding(s);
>          return;
>      }
> -

Ditto.


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
