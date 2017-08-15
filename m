Received: from eggs.gnu.org ([2001:4830:134:3::10]:52755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dheCz-00063e-U2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dheCw-00086q-QU
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:56:45 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dheCw-00085T-MD
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:56:42 -0400
Received: by mail-qt0-x241.google.com with SMTP id d10so1097520qtb.4
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:56:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170815145714.17635-1-richard.henderson@linaro.org>
	<20170815145714.17635-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c30ad9c1-bd1c-0fdf-085e-2449d9034dd6@amsat.org>
Date: Tue, 15 Aug 2017 12:56:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170815145714.17635-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 3/3] target/arm: Require
 alignment for load exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair.francis@xilinx.com

Hi Richard,

On 08/15/2017 11:57 AM, Richard Henderson wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
> 
> Acording to the ARM ARM exclusive loads require the same allignment as
> exclusive stores. Let's update the memops used for the load to match
> that of the store. This adds the alignment requirement to the memops.
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> [rth: Require 16-byte alignment for 64-bit LDXP.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/translate-a64.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index eac545e4f2..2200e25be0 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1861,7 +1861,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
>           g_assert(size >= 2);
>           if (size == 2) {
>               /* The pair must be single-copy atomic for the doubleword.  */
> -            memop |= MO_64;
> +            memop |= MO_64 | MO_ALIGN;

isn't MO_ALIGN_8 enough?

>               tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
>               if (s->be_data == MO_LE) {
>                   tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, 32);
> @@ -1871,10 +1871,11 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
>                   tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 0, 32);
>               }
>           } else {
> -            /* The pair must be single-copy atomic for *each* doubleword,
> -               but not the entire quadword.  */
> +            /* The pair must be single-copy atomic for *each* doubleword, not
> +               the entire quadword, however it must be quadword aligned.  */
>               memop |= MO_64;
> -            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
> +            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx,
> +                                memop | MO_ALIGN_16);

ok

>   
>               TCGv_i64 addr2 = tcg_temp_new_i64();
>               tcg_gen_addi_i64(addr2, addr, 8);
> @@ -1885,7 +1886,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
>               tcg_gen_mov_i64(cpu_reg(s, rt2), cpu_exclusive_high);
>           }
>       } else {
> -        memop |= size;
> +        memop |= size | MO_ALIGN;

MO_ALIGN_8 here too?

>           tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
>           tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
>       }
> 

Regards,

Phil.
