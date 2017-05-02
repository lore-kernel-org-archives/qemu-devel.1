Received: from eggs.gnu.org ([2001:4830:134:3::10]:49705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5XOL-0000gt-Qu
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5XOH-0003oM-P7
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:58:57 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5XOH-0003oA-Ky
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:58:53 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so21145429qka.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 05:58:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170501221046.9369-1-aurelien@aurel32.net>
	<20170501221046.9369-12-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e45124ea-0283-3e91-fa88-9bcdf73c1612@amsat.org>
Date: Tue, 2 May 2017 09:58:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170501221046.9369-12-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/14] target/sh4: generate fences for SH4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/01/2017 07:10 PM, Aurelien Jarno wrote:
> synco is a SH4-A only instruction.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/translate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 7de459c9a5..c226be9718 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1570,10 +1570,11 @@ static void _decode_opc(DisasContext * ctx)
>  	else
>  	    break;
>      case 0x00ab:		/* synco */
> -	if (ctx->features & SH_FEATURE_SH4A)
> -	    return;
> -	else
> -	    break;
> +        if (ctx->features & SH_FEATURE_SH4A) {
> +            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +            return;
> +        }
> +        break;
>      case 0x4024:		/* rotcl Rn */
>  	{
>  	    TCGv tmp = tcg_temp_new();
>
