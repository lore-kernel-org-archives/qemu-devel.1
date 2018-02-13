Received: from eggs.gnu.org ([2001:4830:134:3::10]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRvk-0002px-N8
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRvj-0000YG-PL
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:10:56 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:40621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRvj-0000Y4-Jk
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:10:55 -0500
Received: by mail-qt0-x244.google.com with SMTP id c19so2229338qtm.7
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:10:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180211203934.15546-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f74b295-ae35-e5e3-5d60-64302305c67d@amsat.org>
Date: Tue, 13 Feb 2018 01:10:52 -0300
MIME-Version: 1.0
In-Reply-To: <20180211203934.15546-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Improve tcg_gen_muli_i32/i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 02/11/2018 05:39 PM, Richard Henderson wrote:
> Convert multiplication by power of two to left shift.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/tcg-op.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 3467787323..34b96d68f3 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -277,9 +277,15 @@ void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
>  
>  void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
> -    TCGv_i32 t0 = tcg_const_i32(arg2);
> -    tcg_gen_mul_i32(ret, arg1, t0);
> -    tcg_temp_free_i32(t0);
> +    if (arg2 == 0) {
> +        tcg_gen_movi_i32(ret, 0);
> +    } else if (is_power_of_2(arg2)) {
> +        tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
> +    } else {
> +        TCGv_i32 t0 = tcg_const_i32(arg2);
> +        tcg_gen_mul_i32(ret, arg1, t0);
> +        tcg_temp_free_i32(t0);
> +    }
>  }
>  
>  void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
> @@ -1430,9 +1436,15 @@ void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
>  
>  void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
> -    TCGv_i64 t0 = tcg_const_i64(arg2);
> -    tcg_gen_mul_i64(ret, arg1, t0);
> -    tcg_temp_free_i64(t0);
> +    if (arg2 == 0) {
> +        tcg_gen_movi_i64(ret, 0);
> +    } else if (is_power_of_2(arg2)) {
> +        tcg_gen_shli_i64(ret, arg1, ctz64(arg2));
> +    } else {
> +        TCGv_i64 t0 = tcg_const_i64(arg2);
> +        tcg_gen_mul_i64(ret, arg1, t0);
> +        tcg_temp_free_i64(t0);
> +    }
>  }
>  
>  void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
> 
