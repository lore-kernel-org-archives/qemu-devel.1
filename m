Received: from eggs.gnu.org ([2001:4830:134:3::10]:40487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQy3-00047r-Gp
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQy2-0006F9-HU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:45:47 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dNQy2-0006F2-6D
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:45:46 -0400
Received: by mail-wr0-x242.google.com with SMTP id z45so20993756wrb.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 14:45:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497973886-26257-8-git-send-email-edgar.iglesias@gmail.com>
References: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
	<1497973886-26257-8-git-send-email-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Jun 2017 14:45:14 -0700
Message-ID: <CAKmqyKNmh=Md9=O8b0uWOhHxMLh5aBtUk=BE=n8FZVam62cvdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 7/8] target-microblaze: Introduce a
 use-msr-instr property
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
> Introduce a use-msr-instr property making msr instructions
> optional.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  target/microblaze/cpu.c       | 5 +++--
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/translate.c | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 70e4743..bc96505 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -157,7 +157,6 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          | PVR2_D_LMB_MASK \
>                          | PVR2_I_OPB_MASK \
>                          | PVR2_I_LMB_MASK \
> -                        | PVR2_USE_MSR_INSTR \
>                          | PVR2_USE_PCMP_INSTR \
>                          | PVR2_FPU_EXC_MASK \
>                          | 0;
> @@ -188,7 +187,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          (cpu->cfg.use_hw_mul ? PVR2_USE_HW_MUL_MASK : 0) |
>                          (cpu->cfg.use_hw_mul > 1 ? PVR2_USE_MUL64_MASK : 0) |
>                          (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : 0) |
> -                        (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0);
> +                        (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0) |
> +                        (cpu->cfg.use_msr_instr ? PVR2_USE_MSR_INSTR : 0);
>
>      env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
>                                          PVR5_DCACHE_WRITEBACK_MASK : 0;
> @@ -241,6 +241,7 @@ static Property mb_properties[] = {
>      DEFINE_PROP_UINT8("use-hw-mul", MicroBlazeCPU, cfg.use_hw_mul, 2),
>      DEFINE_PROP_BOOL("use-barrel", MicroBlazeCPU, cfg.use_barrel, true),
>      DEFINE_PROP_BOOL("use-div", MicroBlazeCPU, cfg.use_div, true),
> +    DEFINE_PROP_BOOL("use-msr-instr", MicroBlazeCPU, cfg.use_msr_instr, true),
>      DEFINE_PROP_BOOL("use-mmu", MicroBlazeCPU, cfg.use_mmu, true),
>      DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_writeback,
>                       false),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index e202229..5c960d0 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -301,6 +301,7 @@ struct MicroBlazeCPU {
>          uint8_t use_hw_mul;
>          bool use_barrel;
>          bool use_div;
> +        bool use_msr_instr;
>          bool use_mmu;
>          bool dcache_writeback;
>          bool endi;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 36caa03..bb1bdfa 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -443,7 +443,7 @@ static void dec_msr(DisasContext *dc)
>          LOG_DIS("msr%s r%d imm=%x\n", clr ? "clr" : "set",
>                  dc->rd, dc->imm);
>
> -        if (!(dc->cpu->env.pvr.regs[2] & PVR2_USE_MSR_INSTR)) {
> +        if (!dc->cpu->cfg.use_msr_instr) {
>              /* nop??? */
>              return;
>          }
> --
> 2.7.4
>
>
