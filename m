Received: from eggs.gnu.org ([2001:4830:134:3::10]:39707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dG7dT-0006iV-87
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dG7dP-0000i5-OT
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:42:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dG7d6-0000Yc-4g
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:42:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2059EC0272E6
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:41:54 +0000 (UTC)
Date: Wed, 31 May 2017 14:41:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170531174145.GD10124@thinpad.lan.raisama.net>
References: <20170513033316.22395-1-ehabkost@redhat.com>
	<20170513033316.22395-4-ehabkost@redhat.com>
	<87r2zf4ocg.fsf@dusky.pond.sub.org>
	<20170524163921.GO32274@thinpad.lan.raisama.net>
	<8737bo9frk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8737bo9frk.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] scripts: Test script to look for
 -device crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Mon, May 29, 2017 at 11:25:03AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> > On Tue, May 23, 2017 at 04:52:47PM +0200, Markus Armbruster wrote:
[...]
> >> > +ERROR_WHITELIST = [
> >> > +  # Machines that won't work out of the box:
> >> > +  #             MACHINE                         | ERROR MESSAGE
> >> > +  dict(machine='niagara', expected=True),       # Unable to load a firmware for -M niagara
> >> 
> >> What's wrong with dictionary displays?
> >> 
> >>      {'expected': True, 'machine': 'niagara'}
> >
> > Nothing wrong.  I just prefer the dict(key=value) syntax to the
> > colons and extra quotes in {'key': value}.
> 
> Since Python provides syntactic sugar ("dictionary displays")
> specifically for creating dictionaries, shouldn't we use it?
> 
> As far as I can tell, existing Python code always uses dictionary
> displays, never the equivalent constructor call.

Well, if dict literals is less surprising, I can change it.

I will squash this in:

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 3b089099ce..5f90e9bb54 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -65,175 +65,175 @@ dbg = logger.debug
 ERROR_WHITELIST = [
     # Machines that won't work out of the box:
     #             MACHINE                         | ERROR MESSAGE
-    dict(machine='niagara', expected=True),       # Unable to load a firmware for -M niagara
-    dict(machine='boston', expected=True),        # Please provide either a -kernel or -bios argument
-    dict(machine='leon3_generic', expected=True), # Can't read bios image (null)
+    {'machine':'niagara', 'expected':True},       # Unable to load a firmware for -M niagara
+    {'machine':'boston', 'expected':True},        # Please provide either a -kernel or -bios argument
+    {'machine':'leon3_generic', 'expected':True}, # Can't read bios image (null)
 
     # devices that don't work out of the box because they require extra options to "-device DEV":
     #            DEVICE                                    | ERROR MESSAGE
-    dict(device='.*-(i386|x86_64)-cpu', expected=True),    # CPU socket-id is not set
-    dict(device='ARM,bitband-memory', expected=True),      # source-memory property not set
-    dict(device='arm.cortex-a9-global-timer', expected=True), # a9_gtimer_realize: num-cpu must be between 1 and 4
-    dict(device='arm_mptimer', expected=True),             # num-cpu must be between 1 and 4
-    dict(device='armv7m', expected=True),                  # memory property was not set
-    dict(device='aspeed.scu', expected=True),              # Unknown silicon revision: 0x0
-    dict(device='aspeed.sdmc', expected=True),             # Unknown silicon revision: 0x0
-    dict(device='bcm2835-dma', expected=True),             # bcm2835_dma_realize: required dma-mr link not found: Property '.dma-mr' not found
-    dict(device='bcm2835-fb', expected=True),              # bcm2835_fb_realize: required vcram-base property not set
-    dict(device='bcm2835-mbox', expected=True),            # bcm2835_mbox_realize: required mbox-mr link not found: Property '.mbox-mr' not found
-    dict(device='bcm2835-peripherals', expected=True),     # bcm2835_peripherals_realize: required ram link not found: Property '.ram' not found
-    dict(device='bcm2835-property', expected=True),        # bcm2835_property_realize: required fb link not found: Property '.fb' not found
-    dict(device='bcm2835_gpio', expected=True),            # bcm2835_gpio_realize: required sdhci link not found: Property '.sdbus-sdhci' not found
-    dict(device='bcm2836', expected=True),                 # bcm2836_realize: required ram link not found: Property '.ram' not found
-    dict(device='cfi.pflash01', expected=True),            # attribute "sector-length" not specified or zero.
-    dict(device='cfi.pflash02', expected=True),            # attribute "sector-length" not specified or zero.
-    dict(device='icp', expected=True),                     # icp_realize: required link 'xics' not found: Property '.xics' not found
-    dict(device='ics', expected=True),                     # ics_base_realize: required link 'xics' not found: Property '.xics' not found
+    {'device':'.*-(i386|x86_64)-cpu', 'expected':True},    # CPU socket-id is not set
+    {'device':'ARM,bitband-memory', 'expected':True},      # source-memory property not set
+    {'device':'arm.cortex-a9-global-timer', 'expected':True}, # a9_gtimer_realize: num-cpu must be between 1 and 4
+    {'device':'arm_mptimer', 'expected':True},             # num-cpu must be between 1 and 4
+    {'device':'armv7m', 'expected':True},                  # memory property was not set
+    {'device':'aspeed.scu', 'expected':True},              # Unknown silicon revision: 0x0
+    {'device':'aspeed.sdmc', 'expected':True},             # Unknown silicon revision: 0x0
+    {'device':'bcm2835-dma', 'expected':True},             # bcm2835_dma_realize: required dma-mr link not found: Property '.dma-mr' not found
+    {'device':'bcm2835-fb', 'expected':True},              # bcm2835_fb_realize: required vcram-base property not set
+    {'device':'bcm2835-mbox', 'expected':True},            # bcm2835_mbox_realize: required mbox-mr link not found: Property '.mbox-mr' not found
+    {'device':'bcm2835-peripherals', 'expected':True},     # bcm2835_peripherals_realize: required ram link not found: Property '.ram' not found
+    {'device':'bcm2835-property', 'expected':True},        # bcm2835_property_realize: required fb link not found: Property '.fb' not found
+    {'device':'bcm2835_gpio', 'expected':True},            # bcm2835_gpio_realize: required sdhci link not found: Property '.sdbus-sdhci' not found
+    {'device':'bcm2836', 'expected':True},                 # bcm2836_realize: required ram link not found: Property '.ram' not found
+    {'device':'cfi.pflash01', 'expected':True},            # attribute "sector-length" not specified or zero.
+    {'device':'cfi.pflash02', 'expected':True},            # attribute "sector-length" not specified or zero.
+    {'device':'icp', 'expected':True},                     # icp_realize: required link 'xics' not found: Property '.xics' not found
+    {'device':'ics', 'expected':True},                     # ics_base_realize: required link 'xics' not found: Property '.xics' not found
     # "-device ide-cd" does work on more recent QEMU versions, so it doesn't have expected=True
-    dict(device='ide-cd'),                                 # No drive specified
-    dict(device='ide-drive', expected=True),               # No drive specified
-    dict(device='ide-hd', expected=True),                  # No drive specified
-    dict(device='ipmi-bmc-extern', expected=True),         # IPMI external bmc requires chardev attribute
-    dict(device='isa-debugcon', expected=True),            # Can't create serial device, empty char device
-    dict(device='isa-ipmi-bt', expected=True),             # IPMI device requires a bmc attribute to be set
-    dict(device='isa-ipmi-kcs', expected=True),            # IPMI device requires a bmc attribute to be set
-    dict(device='isa-parallel', expected=True),            # Can't create serial device, empty char device
-    dict(device='isa-serial', expected=True),              # Can't create serial device, empty char device
-    dict(device='ivshmem', expected=True),                 # You must specify either 'shm' or 'chardev'
-    dict(device='ivshmem-doorbell', expected=True),        # You must specify a 'chardev'
-    dict(device='ivshmem-plain', expected=True),           # You must specify a 'memdev'
-    dict(device='kvm-pci-assign', expected=True),          # no host device specified
-    dict(device='loader', expected=True),                  # please include valid arguments
-    dict(device='nand', expected=True),                    # Unsupported NAND block size 0x1
-    dict(device='nvdimm', expected=True),                  # 'memdev' property is not set
-    dict(device='nvme', expected=True),                    # Device initialization failed
-    dict(device='pc-dimm', expected=True),                 # 'memdev' property is not set
-    dict(device='pci-bridge', expected=True),              # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
-    dict(device='pci-bridge-seat', expected=True),         # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
-    dict(device='pci-serial', expected=True),              # Can't create serial device, empty char device
-    dict(device='pci-serial-2x', expected=True),           # Can't create serial device, empty char device
-    dict(device='pci-serial-4x', expected=True),           # Can't create serial device, empty char device
-    dict(device='pxa2xx-dma', expected=True),              # channels value invalid
-    dict(device='pxb', expected=True),                     # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
-    dict(device='scsi-block', expected=True),              # drive property not set
-    dict(device='scsi-disk', expected=True),               # drive property not set
-    dict(device='scsi-generic', expected=True),            # drive property not set
-    dict(device='scsi-hd', expected=True),                 # drive property not set
-    dict(device='spapr-pci-host-bridge', expected=True),   # BUID not specified for PHB
-    dict(device='spapr-pci-vfio-host-bridge', expected=True), # BUID not specified for PHB
-    dict(device='spapr-rng', expected=True),               # spapr-rng needs an RNG backend!
-    dict(device='spapr-vty', expected=True),               # chardev property not set
-    dict(device='tpm-tis', expected=True),                 # tpm_tis: backend driver with id (null) could not be found
-    dict(device='unimplemented-device', expected=True),    # property 'size' not specified or zero
-    dict(device='usb-braille', expected=True),             # Property chardev is required
-    dict(device='usb-mtp', expected=True),                 # x-root property must be configured
-    dict(device='usb-redir', expected=True),               # Parameter 'chardev' is missing
-    dict(device='usb-serial', expected=True),              # Property chardev is required
-    dict(device='usb-storage', expected=True),             # drive property not set
-    dict(device='vfio-amd-xgbe', expected=True),           # -device vfio-amd-xgbe: vfio error: wrong host device name
-    dict(device='vfio-calxeda-xgmac', expected=True),      # -device vfio-calxeda-xgmac: vfio error: wrong host device name
-    dict(device='vfio-pci', expected=True),                # No provided host device
-    dict(device='vfio-pci-igd-lpc-bridge', expected=True), # VFIO dummy ISA/LPC bridge must have address 1f.0
-    dict(device='vhost-scsi.*', expected=True),            # vhost-scsi: missing wwpn
-    dict(device='vhost-vsock-device', expected=True),      # guest-cid property must be greater than 2
-    dict(device='vhost-vsock-pci', expected=True),         # guest-cid property must be greater than 2
-    dict(device='virtio-9p-ccw', expected=True),           # 9pfs device couldn't find fsdev with the id = NULL
-    dict(device='virtio-9p-device', expected=True),        # 9pfs device couldn't find fsdev with the id = NULL
-    dict(device='virtio-9p-pci', expected=True),           # 9pfs device couldn't find fsdev with the id = NULL
-    dict(device='virtio-blk-ccw', expected=True),          # drive property not set
-    dict(device='virtio-blk-device', expected=True),       # drive property not set
-    dict(device='virtio-blk-device', expected=True),       # drive property not set
-    dict(device='virtio-blk-pci', expected=True),          # drive property not set
-    dict(device='virtio-crypto-ccw', expected=True),       # 'cryptodev' parameter expects a valid object
-    dict(device='virtio-crypto-device', expected=True),    # 'cryptodev' parameter expects a valid object
-    dict(device='virtio-crypto-pci', expected=True),       # 'cryptodev' parameter expects a valid object
-    dict(device='virtio-input-host-device', expected=True), # evdev property is required
-    dict(device='virtio-input-host-pci', expected=True),   # evdev property is required
-    dict(device='xen-pvdevice', expected=True),            # Device ID invalid, it must always be supplied
-    dict(device='vhost-vsock-ccw', expected=True),         # guest-cid property must be greater than 2
-    dict(device='ALTR.timer', expected=True),              # "clock-frequency" property must be provided
-    dict(device='zpci', expected=True),                    # target must be defined
-    dict(device='pnv-(occ|icp|lpc)', expected=True),       # required link 'xics' not found: Property '.xics' not found
-    dict(device='powernv-cpu-.*', expected=True),          # pnv_core_realize: required link 'xics' not found: Property '.xics' not found
+    {'device':'ide-cd'},                                 # No drive specified
+    {'device':'ide-drive', 'expected':True},               # No drive specified
+    {'device':'ide-hd', 'expected':True},                  # No drive specified
+    {'device':'ipmi-bmc-extern', 'expected':True},         # IPMI external bmc requires chardev attribute
+    {'device':'isa-debugcon', 'expected':True},            # Can't create serial device, empty char device
+    {'device':'isa-ipmi-bt', 'expected':True},             # IPMI device requires a bmc attribute to be set
+    {'device':'isa-ipmi-kcs', 'expected':True},            # IPMI device requires a bmc attribute to be set
+    {'device':'isa-parallel', 'expected':True},            # Can't create serial device, empty char device
+    {'device':'isa-serial', 'expected':True},              # Can't create serial device, empty char device
+    {'device':'ivshmem', 'expected':True},                 # You must specify either 'shm' or 'chardev'
+    {'device':'ivshmem-doorbell', 'expected':True},        # You must specify a 'chardev'
+    {'device':'ivshmem-plain', 'expected':True},           # You must specify a 'memdev'
+    {'device':'kvm-pci-assign', 'expected':True},          # no host device specified
+    {'device':'loader', 'expected':True},                  # please include valid arguments
+    {'device':'nand', 'expected':True},                    # Unsupported NAND block size 0x1
+    {'device':'nvdimm', 'expected':True},                  # 'memdev' property is not set
+    {'device':'nvme', 'expected':True},                    # Device initialization failed
+    {'device':'pc-dimm', 'expected':True},                 # 'memdev' property is not set
+    {'device':'pci-bridge', 'expected':True},              # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
+    {'device':'pci-bridge-seat', 'expected':True},         # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
+    {'device':'pci-serial', 'expected':True},              # Can't create serial device, empty char device
+    {'device':'pci-serial-2x', 'expected':True},           # Can't create serial device, empty char device
+    {'device':'pci-serial-4x', 'expected':True},           # Can't create serial device, empty char device
+    {'device':'pxa2xx-dma', 'expected':True},              # channels value invalid
+    {'device':'pxb', 'expected':True},                     # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
+    {'device':'scsi-block', 'expected':True},              # drive property not set
+    {'device':'scsi-disk', 'expected':True},               # drive property not set
+    {'device':'scsi-generic', 'expected':True},            # drive property not set
+    {'device':'scsi-hd', 'expected':True},                 # drive property not set
+    {'device':'spapr-pci-host-bridge', 'expected':True},   # BUID not specified for PHB
+    {'device':'spapr-pci-vfio-host-bridge', 'expected':True}, # BUID not specified for PHB
+    {'device':'spapr-rng', 'expected':True},               # spapr-rng needs an RNG backend!
+    {'device':'spapr-vty', 'expected':True},               # chardev property not set
+    {'device':'tpm-tis', 'expected':True},                 # tpm_tis: backend driver with id (null) could not be found
+    {'device':'unimplemented-device', 'expected':True},    # property 'size' not specified or zero
+    {'device':'usb-braille', 'expected':True},             # Property chardev is required
+    {'device':'usb-mtp', 'expected':True},                 # x-root property must be configured
+    {'device':'usb-redir', 'expected':True},               # Parameter 'chardev' is missing
+    {'device':'usb-serial', 'expected':True},              # Property chardev is required
+    {'device':'usb-storage', 'expected':True},             # drive property not set
+    {'device':'vfio-amd-xgbe', 'expected':True},           # -device vfio-amd-xgbe: vfio error: wrong host device name
+    {'device':'vfio-calxeda-xgmac', 'expected':True},      # -device vfio-calxeda-xgmac: vfio error: wrong host device name
+    {'device':'vfio-pci', 'expected':True},                # No provided host device
+    {'device':'vfio-pci-igd-lpc-bridge', 'expected':True}, # VFIO dummy ISA/LPC bridge must have address 1f.0
+    {'device':'vhost-scsi.*', 'expected':True},            # vhost-scsi: missing wwpn
+    {'device':'vhost-vsock-device', 'expected':True},      # guest-cid property must be greater than 2
+    {'device':'vhost-vsock-pci', 'expected':True},         # guest-cid property must be greater than 2
+    {'device':'virtio-9p-ccw', 'expected':True},           # 9pfs device couldn't find fsdev with the id = NULL
+    {'device':'virtio-9p-device', 'expected':True},        # 9pfs device couldn't find fsdev with the id = NULL
+    {'device':'virtio-9p-pci', 'expected':True},           # 9pfs device couldn't find fsdev with the id = NULL
+    {'device':'virtio-blk-ccw', 'expected':True},          # drive property not set
+    {'device':'virtio-blk-device', 'expected':True},       # drive property not set
+    {'device':'virtio-blk-device', 'expected':True},       # drive property not set
+    {'device':'virtio-blk-pci', 'expected':True},          # drive property not set
+    {'device':'virtio-crypto-ccw', 'expected':True},       # 'cryptodev' parameter expects a valid object
+    {'device':'virtio-crypto-device', 'expected':True},    # 'cryptodev' parameter expects a valid object
+    {'device':'virtio-crypto-pci', 'expected':True},       # 'cryptodev' parameter expects a valid object
+    {'device':'virtio-input-host-device', 'expected':True}, # evdev property is required
+    {'device':'virtio-input-host-pci', 'expected':True},   # evdev property is required
+    {'device':'xen-pvdevice', 'expected':True},            # Device ID invalid, it must always be supplied
+    {'device':'vhost-vsock-ccw', 'expected':True},         # guest-cid property must be greater than 2
+    {'device':'ALTR.timer', 'expected':True},              # "clock-frequency" property must be provided
+    {'device':'zpci', 'expected':True},                    # target must be defined
+    {'device':'pnv-(occ|icp|lpc)', 'expected':True},       # required link 'xics' not found: Property '.xics' not found
+    {'device':'powernv-cpu-.*', 'expected':True},          # pnv_core_realize: required link 'xics' not found: Property '.xics' not found
 
     # ioapic devices are already created by pc and will fail:
-    dict(machine='q35|pc.*', device='kvm-ioapic', expected=True), # Only 1 ioapics allowed
-    dict(machine='q35|pc.*', device='ioapic', expected=True),     # Only 1 ioapics allowed
+    {'machine':'q35|pc.*', 'device':'kvm-ioapic', 'expected':True}, # Only 1 ioapics allowed
+    {'machine':'q35|pc.*', 'device':'ioapic', 'expected':True},     # Only 1 ioapics allowed
 
     # KVM-specific devices shouldn't be tried without accel=kvm:
-    dict(accel='(?!kvm).*', device='kvmclock', expected=True),
-    dict(accel='(?!kvm).*', device='kvm-pci-assign', expected=True),
+    {'accel':'(?!kvm).*', 'device':'kvmclock', 'expected':True},
+    {'accel':'(?!kvm).*', 'device':'kvm-pci-assign', 'expected':True},
 
     # xen-specific machines and devices:
-    dict(accel='(?!xen).*', machine='xen.*', expected=True),
-    dict(accel='(?!xen).*', device='xen-.*', expected=True),
+    {'accel':'(?!xen).*', 'machine':'xen.*', 'expected':True},
+    {'accel':'(?!xen).*', 'device':'xen-.*', 'expected':True},
 
     # this fails on some machine-types, but not all, so they don't have expected=True:
-    dict(device='vmgenid'), # vmgenid requires DMA write support in fw_cfg, which this machine type does not provide
+    {'device':'vmgenid'}, # vmgenid requires DMA write support in fw_cfg, which this machine type does not provide
 
     # Silence INFO messages for errors that are common on multiple
     # devices/machines:
-    dict(log=r"No '[\w-]+' bus found for device '[\w-]+'"),
-    dict(log=r"images* must be given with the 'pflash' parameter"),
-    dict(log=r"(Guest|ROM|Flash|Kernel) image must be specified"),
-    dict(log=r"[cC]ould not load [\w ]+ (BIOS|bios) '[\w-]+\.bin'"),
-    dict(log=r"Couldn't find rom image '[\w-]+\.bin'"),
-    dict(log=r"speed mismatch trying to attach usb device"),
-    dict(log=r"Can't create a second ISA bus"),
-    dict(log=r"duplicate fw_cfg file name"),
+    {'log':r"No '[\w-]+' bus found for device '[\w-]+'"},
+    {'log':r"images* must be given with the 'pflash' parameter"},
+    {'log':r"(Guest|ROM|Flash|Kernel) image must be specified"},
+    {'log':r"[cC]ould not load [\w ]+ (BIOS|bios) '[\w-]+\.bin'"},
+    {'log':r"Couldn't find rom image '[\w-]+\.bin'"},
+    {'log':r"speed mismatch trying to attach usb device"},
+    {'log':r"Can't create a second ISA bus"},
+    {'log':r"duplicate fw_cfg file name"},
     # sysbus-related error messages: most machines reject most dynamic sysbus devices:
-    dict(log=r"Option '-device [\w.,-]+' cannot be handled by this machine"),
-    dict(log=r"Device [\w.,-]+ is not supported by this machine yet"),
-    dict(log=r"Device [\w.,-]+ can not be dynamically instantiated"),
-    dict(log=r"Platform Bus: Can not fit MMIO region of size "),
+    {'log':r"Option '-device [\w.,-]+' cannot be handled by this machine"},
+    {'log':r"Device [\w.,-]+ is not supported by this machine yet"},
+    {'log':r"Device [\w.,-]+ can not be dynamically instantiated"},
+    {'log':r"Platform Bus: Can not fit MMIO region of size "},
     # other more specific errors we will ignore:
-    dict(device='allwinner-a10', log="Unsupported NIC model:"),
-    dict(device='.*-spapr-cpu-core', log=r"CPU core type should be"),
-    dict(log=r"MSI(-X)? is not supported by interrupt controller"),
-    dict(log=r"pxb-pcie? devices cannot reside on a PCIe? bus"),
-    dict(log=r"Ignoring smp_cpus value"),
-    dict(log=r"sd_init failed: Drive 'sd0' is already in use because it has been automatically connected to another device"),
-    dict(log=r"This CPU requires a smaller page size than the system is using"),
-    dict(log=r"MSI-X support is mandatory in the S390 architecture"),
-    dict(log=r"rom check and register reset failed"),
-    dict(log=r"Unable to initialize GIC, CPUState for CPU#0 not valid"),
-    dict(log=r"Multiple VT220 operator consoles are not supported"),
-    dict(log=r"core 0 already populated"),
-    dict(log=r"could not find stage1 bootloader"),
+    {'device':'allwinner-a10', 'log':"Unsupported NIC model:"},
+    {'device':'.*-spapr-cpu-core', 'log':r"CPU core type should be"},
+    {'log':r"MSI(-X)? is not supported by interrupt controller"},
+    {'log':r"pxb-pcie? devices cannot reside on a PCIe? bus"},
+    {'log':r"Ignoring smp_cpus value"},
+    {'log':r"sd_init failed: Drive 'sd0' is already in use because it has been automatically connected to another device"},
+    {'log':r"This CPU requires a smaller page size than the system is using"},
+    {'log':r"MSI-X support is mandatory in the S390 architecture"},
+    {'log':r"rom check and register reset failed"},
+    {'log':r"Unable to initialize GIC, CPUState for CPU#0 not valid"},
+    {'log':r"Multiple VT220 operator consoles are not supported"},
+    {'log':r"core 0 already populated"},
+    {'log':r"could not find stage1 bootloader"},
 
     # other exitcode=1 failures not listed above will just generate INFO messages:
-    dict(exitcode=1, loglevel=logging.INFO),
+    {'exitcode':1, 'loglevel':logging.INFO},
 
     # KNOWN CRASHES:
     # Known crashes will generate error messages, but won't be fatal.
     # Those entries must be removed once we fix the crashes.
-    dict(exitcode=-6, log=r"Device 'serial0' is in use", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"spapr_rtas_register: Assertion .*rtas_table\[token\]\.name.* failed", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"qemu_net_client_setup: Assertion `!peer->peer' failed", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r'RAMBlock "[\w.-]+" already registered', loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"find_ram_offset: Assertion `size != 0' failed.", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"puv3_load_kernel: Assertion `kernel_filename != NULL' failed", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"add_cpreg_to_hashtable: code should not be reached", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"qemu_alloc_display: Assertion `surface->image != NULL' failed", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"Unexpected error in error_set_from_qdev_prop_error", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"Object .* is not an instance of type spapr-machine", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"Object .* is not an instance of type generic-pc-machine", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"Object .* is not an instance of type e500-ccsr", loglevel=logging.ERROR),
-    dict(exitcode=-6, log=r"vmstate_register_with_alias_id: Assertion `!se->compat || se->instance_id == 0' failed", loglevel=logging.ERROR),
-    dict(exitcode=-11, device='stm32f205-soc', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, device='xlnx,zynqmp', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, device='mips-cps', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, device='gus', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, device='a9mpcore_priv', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, device='a15mpcore_priv', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, device='isa-serial', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, device='sb16', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, device='cs4231a', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, device='arm-gicv3', loglevel=logging.ERROR, expected=True),
-    dict(exitcode=-11, machine='isapc', device='.*-iommu', loglevel=logging.ERROR, expected=True),
+    {'exitcode':-6, 'log':r"Device 'serial0' is in use", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"spapr_rtas_register: Assertion .*rtas_table\[token\]\.name.* failed", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"qemu_net_client_setup: Assertion `!peer->peer' failed", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r'RAMBlock "[\w.-]+" already registered', 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"find_ram_offset: Assertion `size != 0' failed.", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"puv3_load_kernel: Assertion `kernel_filename != NULL' failed", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"add_cpreg_to_hashtable: code should not be reached", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"qemu_alloc_display: Assertion `surface->image != NULL' failed", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"Unexpected error in error_set_from_qdev_prop_error", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"Object .* is not an instance of type spapr-machine", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat || se->instance_id == 0' failed", 'loglevel':logging.ERROR},
+    {'exitcode':-11, 'device':'stm32f205-soc', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'xlnx,zynqmp', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'mips-cps', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'gus', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'a9mpcore_priv', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'a15mpcore_priv', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'sb16', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'cs4231a', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'arm-gicv3', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
-    dict(exitcode=None, fatal=True, loglevel=logging.FATAL),
+    {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
 ]
 
 
@@ -423,11 +423,11 @@ def checkOneCase(args, testcase):
         log = vm.get_log()
 
     if exc_traceback is not None or ec != 0:
-        return dict(exc_traceback=exc_traceback,
-                    exitcode=ec,
-                    log=log,
-                    testcase=testcase,
-                    cmdline=cmdline)
+        return {'exc_traceback':exc_traceback,
+                'exitcode':ec,
+                'log':log,
+                'testcase':testcase,
+                'cmdline':cmdline}
 
 
 def binariesToTest(args, testcase):

-- 
Eduardo
