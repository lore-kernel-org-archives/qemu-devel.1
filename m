Received: from eggs.gnu.org ([2001:4830:134:3::10]:45410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72Qm-0005FV-64
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72Qj-0006JI-03
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:19:40 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72Qi-0006JD-Rm
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:19:36 -0400
Received: by mail-qt0-x242.google.com with SMTP id r58so4575638qtb.2
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 09:19:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-11-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <42b1b33c-c8e5-70d6-650c-3f512c4b5439@amsat.org>
Date: Sat, 6 May 2017 13:19:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-11-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/14] target/sh4: optimize gen_write_sr
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

Lovely!

What about a Coccinelle meta-script to catch similar (ab)uses?

Phil.

On 05/06/2017 08:14 AM, Aurelien Jarno wrote:
> This doesn't change the generated code on x86, but optimizes it on most
> RISC architectures and makes the code simpler to read.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/translate.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index b4e5606098..8c766eed2a 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -204,12 +204,9 @@ static void gen_write_sr(TCGv src)
>  {
>      tcg_gen_andi_i32(cpu_sr, src,
>                       ~((1u << SR_Q) | (1u << SR_M) | (1u << SR_T)));
> -    tcg_gen_shri_i32(cpu_sr_q, src, SR_Q);
> -    tcg_gen_andi_i32(cpu_sr_q, cpu_sr_q, 1);
> -    tcg_gen_shri_i32(cpu_sr_m, src, SR_M);
> -    tcg_gen_andi_i32(cpu_sr_m, cpu_sr_m, 1);
> -    tcg_gen_shri_i32(cpu_sr_t, src, SR_T);
> -    tcg_gen_andi_i32(cpu_sr_t, cpu_sr_t, 1);
> +    tcg_gen_extract_i32(cpu_sr_q, src, SR_Q, 1);
> +    tcg_gen_extract_i32(cpu_sr_m, src, SR_M, 1);
> +    tcg_gen_extract_i32(cpu_sr_t, src, SR_T, 1);
>  }
>
>  static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
>
