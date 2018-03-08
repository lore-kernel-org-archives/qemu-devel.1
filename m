Received: from eggs.gnu.org ([2001:4830:134:3::10]:32961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etswU-0004EW-CR
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etswP-0004h8-Fa
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:38:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1etswP-0004h2-9y
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:38:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D82338424D
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 10:38:17 +0000 (UTC)
References: <20180306194600.9650-1-pbonzini@redhat.com>
	<20180306194600.9650-4-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <599bfe48-6848-d5a4-5df6-64e0aa627aee@redhat.com>
Date: Thu, 8 Mar 2018 11:38:11 +0100
MIME-Version: 1.0
In-Reply-To: <20180306194600.9650-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] q35: change default NIC to e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

On 06.03.2018 20:46, Paolo Bonzini wrote:
> The e1000 NIC is getting old and is not a very good default for a
> PCIe machine type.  Change it to e1000e, which should be supported
> by a good number of guests.
> 
> In particular, drivers for 82574 were added first to Linux 2.6.27 (2008)
> and Windows 2008 R2.  This does mean that Windows 2008 will not work
> anymore with Q35 machine types and a default "-net nic -net xxx" network
> configuration; it did work before because it does have an AHCI driver.
> However, Windows 2008 has been declared out of main stream support
> in 2015.  It will get out of extended support in 2020.  Windows 2008
> R2 has the same end of support dates and, since the two are basically
> Vista vs. Windows 7, R2 probably is more popular.
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/pc.c         | 7 ++++---
>  hw/i386/pc_piix.c    | 6 +++++-
>  hw/i386/pc_q35.c     | 8 +++++++-
>  hw/pci/pci.c         | 2 +-
>  include/hw/i386/pc.h | 3 ++-
>  5 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 35fcb6efdf..d3e1d50b59 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1619,18 +1619,19 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
>      }
>  }
>  
> -void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus)
> +void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
>  {
>      int i;
>  
>      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_NIC);
>      for (i = 0; i < nb_nics; i++) {
>          NICInfo *nd = &nd_table[i];
> +        const char *model = nd->model ? nd->model : pcmc->default_nic_model;
>  
> -        if (!pci_bus || (nd->model && strcmp(nd->model, "ne2k_isa") == 0)) {
> +        if (!strcmp(model, "ne2k_isa")) {

<bikeshedpainting>
I'd prefer g_str_equal() these days ...
</bikeshedpainting>

>              pc_init_ne2k_isa(isa_bus, nd);
>          } else {
> -            pci_nic_init_nofail(nd, pci_bus, "e1000", NULL);
> +            pci_nic_init_nofail(nd, pci_bus, model, NULL);
>          }
>      }
>      rom_reset_order_override();
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 8658bcba63..0f1966d547 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -240,7 +240,7 @@ static void pc_init1(MachineState *machine,
>      pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
>                           (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit, 0x4);
>  
> -    pc_nic_init(isa_bus, pci_bus);
> +    pc_nic_init(pcmc, isa_bus, pci_bus);
>  
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>      if (pcmc->pci_enabled) {
> @@ -417,6 +417,9 @@ static void pc_xen_hvm_init(MachineState *machine)
>  
>  static void pc_i440fx_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +    pcmc->default_nic_model = "e1000";
> +
>      m->family = "pc_piix";
>      m->desc = "Standard PC (i440FX + PIIX, 1996)";
>      m->default_machine_opts = "firmware=bios-256k.bin";
> @@ -1114,6 +1117,7 @@ static void isapc_machine_options(MachineClass *m)
>      pcmc->gigabyte_align = false;
>      pcmc->smbios_legacy_mode = true;
>      pcmc->has_reserved_memory = false;
> +    pcmc->default_nic_model = "ne2k_isa";
>      m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>  }
>  
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 0c0bc48137..9ae916327e 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -272,7 +272,7 @@ static void pc_q35_init(MachineState *machine)
>  
>      /* the rest devices to which pci devfn is automatically assigned */
>      pc_vga_init(isa_bus, host_bus);
> -    pc_nic_init(isa_bus, host_bus);
> +    pc_nic_init(pcmc, isa_bus, host_bus);
>  
>      if (pcms->acpi_nvdimm_state.is_enabled) {
>          nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
> @@ -294,6 +294,9 @@ static void pc_q35_init(MachineState *machine)
>  
>  static void pc_q35_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +    pcmc->default_nic_model = "e1000e";
> +
>      m->family = "pc_q35";
>      m->desc = "Standard PC (Q35 + ICH9, 2009)";
>      m->units_per_default_bus = 1;
> @@ -316,7 +319,10 @@ DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
>  
>  static void pc_q35_2_11_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>      pc_q35_2_12_machine_options(m);
> +    pcmc->default_nic_model = "e1000";
>      m->alias = NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
>  }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index aa24a26680..3b0df51983 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1829,7 +1829,7 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>      int devfn;
>      int i;
>  
> -    if (!strcmp(nd->model, "virtio")) {
> +    if (nd->model && !strcmp(nd->model, "virtio")) {

Please squash that into the previous patch instead.

>          g_free(nd->model);
>          nd->model = g_strdup("virtio-net-pci");
>      }
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index bb49165fe0..e81654eb7f 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -114,6 +114,7 @@ struct PCMachineClass {
>      /* Device configuration: */
>      bool pci_enabled;
>      bool kvmclock_enabled;
> +    const char *default_nic_model;
>  
>      /* Compat options: */
>  
> @@ -248,7 +249,7 @@ void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd);
>  void pc_cmos_init(PCMachineState *pcms,
>                    BusState *ide0, BusState *ide1,
>                    ISADevice *s);
> -void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus);
> +void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
>  void pc_pci_device_init(PCIBus *pci_bus);
>  
>  typedef void (*cpu_set_smm_t)(int smm, void *arg);
> 

Apart from the nits, this looks fine to me.

 Thomas
