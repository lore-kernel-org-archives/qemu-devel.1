Received: from eggs.gnu.org ([2001:4830:134:3::10]:33228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cYDZ0-0005dV-Is
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cYDYx-00038B-6v
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:08:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cYDYw-00037J-UX
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:08:11 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 430F961B9B
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 15:08:10 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
Date: Mon, 30 Jan 2017 16:07:57 +0100
Message-Id: <1485788877-3823-1-git-send-email-abologna@redhat.com>
Subject: [Qemu-devel] [PATCH] q35: Provide improved sample configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: drjones@redhat.com

Instead of having a single sample configuration file,
now we have two: one gives access to the guest through
the serial console and only includes a minimal set of
devices, the other uses a graphical console and includes
extra devices such as an audio card.

Both configuration file are full commented, neatly
organized, and use paravirtualized devices instead of
emulated devices whenever possible for a better user
experience. Moreover, they follow the PCI Express
Guidelines (docs/pcie.txt) for their topology.
---
I plan to provide similar sample configurations for
aarch64/virt guests once the generic PCIe Root Ports
have been merged.

 docs/q35-chipset.cfg   | 152 ------------------------------------------------
 docs/q35-graphical.cfg | 154 +++++++++++++++++++++++++++++++++++++++++++++++++
 docs/q35-serial.cfg    | 110 +++++++++++++++++++++++++++++++++++
 3 files changed, 264 insertions(+), 152 deletions(-)
 delete mode 100644 docs/q35-chipset.cfg
 create mode 100644 docs/q35-graphical.cfg
 create mode 100644 docs/q35-serial.cfg

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
diff --git a/docs/q35-graphical.cfg b/docs/q35-graphical.cfg
new file mode 100644
index 0000000..90c25cc
--- /dev/null
+++ b/docs/q35-graphical.cfg
@@ -0,0 +1,154 @@
+# q35 guest - sample configuration (graphical console)
+# =========================================================
+#
+# Usage:
+#
+#   $ qemu-system-x86_64 \
+#     -nodefaults \
+#     -readconfig q35-graphical.cfg \
+#     -drive file=q35.qcow2,format=qcow2
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
+# We create four PCIe Root Ports: the first three are used
+# by devices defined below, while the last one is left
+# unused so that one more device can be hotplugged.
+
+[device "pci.1"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x2"
+  port = "0x10"
+  chassis = "1"
+
+[device "pci.2"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x3"
+  port = "0x11"
+  chassis = "2"
+
+[device "pci.3"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x4"
+  port = "0x12"
+  chassis = "3"
+
+[device "pci.4"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x5"
+  port = "0x13"
+  chassis = "4"
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
+# both a USB keyboard and a USB tablet so that graphical
+# guests can be controlled appropriately.
+
+[device "usb"]
+  driver = "nec-usb-xhci"
+  bus = "pci.3"
+  addr = "0x0"
+
+[device "keyboard"]
+  driver = "usb-kbd"
+  bus = "usb.0"
+  port = "1"
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
diff --git a/docs/q35-serial.cfg b/docs/q35-serial.cfg
new file mode 100644
index 0000000..e1f2366
--- /dev/null
+++ b/docs/q35-serial.cfg
@@ -0,0 +1,110 @@
+# q35 guest - sample configuration (serial console)
+# =========================================================
+#
+# Usage:
+#
+#   $ qemu-system-x86_64 \
+#     -nographic -nodefaults \
+#     -readconfig q35-serial.cfg \
+#     -drive file=q35.qcow2,format=qcow2
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
+# We create three PCIe Root Ports: the first two are used
+# by devices defined below, while the last one is left
+# unused so that one more device can be hotplugged.
+
+[device "pci.1"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x2"
+  port = "0x10"
+  chassis = "1"
+
+[device "pci.2"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x3"
+  port = "0x11"
+  chassis = "2"
+
+[device "pci.3"]
+  driver = "ioh3420"
+  bus = "pcie.0"
+  addr = "0x4"
+  port = "0x12"
+  chassis = "3"
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
