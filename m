Received: from eggs.gnu.org ([2001:4830:134:3::10]:34758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQYy-0005oz-9E
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQYx-0002bQ-2T
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:19:52 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dNQYw-0002b6-Ry
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:19:50 -0400
Received: by mail-wr0-x242.google.com with SMTP id z45so20802035wrb.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 14:19:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497973886-26257-5-git-send-email-edgar.iglesias@gmail.com>
References: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
	<1497973886-26257-5-git-send-email-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Jun 2017 14:19:19 -0700
Message-ID: <CAKmqyKNt==oyx9ohFV5OyTMstSi0g=6OHk31BZyWKRocBQ2VGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 4/8] target-microblaze: Introduce a
 use-barrel property
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
> Introduce a use-barrel property making barrel shifter instructions
> optional.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  target/microblaze/cpu.c       | 9 +++++----
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/translate.c | 2 +-
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 982cb61..bae47b5 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -150,8 +150,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>
>      qemu_init_vcpu(cs);
>
> -    env->pvr.regs[0] = PVR0_USE_BARREL_MASK \
> -                       | PVR0_USE_DIV_MASK \
> +    env->pvr.regs[0] = PVR0_USE_DIV_MASK \
>                         | PVR0_USE_HW_MUL_MASK \
>                         | PVR0_USE_EXC_MASK \
>                         | PVR0_USE_ICACHE_MASK \
> @@ -162,7 +161,6 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          | PVR2_I_LMB_MASK \
>                          | PVR2_USE_MSR_INSTR \
>                          | PVR2_USE_PCMP_INSTR \
> -                        | PVR2_USE_BARREL_MASK \
>                          | PVR2_USE_DIV_MASK \
>                          | PVR2_USE_HW_MUL_MASK \
>                          | PVR2_USE_MUL64_MASK \
> @@ -182,13 +180,15 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>
>      env->pvr.regs[0] |= (cpu->cfg.stackprot ? PVR0_SPROT_MASK : 0) |
>                          (cpu->cfg.use_fpu ? PVR0_USE_FPU_MASK : 0) |
> +                        (cpu->cfg.use_barrel ? PVR0_USE_BARREL_MASK : 0) |
>                          (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
>                          (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
>                          (version_code << PVR0_VERSION_SHIFT) |
>                          (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0);
>
>      env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
> -                        (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0);
> +                        (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
> +                        (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : 0);
>
>      env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
>                                          PVR5_DCACHE_WRITEBACK_MASK : 0;
> @@ -235,6 +235,7 @@ static Property mb_properties[] = {
>       *                  are enabled
>       */
>      DEFINE_PROP_UINT8("use-fpu", MicroBlazeCPU, cfg.use_fpu, 2),
> +    DEFINE_PROP_BOOL("use-barrel", MicroBlazeCPU, cfg.use_barrel, true),
>      DEFINE_PROP_BOOL("use-mmu", MicroBlazeCPU, cfg.use_mmu, true),
>      DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_writeback,
>                       false),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 68c33e8..2a4a65a 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -298,6 +298,7 @@ struct MicroBlazeCPU {
>          bool stackprot;
>          uint32_t base_vectors;
>          uint8_t use_fpu;
> +        bool use_barrel;
>          bool use_mmu;
>          bool dcache_writeback;
>          bool endi;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 0bb6095..26b221c 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -665,7 +665,7 @@ static void dec_barrel(DisasContext *dc)
>
>      if ((dc->tb_flags & MSR_EE_FLAG)
>            && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -          && !(dc->cpu->env.pvr.regs[0] & PVR0_USE_BARREL_MASK)) {
> +          && !dc->cpu->cfg.use_barrel) {
>          tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
>          t_gen_raise_exception(dc, EXCP_HW_EXCP);
>          return;
> --
> 2.7.4
>
>
