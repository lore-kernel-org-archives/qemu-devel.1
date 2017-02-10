Received: from eggs.gnu.org ([2001:4830:134:3::10]:44245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cc8au-00027L-JM
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cc8ar-0003OW-C7
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:38:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cc8ar-0003OD-2M
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:38:21 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C9FB80482
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 10:38:21 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 10 Feb 2017 11:38:05 +0100
Message-Id: <1486723086-12247-1-git-send-email-abologna@redhat.com>
In-Reply-To: <1486722439-12033-1-git-send-email-abologna@redhat.com>
References: <1486722439-12033-1-git-send-email-abologna@redhat.com>
Subject: [Qemu-devel] [PATCH v6 1/2] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, lersek@redhat.com, kraxel@redhat.com

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
 docs/q35-chipset.cfg          | 152 ------------------------
 docs/q35-emulated.cfg         | 269 ++++++++++++++++++++++++++++++++++++++++++
 docs/q35-virtio-graphical.cfg | 229 +++++++++++++++++++++++++++++++++++
 docs/q35-virtio-serial.cfg    | 174 +++++++++++++++++++++++++++
 4 files changed, 672 insertions(+), 152 deletions(-)
 delete mode 100644 docs/q35-chipset.cfg
 create mode 100644 docs/q35-emulated.cfg
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
index 0000000..7a60bb5
--- /dev/null
+++ b/docs/q35-emulated.cfg
@@ -0,0 +1,269 @@
+# q35 - Emulated guest (graphical console)
+# =========================================================
+#
+# Usage:
+#
+#   $ qemu-system-x86_64 \
+#     -nodefaults \
+#     -readconfig q35-emulated.cfg
+#
+# You will probably need to tweak the lines marked as
+# CHANGE ME before being able to use this configuration!
+#
+# The guest will have a selection of emulated devices that
+# closely resembles that of a physical machine, and will be
+# accessed through a graphical console.
+#
+# ---------------------------------------------------------
+#
+# Using -nodefaults is required to have full control over
+# the virtual hardware: when it's specified, QEMU will
+# populate the board with only the builtin peripherals
+# plus a small selection of core PCI devices and
+# controllers; the user will then have to explicitly add
+# further devices.
+#
+# The core PCI devices show up in the guest as:
+#
+#   00:00.0 Host bridge
+#   00:1f.0 ISA bridge / LPC
+#   00:1f.2 SATA (AHCI) controller
+#   00:1f.3 SMBus controller
+#
+# This configuration file adds a number of devices that
+# are pretty much guaranteed to be present in every single
+# physical machine based on q35, more specifically:
+#
+#   00:01.0 VGA compatible controller
+#   00:19.0 Ethernet controller
+#   00:1a.* USB controller (#2)
+#   00:1b.0 Audio device
+#   00:1c.* PCI bridge (PCI Express Root Ports)
+#   00:1d.* USB Controller (#1)
+#   00:1e.0 PCI bridge (legacy PCI bridge)
+#
+# More information about these devices is available below.
+
+
+# Machine options
+# =========================================================
+#
+# We use the q35 machine type and enable KVM acceleration
+# for better performance.
+#
+# Using less than 1 GiB of memory is probably not going to
+# yield good performance in the guest, and might even lead
+# to obscure boot issues in some cases.
+#
+# Unfortunately, there is no way to configure the CPU model
+# in this file, so it will have to be provided on the
+# command line.
+
+[machine]
+  type = "q35"
+  accel = "kvm"
+
+[memory]
+  size = "1024"
+
+
+# PCI bridge (PCI Express Root Ports)
+# =========================================================
+#
+# We add four PCI Express Root Ports, all sharing the same
+# slot on the PCI Express  Root Bus. These ports support
+# hotplug.
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
+# PCI bridge (legacy PCI bridge)
+# =========================================================
+#
+# This bridge can be used to build an independent topology
+# for legacy PCI devices. PCI Express devices should be
+# plugged into PCI Express slots instead, so ideally there
+# will be no devices connected to this bridge.
+
+[device "ich9-pci-bridge"]
+  driver = "i82801b11-bridge"
+  bus = "pcie.0"
+  addr = "1e.0"
+
+
+# SATA storage
+# =========================================================
+#
+# An implicit SATA controller is created automatically for
+# every single q35 guest; here we create a disk, backed by
+# a qcow2 disk image on the host's filesystem, and attach
+# it to that controller so that the guest can use it.
+
+[device "sata-disk"]
+  driver = "ide-hd"
+  bus = "ide.0"
+  drive = "disk"
+
+[drive "disk"]
+  file = "guest.qcow2"                          # CHANGE ME
+  format = "qcow2"
+  if = "none"
+
+
+# USB controller (#1)
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
+# USB controller (#2)
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
+# Ethernet controller
+# =========================================================
+#
+# We add a Gigabit Ethernet interface to the guest; on the
+# host side, we take advantage of user networking so that
+# the QEMU process doesn't require any additional
+# privileges.
+
+[netdev "hostnet"]
+  type = "user"
+
+[device "net"]
+  driver = "e1000"
+  netdev = "hostnet"
+  bus = "pcie.0"
+  addr = "19.0"
+
+
+# VGA compatible controller
+# =========================================================
+#
+# We use stdvga instead of Cirrus as it supports more video
+# modes and is closer to what actual hardware looks like.
+#
+# If you're running the guest on a remote, potentially
+# headless host, you will probably want to append something
+# like
+#
+#   -display vnc=127.0.0.1:0
+#
+# to the command line in order to prevent QEMU from trying
+# to display a GTK+ window on the host and enable remote
+# access instead.
+
+[device "video"]
+  driver = "VGA"
+  bus = "pcie.0"
+  addr = "01.0"
+
+
+# Audio device
+# =========================================================
+#
+# The sound card is a legacy PCI device that is plugged
+# directly into the PCI Express Root Bus.
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
diff --git a/docs/q35-virtio-graphical.cfg b/docs/q35-virtio-graphical.cfg
new file mode 100644
index 0000000..58ce145
--- /dev/null
+++ b/docs/q35-virtio-graphical.cfg
@@ -0,0 +1,229 @@
+# q35 - VirtIO guest (graphical console)
+# =========================================================
+#
+# Usage:
+#
+#   $ qemu-system-x86_64 \
+#     -nodefaults \
+#     -readconfig q35-virtio-graphical.cfg
+#
+# You will probably need to tweak the lines marked as
+# CHANGE ME before being able to use this configuration!
+#
+# The guest will have a selection of VirtIO devices
+# tailored towards optimal performance with modern guests,
+# and will be accessed through a graphical console.
+#
+# ---------------------------------------------------------
+#
+# Using -nodefaults is required to have full control over
+# the virtual hardware: when it's specified, QEMU will
+# populate the board with only the builtin peripherals
+# plus a small selection of core PCI devices and
+# controllers; the user will then have to explicitly add
+# further devices.
+#
+# The core PCI devices show up in the guest as:
+#
+#   00:00.0 Host bridge
+#   00:1f.0 ISA bridge / LPC
+#   00:1f.2 SATA (AHCI) controller
+#   00:1f.3 SMBus controller
+#
+# This configuration file adds a number of other useful
+# devices, more specifically:
+#
+#   00:01.0 VGA compatible controller
+#   00:1b.0 Audio device
+#   00.1c.* PCI bridge (PCI Express Root Ports)
+#   01:00.0 SCSI storage controller
+#   02:00.0 Ethernet controller
+#   03:00.0 USB controller
+#
+# More information about these devices is available below.
+
+
+# Machine options
+# =========================================================
+#
+# We use the q35 machine type and enable KVM acceleration
+# for better performance.
+#
+# Using less than 1 GiB of memory is probably not going to
+# yield good performance in the guest, and might even lead
+# to obscure boot issues in some cases.
+
+[machine]
+  type = "q35"
+  accel = "kvm"
+
+[memory]
+  size = "1024"
+
+
+# PCI bridge (PCI Express Root Ports)
+# =========================================================
+#
+# We create eight PCI Express Root Ports, and we plug them
+# all into separate functions of the same slot. Some of
+# them will be used by devices, the rest will remain
+# available for hotplug.
+
+[device "pci.1"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.0"
+  port = "1"
+  chassis = "1"
+  multifunction = "on"
+
+[device "pci.2"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.1"
+  port = "2"
+  chassis = "2"
+
+[device "pci.3"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.2"
+  port = "3"
+  chassis = "3"
+
+[device "pci.4"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.3"
+  port = "4"
+  chassis = "4"
+
+[device "pci.5"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.4"
+  port = "5"
+  chassis = "5"
+
+[device "pci.6"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.5"
+  port = "6"
+  chassis = "6"
+
+[device "pci.7"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.6"
+  port = "7"
+  chassis = "7"
+
+[device "pci.8"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.7"
+  port = "8"
+  chassis = "8"
+
+
+# SCSI storage controller (and storage)
+# =========================================================
+#
+# We use virtio-scsi here so that we can (hot)plug a large
+# number of disks without running into issues; a SCSI disk,
+# backed by a qcow2 disk image on the host's filesystem, is
+# attached to it.
+
+[device "scsi"]
+  driver = "virtio-scsi-pci"
+  bus = "pci.1"
+  addr = "00.0"
+
+[device "scsi-disk"]
+  driver = "scsi-hd"
+  bus = "scsi.0"
+  drive = "disk"
+
+[drive "disk"]
+  file = "guest.qcow2"                          # CHANGE ME
+  format = "qcow2"
+  if = "none"
+
+
+# Ethernet controller
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
+  addr = "00.0"
+
+
+# USB controller (and input devices)
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
+  addr = "00.0"
+
+[device "tablet"]
+  driver = "usb-tablet"
+  bus = "usb.0"
+
+
+# VGA compatible controller
+# =========================================================
+#
+# We plug the QXL video card directly into the PCI Express
+# Root Bus as it is a legacy PCI device; this way, we can
+# reduce the number of PCI Express controllers in the
+# guest.
+#
+# If you're running the guest on a remote, potentially
+# headless host, you will probably want to append something
+# like
+#
+#   -display vnc=127.0.0.1:0
+#
+# to the command line in order to prevent QEMU from trying
+# to display a GTK+ window on the host and enable remote
+# access instead.
+
+[device "video"]
+  driver = "qxl-vga"
+  bus = "pcie.0"
+  addr = "01.0"
+
+
+# Audio device
+# =========================================================
+#
+# Like the video card, the sound card is a legacy PCI
+# device and as such can be plugged directly into the PCI
+# Express Root Bus.
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
index 0000000..1fcdefd
--- /dev/null
+++ b/docs/q35-virtio-serial.cfg
@@ -0,0 +1,174 @@
+# q35 - VirtIO guest (serial console)
+# =========================================================
+#
+# Usage:
+#
+#   $ qemu-system-x86_64 \
+#     -nodefaults \
+#     -readconfig q35-virtio-serial.cfg \
+#     -display none -serial mon:stdio
+#
+# You will probably need to tweak the lines marked as
+# CHANGE ME before being able to use this configuration!
+#
+# The guest will have a selection of VirtIO devices
+# tailored towards optimal performance with modern guests,
+# and will be accessed through the serial console.
+#
+# ---------------------------------------------------------
+#
+# Using -nodefaults is required to have full control over
+# the virtual hardware: when it's specified, QEMU will
+# populate the board with only the builtin peripherals
+# plus a small selection of core PCI devices and
+# controllers; the user will then have to explicitly add
+# further devices.
+#
+# The core PCI devices show up in the guest as:
+#
+#   00:00.0 Host bridge
+#   00:1f.0 ISA bridge / LPC
+#   00:1f.2 SATA (AHCI) controller
+#   00:1f.3 SMBus controller
+#
+# This configuration file adds a number of other useful
+# devices, more specifically:
+#
+#   00.1c.* PCI bridge (PCI Express Root Ports)
+#   01:00.0 SCSI storage controller
+#   02:00.0 Ethernet controller
+#
+# More information about these devices is available below.
+#
+# We use '-display none' to prevent QEMU from creating a
+# graphical display window, which would serve no use in
+# this specific configuration, and '-serial mon:stdio' to
+# multiplex the guest's serial console and the QEMU monitor
+# to the host's stdio; use 'Ctrl+A h' to learn how to
+# switch between the two and more.
+
+
+# Machine options
+# =========================================================
+#
+# We use the q35 machine type and enable KVM acceleration
+# for better performance.
+#
+# Using less than 1 GiB of memory is probably not going to
+# yield good performance in the guest, and might even lead
+# to obscure boot issues in some cases.
+
+[machine]
+  type = "q35"
+  accel = "kvm"
+
+[memory]
+  size = "1024"
+
+
+# PCI bridge (PCI Express Root Ports)
+# =========================================================
+#
+# We create eight PCI Express Root Ports, and we plug them
+# all into separate functions of the same slot. Some of
+# them will be used by devices, the rest will remain
+# available for hotplug.
+
+[device "pci.1"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.0"
+  port = "1"
+  chassis = "1"
+  multifunction = "on"
+
+[device "pci.2"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.1"
+  port = "2"
+  chassis = "2"
+
+[device "pci.3"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.2"
+  port = "3"
+  chassis = "3"
+
+[device "pci.4"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.3"
+  port = "4"
+  chassis = "4"
+
+[device "pci.5"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.4"
+  port = "5"
+  chassis = "5"
+
+[device "pci.6"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.5"
+  port = "6"
+  chassis = "6"
+
+[device "pci.7"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.6"
+  port = "7"
+  chassis = "7"
+
+[device "pci.8"]
+  driver = "pcie-root-port"
+  bus = "pcie.0"
+  addr = "1c.7"
+  port = "8"
+  chassis = "8"
+
+
+# SCSI storage controller (and storage)
+# =========================================================
+#
+# We use virtio-scsi here so that we can (hot)plug a large
+# number of disks without running into issues; a SCSI disk,
+# backed by a qcow2 disk image on the host's filesystem, is
+# attached to it.
+
+[device "scsi"]
+  driver = "virtio-scsi-pci"
+  bus = "pci.1"
+  addr = "00.0"
+
+[device "scsi-disk"]
+  driver = "scsi-hd"
+  bus = "scsi.0"
+  drive = "disk"
+
+[drive "disk"]
+  file = "guest.qcow2"                          # CHANGE ME
+  format = "qcow2"
+  if = "none"
+
+
+# Ethernet controller
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
+  addr = "00.0"
-- 
2.7.4
