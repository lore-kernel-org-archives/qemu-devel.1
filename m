Received: from eggs.gnu.org ([209.51.188.92]:58292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gx6NI-0001SL-U9
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gx6NH-0000eV-On
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:40:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gx6NH-0000RP-AA
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:40:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so1397891wrw.8
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 00:39:52 -0800 (PST)
References: <20190222060504.17715-1-richard.henderson@linaro.org>
	<20190222060504.17715-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <08e9391e-b45a-bfe4-2908-b656acfc2b3a@redhat.com>
Date: Fri, 22 Feb 2019 09:39:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190222060504.17715-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/hppa: Do not return freed
 temporary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 2/22/19 7:05 AM, Richard Henderson wrote:
> For priv levels 1 & 2, we were doing so from do_ibranch_priv.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index b4fd307b77..dad8ce563c 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2007,16 +2007,15 @@ static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
>          /* Privilege 0 is maximum and is allowed to decrease.  */
>          return offset;
>      case 3:
> -        /* Privilege 3 is minimum and is never allowed increase.  */
> +        /* Privilege 3 is minimum and is never allowed to increase.  */
>          dest = get_temp(ctx);
>          tcg_gen_ori_reg(dest, offset, 3);
>          break;
>      default:
> -        dest = tcg_temp_new();
> +        dest = get_temp(ctx);
>          tcg_gen_andi_reg(dest, offset, -4);
>          tcg_gen_ori_reg(dest, dest, ctx->privilege);
>          tcg_gen_movcond_reg(TCG_COND_GTU, dest, dest, offset, dest, offset);
> -        tcg_temp_free(dest);
>          break;
>      }
>      return dest;

Oops!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
