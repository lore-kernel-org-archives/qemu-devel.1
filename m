Received: from eggs.gnu.org ([2001:4830:134:3::10]:40989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNR0Q-0005I9-HK
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNR0P-00078f-LG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:48:14 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dNR0P-00076h-ES
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:48:13 -0400
Received: by mail-wr0-x244.google.com with SMTP id z45so21010557wrb.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 14:48:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497973886-26257-9-git-send-email-edgar.iglesias@gmail.com>
References: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
	<1497973886-26257-9-git-send-email-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Jun 2017 14:47:41 -0700
Message-ID: <CAKmqyKPrnv85fG7ysxWqvpXB+wB=dFjvgkTA1bb5JjFKArjTvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target-microblaze: Introduce a
 use-pcmp-instr property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistai@xilinx.com>

On Tue, Jun 20, 2017 at 8:51 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Introduce a use-pcmp-instr property making pcmp instructions
> optional.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  target/microblaze/cpu.c       | 5 +++--
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/translate.c | 6 +++---
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index bc96505..6e27c3c 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -157,7 +157,6 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          | PVR2_D_LMB_MASK \
>                          | PVR2_I_OPB_MASK \
>                          | PVR2_I_LMB_MASK \
> -                        | PVR2_USE_PCMP_INSTR \
>                          | PVR2_FPU_EXC_MASK \
>                          | 0;
>
> @@ -188,7 +187,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          (cpu->cfg.use_hw_mul > 1 ? PVR2_USE_MUL64_MASK : 0) |
>                          (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : 0) |
>                          (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0) |
> -                        (cpu->cfg.use_msr_instr ? PVR2_USE_MSR_INSTR : 0);
> +                        (cpu->cfg.use_msr_instr ? PVR2_USE_MSR_INSTR : 0) |
> +                        (cpu->cfg.use_pcmp_instr ? PVR2_USE_PCMP_INSTR : 0);
>
>      env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
>                                          PVR5_DCACHE_WRITEBACK_MASK : 0;
> @@ -242,6 +242,7 @@ static Property mb_properties[] = {
>      DEFINE_PROP_BOOL("use-barrel", MicroBlazeCPU, cfg.use_barrel, true),
>      DEFINE_PROP_BOOL("use-div", MicroBlazeCPU, cfg.use_div, true),
>      DEFINE_PROP_BOOL("use-msr-instr", MicroBlazeCPU, cfg.use_msr_instr, true),
> +    DEFINE_PROP_BOOL("use-pcmp-instr", MicroBlazeCPU, cfg.use_pcmp_instr, true),
>      DEFINE_PROP_BOOL("use-mmu", MicroBlazeCPU, cfg.use_mmu, true),
>      DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_writeback,
>                       false),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 5c960d0..5ce4c82 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -302,6 +302,7 @@ struct MicroBlazeCPU {
>          bool use_barrel;
>          bool use_div;
>          bool use_msr_instr;
> +        bool use_pcmp_instr;
>          bool use_mmu;
>          bool dcache_writeback;
>          bool endi;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index bb1bdfa..fbb8bb4 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -326,7 +326,7 @@ static void dec_pattern(DisasContext *dc)
>
>      if ((dc->tb_flags & MSR_EE_FLAG)
>            && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -          && !((dc->cpu->env.pvr.regs[2] & PVR2_USE_PCMP_INSTR))) {
> +          && !dc->cpu->cfg.use_pcmp_instr) {
>          tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
>          t_gen_raise_exception(dc, EXCP_HW_EXCP);
>      }
> @@ -762,11 +762,11 @@ static void dec_bit(DisasContext *dc)
>          case 0xe0:
>              if ((dc->tb_flags & MSR_EE_FLAG)
>                  && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -                && !((dc->cpu->env.pvr.regs[2] & PVR2_USE_PCMP_INSTR))) {
> +                && !dc->cpu->cfg.use_pcmp_instr) {
>                  tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
>                  t_gen_raise_exception(dc, EXCP_HW_EXCP);
>              }
> -            if (dc->cpu->env.pvr.regs[2] & PVR2_USE_PCMP_INSTR) {
> +            if (dc->cpu->cfg.use_pcmp_instr) {
>                  tcg_gen_clzi_i32(cpu_R[dc->rd], cpu_R[dc->ra], 32);
>              }
>              break;
> --
> 2.7.4
>
>
