Received: from eggs.gnu.org ([2001:4830:134:3::10]:53798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8bSF-0001M6-AY
	for qemu-devel@nongnu.org; Wed, 10 May 2017 19:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8bSB-0001Uj-Eo
	for qemu-devel@nongnu.org; Wed, 10 May 2017 19:55:39 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8bSB-0001US-AT
	for qemu-devel@nongnu.org; Wed, 10 May 2017 19:55:35 -0400
Received: by mail-qt0-x242.google.com with SMTP id a46so927514qte.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 16:55:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510182636.17791-1-aurelien@aurel32.net>
	<20170510182636.17791-10-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d6a6f0ff-ca07-e022-5b94-bfdf4682028a@amsat.org>
Date: Wed, 10 May 2017 20:55:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170510182636.17791-10-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/15] target/sh4: optimize
 gen_store_fpr64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/10/2017 03:26 PM, Aurelien Jarno wrote:
> Using extr and avoiding intermediate temps.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/translate.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index a4c7a0895b..fe8bff54a6 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -305,13 +305,7 @@ static inline void gen_load_fpr64(TCGv_i64 t, int reg)
>
>  static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
>  {
> -    TCGv_i32 tmp = tcg_temp_new_i32();
> -    tcg_gen_extrl_i64_i32(tmp, t);
> -    tcg_gen_mov_i32(cpu_fregs[reg + 1], tmp);
> -    tcg_gen_shri_i64(t, t, 32);
> -    tcg_gen_extrl_i64_i32(tmp, t);
> -    tcg_gen_mov_i32(cpu_fregs[reg], tmp);
> -    tcg_temp_free_i32(tmp);
> +    tcg_gen_extr_i64_i32(cpu_fregs[reg + 1], cpu_fregs[reg], t);
>  }
>
>  #define B3_0 (ctx->opcode & 0xf)
>
