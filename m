Received: from eggs.gnu.org ([2001:4830:134:3::10]:44576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbW9v-00028T-Ty
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbW9u-0005lC-2O
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:35:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbW9t-0005kn-R9
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:35:58 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06DEF804EF
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 17:35:58 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed,  8 Feb 2017 18:35:31 +0100
Message-Id: <1486575331-14455-3-git-send-email-abologna@redhat.com>
In-Reply-To: <1486575331-14455-1-git-send-email-abologna@redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample configuration
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, kraxel@redhat.com, lersek@redhat.com

These are very much like the sample configuration files
for q35, and can be used both as documentation and as
a starting point for creating your own guest.

Two sample configuration files are provided:

  * mach-virt-graphical.cfg can be used to start a
    fully-featured (USB, graphical console, etc.)
    guest that uses VirtIO devices;

  * mach-virt-serial.cfg is similar but has a minimal
    set of devices and uses the serial console.

All configuration files are fully commented and neatly
organized.
---
 docs/mach-virt-graphical.cfg | 245 +++++++++++++++++++++++++++++++++++++++++++
 docs/mach-virt-serial.cfg    | 234 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 479 insertions(+)
 create mode 100644 docs/mach-virt-graphical.cfg
 create mode 100644 docs/mach-virt-serial.cfg

diff --git a/docs/mach-virt-graphical.cfg b/docs/mach-virt-graphical.cfg
new file mode 100644
index 0000000..d942394
--- /dev/null
+++ b/docs/mach-virt-graphical.cfg
@@ -0,0 +1,245 @@
+# mach-virt - VirtIO guest (graphical console)
+# =========================================================
+#
+# You will probably need to tweak the lines marked as
+# CHANGE ME before being able to use this configuration!
+#
+# Usage:
+#
+#   $ qemu-system-aarch64 \
+#     -nodefaults \
+#     -readconfig mach-virt-graphical.cfg \
+#     -cpu host
+#
+# The guest will have a selection of VirtIO devices
+# tailored towards optimal performance with modern guests,
+# and will be accessed through a graphical console.
+#
+# ---------------------------------------------------------
+#
+# Using -nodefaults is required to have full control over
+# the virtual hardware: when it's specified, QEMU will
+# create a bare machine with just the very essential
+# chipset devices being present:
+#
+#   00:00.0 Host bridge
+#
+# This configuration file adds a number of other useful
+# devices, more specifically:
+#
+#   00:01.0 Display controller
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
+# We use the virt machine type and enable KVM acceleration
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
+  type = "virt"
+  accel = "kvm"
+
+[memory]
+  size = "1024"
+
+
+# Firmware configuration
+# =========================================================
+#
+# There are two parts to the firmware: a read-only image
+# containing the executable code, which is shared between
+# guests, and a read/write variable store that is used by
+# to record information such as the boot device. An empty
+# variable store can be created by simply copying a
+# template provided as part of AAVMF.
+#
+# Depending on the distribution you're using on the host,
+# paths to the firmware itself and variable store template
+# will be different. Some examples:
+#
+# Fedora:
+#   /usr/share/edk2/aarch64/QEMU_EFI.fd
+#   /usr/share/edk2/aarch64/QEMU_VARS.fd
+# RHEL:
+#   /usr/share/AAVMF/AAVMF_CODE.fd
+#   /usr/share/AAVMF/AAVMF_VARS.fd
+
+[drive "aavmf-code"]
+  file = "/usr/share/edk2/aarch64/QEMU_EFI.fd"  # CHANGE ME
+  format = "raw"
+  if = "pflash"
+  unit = "0"
+  readonly = "on"
+
+[drive "aavmf-vars"]
+  file = "guest_VARS.fd"                        # CHANGE ME
+  format = "raw"
+  if = "pflash"
+  unit = "1"
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
+# a USB keyboard / USB tablet combo so that graphical
+# guests can be controlled appropriately.
+
+[device "usb"]
+  driver = "nec-usb-xhci"
+  bus = "pci.3"
+  addr = "00.0"
+
+[device "keyboard"]
+  driver = "usb-kbd"
+  bus = "usb.0"
+
+[device "tablet"]
+  driver = "usb-tablet"
+  bus = "usb.0"
+
+
+# Display controller
+# =========================================================
+#
+# We use virtio-gpu because the legacy VGA framebuffer is
+# very troublesome on aarch64, and virtio-gpu is the only
+# video device that doesn't implement it.
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
+  driver = "virtio-gpu"
+  bus = "pcie.0"
+  addr = "01.0"
diff --git a/docs/mach-virt-serial.cfg b/docs/mach-virt-serial.cfg
new file mode 100644
index 0000000..6bf8cb2
--- /dev/null
+++ b/docs/mach-virt-serial.cfg
@@ -0,0 +1,234 @@
+# mach-virt - VirtIO guest (serial console)
+# =========================================================
+#
+# You will probably need to tweak the lines marked as
+# CHANGE ME before being able to use this configuration!
+#
+# Usage:
+#
+#   $ qemu-system-aarch64 \
+#     -nographic -nodefaults \
+#     -readconfig mach-virt-serial.cfg \
+#     -cpu host
+#
+# The guest will have a selection of VirtIO devices
+# tailored towards optimal performance with modern guests,
+# and will be accessed through the serial console.
+#
+# ---------------------------------------------------------
+#
+# We need -nographic to prevent QEMU from creating an empty
+# display window, which we're not interested in.
+#
+# Using -nodefaults is required to have full control over
+# the virtual hardware: when it's specified, QEMU will
+# create a bare machine with just the very essential
+# chipset devices being present:
+#
+#   00:00.0 Host bridge
+#
+# This configuration file adds a number of other useful
+# devices, more specifically:
+#
+#   00.1c.* PCI bridge (PCI Express Root Ports)
+#   01:00.0 SCSI storage controller
+#   02:00.0 Ethernet controller
+#   03:00.0 Communication controller (serial console)
+#
+# More information about these devices is available below.
+
+
+# Machine options
+# =========================================================
+#
+# We use the virt machine type and enable KVM acceleration
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
+  type = "virt"
+  accel = "kvm"
+
+[memory]
+  size = "1024"
+
+
+# Firmware configuration
+# =========================================================
+#
+# There are two parts to the firmware: a read-only image
+# containing the executable code, which is shared between
+# guests, and a read/write variable store that is used by
+# to record information such as the boot device. An empty
+# variable store can be created by simply copying a
+# template provided as part of AAVMF.
+#
+# Depending on the distribution you're using on the host,
+# paths to the firmware itself and variable store template
+# will be different. Some examples:
+#
+# Fedora:
+#   /usr/share/edk2/aarch64/QEMU_EFI.fd
+#   /usr/share/edk2/aarch64/QEMU_VARS.fd
+# RHEL:
+#   /usr/share/AAVMF/AAVMF_CODE.fd
+#   /usr/share/AAVMF/AAVMF_VARS.fd
+
+[drive "aavmf-code"]
+  file = "/usr/share/edk2/aarch64/QEMU_EFI.fd"  # CHANGE ME
+  format = "raw"
+  if = "pflash"
+  unit = "0"
+  readonly = "on"
+
+[drive "aavmf-vars"]
+  file = "guest_VARS.fd"                        # CHANGE ME
+  format = "raw"
+  if = "pflash"
+  unit = "1"
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
+# Communication controller (serial console)
+# =========================================================
+#
+# We use virtconsole along with virtio-serial, and connect
+# it with the host's standard input / output channels. In
+# this configuration, the guest will behave pretty much
+# like any other Unix utility: that includes terminating
+# as soon as Ctrl-C is pressed, so caution is advised.
+#
+# If you want to use the platform's native serial console
+# instead, you should comment out this section and append
+#
+#   -serial stdio
+#
+# to the QEMU command line. Doing so might be needed to be
+# able to access the GRUB menu or see the output from the
+# boot process.
+
+[chardev "hostconsole"]
+  backend = "stdio"
+
+[device "serial"]
+  driver = "virtio-serial-pci"
+  bus = "pci.3"
+  addr = "00.0"
+
+[device "console"]
+  driver = "virtconsole"
+  chardev = "hostconsole"
-- 
2.7.4
