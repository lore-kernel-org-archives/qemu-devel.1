Received: from eggsout.gnu.org ([209.51.188.92]:38492 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gfYl2-0007Ki-SY
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gfYl1-0007mi-Ux
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:20:04 -0500
MIME-Version: 1.0
References: <20190104142812.20444-1-edgar.iglesias@gmail.com>
	<20190104142812.20444-3-edgar.iglesias@gmail.com>
In-Reply-To: <20190104142812.20444-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jan 2019 15:19:35 -0800
Message-ID: <CAKmqyKN0ow18Wkst--cJ8+6d2h-1xTsU-WakTXL2AvDkeavdDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target/microblaze: Add props
 enabling exceptions on failed bus accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Luc Michel <luc.michel@greensocs.com>

On Fri, Jan 4, 2019 at 6:28 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add MicroBlaze CPU properties to enable exceptions on failed
> bus accesses.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.c | 12 +++++++++++-
>  target/microblaze/cpu.h |  2 ++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 49876b19b3..5596cd5485 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -202,7 +202,11 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : 0) |
>                          (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0) |
>                          (cpu->cfg.use_msr_instr ? PVR2_USE_MSR_INSTR : 0) |
> -                        (cpu->cfg.use_pcmp_instr ? PVR2_USE_PCMP_INSTR : 0);
> +                        (cpu->cfg.use_pcmp_instr ? PVR2_USE_PCMP_INSTR : 0) |
> +                        (cpu->cfg.dopb_bus_exception ?
> +                                                 PVR2_DOPB_BUS_EXC_MASK : 0) |
> +                        (cpu->cfg.iopb_bus_exception ?
> +                                                 PVR2_IOPB_BUS_EXC_MASK : 0);
>
>      env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
>                                          PVR5_DCACHE_WRITEBACK_MASK : 0;
> @@ -265,6 +269,12 @@ static Property mb_properties[] = {
>      DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_writeback,
>                       false),
>      DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
> +    /* Enables bus exceptions on failed data accesses (load/stores).  */
> +    DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
> +                     cfg.dopb_bus_exception, false),
> +    /* Enables bus exceptions on failed instruction fetches.  */
> +    DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
> +                     cfg.iopb_bus_exception, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
>      DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 03ca91007d..792bbc97c7 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -308,6 +308,8 @@ struct MicroBlazeCPU {
>          bool use_mmu;
>          bool dcache_writeback;
>          bool endi;
> +        bool dopb_bus_exception;
> +        bool iopb_bus_exception;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> --
> 2.17.1
>
>
