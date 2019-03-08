Received: from eggs.gnu.org ([209.51.188.92]:48891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2P7n-0003W1-6u
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 18:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2P7k-0002xN-Kb
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 18:41:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2P7k-0002wW-BE
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 18:41:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id x10so13649946wmg.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 15:41:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2c32c0aa-cac8-365a-6b92-24c819bcb4e4@amsat.org>
Date: Sat, 9 Mar 2019 00:41:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190307144126.31847-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/9] tcg/aarch64: Support
 INDEX_op_extract2_{i32, i64}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: david@redhat.com

On 3/7/19 3:41 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.h     |  4 ++--
>  tcg/aarch64/tcg-target.inc.c | 11 +++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 6600a54a02..ce2bb1f90b 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -77,7 +77,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_deposit_i32      1
>  #define TCG_TARGET_HAS_extract_i32      1
>  #define TCG_TARGET_HAS_sextract_i32     1
> -#define TCG_TARGET_HAS_extract2_i32     0
> +#define TCG_TARGET_HAS_extract2_i32     1
>  #define TCG_TARGET_HAS_movcond_i32      1
>  #define TCG_TARGET_HAS_add2_i32         1
>  #define TCG_TARGET_HAS_sub2_i32         1
> @@ -114,7 +114,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_deposit_i64      1
>  #define TCG_TARGET_HAS_extract_i64      1
>  #define TCG_TARGET_HAS_sextract_i64     1
> -#define TCG_TARGET_HAS_extract2_i64     0
> +#define TCG_TARGET_HAS_extract2_i64     1
>  #define TCG_TARGET_HAS_movcond_i64      1
>  #define TCG_TARGET_HAS_add2_i64         1
>  #define TCG_TARGET_HAS_sub2_i64         1
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index d57f9e500f..8b93598bce 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -2058,6 +2058,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>          tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
>          break;
>  
> +    case INDEX_op_extract2_i64:
> +    case INDEX_op_extract2_i32:
> +        tcg_out_extr(s, ext, a0, a1, a2, args[3]);

EXTR a0, a1, a2, #args[3] ; OK

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        break;
> +
>      case INDEX_op_add2_i32:
>          tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, REG0(2), REG0(3),
>                          (int32_t)args[4], args[5], const_args[4],
> @@ -2300,6 +2305,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>          = { .args_ct_str = { "r", "r", "rAL" } };
>      static const TCGTargetOpDef dep
>          = { .args_ct_str = { "r", "0", "rZ" } };
> +    static const TCGTargetOpDef ext2
> +        = { .args_ct_str = { "r", "rZ", "rZ" } };
>      static const TCGTargetOpDef movc
>          = { .args_ct_str = { "r", "r", "rA", "rZ", "rZ" } };
>      static const TCGTargetOpDef add2
> @@ -2430,6 +2437,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>      case INDEX_op_deposit_i64:
>          return &dep;
>  
> +    case INDEX_op_extract2_i32:
> +    case INDEX_op_extract2_i64:
> +        return &ext2;
> +
>      case INDEX_op_add2_i32:
>      case INDEX_op_add2_i64:
>      case INDEX_op_sub2_i32:
> 
