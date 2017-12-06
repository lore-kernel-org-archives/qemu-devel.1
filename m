Received: from eggs.gnu.org ([2001:4830:134:3::10]:33915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eMaUS-0006ps-M5
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eMaUO-0001V9-7J
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:16:00 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:33830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eMaUN-0001UV-Vr
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:15:56 -0500
Received: by mail-pl0-x244.google.com with SMTP id d21so952515pll.1
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 06:15:55 -0800 (PST)
References: <20171206093050.25308-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <349486cb-53fa-84e1-a09d-04bcb5a2f36c@linaro.org>
Date: Wed, 6 Dec 2017 06:15:51 -0800
MIME-Version: 1.0
In-Reply-To: <20171206093050.25308-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] target/sh4/translate.c: fix TCG leak
 during gusa sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, 1735384@bugs.launchpad.net, qemu-stable <qemu-stable@nongnu.org>

On 12/06/2017 01:30 AM, Alex Bennée wrote:
> This fixes bug #1735384 while running java under qemu-sh4. When debug
> was enabled it showed a problem with TCG temps. Once fixed I was able
> to run java -version normally.
> 
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Cc: stable, as the bug is present in 2.10 too.

r~

>  target/sh4/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 703020fe87..b4b5c822d0 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -2189,7 +2189,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
>      }
>  
>      /* If op_src is not a valid register, then op_arg was a constant.  */
> -    if (op_src < 0) {
> +    if (op_src < 0 && !TCGV_IS_UNUSED(op_arg)) {
>          tcg_temp_free_i32(op_arg);
>      }
>  
> 
