Received: from eggs.gnu.org ([2001:4830:134:3::10]:35054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlKSX-00018g-Jp
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 15:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlKST-0001VG-Qc
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 15:40:01 -0400
Date: Fri, 25 Aug 2017 16:39:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170825193922.GN27715@localhost.localdomain>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823221445.15243-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] pci: Add INTERFACE_LEGACY_PCI_DEVICE
 to legacy PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Jiri Slaby <jslaby@suse.cz>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Hannes Reinecke <hare@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

CCing maintainers of affected devices (sorry for not CCing you
before).

On Wed, Aug 23, 2017 at 07:14:44PM -0300, Eduardo Habkost wrote:
> Add INTERFACE_LEGACY_PCI_DEVICE to all direct subtypes of
> TYPE_PCI_DEVICE, except:
> 
> 1) The ones that already have INTERFACE_PCIE_DEVICE set:
> 
> * base-xhci
> * e1000e
> * nvme
> * pvscsi
> * vfio-pci
> * virtio-pci
> * vmxnet3
> 
> 2) base-pci-bridge
> 
> Not all PCI bridges are legacy PCI devices, so
> INTERFACE_LEGACY_PCI_DEVICE is added only to the subtypes that
> are actually legacy PCI devices:
> 
> * dec-21154-p2p-bridge
> * i82801b11-bridge
> * pbm-bridge
> * pci-bridge
> 
> The direct subtypes of base-pci-bridge not touched by this patch
> are:
> 
> * xilinx-pcie-root: Already marked as PCIe-only device.
> * pcie-port: all non-abstract subtypes of pcie-port are already
>   marked as PCIe-only devices.
> 
> 3) megasas-base
> 
> Not all megasas devices are legacy PCI devices, so the interface
> names are added to the subclasses registered by
> megasas_register_types(), according to information in the
> megasas_devices[] array.
> 
> "megasas-gen2" already implements INTERFACE_PCIE_DEVICE, so add
> INTERFACE_LEGACY_PCI_DEVICE only to "megasas".
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/acpi/piix4.c                     |  1 +
>  hw/audio/ac97.c                     |  4 ++++
>  hw/audio/es1370.c                   |  4 ++++
>  hw/audio/intel-hda.c                |  4 ++++
>  hw/char/serial-pci.c                | 12 ++++++++++++
>  hw/display/cirrus_vga.c             |  4 ++++
>  hw/display/qxl.c                    |  4 ++++
>  hw/display/sm501.c                  |  4 ++++
>  hw/display/vga-pci.c                |  4 ++++
>  hw/display/vmware_vga.c             |  4 ++++
>  hw/i2c/smbus_ich9.c                 |  4 ++++
>  hw/i386/amd_iommu.c                 |  4 ++++
>  hw/i386/kvm/pci-assign.c            |  4 ++++
>  hw/i386/pc_piix.c                   |  4 ++++
>  hw/i386/xen/xen_platform.c          |  4 ++++
>  hw/i386/xen/xen_pvdevice.c          |  4 ++++
>  hw/ide/ich.c                        |  4 ++++
>  hw/ide/pci.c                        |  4 ++++
>  hw/ipack/tpci200.c                  |  4 ++++
>  hw/isa/i82378.c                     |  4 ++++
>  hw/isa/lpc_ich9.c                   |  1 +
>  hw/isa/piix4.c                      |  4 ++++
>  hw/isa/vt82c686.c                   | 16 ++++++++++++++++
>  hw/mips/gt64xxx_pci.c               |  4 ++++
>  hw/misc/edu.c                       |  5 +++++
>  hw/misc/ivshmem.c                   |  4 ++++
>  hw/misc/macio/macio.c               |  4 ++++
>  hw/misc/pci-testdev.c               |  4 ++++
>  hw/net/e1000.c                      |  4 ++++
>  hw/net/eepro100.c                   |  4 ++++
>  hw/net/ne2000.c                     |  4 ++++
>  hw/net/pcnet-pci.c                  |  4 ++++
>  hw/net/rocker/rocker.c              |  4 ++++
>  hw/net/rtl8139.c                    |  4 ++++
>  hw/pci-bridge/dec.c                 |  8 ++++++++
>  hw/pci-bridge/i82801b11.c           |  4 ++++
>  hw/pci-bridge/pci_bridge_dev.c      |  1 +
>  hw/pci-bridge/pci_expander_bridge.c |  8 ++++++++
>  hw/pci-host/apb.c                   |  8 ++++++++
>  hw/pci-host/bonito.c                |  4 ++++
>  hw/pci-host/gpex.c                  |  4 ++++
>  hw/pci-host/grackle.c               |  4 ++++
>  hw/pci-host/piix.c                  |  8 ++++++++
>  hw/pci-host/ppce500.c               |  4 ++++
>  hw/pci-host/prep.c                  |  4 ++++
>  hw/pci-host/q35.c                   |  4 ++++
>  hw/pci-host/uninorth.c              | 16 ++++++++++++++++
>  hw/pci-host/versatile.c             |  4 ++++
>  hw/ppc/ppc4xx_pci.c                 |  4 ++++
>  hw/scsi/esp-pci.c                   |  4 ++++
>  hw/scsi/lsi53c895a.c                |  4 ++++
>  hw/scsi/megasas.c                   |  4 ++++
>  hw/scsi/mptsas.c                    |  4 ++++
>  hw/sd/sdhci.c                       |  4 ++++
>  hw/sh4/sh_pci.c                     |  4 ++++
>  hw/sparc64/sun4u.c                  |  4 ++++
>  hw/usb/hcd-ehci-pci.c               |  4 ++++
>  hw/usb/hcd-ohci.c                   |  4 ++++
>  hw/usb/hcd-uhci.c                   |  4 ++++
>  hw/vfio/pci-quirks.c                |  4 ++++
>  hw/watchdog/wdt_i6300esb.c          |  4 ++++
>  hw/xen/xen_pt.c                     |  4 ++++
>  62 files changed, 288 insertions(+)
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index f276967..defe98a 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -723,6 +723,7 @@ static const TypeInfo piix4_pm_info = {
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_HOTPLUG_HANDLER },
>          { TYPE_ACPI_DEVICE_IF },
> +        { INTERFACE_LEGACY_PCI_DEVICE },
>          { }
>      }
>  };
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index 959c786..6027e15 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -1431,6 +1431,10 @@ static const TypeInfo ac97_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof (AC97LinkState),
>      .class_init    = ac97_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void ac97_register_types (void)
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index dd7c23d..ed14ec3 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -1082,6 +1082,10 @@ static const TypeInfo es1370_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof (ES1370State),
>      .class_init    = es1370_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void es1370_register_types (void)
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 06acc98..e2b9bf5 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -1299,6 +1299,10 @@ static const TypeInfo intel_hda_info = {
>      .instance_size = sizeof(IntelHDAState),
>      .class_init    = intel_hda_class_init,
>      .abstract      = true,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static const TypeInfo intel_hda_info_ich6 = {
> diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
> index 303104d..c2dbcc0 100644
> --- a/hw/char/serial-pci.c
> +++ b/hw/char/serial-pci.c
> @@ -250,6 +250,10 @@ static const TypeInfo serial_pci_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCISerialState),
>      .class_init    = serial_pci_class_initfn,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static const TypeInfo multi_2x_serial_pci_info = {
> @@ -257,6 +261,10 @@ static const TypeInfo multi_2x_serial_pci_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIMultiSerialState),
>      .class_init    = multi_2x_serial_pci_class_initfn,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static const TypeInfo multi_4x_serial_pci_info = {
> @@ -264,6 +272,10 @@ static const TypeInfo multi_4x_serial_pci_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIMultiSerialState),
>      .class_init    = multi_4x_serial_pci_class_initfn,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void serial_pci_register_types(void)
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index afc290a..9a39fa0 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -3162,6 +3162,10 @@ static const TypeInfo cirrus_vga_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCICirrusVGAState),
>      .class_init    = cirrus_vga_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void cirrus_vga_register_types(void)
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index ae3677f..1a010e8 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2430,6 +2430,10 @@ static const TypeInfo qxl_pci_type_info = {
>      .instance_size = sizeof(PCIQXLDevice),
>      .abstract = true,
>      .class_init = qxl_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void qxl_primary_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 9aa515b..7538f0c 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1843,6 +1843,10 @@ static const TypeInfo sm501_pci_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(SM501PCIState),
>      .class_init    = sm501_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void sm501_register_types(void)
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index ac9a764..72477e4 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -338,6 +338,10 @@ static const TypeInfo vga_pci_type_info = {
>      .instance_size = sizeof(PCIVGAState),
>      .abstract = true,
>      .class_init = vga_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void vga_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> index 4a64b41..9c2aa2d 100644
> --- a/hw/display/vmware_vga.c
> +++ b/hw/display/vmware_vga.c
> @@ -1350,6 +1350,10 @@ static const TypeInfo vmsvga_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(struct pci_vmsvga_state_s),
>      .class_init    = vmsvga_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void vmsvga_register_types(void)
> diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
> index ea51e09..83b0512 100644
> --- a/hw/i2c/smbus_ich9.c
> +++ b/hw/i2c/smbus_ich9.c
> @@ -119,6 +119,10 @@ static const TypeInfo ich9_smb_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(ICH9SMBState),
>      .class_init = ich9_smb_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void ich9_smb_register(void)
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 334938a..471c7a9 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1227,6 +1227,10 @@ static const TypeInfo amdviPCI = {
>      .name = "AMDVI-PCI",
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(AMDVIPCIState),
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void amdvi_iommu_memory_region_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
> index 33e20cb..57800d3 100644
> --- a/hw/i386/kvm/pci-assign.c
> +++ b/hw/i386/kvm/pci-assign.c
> @@ -1864,6 +1864,10 @@ static const TypeInfo assign_info = {
>      .instance_size      = sizeof(AssignedDevice),
>      .class_init         = assign_class_init,
>      .instance_init      = assigned_dev_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void assign_register_types(void)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 46dfd2c..eafc207 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -1049,6 +1049,10 @@ static TypeInfo isa_bridge_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init = isa_bridge_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pt_graphics_register_types(void)
> diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> index 9ba7474..2113bd0 100644
> --- a/hw/i386/xen/xen_platform.c
> +++ b/hw/i386/xen/xen_platform.c
> @@ -517,6 +517,10 @@ static const TypeInfo xen_platform_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIXenPlatformState),
>      .class_init    = xen_platform_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void xen_platform_register_types(void)
> diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
> index c093b34..e2ae81b 100644
> --- a/hw/i386/xen/xen_pvdevice.c
> +++ b/hw/i386/xen/xen_pvdevice.c
> @@ -127,6 +127,10 @@ static const TypeInfo xen_pv_type_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(XenPVDevice),
>      .class_init    = xen_pv_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void xen_pv_register_types(void)
> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
> index 9472a60..0c60aa3 100644
> --- a/hw/ide/ich.c
> +++ b/hw/ide/ich.c
> @@ -184,6 +184,10 @@ static const TypeInfo ich_ahci_info = {
>      .instance_size = sizeof(AHCIPCIState),
>      .instance_init = pci_ich9_ahci_init,
>      .class_init    = ich_ahci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void ich_ahci_register_types(void)
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index 3cfb510..f437298 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -458,6 +458,10 @@ static const TypeInfo pci_ide_type_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIIDEState),
>      .abstract = true,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pci_ide_register_types(void)
> diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
> index 4dfa6b3..e380378 100644
> --- a/hw/ipack/tpci200.c
> +++ b/hw/ipack/tpci200.c
> @@ -646,6 +646,10 @@ static const TypeInfo tpci200_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(TPCI200State),
>      .class_init    = tpci200_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void tpci200_register_types(void)
> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> index 4d29a99..13702b8 100644
> --- a/hw/isa/i82378.c
> +++ b/hw/isa/i82378.c
> @@ -138,6 +138,10 @@ static const TypeInfo i82378_type_info = {
>      .instance_size = sizeof(I82378State),
>      .instance_init = i82378_init,
>      .class_init = i82378_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void i82378_register_types(void)
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index ac8416d..dcde152 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -823,6 +823,7 @@ static const TypeInfo ich9_lpc_info = {
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_HOTPLUG_HANDLER },
>          { TYPE_ACPI_DEVICE_IF },
> +        { INTERFACE_LEGACY_PCI_DEVICE },
>          { }
>      }
>  };
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index f811eba..515e55d 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -132,6 +132,10 @@ static const TypeInfo piix4_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PIIX4State),
>      .class_init    = piix4_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void piix4_register_types(void)
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 50dc83d..319dc7f 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -301,6 +301,10 @@ static const TypeInfo via_ac97_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(VT686AC97State),
>      .class_init    = via_ac97_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void vt82c686b_mc97_realize(PCIDevice *dev, Error **errp)
> @@ -341,6 +345,10 @@ static const TypeInfo via_mc97_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(VT686MC97State),
>      .class_init    = via_mc97_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  /* vt82c686 pm init */
> @@ -419,6 +427,10 @@ static const TypeInfo via_pm_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(VT686PMState),
>      .class_init    = via_pm_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static const VMStateDescription vmstate_via = {
> @@ -502,6 +514,10 @@ static const TypeInfo via_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(VT82C686BState),
>      .class_init    = via_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void vt82c686b_register_types(void)
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index e8b2eef..96d8cd0 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -1232,6 +1232,10 @@ static const TypeInfo gt64120_pci_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init    = gt64120_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void gt64120_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 01acacf..64b12b3 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -408,12 +408,17 @@ static void edu_class_init(ObjectClass *class, void *data)
>  
>  static void pci_edu_register_types(void)
>  {
> +    static InterfaceInfo interfaces[] = {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    };
>      static const TypeInfo edu_info = {
>          .name          = "edu",
>          .parent        = TYPE_PCI_DEVICE,
>          .instance_size = sizeof(EduState),
>          .instance_init = edu_instance_init,
>          .class_init    = edu_class_init,
> +        .interfaces = interfaces,
>      };
>  
>      type_register_static(&edu_info);
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 47a015f..da63c90 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -1010,6 +1010,10 @@ static const TypeInfo ivshmem_common_info = {
>      .instance_size = sizeof(IVShmemState),
>      .abstract      = true,
>      .class_init    = ivshmem_common_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static const VMStateDescription ivshmem_plain_vmsd = {
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 5d57f45..fa163e3 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -415,6 +415,10 @@ static const TypeInfo macio_type_info = {
>      .instance_init = macio_instance_init,
>      .abstract      = true,
>      .class_init    = macio_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void macio_register_types(void)
> diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
> index 7d59902..992157f 100644
> --- a/hw/misc/pci-testdev.c
> +++ b/hw/misc/pci-testdev.c
> @@ -326,6 +326,10 @@ static const TypeInfo pci_testdev_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCITestDevState),
>      .class_init    = pci_testdev_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pci_testdev_register_types(void)
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index f2e5072..51ab83d 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -1685,6 +1685,10 @@ static const TypeInfo e1000_base_info = {
>      .instance_init = e1000_instance_init,
>      .class_size    = sizeof(E1000BaseClass),
>      .abstract      = true,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static const E1000Info e1000_devices[] = {
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 5a4774a..8f5c567 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -2117,6 +2117,10 @@ static void eepro100_register_types(void)
>          type_info.class_init = eepro100_class_init;
>          type_info.instance_size = sizeof(EEPRO100State);
>          type_info.instance_init = eepro100_instance_init;
> +        type_info.interfaces = (InterfaceInfo[]) {
> +            { INTERFACE_LEGACY_PCI_DEVICE },
> +            { },
> +        };
>  
>          type_register(&type_info);
>      }
> diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
> index 798d681..fce3420 100644
> --- a/hw/net/ne2000.c
> +++ b/hw/net/ne2000.c
> @@ -786,6 +786,10 @@ static const TypeInfo ne2000_info = {
>      .instance_size = sizeof(PCINE2000State),
>      .class_init    = ne2000_class_init,
>      .instance_init = ne2000_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void ne2000_register_types(void)
> diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
> index 0acf8a4..cbe6e99 100644
> --- a/hw/net/pcnet-pci.c
> +++ b/hw/net/pcnet-pci.c
> @@ -365,6 +365,10 @@ static const TypeInfo pcnet_info = {
>      .instance_size = sizeof(PCIPCNetState),
>      .class_init    = pcnet_class_init,
>      .instance_init = pcnet_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pci_pcnet_register_types(void)
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 4f0f6d7..2eb53ad 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1573,6 +1573,10 @@ static const TypeInfo rocker_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(Rocker),
>      .class_init    = rocker_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void rocker_register_types(void)
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 671c7e4..3371318 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -3489,6 +3489,10 @@ static const TypeInfo rtl8139_info = {
>      .instance_size = sizeof(RTL8139State),
>      .class_init    = rtl8139_class_init,
>      .instance_init = rtl8139_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void rtl8139_register_types(void)
> diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
> index eb275e1..77a07d0 100644
> --- a/hw/pci-bridge/dec.c
> +++ b/hw/pci-bridge/dec.c
> @@ -79,6 +79,10 @@ static const TypeInfo dec_21154_pci_bridge_info = {
>      .parent        = TYPE_PCI_BRIDGE,
>      .instance_size = sizeof(PCIBridge),
>      .class_init    = dec_21154_pci_bridge_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  PCIBus *pci_dec_21154_init(PCIBus *parent_bus, int devfn)
> @@ -138,6 +142,10 @@ static const TypeInfo dec_21154_pci_host_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init    = dec_21154_pci_host_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pci_dec_21154_device_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
> index 2c1b747..baac63b 100644
> --- a/hw/pci-bridge/i82801b11.c
> +++ b/hw/pci-bridge/i82801b11.c
> @@ -106,6 +106,10 @@ static const TypeInfo i82801b11_bridge_info = {
>      .parent        = TYPE_PCI_BRIDGE,
>      .instance_size = sizeof(I82801b11Bridge),
>      .class_init    = i82801b11_bridge_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void d2pbr_register(void)
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> index 4373f1d..d83824b 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -238,6 +238,7 @@ static const TypeInfo pci_bridge_dev_info = {
>      .instance_finalize = pci_bridge_dev_instance_finalize,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_HOTPLUG_HANDLER },
> +        { INTERFACE_LEGACY_PCI_DEVICE },
>          { }
>      }
>  };
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index ff59abf..cc9ec88 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -316,6 +316,10 @@ static const TypeInfo pxb_dev_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PXBDev),
>      .class_init    = pxb_dev_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pxb_pcie_dev_realize(PCIDevice *dev, Error **errp)
> @@ -350,6 +354,10 @@ static const TypeInfo pxb_pcie_dev_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PXBDev),
>      .class_init    = pxb_pcie_dev_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pxb_register_types(void)
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 96e5d0b..c2c8c6d 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -817,6 +817,10 @@ static const TypeInfo pbm_pci_host_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init    = pbm_pci_host_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pbm_host_class_init(ObjectClass *klass, void *data)
> @@ -857,6 +861,10 @@ static const TypeInfo pbm_pci_bridge_info = {
>      .name          = "pbm-bridge",
>      .parent        = TYPE_PCI_BRIDGE,
>      .class_init    = pbm_pci_bridge_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pbm_iommu_memory_region_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 89133a9..f037378 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -833,6 +833,10 @@ static const TypeInfo bonito_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIBonitoState),
>      .class_init    = bonito_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void bonito_pcihost_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index 83084b9..c348e84 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -144,6 +144,10 @@ static const TypeInfo gpex_root_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(GPEXRootState),
>      .class_init = gpex_root_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void gpex_register(void)
> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> index 2e281f6..01d3edc 100644
> --- a/hw/pci-host/grackle.c
> +++ b/hw/pci-host/grackle.c
> @@ -142,6 +142,10 @@ static const TypeInfo grackle_pci_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init = grackle_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pci_grackle_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 072a04e..d35520e 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -694,6 +694,10 @@ static const TypeInfo piix3_pci_type_info = {
>      .instance_size = sizeof(PIIX3State),
>      .abstract = true,
>      .class_init = pci_piix3_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void piix3_class_init(ObjectClass *klass, void *data)
> @@ -748,6 +752,10 @@ static const TypeInfo i440fx_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCII440FXState),
>      .class_init    = i440fx_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  /* IGD Passthrough Host Bridge. */
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index becc0ee..6dd66c4 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -516,6 +516,10 @@ static const TypeInfo e500_host_bridge_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PPCE500PCIBridgeState),
>      .class_init    = e500_host_bridge_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static Property pcihost_properties[] = {
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 8b293ba..bb19b6d 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -372,6 +372,10 @@ static const TypeInfo raven_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(RavenPCIState),
>      .class_init = raven_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static Property raven_pcihost_properties[] = {
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 0e472f2..a6f93f1 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -591,6 +591,10 @@ static const TypeInfo mch_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(MCHPCIState),
>      .class_init = mch_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void q35_register(void)
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 6cf5e59..3b40a9a 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -374,6 +374,10 @@ static const TypeInfo unin_main_pci_host_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init = unin_main_pci_host_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void u3_agp_pci_host_class_init(ObjectClass *klass, void *data)
> @@ -398,6 +402,10 @@ static const TypeInfo u3_agp_pci_host_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init = u3_agp_pci_host_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void unin_agp_pci_host_class_init(ObjectClass *klass, void *data)
> @@ -422,6 +430,10 @@ static const TypeInfo unin_agp_pci_host_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init = unin_agp_pci_host_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void unin_internal_pci_host_class_init(ObjectClass *klass, void *data)
> @@ -446,6 +458,10 @@ static const TypeInfo unin_internal_pci_host_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init = unin_internal_pci_host_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void pci_unin_main_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
> index aa1fdf7..e1ba6f4 100644
> --- a/hw/pci-host/versatile.c
> +++ b/hw/pci-host/versatile.c
> @@ -487,6 +487,10 @@ static const TypeInfo versatile_pci_host_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init    = versatile_pci_host_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static Property pci_vpb_properties[] = {
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index 6953f8b..92027c3 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -359,6 +359,10 @@ static const TypeInfo ppc4xx_host_bridge_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init    = ppc4xx_host_bridge_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void ppc4xx_pcihost_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
> index e295d88..2f0c659 100644
> --- a/hw/scsi/esp-pci.c
> +++ b/hw/scsi/esp-pci.c
> @@ -398,6 +398,10 @@ static const TypeInfo esp_pci_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIESPState),
>      .class_init = esp_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  typedef struct {
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 3e56ab2..788bfc3 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -2244,6 +2244,10 @@ static const TypeInfo lsi_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(LSIState),
>      .class_init    = lsi_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void lsi53c810_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 3641c30..cf69b56 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2468,6 +2468,10 @@ static struct MegasasInfo megasas_devices[] = {
>          .is_express = false,
>          .vmsd = &vmstate_megasas_gen1,
>          .props = megasas_properties_gen1,
> +        .interfaces = (InterfaceInfo[]) {
> +            { INTERFACE_LEGACY_PCI_DEVICE },
> +            { },
> +        },
>      },{
>          .name = TYPE_MEGASAS_GEN2,
>          .desc = "LSI MegaRAID SAS 2108",
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 765ab53..6ff773e 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -1441,6 +1441,10 @@ static const TypeInfo mptsas_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(MPTSASState),
>      .class_init = mptsas1068_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void mptsas_register_types(void)
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 6d6a791..f6b18d6 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1315,6 +1315,10 @@ static const TypeInfo sdhci_pci_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(SDHCIState),
>      .class_init = sdhci_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static Property sdhci_sysbus_properties[] = {
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index 38395c0..6cec225 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -179,6 +179,10 @@ static const TypeInfo sh_pci_host_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
>      .class_init    = sh_pci_host_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void sh_pci_device_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index bbdb40c..b2b3bab 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -277,6 +277,10 @@ static const TypeInfo ebus_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(EbusState),
>      .class_init    = ebus_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  #define TYPE_OPENPROM "openprom"
> diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
> index 6dedcb8..464178d 100644
> --- a/hw/usb/hcd-ehci-pci.c
> +++ b/hw/usb/hcd-ehci-pci.c
> @@ -170,6 +170,10 @@ static const TypeInfo ehci_pci_type_info = {
>      .instance_finalize = usb_ehci_pci_finalize,
>      .abstract = true,
>      .class_init = ehci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void ehci_data_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 267982e..8b5e579 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -2139,6 +2139,10 @@ static const TypeInfo ohci_pci_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(OHCIPCIState),
>      .class_init    = ohci_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static Property ohci_sysbus_properties[] = {
> diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
> index e3562a4..8842ea6 100644
> --- a/hw/usb/hcd-uhci.c
> +++ b/hw/usb/hcd-uhci.c
> @@ -1323,6 +1323,10 @@ static const TypeInfo uhci_pci_type_info = {
>      .class_size    = sizeof(UHCIPCIDeviceClass),
>      .abstract = true,
>      .class_init = uhci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void uhci_data_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 349085e..83a820a 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1197,6 +1197,10 @@ static TypeInfo vfio_pci_igd_lpc_bridge_info = {
>      .name = "vfio-pci-igd-lpc-bridge",
>      .parent = TYPE_PCI_DEVICE,
>      .class_init = vfio_pci_igd_lpc_bridge_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void vfio_pci_igd_register_types(void)
> diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
> index 49b3cd1..f8b7e0c 100644
> --- a/hw/watchdog/wdt_i6300esb.c
> +++ b/hw/watchdog/wdt_i6300esb.c
> @@ -463,6 +463,10 @@ static const TypeInfo i6300esb_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(I6300State),
>      .class_init    = i6300esb_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void i6300esb_register_types(void)
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 375efa6..66664fc 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -964,6 +964,10 @@ static const TypeInfo xen_pci_passthrough_info = {
>      .instance_size = sizeof(XenPCIPassthroughState),
>      .instance_finalize = xen_pci_passthrough_finalize,
>      .class_init = xen_pci_passthrough_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_LEGACY_PCI_DEVICE },
> +        { },
> +    },
>  };
>  
>  static void xen_pci_passthrough_register_types(void)
> -- 
> 2.9.4
> 
> 

-- 
Eduardo
