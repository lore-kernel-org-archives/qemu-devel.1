Received: from eggs.gnu.org ([2001:4830:134:3::10]:52330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnGE-0000R5-KN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnGD-00051a-Qi
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:56:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170516230159.4195-1-aurelien@aurel32.net>
	<20170516230159.4195-2-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f476c3cd-3c61-4c9c-dc69-f9fa9ac502f8@amsat.org>
Date: Tue, 16 May 2017 21:56:06 -0300
MIME-Version: 1.0
In-Reply-To: <20170516230159.4195-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/4] target/arm: optimize
 aarch32 rev16
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

Hi Aurelien,

On 05/16/2017 08:01 PM, Aurelien Jarno wrote:
> Use the same mask to avoid having to load two different constants, as

> suggested by Richard Henderson.

What about
Suggested-by: Richard Henderson <rth@twiddle.net> ?

> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/translate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 0b5a0bca06..5becb2bb89 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -339,11 +339,13 @@ static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
>  static void gen_rev16(TCGv_i32 var)
>  {
>      TCGv_i32 tmp = tcg_temp_new_i32();
> +    TCGv_i32 mask = tcg_const_i32(0x00ff00ff);
>      tcg_gen_shri_i32(tmp, var, 8);
> -    tcg_gen_andi_i32(tmp, tmp, 0x00ff00ff);
> +    tcg_gen_and_i32(tmp, tmp, mask);
> +    tcg_gen_and_i32(var, var, mask);
>      tcg_gen_shli_i32(var, var, 8);
> -    tcg_gen_andi_i32(var, var, 0xff00ff00);
>      tcg_gen_or_i32(var, var, tmp);
> +    tcg_temp_free_i32(mask);
>      tcg_temp_free_i32(tmp);
>  }
>
>
