Received: from eggs.gnu.org ([2001:4830:134:3::10]:45871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ccFNy-00054q-27
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ccFNt-0003Zz-Vy
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:53:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ccFNt-0003Yd-Mr
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:53:25 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AB5DC056793
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 17:53:25 +0000 (UTC)
Date: Fri, 10 Feb 2017 18:53:20 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170210175320.i45loxvo4pgkisbb@hawk.localdomain>
References: <1486747506-15876-1-git-send-email-abologna@redhat.com>
	<1486747506-15876-3-git-send-email-abologna@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486747506-15876-3-git-send-email-abologna@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, lersek@redhat.com, kraxel@redhat.com

On Fri, Feb 10, 2017 at 06:25:06PM +0100, Andrea Bolognani wrote:
> These are very much like the sample configuration files
> for q35, and can be used both as documentation and as
> a starting point for creating your own guest.
> 
> Two sample configuration files are provided:
> 
>   * mach-virt-graphical.cfg can be used to start a
>     fully-featured (USB, graphical console, etc.)
>     guest that uses VirtIO devices;
> 
>   * mach-virt-serial.cfg is similar but has a minimal
>     set of devices and uses the serial console.
> 
> All configuration files are fully commented and neatly
> organized.
> ---
>  docs/mach-virt-graphical.cfg | 281 +++++++++++++++++++++++++++++++++++++++++++
>  docs/mach-virt-serial.cfg    | 243 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 524 insertions(+)
>  create mode 100644 docs/mach-virt-graphical.cfg
>  create mode 100644 docs/mach-virt-serial.cfg

Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks Andrea!

> 
> diff --git a/docs/mach-virt-graphical.cfg b/docs/mach-virt-graphical.cfg
> new file mode 100644
> index 0000000..0fdf684
> --- /dev/null
> +++ b/docs/mach-virt-graphical.cfg
> @@ -0,0 +1,281 @@
> +# mach-virt - VirtIO guest (graphical console)
> +# =========================================================
> +#
> +# Usage:
> +#
> +#   $ qemu-system-aarch64 \
> +#     -nodefaults \
> +#     -readconfig mach-virt-graphical.cfg \
> +#     -cpu host
> +#
> +# You will probably need to tweak the lines marked as
> +# CHANGE ME before being able to use this configuration!
> +#
> +# The guest will have a selection of VirtIO devices
> +# tailored towards optimal performance with modern guests,
> +# and will be accessed through a graphical console.
> +#
> +# ---------------------------------------------------------
> +#
> +# Using -nodefaults is required to have full control over
> +# the virtual hardware: when it's specified, QEMU will
> +# populate the board with only the builtin peripherals,
> +# such as the PL011 UART, plus a PCI Express Root Bus; the
> +# user will then have to explicitly add further devices.
> +#
> +# The PCI Express Root Bus shows up in the guest as:
> +#
> +#   00:00.0 Host bridge
> +#
> +# This configuration file adds a number of other useful
> +# devices, more specifically:
> +#
> +#   00:01.0 Display controller
> +#   00.1c.* PCI bridge (PCI Express Root Ports)
> +#   01:00.0 SCSI storage controller
> +#   02:00.0 Ethernet controller
> +#   03:00.0 USB controller
> +#
> +# More information about these devices is available below.
> +
> +
> +# Machine options
> +# =========================================================
> +#
> +# We use the virt machine type and enable KVM acceleration
> +# for better performance.
> +#
> +# Using less than 1 GiB of memory is probably not going to
> +# yield good performance in the guest, and might even lead
> +# to obscure boot issues in some cases.
> +#
> +# Unfortunately, there is no way to configure the CPU model
> +# in this file, so it will have to be provided on the
> +# command line, but we can configure the guest to use the
> +# same GIC version as the host.
> +
> +[machine]
> +  type = "virt"
> +  accel = "kvm"
> +  gic-version = "host"
> +
> +[memory]
> +  size = "1024"
> +
> +
> +# Firmware configuration
> +# =========================================================
> +#
> +# There are two parts to the firmware: a read-only image
> +# containing the executable code, which is shared between
> +# guests, and a read/write variable store that is owned
> +# by one specific guest, exclusively, and is used to
> +# record information such as the UEFI boot order.
> +#
> +# For any new guest, its permanent, private variable store
> +# should initially be copied from the template file
> +# provided along with the firmware binary.
> +#
> +# Depending on the OS distribution you're using on the
> +# host, the name of the package containing the firmware
> +# binary and variable store template, as well as the paths
> +# to the files themselves, will be different. For example:
> +#
> +# Fedora
> +#   edk2-aarch64                                      (pkg)
> +#   /usr/share/edk2/aarch64/QEMU_EFI-pflash.raw       (bin)
> +#   /usr/share/edk2/aarch64/vars-template-pflash.raw  (var)
> +#
> +# RHEL
> +#   AAVMF                                             (pkg)
> +#   /usr/share/AAVMF/AAVMF_CODE.fd                    (bin)
> +#   /usr/share/AAVMF/AAVMF_VARS.fd                    (var)
> +#
> +# Debian/Ubuntu
> +#   qemu-efi                                          (pkg)
> +#   /usr/share/AAVMF/AAVMF_CODE.fd                    (bin)
> +#   /usr/share/AAVMF/AAVMF_VARS.fd                    (var)
> +
> +[drive "uefi-binary"]
> +  file = "/usr/share/AAVMF/AAVMF_CODE.fd"       # CHANGE ME
> +  format = "raw"
> +  if = "pflash"
> +  unit = "0"
> +  readonly = "on"
> +
> +[drive "uefi-varstore"]
> +  file = "guest_VARS.fd"                        # CHANGE ME
> +  format = "raw"
> +  if = "pflash"
> +  unit = "1"
> +
> +
> +# PCI bridge (PCI Express Root Ports)
> +# =========================================================
> +#
> +# We create eight PCI Express Root Ports, and we plug them
> +# all into separate functions of the same slot. Some of
> +# them will be used by devices, the rest will remain
> +# available for hotplug.
> +
> +[device "pcie.1"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.0"
> +  port = "1"
> +  chassis = "1"
> +  multifunction = "on"
> +
> +[device "pcie.2"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.1"
> +  port = "2"
> +  chassis = "2"
> +
> +[device "pcie.3"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.2"
> +  port = "3"
> +  chassis = "3"
> +
> +[device "pcie.4"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.3"
> +  port = "4"
> +  chassis = "4"
> +
> +[device "pcie.5"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.4"
> +  port = "5"
> +  chassis = "5"
> +
> +[device "pcie.6"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.5"
> +  port = "6"
> +  chassis = "6"
> +
> +[device "pcie.7"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.6"
> +  port = "7"
> +  chassis = "7"
> +
> +[device "pcie.8"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.7"
> +  port = "8"
> +  chassis = "8"
> +
> +
> +# SCSI storage controller (and storage)
> +# =========================================================
> +#
> +# We use virtio-scsi here so that we can (hot)plug a large
> +# number of disks without running into issues; a SCSI disk,
> +# backed by a qcow2 disk image on the host's filesystem, is
> +# attached to it.
> +#
> +# We also create an optical disk, mostly for installation
> +# purposes: once the guest OS has been succesfully
> +# installed, the guest will no longer boot from optical
> +# media. If you don't want, or no longer want, to have an
> +# optical disk in the guest you can safely comment out
> +# all relevant sections below.
> +
> +[device "scsi"]
> +  driver = "virtio-scsi-pci"
> +  bus = "pcie.1"
> +  addr = "00.0"
> +
> +[device "scsi-disk"]
> +  driver = "scsi-hd"
> +  bus = "scsi.0"
> +  drive = "disk"
> +  bootindex = "1"
> +
> +[drive "disk"]
> +  file = "guest.qcow2"                          # CHANGE ME
> +  format = "qcow2"
> +  if = "none"
> +
> +[device "scsi-optical-disk"]
> +  driver = "scsi-cd"
> +  bus = "scsi.0"
> +  drive = "optical-disk"
> +  bootindex = "2"
> +
> +[drive "optical-disk"]
> +  file = "install.iso"                          # CHANGE ME
> +  format = "raw"
> +  if = "none"
> +
> +
> +# Ethernet controller
> +# =========================================================
> +#
> +# We use virtio-net for improved performance over emulated
> +# hardware; on the host side, we take advantage of user
> +# networking so that the QEMU process doesn't require any
> +# additional privileges.
> +
> +[netdev "hostnet"]
> +  type = "user"
> +
> +[device "net"]
> +  driver = "virtio-net-pci"
> +  netdev = "hostnet"
> +  bus = "pcie.2"
> +  addr = "00.0"
> +
> +
> +# USB controller (and input devices)
> +# =========================================================
> +#
> +# We add a virtualization-friendly USB 3.0 controller and
> +# a USB keyboard / USB tablet combo so that graphical
> +# guests can be controlled appropriately.
> +
> +[device "usb"]
> +  driver = "nec-usb-xhci"
> +  bus = "pcie.3"
> +  addr = "00.0"
> +
> +[device "keyboard"]
> +  driver = "usb-kbd"
> +  bus = "usb.0"
> +
> +[device "tablet"]
> +  driver = "usb-tablet"
> +  bus = "usb.0"
> +
> +
> +# Display controller
> +# =========================================================
> +#
> +# We use virtio-gpu because the legacy VGA framebuffer is
> +# very troublesome on aarch64, and virtio-gpu is the only
> +# video device that doesn't implement it.
> +#
> +# If you're running the guest on a remote, potentially
> +# headless host, you will probably want to append something
> +# like
> +#
> +#   -display vnc=127.0.0.1:0
> +#
> +# to the command line in order to prevent QEMU from
> +# creating a graphical display window on the host and
> +# enable remote access instead.
> +
> +[device "video"]
> +  driver = "virtio-gpu"
> +  bus = "pcie.0"
> +  addr = "01.0"
> diff --git a/docs/mach-virt-serial.cfg b/docs/mach-virt-serial.cfg
> new file mode 100644
> index 0000000..aee9f1c
> --- /dev/null
> +++ b/docs/mach-virt-serial.cfg
> @@ -0,0 +1,243 @@
> +# mach-virt - VirtIO guest (serial console)
> +# =========================================================
> +#
> +# Usage:
> +#
> +#   $ qemu-system-aarch64 \
> +#     -nodefaults \
> +#     -readconfig mach-virt-serial.cfg \
> +#     -display none -serial mon:stdio \
> +#     -cpu host
> +#
> +# You will probably need to tweak the lines marked as
> +# CHANGE ME before being able to use this configuration!
> +#
> +# The guest will have a selection of VirtIO devices
> +# tailored towards optimal performance with modern guests,
> +# and will be accessed through the serial console.
> +#
> +# ---------------------------------------------------------
> +#
> +# Using -nodefaults is required to have full control over
> +# the virtual hardware: when it's specified, QEMU will
> +# populate the board with only the builtin peripherals,
> +# such as the PL011 UART, plus a PCI Express Root Bus; the
> +# user will then have to explicitly add further devices.
> +#
> +# The PCI Express Root Bus shows up in the guest as:
> +#
> +#   00:00.0 Host bridge
> +#
> +# This configuration file adds a number of other useful
> +# devices, more specifically:
> +#
> +#   00.1c.* PCI bridge (PCI Express Root Ports)
> +#   01:00.0 SCSI storage controller
> +#   02:00.0 Ethernet controller
> +#
> +# More information about these devices is available below.
> +#
> +# We use '-display none' to prevent QEMU from creating a
> +# graphical display window, which would serve no use in
> +# this specific configuration, and '-serial mon:stdio' to
> +# multiplex the guest's serial console and the QEMU monitor
> +# to the host's stdio; use 'Ctrl+A h' to learn how to
> +# switch between the two and more.
> +
> +
> +# Machine options
> +# =========================================================
> +#
> +# We use the virt machine type and enable KVM acceleration
> +# for better performance.
> +#
> +# Using less than 1 GiB of memory is probably not going to
> +# yield good performance in the guest, and might even lead
> +# to obscure boot issues in some cases.
> +#
> +# Unfortunately, there is no way to configure the CPU model
> +# in this file, so it will have to be provided on the
> +# command line, but we can configure the guest to use the
> +# same GIC version as the host.
> +
> +[machine]
> +  type = "virt"
> +  accel = "kvm"
> +  gic-version = "host"
> +
> +[memory]
> +  size = "1024"
> +
> +
> +# Firmware configuration
> +# =========================================================
> +#
> +# There are two parts to the firmware: a read-only image
> +# containing the executable code, which is shared between
> +# guests, and a read/write variable store that is owned
> +# by one specific guest, exclusively, and is used to
> +# record information such as the UEFI boot order.
> +#
> +# For any new guest, its permanent, private variable store
> +# should initially be copied from the template file
> +# provided along with the firmware binary.
> +#
> +# Depending on the OS distribution you're using on the
> +# host, the name of the package containing the firmware
> +# binary and variable store template, as well as the paths
> +# to the files themselves, will be different. For example:
> +#
> +# Fedora
> +#   edk2-aarch64                                      (pkg)
> +#   /usr/share/edk2/aarch64/QEMU_EFI-pflash.raw       (bin)
> +#   /usr/share/edk2/aarch64/vars-template-pflash.raw  (var)
> +#
> +# RHEL
> +#   AAVMF                                             (pkg)
> +#   /usr/share/AAVMF/AAVMF_CODE.fd                    (bin)
> +#   /usr/share/AAVMF/AAVMF_VARS.fd                    (var)
> +#
> +# Debian/Ubuntu
> +#   qemu-efi                                          (pkg)
> +#   /usr/share/AAVMF/AAVMF_CODE.fd                    (bin)
> +#   /usr/share/AAVMF/AAVMF_VARS.fd                    (var)
> +
> +[drive "uefi-binary"]
> +  file = "/usr/share/AAVMF/AAVMF_CODE.fd"       # CHANGE ME
> +  format = "raw"
> +  if = "pflash"
> +  unit = "0"
> +  readonly = "on"
> +
> +[drive "uefi-varstore"]
> +  file = "guest_VARS.fd"                        # CHANGE ME
> +  format = "raw"
> +  if = "pflash"
> +  unit = "1"
> +
> +
> +# PCI bridge (PCI Express Root Ports)
> +# =========================================================
> +#
> +# We create eight PCI Express Root Ports, and we plug them
> +# all into separate functions of the same slot. Some of
> +# them will be used by devices, the rest will remain
> +# available for hotplug.
> +
> +[device "pcie.1"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.0"
> +  port = "1"
> +  chassis = "1"
> +  multifunction = "on"
> +
> +[device "pcie.2"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.1"
> +  port = "2"
> +  chassis = "2"
> +
> +[device "pcie.3"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.2"
> +  port = "3"
> +  chassis = "3"
> +
> +[device "pcie.4"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.3"
> +  port = "4"
> +  chassis = "4"
> +
> +[device "pcie.5"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.4"
> +  port = "5"
> +  chassis = "5"
> +
> +[device "pcie.6"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.5"
> +  port = "6"
> +  chassis = "6"
> +
> +[device "pcie.7"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.6"
> +  port = "7"
> +  chassis = "7"
> +
> +[device "pcie.8"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.7"
> +  port = "8"
> +  chassis = "8"
> +
> +
> +# SCSI storage controller (and storage)
> +# =========================================================
> +#
> +# We use virtio-scsi here so that we can (hot)plug a large
> +# number of disks without running into issues; a SCSI disk,
> +# backed by a qcow2 disk image on the host's filesystem, is
> +# attached to it.
> +#
> +# We also create an optical disk, mostly for installation
> +# purposes: once the guest OS has been succesfully
> +# installed, the guest will no longer boot from optical
> +# media. If you don't want, or no longer want, to have an
> +# optical disk in the guest you can safely comment out
> +# all relevant sections below.
> +
> +[device "scsi"]
> +  driver = "virtio-scsi-pci"
> +  bus = "pcie.1"
> +  addr = "00.0"
> +
> +[device "scsi-disk"]
> +  driver = "scsi-hd"
> +  bus = "scsi.0"
> +  drive = "disk"
> +  bootindex = "1"
> +
> +[drive "disk"]
> +  file = "guest.qcow2"                          # CHANGE ME
> +  format = "qcow2"
> +  if = "none"
> +
> +[device "scsi-optical-disk"]
> +  driver = "scsi-cd"
> +  bus = "scsi.0"
> +  drive = "optical-disk"
> +  bootindex = "2"
> +
> +[drive "optical-disk"]
> +  file = "install.iso"                          # CHANGE ME
> +  format = "raw"
> +  if = "none"
> +
> +
> +# Ethernet controller
> +# =========================================================
> +#
> +# We use virtio-net for improved performance over emulated
> +# hardware; on the host side, we take advantage of user
> +# networking so that the QEMU process doesn't require any
> +# additional privileges.
> +
> +[netdev "hostnet"]
> +  type = "user"
> +
> +[device "net"]
> +  driver = "virtio-net-pci"
> +  netdev = "hostnet"
> +  bus = "pcie.2"
> +  addr = "00.0"
> -- 
> 2.7.4
> 
> 
