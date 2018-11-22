Received: from eggs.gnu.org ([2001:4830:134:3::10]:37365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPkbI-0000LA-Qh
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 03:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPkbE-0001ID-Ry
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 03:44:40 -0500
References: <20181121233123.6408-1-palmer@sifive.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fcc9d781-43a4-1881-47da-1ca26ba7e9b2@redhat.com>
Date: Thu, 22 Nov 2018 09:44:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181121233123.6408-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2] RISC-V: Deprecate hifive_e and
 hifive_u machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org

 Hi,

On 2018-11-22 00:31, Palmer Dabbelt wrote:
> These machines had names that were too general: there are many E
> and U machines, and it's easy for users to get confused about which one
> is which.  The one configuration that can faithfully match an existing
> ASIC-based board has been renamed to 'sifive-hifive1', we'll work
> through the emulation fidelity issues apparent in the other targets
> before adding machines for those.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  hw/riscv/sifive_e.c  | 26 ++++++++++++++++++++++++--
>  hw/riscv/sifive_u.c  |  2 ++
>  qemu-deprecated.texi |  7 +++++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index cb513cc3bb50..439d20e0efe7 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -95,7 +95,7 @@ static void sifive_mmio_emulate(MemoryRegion *parent, const char *name,
>      memory_region_add_subregion(parent, offset, mock_mmio);
>  }
>  
> -static void riscv_sifive_e_init(MachineState *machine)
> +static void riscv_sifive_hifive1_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = sifive_e_memmap;
>  
> @@ -135,6 +135,17 @@ static void riscv_sifive_e_init(MachineState *machine)
>      }
>  }
>  
> +static void riscv_sifive_e_init(MachineState *machine)
> +{
> +#if defined(TARGET_RISCV32)
> +    warn_report("The sifive_e machine is deprecated in favor of sifive-hifive1");
> +#else
> +    warn_report("The sifive_e machine is deprecated.");
> +#endif
> +
> +    return riscv_sifive_hifive1_init(machine);
> +}
> +
>  static void riscv_sifive_e_soc_init(Object *obj)
>  {
>      SiFiveESoCState *s = RISCV_E_SOC(obj);
> @@ -213,13 +224,24 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>  
>  static void riscv_sifive_e_machine_init(MachineClass *mc)
>  {
> -    mc->desc = "RISC-V Board compatible with SiFive E SDK";
> +    mc->desc = "(deprecated) RISC-V Board compatible with SiFive E SDK";
>      mc->init = riscv_sifive_e_init;
>      mc->max_cpus = 1;
>  }
>  
>  DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
>  
> +#if defined(TARGET_RISCV32)
> +static void riscv_sifive_hifive1_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "SiFive's HiFive1 Development Board";
> +    mc->init = riscv_sifive_hifive1_init;
> +    mc->max_cpus = 1;
> +}
> +
> +DEFINE_MACHINE("sifive-hifive1", riscv_sifive_hifive1_machine_init)
> +#endif
> +
>  static void riscv_sifive_e_soc_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ef07df244241..0ce6a9dd2609 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -238,6 +238,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>  
>  static void riscv_sifive_u_init(MachineState *machine)
>  {
> +    warn_report("The sifive_u machine is deprecated.");

FWIW, you can also simply set MachineClass->deprecation_reason nowadays
instead of manually issuing a warn_report() and tweaking the description
... that would be a little bit easier and is in sync with the other
deprecated boards (see e.g. commit 08fe68244 or 54c86f5a4844d51 for
other examples).

 Thomas
