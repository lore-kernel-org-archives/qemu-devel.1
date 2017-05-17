Received: from eggs.gnu.org ([2001:4830:134:3::10]:52501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnGd-0000kC-BU
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnGc-0005FK-Ft
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:56:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170516230159.4195-1-aurelien@aurel32.net>
	<20170516230159.4195-3-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <acf24fae-f9a4-fd99-dfe9-b60cbd735e5e@amsat.org>
Date: Tue, 16 May 2017 21:56:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170516230159.4195-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/4] target/arm: simplify and
 optimize aarch64 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 05/16/2017 08:01 PM, Aurelien Jarno wrote:
> Instead of byteswapping individual 16-bit words one by one, work on the
> whole register at the same time using shifts and mask. This is the same
> strategy than the aarch32 version of rev16 and is much more efficient
> in the case sf=1.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/translate-a64.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 24de30d92c..ed15d21655 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -4035,24 +4035,12 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
>      TCGv_i64 tcg_tmp = tcg_temp_new_i64();
>      TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
>
> -    tcg_gen_andi_i64(tcg_tmp, tcg_rn, 0xffff);
> -    tcg_gen_bswap16_i64(tcg_rd, tcg_tmp);
> -
> -    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 16);
> -    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
> -    tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
> -    tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 16, 16);
> -
> -    if (sf) {
> -        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 32);
> -        tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
> -        tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
> -        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 32, 16);
> -
> -        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 48);
> -        tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
> -        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 48, 16);
> -    }
> +    TCGv mask = tcg_const_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
> +    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
> +    tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
> +    tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
> +    tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
> +    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
>
>      tcg_temp_free_i64(tcg_tmp);
>  }
>
