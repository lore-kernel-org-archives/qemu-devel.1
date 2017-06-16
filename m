Received: from eggs.gnu.org ([2001:4830:134:3::10]:56194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLtui-0006BG-An
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLtud-0003Ku-VW
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:16:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLtud-0003KX-JC
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:15:55 -0400
References: <1497625153-19812-1-git-send-email-thuth@redhat.com>
	<b2343916-49d4-5c18-8b2f-f3538839b46e@redhat.com>
	<76504ef2-8dd0-ecbc-6e25-55be6abcb14a@redhat.com>
	<2d873cf2-11cd-1a2c-30e9-07d506685d37@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0a3dbc29-35cb-454b-d9c0-07304270c367@redhat.com>
Date: Fri, 16 Jun 2017 18:15:50 +0200
MIME-Version: 1.0
In-Reply-To: <2d873cf2-11cd-1a2c-30e9-07d506685d37@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Poison some more target-specific
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 16.06.2017 17:55, Paolo Bonzini wrote:
>=20
>=20
> On 16/06/2017 17:21, Thomas Huth wrote:
>>> Why do you say they can't be moved?  They can, and your series should
>>> change nothing about it, thanks to what you're doing now with
>>> CONFIG_KVM_IS_POSSIBLE (which was also done before with NEED_CPU_H).
>> numa.c and balloon.c both use ram_addr_t (numa.c uses it directly, and
>> balloon.c indirectly via the QEMUBalloonEvent typedef from the header)=
.
>> And ram_addr_t is currently target-specific - it depends on
>> CONFIG_XEN_BACKEND. So this could break in certain subtle cases, e.g.
>> when compiling on a 32-bit host with XEN enabled.
>=20
> Can ram_addr_t be poisoned on target-independent files?

This is quite similar to trying to poison CONFIG_USER_ONLY ... every
common file that depends on include/exec/memory.h or
/include/exec/cpu-common.h then does not compile anymore - and as far as
I can see, this can't be fixed with some trivial "#ifdef NEED_CPU_H"s in
most cases anymore.

Since you've asked on IRC for a list of files which do not compile
anymore in this case, here we go (some of them are also quite easy to
fix, I think, but some need some bigger reworks, I guess):

stubs/xen-common.o
stubs/xen-hvm.o
stubs/qmp_pc_dimm_device_list.o
stubs/pc_madt_cpu_entry.o
device-hotplug.o
qdev-monitor.o
accel.o
dma-helpers.o
device_tree.o
qmp.o
cpus-common.o
hmp.o
vl.o
audio/audio.o
audio/wavcapture.o
backends/hostmem-ram.o
backends/hostmem.o
backends/hostmem-file.o
backends/cryptodev.o
backends/cryptodev-builtin.o
hw/9pfs/9p.o
hw/acpi/core.o
hw/acpi/pcihp.o
hw/acpi/piix4.o
hw/acpi/ich9.o
hw/acpi/cpu_hotplug.o
hw/acpi/memory_hotplug.o
hw/acpi/tco.o
hw/acpi/cpu.o
hw/acpi/nvdimm.o
hw/acpi/acpi_interface.o
hw/acpi/vmgenid.o
hw/acpi/aml-build.o
hw/acpi/ipmi.o
hw/audio/sb16.o
hw/acpi/acpi-stub.o
hw/audio/es1370.o
hw/audio/ac97.o
hw/audio/adlib.o
hw/audio/gus.o
hw/audio/cs4231a.o
hw/audio/pcspk.o
hw/audio/hda-codec.o
hw/audio/intel-hda.o
hw/audio/wm8750.o
hw/audio/lm4549.o
hw/audio/pl041.o
hw/audio/cs4231.o
hw/audio/marvell_88w8618.o
hw/audio/milkymist-ac97.o
hw/block/cdrom.o
hw/audio/soundhw.o
hw/block/fdc.o
hw/block/m25p80.o
hw/block/nand.o
hw/block/pflash_cfi01.o
hw/block/pflash_cfi02.o
hw/block/ecc.o
hw/block/onenand.o
hw/block/nvme.o
hw/char/ipoctal232.o
hw/bt/hci.o
hw/char/parallel.o
hw/char/pl011.o
hw/char/serial.o
hw/char/escc.o
hw/char/serial-isa.o
hw/char/serial-pci.o
hw/char/xilinx_uartlite.o
hw/char/virtio-console.o
hw/char/etraxfs_ser.o
hw/char/cadence_uart.o
hw/char/debugcon.o
hw/char/grlib_apbuart.o
hw/char/imx_serial.o
hw/char/lm32_juart.o
hw/char/lm32_uart.o
hw/char/milkymist-uart.o
hw/char/sclpconsole.o
hw/char/sclpconsole-lm.o
hw/core/qdev-properties.o
hw/core/qdev.o
hw/core/bus.o
hw/core/empty_slot.o
hw/core/ptimer.o
hw/core/sysbus.o
hw/core/machine.o
hw/core/loader.o
hw/core/loader-fit.o
hw/core/qdev-properties-system.o
hw/core/register.o
hw/core/or-irq.o
hw/core/platform-bus.o
hw/cpu/core.o
hw/display/ads7846.o
hw/display/g364fb.o
hw/display/jazz_led.o
hw/display/cirrus_vga.o
hw/display/ssd0303.o
hw/display/ssd0323.o
hw/display/pl110.o
hw/display/vga-pci.o
hw/display/vga-isa.o
hw/display/vga-isa-mm.o
hw/display/vmware_vga.o
hw/display/exynos4210_fimd.o
hw/display/framebuffer.o
hw/display/milkymist-vgafb.o
hw/dma/puv3_dma.o
hw/display/tc6393xb.o
hw/display/milkymist-tmu2.o
hw/dma/rc4030.o
hw/dma/pl080.o
hw/dma/i82374.o
hw/dma/i8257.o
hw/dma/pl330.o
hw/dma/xilinx_axidma.o
hw/dma/xlnx-zynq-devcfg.o
hw/dma/etraxfs_dma.o
hw/dma/sparc32_dma.o
hw/dma/sun4m_iommu.o
hw/gpio/max7310.o
hw/gpio/puv3_gpio.o
hw/gpio/pl061.o
hw/gpio/zaurus.o
hw/gpio/mpc8xxx.o
hw/gpio/gpio_key.o
hw/i2c/core.o
hw/i2c/smbus.o
hw/i2c/smbus_eeprom.o
hw/i2c/i2c-ddc.o
hw/i2c/versatile_i2c.o
hw/i2c/smbus_ich9.o
hw/i2c/pm_smbus.o
hw/i2c/bitbang_i2c.o
hw/i2c/exynos4210_i2c.o
hw/i2c/imx_i2c.o
hw/i2c/aspeed_i2c.o
hw/ide/core.o
hw/ide/atapi.o
hw/ide/qdev.o
hw/ide/pci.o
hw/ide/isa.o
hw/ide/piix.o
hw/ide/cmd646.o
hw/ide/macio.o
hw/ide/mmio.o
hw/ide/via.o
hw/ide/microdrive.o
hw/ide/ahci.o
hw/ide/ich.o
hw/input/adb.o
hw/input/pckbd.o
hw/input/hid.o
hw/input/lm832x.o
hw/input/pl050.o
hw/input/stellaris_input.o
hw/input/ps2.o
hw/input/tsc2005.o
hw/input/vmmouse.o
hw/input/virtio-input.o
hw/input/virtio-input-host.o
hw/intc/heathrow_pic.o
hw/input/virtio-input-hid.o
hw/intc/i8259_common.o
hw/intc/i8259.o
hw/intc/pl190.o
hw/intc/puv3_intc.o
hw/intc/xilinx_intc.o
hw/intc/etraxfs_pic.o
hw/intc/imx_avic.o
hw/intc/lm32_pic.o
hw/intc/realview_gic.o
hw/intc/ioapic_common.o
hw/intc/slavio_intctl.o
hw/intc/arm_gic_common.o
hw/intc/arm_gic.o
hw/intc/arm_gicv2m.o
hw/intc/arm_gicv3_common.o
hw/intc/arm_gicv3.o
hw/intc/arm_gicv3_dist.o
hw/intc/arm_gicv3_its_common.o
hw/intc/arm_gicv3_redist.o
hw/intc/openpic.o
hw/ipack/ipack.o
hw/ipack/tpci200.o
hw/ipmi/ipmi.o
hw/ipmi/ipmi_bmc_sim.o
hw/ipmi/ipmi_bmc_extern.o
hw/ipmi/isa_ipmi_kcs.o
hw/ipmi/isa_ipmi_bt.o
hw/isa/apm.o
hw/isa/isa-bus.o
hw/isa/i82378.o
hw/isa/pc87312.o
hw/isa/vt82c686.o
hw/isa/piix4.o
hw/mem/pc-dimm.o
hw/mem/nvdimm.o
hw/misc/max111x.o
hw/misc/tmp105.o
hw/misc/tmp421.o
hw/misc/applesmc.o
hw/misc/debugexit.o
hw/misc/sga.o
hw/misc/pc-testdev.o
hw/misc/pci-testdev.o
hw/misc/unimp.o
hw/misc/arm_l2x0.o
hw/misc/arm_integrator_debug.o
hw/misc/a9scu.o
hw/misc/puv3_pm.o
hw/misc/arm11scu.o
hw/misc/macio/macio.o
hw/misc/macio/cuda.o
hw/misc/macio/mac_dbdma.o
hw/net/dp8393x.o
hw/net/ne2000.o
hw/net/eepro100.o
hw/net/pcnet-pci.o
hw/net/pcnet.o
hw/net/e1000x_common.o
hw/net/e1000.o
hw/net/net_tx_pkt.o
hw/net/e1000e.o
hw/net/rtl8139.o
hw/net/e1000e_core.o
hw/net/smc91c111.o
hw/net/vmxnet3.o
hw/net/lan9118.o
hw/net/ne2000-isa.o
hw/net/opencores_eth.o
hw/net/xgmac.o
hw/net/mipsnet.o
hw/net/xilinx_axienet.o
hw/net/allwinner_emac.o
hw/net/imx_fec.o
hw/net/stellaris_enet.o
hw/net/cadence_gem.o
hw/net/lance.o
hw/net/ftgmac100.o
hw/net/rocker/rocker.o
hw/net/rocker/rocker_desc.o
hw/nvram/ds1225y.o
hw/nvram/eeprom93xx.o
hw/nvram/fw_cfg.o
hw/nvram/chrp_nvram.o
hw/nvram/mac_nvram.o
hw/pci-bridge/pci_bridge_dev.o
hw/pci-bridge/pcie_root_port.o
hw/pci-bridge/gen_pcie_root_port.o
hw/pci-bridge/xio3130_upstream.o
hw/pci-bridge/pci_expander_bridge.o
hw/pci-bridge/xio3130_downstream.o
hw/pci-bridge/ioh3420.o
hw/pci-bridge/dec.o
hw/pci-bridge/i82801b11.o
hw/pci-host/pam.o
hw/pci-host/prep.o
hw/pci-host/grackle.o
hw/pci-host/uninorth.o
hw/pci-host/ppce500.o
hw/pci-host/versatile.o
hw/pci-host/apb.o
hw/pci-host/bonito.o
hw/pci-host/piix.o
hw/pci-host/q35.o
hw/pci-host/gpex.o
hw/pci-host/xilinx-pcie.o
hw/pci/pci.o
hw/pci/pci_bridge.o
hw/pci/msix.o
hw/pci/msi.o
hw/pci/shpc.o
hw/pci/slotid_cap.o
hw/pci/pci_host.o
hw/pci/pcie_host.o
hw/pci/pcie.o
hw/pci/pcie_port.o
hw/pci/pcie_aer.o
hw/pci/pci-stub.o
hw/pcmcia/pcmcia.o
hw/scsi/scsi-generic.o
hw/scsi/scsi-disk.o
hw/scsi/scsi-bus.o
hw/scsi/lsi53c895a.o
hw/scsi/mptsas.o
hw/scsi/mptconfig.o
hw/scsi/mptendian.o
hw/scsi/megasas.o
hw/scsi/esp.o
hw/scsi/vmw_pvscsi.o
hw/scsi/esp-pci.o
hw/sd/pl181.o
hw/sd/ssi-sd.o
hw/sd/sd.o
hw/sd/core.o
hw/sd/sdhci.o
hw/smbios/smbios_type_38.o
hw/smbios/smbios.o
hw/ssi/pl022.o
hw/ssi/ssi.o
hw/ssi/xilinx_spi.o
hw/ssi/aspeed_smc.o
hw/ssi/xilinx_spips.o
hw/ssi/stm32f2xx_spi.o
hw/timer/arm_timer.o
hw/timer/arm_mptimer.o
hw/timer/armv7m_systick.o
hw/timer/a9gtimer.o
hw/timer/cadence_ttc.o
hw/timer/ds1338.o
hw/timer/i8254_common.o
hw/timer/i8254.o
hw/timer/hpet.o
hw/timer/m48t59.o
hw/timer/m48t59-isa.o
hw/timer/pl031.o
hw/timer/puv3_ost.o
hw/timer/xilinx_timer.o
hw/timer/slavio_timer.o
hw/timer/twl92230.o
hw/timer/etraxfs_timer.o
hw/timer/grlib_gptimer.o
hw/timer/imx_epit.o
hw/timer/imx_gpt.o
hw/timer/lm32_timer.o
hw/timer/milkymist-sysctl.o
hw/timer/stm32f2xx_timer.o
hw/timer/aspeed_timer.o
hw/timer/sun4v-rtc.o
hw/tpm/tpm_tis.o
hw/tpm/tpm_passthrough.o
hw/tpm/tpm_util.o
hw/usb/core.o
hw/usb/libhw.o
hw/usb/combined-packet.o
hw/usb/bus.o
hw/usb/desc.o
hw/usb/desc-msos.o
hw/usb/hcd-uhci.o
hw/usb/hcd-ohci.o
hw/usb/hcd-ehci-pci.o
hw/usb/hcd-ehci-sysbus.o
hw/usb/hcd-ehci.o
hw/usb/hcd-xhci-nec.o
hw/usb/hcd-xhci.o
hw/usb/hcd-musb.o
hw/usb/dev-hub.o
hw/usb/dev-hid.o
hw/usb/dev-wacom.o
hw/usb/dev-storage.o
hw/usb/dev-uas.o
hw/usb/dev-audio.o
hw/usb/dev-serial.o
hw/usb/dev-network.o
hw/usb/dev-bluetooth.o
hw/usb/dev-smartcard-reader.o
hw/usb/dev-mtp.o
hw/usb/host-legacy.o
hw/usb/host-libusb.o
hw/virtio/virtio-rng.o
hw/virtio/virtio-bus.o
hw/virtio/virtio-mmio.o
hw/virtio/vhost-stub.o
hw/virtio/virtio-pci.o
hw/watchdog/wdt_i6300esb.o
hw/watchdog/wdt_ib700.o
hw/watchdog/wdt_diag288.o
hw/watchdog/wdt_aspeed.o
migration/socket.o
migration/migration.o
migration/tls.o
migration/channel.o
migration/savevm.o
migration/colo-comm.o
migration/colo.o
migration/colo-failover.o
migration/vmstate.o
migration/vmstate-types.o
migration/qemu-file.o
migration/qemu-file-channel.o
migration/postcopy-ram.o
migration/block.o
net/net.o
net/vhost-user.o
net/filter.o
net/tap.o
qom/cpu.o
slirp/slirp.o
ui/console.o
ui/input.o
ui/vnc.o

 Thomas
