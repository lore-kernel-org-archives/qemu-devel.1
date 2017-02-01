Received: from eggs.gnu.org ([2001:4830:134:3::10]:41357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cYyaV-0002LV-GO
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 12:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cYyaS-0008Ts-An
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 12:20:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cYyaS-0008Tk-3F
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 12:20:52 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17100624BB
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 17:20:52 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed,  1 Feb 2017 18:20:40 +0100
Message-Id: <1485969640-8149-1-git-send-email-abologna@redhat.com>
Subject: [Qemu-devel] [PATCH v2] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcel@redhat.com, drjones@redhat.com

Instead of having a single sample configuration file,
we now have several:

  * q35-emulated.cfg documents the default devices QEMU
    adds to a q35 guest and the additional devices that
    are pretty much guaranteed to be present in a
    physical q35-based machine;

  * q35-virtio-graphical.cfg can be used to start a
    fully-featured (USB, graphical console, audio, etc.)
    guest that uses VirtIO instead of emulated devices;

  * q35-virtio-serial.cfg is similar but has a minimal
    set of devices and uses the serial console.

All configuration files are fully commented and neatly
organized.
---
Changes since [v1]

  * Address review comments:
    - improve the existing configuration file instead
      of removing it;
    - split off the common part for VirtIO guests;
    - plug all ioh3420 devices in a single slot;
    - use slot 1c for ioh3420 devices;
    - remove useless USB keyboard.

  * Improve usage description:
    - make sure the OS disk actually uses the VirtIO
      SCSI controller, as intended, rather than the
      built-in SATA one;
    - provide a command line for running live CDs.

  * Document more devices:
    - the video card is added by default;
    - so is the Ethernet adapter, apparently.

The last part seems to clash with some of Gerd's comments,
so I'm kinda puzzled.


[v1] http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg06342.html

 docs/q35-chipset.cfg          | 152 --------------------------------
 docs/q35-emulated.cfg         | 196 ++++++++++++++++++++++++++++++++++++++++++
 docs/q35-virtio-common.cfg    |  82 ++++++++++++++++++
 docs/q35-virtio-graphical.cfg | 113 ++++++++++++++++++++++++
 docs/q35-virtio-serial.cfg    |  80 +++++++++++++++++
 5 files changed, 471 insertions(+), 152 deletions(-)
 delete mode 100644 docs/q35-chipset.cfg
 create mode 100644 docs/q35-emulated.cfg
 create mode 100644 docs/q35-virtio-common.cfg
 create mode 100644 docs/q35-virtio-graphical.cfg
 create mode 100644 docs/q35-virtio-serial.cfg

diff --git a/docs/q35-chipset.cfg b/docs/q35-chipset.cfg
deleted file mode 100644
index e4ddb7d..0000000
--- a/docs/q35-chipset.cfg
+++ /dev/null
@@ -1,152 +0,0 @@
-################################################################
-#
-# qemu -M q35 creates a bare machine with just the very essential
-# chipset devices being present:
-#
-#     00.0 - Host bridge
-#     1f.0 - ISA bridge / LPC
-#     1f.2 - SATA (AHCI) controller
-#     1f.3 - SMBus controller
-#
-# This config file documents the other devices and how they are
-# created.  You can simply use "-readconfig $thisfile" to create
-# them all.  Here is a overview:
-#
-#     19.0 - Ethernet controller (not created, our e1000 emulation
-#                                 doesn't emulate the ich9 device).
-#     1a.* - USB Controller #2 (ehci + uhci companions)
-#     1b.0 - HD Audio Controller
-#     1c.* - PCI Express Ports
-#     1d.* - USB Controller #1 (ehci + uhci companions,
-#                               "qemu -M q35 -usb" creates these too)
-#     1e.0 - PCI Bridge
-#
-
-[device "ich9-ehci-2"]
-  driver = "ich9-usb-ehci2"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1a.7"
-
-[device "ich9-uhci-4"]
-  driver = "ich9-usb-uhci4"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1a.0"
-  masterbus = "ich9-ehci-2.0"
-  firstport = "0"
-
-[device "ich9-uhci-5"]
-  driver = "ich9-usb-uhci5"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1a.1"
-  masterbus = "ich9-ehci-2.0"
-  firstport = "2"
-
-[device "ich9-uhci-6"]
-  driver = "ich9-usb-uhci6"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1a.2"
-  masterbus = "ich9-ehci-2.0"
-  firstport = "4"
-
-
-[device "ich9-hda-audio"]
-  driver = "ich9-intel-hda"
-  bus = "pcie.0"
-  addr = "1b.0"
-
-
-[device "ich9-pcie-port-1"]
-  driver = "ioh3420"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1c.0"
-  port = "1"
-  chassis = "1"
-
-[device "ich9-pcie-port-2"]
-  driver = "ioh3420"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1c.1"
-  port = "2"
-  chassis = "2"
-
-[device "ich9-pcie-port-3"]
-  driver = "ioh3420"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1c.2"
-  port = "3"
-  chassis = "3"
-
-[device "ich9-pcie-port-4"]
-  driver = "ioh3420"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1c.3"
-  port = "4"
-  chassis = "4"
-
-##
-# Example PCIe switch with two downstream ports
-#
-#[device "pcie-switch-upstream-port-1"]
-#  driver = "x3130-upstream"
-#  bus = "ich9-pcie-port-4"
-#  addr = "00.0"
-#
-#[device "pcie-switch-downstream-port-1-1"]
-#  driver = "xio3130-downstream"
-#  multifunction = "on"
-#  bus = "pcie-switch-upstream-port-1"
-#  addr = "00.0"
-#  port = "1"
-#  chassis = "5"
-#
-#[device "pcie-switch-downstream-port-1-2"]
-#  driver = "xio3130-downstream"
-#  multifunction = "on"
-#  bus = "pcie-switch-upstream-port-1"
-#  addr = "00.1"
-#  port = "1"
-#  chassis = "6"
-
-[device "ich9-ehci-1"]
-  driver = "ich9-usb-ehci1"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1d.7"
-
-[device "ich9-uhci-1"]
-  driver = "ich9-usb-uhci1"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1d.0"
-  masterbus = "ich9-ehci-1.0"
-  firstport = "0"
-
-[device "ich9-uhci-2"]
-  driver = "ich9-usb-uhci2"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1d.1"
-  masterbus = "ich9-ehci-1.0"
-  firstport = "2"
-
-[device "ich9-uhci-3"]
-  driver = "ich9-usb-uhci3"
-  multifunction = "on"
-  bus = "pcie.0"
-  addr = "1d.2"
-  masterbus = "ich9-ehci-1.0"
-  firstport = "4"
-
-
-[device "ich9-pci-bridge"]
-  driver = "i82801b11-bridge"
-  bus = "pcie.0"
-  addr = "1e.0"
diff --git a/docs/q35-emulated.cfg b/docs/q35-emulated.cfg
new file mode 100644
index 0000000..aaa86e1
--- /dev/null
+++ b/docs/q35-emulated.cfg
@@ -0,0 +1,196 @@
+# q35 - Emulated guest (graphical console)
+# =========================================================
+#
+# Usage:
+#
+#   $ qemu-system-x86_64 \
+#     -readconfig q35-emulated.cfg \
+#     -drive file=os.qcow2,format=qcow2
+#
+# Or:
+#
+#   $ qemu-system-x86_64 \
+#     -readconfig q35-emulated.cfg \
+#     -cdrom live.iso
+#
+# ---------------------------------------------------------
+#
+# This file contains a working configuration that can be
+# used for booting a generic q35 guest without too much
+# fuss, or as a starting point for a more fine-tuned
+# configuration. The guest in question will be accessed
+# using a graphical console.
+#
+# If not instructed otherwise, QEMU will create a bare
+# machine with just the very essential chipset devices
+# being present:
+#
+#   00.0 - Host bridge
+#   01.0 - VGA compatible controller
+#   02.0 - Ethernet controller
+#   1f.0 - ISA bridge / LPC
+#   1f.2 - SATA (AHCI) controller
+#   1f.3 - SMBus controller
+#
+# This configuration file adds a number of devices that
+# are very likely to be present in physical machines based
+# on q35, more specifically:
+#
+#   1a.* - USB Controller #2 (EHCI + UHCI companions)
+#   1b.0 - HD Audio Controller
+#   1c.* - PCI Express Ports
+#   1d.* - USB Controller #1 (EHCI + UHCI companions)
+#   1e.0 - PCI Bridge
+#
+# More information about these devices is available below.
+
+
+# Machine options
+# =========================================================
+#
+# We use the q35 machine type and enable KVM acceleration
+# for better performance.
+
+[machine]
+  type = "q35"
+  accel = "kvm"
+
+
+# PCI Express controllers
+# =========================================================
+#
+# We add four PCIe Root Ports, all sharing the same slot
+# on the PCIe Root Bus. These ports support hotplug.
+
+[device "ich9-pcie-port-1"]
+  driver = "ioh3420"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1c.0"
+  port = "1"
+  chassis = "1"
+
+[device "ich9-pcie-port-2"]
+  driver = "ioh3420"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1c.1"
+  port = "2"
+  chassis = "2"
+
+[device "ich9-pcie-port-3"]
+  driver = "ioh3420"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1c.2"
+  port = "3"
+  chassis = "3"
+
+[device "ich9-pcie-port-4"]
+  driver = "ioh3420"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1c.3"
+  port = "4"
+  chassis = "4"
+
+
+# Legacy PCI controllers
+# =========================================================
+#
+# This bridge can be used to build an independent topology
+# for legacy PCI devices.
+
+[device "ich9-pci-bridge"]
+  driver = "i82801b11-bridge"
+  bus = "pcie.0"
+  addr = "1e.0"
+
+
+# USB controller #1
+# =========================================================
+#
+# EHCI controller + UHCI companion controllers.
+
+[device "ich9-ehci-1"]
+  driver = "ich9-usb-ehci1"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1d.7"
+
+[device "ich9-uhci-1"]
+  driver = "ich9-usb-uhci1"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1d.0"
+  masterbus = "ich9-ehci-1.0"
+  firstport = "0"
+
+[device "ich9-uhci-2"]
+  driver = "ich9-usb-uhci2"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1d.1"
+  masterbus = "ich9-ehci-1.0"
+  firstport = "2"
+
+[device "ich9-uhci-3"]
+  driver = "ich9-usb-uhci3"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1d.2"
+  masterbus = "ich9-ehci-1.0"
+  firstport = "4"
+
+
+# USB controller #2
+# =========================================================
+#
+# EHCI controller + UHCI companion controllers.
+
+[device "ich9-ehci-2"]
+  driver = "ich9-usb-ehci2"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1a.7"
+
+[device "ich9-uhci-4"]
+  driver = "ich9-usb-uhci4"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1a.0"
+  masterbus = "ich9-ehci-2.0"
+  firstport = "0"
+
+[device "ich9-uhci-5"]
+  driver = "ich9-usb-uhci5"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1a.1"
+  masterbus = "ich9-ehci-2.0"
+  firstport = "2"
+
+[device "ich9-uhci-6"]
+  driver = "ich9-usb-uhci6"
+  multifunction = "on"
+  bus = "pcie.0"
+  addr = "1a.2"
+  masterbus = "ich9-ehci-2.0"
+  firstport = "4"
+
+
+# Sound card
+# =========================================================
+#
+# The sound card is a legacy PCI device that is plugged
+# directly into the PCIe Root Bus.
+
+[device "ich9-hda-audio"]
+  driver = "ich9-intel-hda"
+  bus = "pcie.0"
+  addr = "1b.0"
+
+[device "ich9-hda-duplex"]
+  driver = "hda-duplex"
+  bus = "ich9-hda-audio.0"
+  cad = "0"
diff --git a/docs/q35-virtio-common.cfg b/docs/q35-virtio-common.cfg
new file mode 100644
index 0000000..b143e65
--- /dev/null
+++ b/docs/q35-virtio-common.cfg
@@ -0,0 +1,82 @@
+# q35 - VirtIO guest (common bits)
+# =========================================================
+#
+# Not very useful on its own. See q35-virtio-graphical.cfg
+# and q35-virtio-serial.cfg for usage instructions.
+
+
+# Machine options
+# =========================================================
+#
+# We use the q35 machine type and enable KVM acceleration
+# for better performance.
+
+[machine]
+  type = "q35"
+  accel = "kvm"
+
+
+# PCIe controllers
+# =========================================================
+#
+# We create eight PCIe Root Ports, and we plug them all
+# into separate functions of the same slot. Some of them
+# will be used by devices, the rest will remain available
+# for hotplug.
+
+[device "pci.1"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x1c.0x0"
+  port = "0x10"
+  chassis = "1"
+  multifunction = "on"
+
+[device "pci.2"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x1c.0x1"
+  port = "0x11"
+  chassis = "2"
+
+[device "pci.3"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x1c.0x2"
+  port = "0x12"
+  chassis = "3"
+
+[device "pci.4"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x1c.0x3"
+  port = "0x13"
+  chassis = "4"
+
+[device "pci.5"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x1c.0x4"
+  port = "0x14"
+  chassis = "5"
+
+[device "pci.6"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x1c.0x5"
+  port = "0x15"
+  chassis = "6"
+
+[device "pci.7"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x1c.0x6"
+  port = "0x16"
+  chassis = "7"
+
+[device "pci.8"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x1c.0x7"
+  port = "0x17"
+  chassis = "8"
diff --git a/docs/q35-virtio-graphical.cfg b/docs/q35-virtio-graphical.cfg
new file mode 100644
index 0000000..4948a20
--- /dev/null
+++ b/docs/q35-virtio-graphical.cfg
@@ -0,0 +1,113 @@
+# q35 - VirtIO guest (graphical console)
+# =========================================================
+#
+# Usage:
+#
+#   $ qemu-system-x86_64 \
+#     -nodefaults \
+#     -readconfig q35-virtio-common.cfg \
+#     -readconfig q35-virtio-graphical.cfg \
+#     -device scsi-hd,bus=scsi.0,drive=disk \
+#     -drive file=os.qcow2,format=qcow2,id=disk,if=none
+#
+# Or:
+#
+#   $ qemu-system-x86_64 \
+#     -nodefaults \
+#     -readconfig q35-virtio-common.cfg \
+#     -readconfig q35-virtio-graphical.cfg \
+#     -cdrom live.iso
+#
+# ---------------------------------------------------------
+#
+# This file contains a working configuration that can be
+# used for booting a generic q35 guest without too much
+# fuss, or as a starting point for a more fine-tuned
+# configuration. The guest in question will be accessed
+# using a graphical console.
+#
+# Using -nodefaults is required to avoid duplicated
+# devices and conflicting address assignments; all devices
+# that are added by this file are explained in detail
+# below.
+
+
+# SCSI controller
+# =========================================================
+#
+# We use virtio-scsi here so that we can (hot)plug a large
+# number of disks without running into issues. QEMU will
+# automatically plug any guest disk into this controller.
+
+[device "scsi"]
+  driver = "virtio-scsi-pci"
+  bus = "pci.1"
+  addr = "0x0"
+
+
+# Network interface
+# =========================================================
+#
+# We use virtio-net for improved performance over emulated
+# hardware; on the host side, we take advantage of user
+# networking so that the QEMU process doesn't require any
+# additional privileges.
+
+[netdev "hostnet"]
+  type = "user"
+
+[device "net"]
+  driver = "virtio-net-pci"
+  netdev = "hostnet"
+  bus = "pci.2"
+  addr = "0x0"
+
+
+# USB controller and input devices
+# =========================================================
+#
+# We add a virtualization-friendly USB 3.0 controller and
+# a USB tablet so that graphical guests can be controlled
+# appropriately. A USB keyboard is not needed, as q35
+# guests get a PS/2 one added automatically.
+
+[device "usb"]
+  driver = "nec-usb-xhci"
+  bus = "pci.3"
+  addr = "0x0"
+
+[device "tablet"]
+  driver = "usb-tablet"
+  bus = "usb.0"
+  port = "2"
+
+
+# Video card
+# =========================================================
+#
+# We plug the QXL video card directly into the PCIe Root
+# Bus as it is a legacy PCI device; this way, we can reduce
+# the number of PCIe controllers in the guest.
+
+[device "video"]
+  driver = "qxl-vga"
+  bus = "pcie.0"
+  addr = "0x1"
+
+
+# Sound card
+# =========================================================
+#
+# Like the video card, the sound card is a legacy PCI
+# device and as such can be plugged directly into the PCIe
+# Root Bus.
+
+[device "sound"]
+  driver = "ich9-intel-hda"
+  bus = "pcie.0"
+  addr = "1b.0"
+
+[device "duplex"]
+  driver = "hda-duplex"
+  bus = "sound.0"
+  cad = "0"
diff --git a/docs/q35-virtio-serial.cfg b/docs/q35-virtio-serial.cfg
new file mode 100644
index 0000000..9ab3958
--- /dev/null
+++ b/docs/q35-virtio-serial.cfg
@@ -0,0 +1,80 @@
+# q35 - VirtIO guest (serial console)
+# =========================================================
+#
+# Usage:
+#
+#   $ qemu-system-x86_64 \
+#     -nographic -nodefaults \
+#     -readconfig q35-virtio-common.cfg \
+#     -readconfig q35-virtio-serial.cfg \
+#     -device scsi-hd,bus=scsi.0,drive=disk \
+#     -drive file=os.qcow2,format=qcow2,id=disk,if=none
+#
+# Or:
+#
+#   $ qemu-system-x86_64 \
+#     -nographic -nodefaults \
+#     -readconfig q35-virtio-common.cfg \
+#     -readconfig q35-virtio-serial.cfg \
+#     -cdrom live.iso
+#
+# ---------------------------------------------------------
+#
+# This file contains a working configuration that can be
+# used for booting a generic q35 guest without too much
+# fuss, or as a starting point for a more fine-tuned
+# configuration. The guest in question will be accessed
+# using the serial console.
+#
+# Using -nodefaults is required to avoid duplicated
+# devices and conflicting address assignments; all devices
+# that are added by this file are explained in detail
+# below.
+
+
+# SCSI controller
+# =========================================================
+#
+# We use virtio-scsi here so that we can (hot)plug a large
+# number of disks without running into issues. QEMU will
+# automatically plug any guest disk into this controller.
+
+[device "scsi"]
+  driver = "virtio-scsi-pci"
+  bus = "pci.1"
+  addr = "0x0"
+
+
+# Network interface
+# =========================================================
+#
+# We use virtio-net for improved performance over emulated
+# hardware; on the host side, we take advantage of user
+# networking so that the QEMU process doesn't require any
+# additional privileges.
+
+[netdev "hostnet"]
+  type = "user"
+
+[device "net"]
+  driver = "virtio-net-pci"
+  netdev = "hostnet"
+  bus = "pci.2"
+  addr = "0x0"
+
+
+# Serial console
+# =========================================================
+#
+# This provides access to the guest via the host's standard
+# input / output channel, eg. the guest will behave pretty
+# much like any other Unix utility. That includes
+# terminating as soon as Ctrl-C is pressed, so caution is
+# advised.
+
+[chardev "console"]
+  backend = "stdio"
+
+[device "serial"]
+  driver = "isa-serial"
+  chardev = "console"
-- 
2.7.4
