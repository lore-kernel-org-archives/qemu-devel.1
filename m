Received: from eggs.gnu.org ([2001:4830:134:3::10]:33591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTejN-0004Sb-D0
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTejK-0007Kw-9l
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:44:53 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:39084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTejK-0007KG-5E
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:44:50 -0400
Received: by mail-qt0-x241.google.com with SMTP id p23-v6so7841033qtn.6
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 19:44:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180614202502.668-1-edgar.iglesias@gmail.com>
	<20180614202502.668-3-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1664a413-337b-9d5b-7261-81dc844fe0f1@amsat.org>
Date: Thu, 14 Jun 2018 23:44:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180614202502.668-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target-microblaze: Rework NOP/zero
 instruction handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, frederic.konrad@adacore.com

On 06/14/2018 05:25 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Remove the abort on a sequence of NOP/zero instructions.
> Always return early and avoid decoding NOP/zero instructions.
> 
> This fixes Coverity CID 1391443.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/microblaze/translate.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 6c64946398..78ca265b04 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -90,7 +90,6 @@ typedef struct DisasContext {
>      uint32_t jmp_pc;
>  
>      int abort_at_next_insn;
> -    int nr_nops;
>      struct TranslationBlock *tb;
>      int singlestep_enabled;
>  } DisasContext;
> @@ -1576,17 +1575,12 @@ static inline void decode(DisasContext *dc, uint32_t ir)
>      dc->ir = ir;
>      LOG_DIS("%8.8x\t", dc->ir);
>  
> -    if (dc->ir)
> -        dc->nr_nops = 0;
> -    else {
> +    if (ir == 0) {
>          trap_illegal(dc, dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK);
> -
> -        LOG_DIS("nr_nops=%d\t", dc->nr_nops);
> -        dc->nr_nops++;
> -        if (dc->nr_nops > 4) {
> -            cpu_abort(CPU(dc->cpu), "fetching nop sequence\n");
> -        }
> +        /* Don't decode nop/zero instructions any further.  */
> +        return;
>      }
> +
>      /* bit 2 seems to indicate insn type.  */
>      dc->type_b = ir & (1 << 29);
>  
> @@ -1633,7 +1627,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
>      dc->singlestep_enabled = cs->singlestep_enabled;
>      dc->cpustate_changed = 0;
>      dc->abort_at_next_insn = 0;
> -    dc->nr_nops = 0;
>  
>      if (pc_start & 3) {
>          cpu_abort(cs, "Microblaze: unaligned PC=%x\n", pc_start);
> 
