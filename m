Received: from eggs.gnu.org ([2001:4830:134:3::10]:38050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbod5-0007CA-DA
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbod0-0000Bt-Fg
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:19:19 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbod0-0000Bo-BP
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:19:14 -0500
Received: by mail-qt0-x242.google.com with SMTP id h53so438179qth.3
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:19:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
	<1486046099-17726-11-git-send-email-batuzovk@ispras.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8fbd2d96-b855-4db8-ad90-443b4bc56faa@amsat.org>
Date: Thu, 9 Feb 2017 10:19:09 -0300
MIME-Version: 1.0
In-Reply-To: <1486046099-17726-11-git-send-email-batuzovk@ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2.1 10/21] target/arm: use vector opcode
 to handle vadd.<size> instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>



On 02/02/2017 11:34 AM, Kirill Batuzov wrote:
> Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
> ---
>  target/arm/translate.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index d7578e2..90e14df 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -5628,6 +5628,37 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>              return 1;
>          }
>
> +        /* Use vector ops to handle what we can */
> +        switch (op) {
> +        case NEON_3R_VADD_VSUB:
> +            if (!u) {
> +                void (* const gen_add_v128[])(TCGv_v128, TCGv_v128,
> +                                             TCGv_v128) = {
> +                    tcg_gen_add_i8x16,
> +                    tcg_gen_add_i16x8,
> +                    tcg_gen_add_i32x4,
> +                    tcg_gen_add_i64x2
> +                };

I'd rather prefer to have gen_add_v128 'static const'.

> +                void (* const gen_add_v64[])(TCGv_v64, TCGv_v64,
> +                                             TCGv_v64) = {
> +                    tcg_gen_add_i8x8,
> +                    tcg_gen_add_i16x4,
> +                    tcg_gen_add_i32x2,
> +                    tcg_gen_add_i64x1
> +                };

same with gen_add_v64.

> +                if (q) {
> +                    gen_add_v128[size](cpu_Q[rd >> 1], cpu_Q[rn >> 1],
> +                                       cpu_Q[rm >> 1]);
> +                } else {
> +                    gen_add_v64[size](cpu_D[rd], cpu_D[rn], cpu_D[rm]);
> +                }
> +                return 0;
> +            }
> +            break;
> +        default:
> +            break;
> +        }
> +
>          for (pass = 0; pass < (q ? 4 : 2); pass++) {
>
>          if (pairwise) {
>
