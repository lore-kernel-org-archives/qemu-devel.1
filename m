Received: from eggs.gnu.org ([2001:4830:134:3::10]:55305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KXa-0001Xo-1b
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KXY-0001ex-5Z
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:04:10 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KXX-0001dx-Vi
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:04:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id l39so8748180qtb.1
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 17:04:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170512233843.27713-1-f4bug@amsat.org>
	<20170512233843.27713-3-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6bfb21ed-7def-25cf-4c6f-fc4e01962835@twiddle.net>
Date: Fri, 12 May 2017 17:04:03 -0700
MIME-Version: 1.0
In-Reply-To: <20170512233843.27713-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/6] target/alpha: optimize cvtlq()
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

On 05/12/2017 04:38 PM, Philippe Mathieu-Daudé wrote:
> Patch created mechanically using Coccinelle script via:
> 
>      $ spatch --macro-file scripts/cocci-macro-file.h --in-place \
>          --sp-file scripts/coccinelle/tcg_gen_extract.cocci --dir target
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   target/alpha/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index df5d695344..531af4f5b8 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -747,9 +747,8 @@ static void gen_cvtlq(TCGv vc, TCGv vb)
>       /* The arithmetic right shift here, plus the sign-extended mask below
>          yields a sign-extended result without an explicit ext32s_i64.  */
>       tcg_gen_sari_i64(tmp, vb, 32);
> -    tcg_gen_shri_i64(vc, vb, 29);
> +    tcg_gen_extract_i64(vc, vb, 29, 30);
>       tcg_gen_andi_i64(tmp, tmp, (int32_t)0xc0000000);
> -    tcg_gen_andi_i64(vc, vc, 0x3fffffff);
>       tcg_gen_or_i64(vc, vc, tmp);

While this is accurate, looking at the broader context I think it would be 
better to use a deposit operation for this case.

   tcg_gen_shri_i64(tmp, vb, 29);
   tcg_gen_sari_i64(vc, vb, 32);
   tcg_gen_deposit_i64(vc, vc, tmp, 0, 30);


r~
