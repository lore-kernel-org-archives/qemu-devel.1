Received: from eggs.gnu.org ([2001:4830:134:3::10]:44414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fambk-0006ws-LU
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fambh-0004ux-ES
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:34:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Jul 2018 20:34:14 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <20180704112859.20146-1-kraxel@redhat.com>
References: <20180704112859.20146-1-kraxel@redhat.com>
Message-ID: <28331953a968ce65bf2d44aa2195a072@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] vga: make stdvga the global default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

Am 2018-07-04 13:28, schrieb Gerd Hoffmann:
> This reverts the stdvga vs. cirrus selection logic.  Current state is
> that "cirrus" is the default and MachineClass->default_display is set 
> to
> "std" by some machine types to override that.
> 
> The patch makes "std" the default.  Setting default_display to "std" is
> dropped.  Machine types which likely depend on cirrus (alpha, mips, old
> pc versions) will explicitly set default_display to "cirrus".
> 
> With this patch applied all ppc machine types will use "std" as default
> display, no matter whenever cirrus-vga is compiled in or not.
> 
> Fixes: 29f9cef39e ppc: Include vga cirrus card into the compiling 
> process
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/alpha/dp264.c     | 1 +
>  hw/i386/pc_piix.c    | 3 +--
>  hw/i386/pc_q35.c     | 1 -
>  hw/mips/mips_malta.c | 1 +
>  hw/mips/mips_r4k.c   | 1 +
>  hw/ppc/spapr.c       | 1 -
>  vl.c                 | 4 ++--
>  7 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 80b987f7fb..668e6d099f 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -182,6 +182,7 @@ static void clipper_machine_init(MachineClass *mc)
>      mc->max_cpus = 4;
>      mc->is_default = 1;
>      mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
> +    mc->default_display = "cirrus";
>  }
> 
>  DEFINE_MACHINE("clipper", clipper_machine_init)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index dc09466b3e..30ad22e2e3 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -424,7 +424,6 @@ static void pc_i440fx_machine_options(MachineClass 
> *m)
>      m->family = "pc_piix";
>      m->desc = "Standard PC (i440FX + PIIX, 1996)";
>      m->default_machine_opts = "firmware=bios-256k.bin";
> -    m->default_display = "std";
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>  }
> 
> @@ -566,7 +565,7 @@ static void 
> pc_i440fx_2_1_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_2_2_machine_options(m);
>      m->hw_version = "2.1.0";
> -    m->default_display = NULL;
> +    m->default_display = "cirrus";
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_1);
>      pcmc->smbios_uuid_encoded = false;
>      pcmc->enforce_aligned_dimm = false;
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 532241e3f8..8f2c8c8b8b 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -303,7 +303,6 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->desc = "Standard PC (Q35 + ICH9, 2009)";
>      m->units_per_default_bus = 1;
>      m->default_machine_opts = "firmware=bios-256k.bin";
> -    m->default_display = "std";
>      m->no_floppy = 1;
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, 
> TYPE_INTEL_IOMMU_DEVICE);
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 3467451482..998971c53a 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1242,6 +1242,7 @@ static void mips_malta_machine_init(MachineClass 
> *mc)
>      mc->block_default_type = IF_IDE;
>      mc->max_cpus = 16;
>      mc->is_default = 1;
> +    mc->default_display = "cirrus";
>  #ifdef TARGET_MIPS64
>      mc->default_cpu_type = MIPS_CPU_TYPE_NAME("20Kc");
>  #else
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index d5725d0555..c4c7ee8aa5 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -295,6 +295,7 @@ static void mips_machine_init(MachineClass *mc)
>      mc->desc = "mips r4k platform";
>      mc->init = mips_r4k_init;
>      mc->block_default_type = IF_IDE;
> +    mc->default_display = "cirrus";
>  #ifdef TARGET_MIPS64
>      mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
>  #else
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3f5e1d3ec2..0ab90f3aa8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3962,7 +3962,6 @@ static void spapr_machine_class_init(ObjectClass
> *oc, void *data)
>      mc->no_parallel = 1;
>      mc->default_boot_order = "";
>      mc->default_ram_size = 512 * MiB;
> -    mc->default_display = "std";
>      mc->kvm_type = spapr_kvm_type;
>      machine_class_allow_dynamic_sysbus_dev(mc, 
> TYPE_SPAPR_PCI_HOST_BRIDGE);
>      mc->pci_allow_0_address = true;
> diff --git a/vl.c b/vl.c
> index 16b913f9d5..e60bf2d6cd 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4475,10 +4475,10 @@ int main(int argc, char **argv, char **envp)
>      if (default_vga) {
>          if (machine_class->default_display) {
>              vga_model = machine_class->default_display;
> -        } else if (vga_interface_available(VGA_CIRRUS)) {
> -            vga_model = "cirrus";
>          } else if (vga_interface_available(VGA_STD)) {
>              vga_model = "std";
> +        } else if (vga_interface_available(VGA_CIRRUS)) {
> +            vga_model = "cirrus";
>          }
>      }
>      if (vga_model) {

If that counts:

Reviewed-by: Sebastian Bauer <mail@sebastianbauer.info>

If applied, perhaps setting the default to "std" except for few machines 
is worth to be mentioned in an upcoming ChangeLog, in case there are 
other machines that may require cirrus graphics.

Bye
Sebastian
