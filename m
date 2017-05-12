Received: from eggs.gnu.org ([2001:4830:134:3::10]:33565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d905g-0007ia-RC
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d905b-0007dO-SN
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:14:00 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d905b-0007d6-N6
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:13:55 -0400
Received: by mail-qk0-x244.google.com with SMTP id y128so6140361qka.3
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 19:13:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <466563b8-288c-8047-55ed-a7ae2c735c09@amsat.org>
Date: Thu, 11 May 2017 23:13:51 -0300
MIME-Version: 1.0
In-Reply-To: <20170510200535.13268-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/8] target/mips: optimize bshfl() using
 extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@imgtec.com>

Hi,

As noticed by Richard in another patch, this one is also WRONG:

$ docker run -it -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle --sp-file 
scripts/coccinelle/tcg_gen_extract.cocci --macro-file 
scripts/cocci-macro-file.h target/mips/translate.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
init_defs: scripts/cocci-macro-file.h
HANDLING: target/mips/translate.c
candidate at target/mips/translate.c:4576
   op_size: tl/tl (same)
   low_bits: 8 (value: 0xff)
   len: 0xff00ff
   len_bits != low_bits
   candidate is NOT optimizable

candidate at target/mips/translate.c:4596
   op_size: tl/tl (same)
   low_bits: 8 (value: 0xff)
   len: 0xff00ff00ff00ff
   len_bits != low_bits
   candidate is NOT optimizable

candidate at target/mips/translate.c:4608
   op_size: tl/tl (same)
   low_bits: 16 (value: 0xffff)
   len: 0xffff0000ffff
   len_bits != low_bits
   candidate is NOT optimizable

On 05/10/2017 05:05 PM, Philippe Mathieu-Daudé wrote:
> Applied using Coccinelle script.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/mips/translate.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 3022f349cb..96177da9ae 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -4573,8 +4573,7 @@ static void gen_bshfl (DisasContext *ctx, uint32_t op2, int rt, int rd)
>          {
>              TCGv t1 = tcg_temp_new();
>
> -            tcg_gen_shri_tl(t1, t0, 8);
> -            tcg_gen_andi_tl(t1, t1, 0x00FF00FF);
> +            tcg_gen_extract_tl(t1, t0, 8, 0x00FF00FF);
>              tcg_gen_shli_tl(t0, t0, 8);
>              tcg_gen_andi_tl(t0, t0, ~0x00FF00FF);
>              tcg_gen_or_tl(t0, t0, t1);
> @@ -4593,8 +4592,7 @@ static void gen_bshfl (DisasContext *ctx, uint32_t op2, int rt, int rd)
>          {
>              TCGv t1 = tcg_temp_new();
>
> -            tcg_gen_shri_tl(t1, t0, 8);
> -            tcg_gen_andi_tl(t1, t1, 0x00FF00FF00FF00FFULL);
> +            tcg_gen_extract_tl(t1, t0, 8, 0x00FF00FF00FF00FFULL);
>              tcg_gen_shli_tl(t0, t0, 8);
>              tcg_gen_andi_tl(t0, t0, ~0x00FF00FF00FF00FFULL);
>              tcg_gen_or_tl(cpu_gpr[rd], t0, t1);
> @@ -4605,8 +4603,7 @@ static void gen_bshfl (DisasContext *ctx, uint32_t op2, int rt, int rd)
>          {
>              TCGv t1 = tcg_temp_new();
>
> -            tcg_gen_shri_tl(t1, t0, 16);
> -            tcg_gen_andi_tl(t1, t1, 0x0000FFFF0000FFFFULL);
> +            tcg_gen_extract_tl(t1, t0, 16, 0x0000FFFF0000FFFFULL);
>              tcg_gen_shli_tl(t0, t0, 16);
>              tcg_gen_andi_tl(t0, t0, ~0x0000FFFF0000FFFFULL);
>              tcg_gen_or_tl(t0, t0, t1);
>
