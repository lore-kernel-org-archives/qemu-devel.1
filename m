Received: from eggs.gnu.org ([2001:4830:134:3::10]:56336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cc9br-0003Gv-O7
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cc9bo-0004e9-Hi
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:43:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cc9bo-0004ds-8Z
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:43:24 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F5723A7691
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 11:43:24 +0000 (UTC)
References: <1486722439-12033-1-git-send-email-abologna@redhat.com>
	<1486723086-12247-1-git-send-email-abologna@redhat.com>
	<1486723086-12247-2-git-send-email-abologna@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d039b4d9-4c9a-ed49-dd36-304b290a013b@redhat.com>
Date: Fri, 10 Feb 2017 12:43:20 +0100
MIME-Version: 1.0
In-Reply-To: <1486723086-12247-2-git-send-email-abologna@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, kraxel@redhat.com

On 02/10/17 11:38, Andrea Bolognani wrote:
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
>  docs/mach-virt-graphical.cfg | 262 +++++++++++++++++++++++++++++++++++++++++++
>  docs/mach-virt-serial.cfg    | 224 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 486 insertions(+)
>  create mode 100644 docs/mach-virt-graphical.cfg
>  create mode 100644 docs/mach-virt-serial.cfg

This looks awesome. I have some easy comments. (I likely could have made
them earlier, but didn't have time/energy to read the patch in full. Sorry!)

> 
> diff --git a/docs/mach-virt-graphical.cfg b/docs/mach-virt-graphical.cfg
> new file mode 100644
> index 0000000..2dab3af
> --- /dev/null
> +++ b/docs/mach-virt-graphical.cfg
> @@ -0,0 +1,262 @@
> +# mach-virt - VirtIO guest (graphical console)
> +# =========================================================
> +#
> +# Usage:
> +#
> +#   $ qemu-system-aarch64 \
> +#     -nodefaults \
> +#     -readconfig mach-virt-graphical.cfg \
> +#     -cpu host

Clearly, for reviewing both files, I applied your patches, and then
diffed the two files created by this patch. :)

So, what speaks against adding "-serial mon:stdio" here too? Even with a
graphical guest, the monitor is useful. And, if you care about firmware
logs (who doesn't? ;)), seeing serial output is good. (Same applies to
the guest kernel -- sooner or later everyone enables serial output for
grub2 and kernel, for reporting bugs.)

Just my two cents, you're welcome to disagree.

> +#
> +# You will probably need to tweak the lines marked as
> +# CHANGE ME before being able to use this configuration!
> +#
> +# The guest will have a selection of VirtIO devices
> +# tailored towards optimal performance with modern guests,
> +# and will be accessed through a graphical console.

("will 'mainly' be accessed through a graphical console", if you agree
with the above)

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
> +[device "pci.1"]

I suggest to call these devices "pcie.x" (and update the references).

> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.0"
> +  port = "1"
> +  chassis = "1"
> +  multifunction = "on"
> +
> +[device "pci.2"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.1"
> +  port = "2"
> +  chassis = "2"
> +
> +[device "pci.3"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.2"
> +  port = "3"
> +  chassis = "3"
> +
> +[device "pci.4"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.3"
> +  port = "4"
> +  chassis = "4"
> +
> +[device "pci.5"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.4"
> +  port = "5"
> +  chassis = "5"
> +
> +[device "pci.6"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.5"
> +  port = "6"
> +  chassis = "6"
> +
> +[device "pci.7"]
> +  driver = "pcie-root-port"
> +  bus = "pcie.0"
> +  addr = "1c.6"
> +  port = "7"
> +  chassis = "7"
> +
> +[device "pci.8"]
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
> +
> +[device "scsi"]
> +  driver = "virtio-scsi-pci"
> +  bus = "pci.1"
> +  addr = "00.0"
> +
> +[device "scsi-disk"]
> +  driver = "scsi-hd"
> +  bus = "scsi.0"
> +  drive = "disk"
> +
> +[drive "disk"]
> +  file = "guest.qcow2"                          # CHANGE ME
> +  format = "qcow2"
> +  if = "none"

A number of suggestions. If you think they are beyond the scope of these
examples, or plain disagree, that's fine. :)

* please add a CD-ROM too (scsi-cd), and point its drive to some
installer ISO. (remember # CHANGE ME for the pathname)

* please spell out the "bootindex" property for both the disk and the
CD-ROM device. If you set booindex=1 for the disk and bootindex=2 for
the CD-ROM, then that configuration is permanently suitable for first
installing the guest from the ISO, then booting it all subsequent times
from the disk. ArmVirtQemu is king like that! ;)

* I'm a *huge* fan of saving disk space on the host. So, thin
provisioning FTW! Virtio-scsi is definitely a step in the right
direction, but for the disk drive, please add these wo properties:

  discard = "unmap"
  werror = "enospc"

The first property will release host filesystem blocks when the guest
runs "fstrim". The second option lets you over-provision the host
filesystem, and if a guest runs out of room mid-flight, it will be
paused. You can free up more disk space and unpause the guest then.

(There's also "detect-zeroes", but I've never tried that. I very vaguely
recall reading bad things about its CPU demand. I could be wrong, but I
certainly don't feel comfortable enough to actively recommend it.)

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
> +  bus = "pci.2"
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
> +  bus = "pci.3"
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
> +# to the command line in order to prevent QEMU from trying
> +# to display a GTK+ window on the host and enable remote
> +# access instead.

Haha, someone prefers GTK+ to SDL? :) Last time I checked the GTK+
window, it was painful. (It was a very long time ago.)

Maybe that's to blame on GTK+ *in RHEL-7* specifically, I'm uncertain.
But, I digress; no need to do anything about this.

> +
> +[device "video"]
> +  driver = "virtio-gpu"
> +  bus = "pcie.0"
> +  addr = "01.0"
> diff --git a/docs/mach-virt-serial.cfg b/docs/mach-virt-serial.cfg
> new file mode 100644
> index 0000000..4a9126a
> --- /dev/null
> +++ b/docs/mach-virt-serial.cfg

[snipping this, I diffed graphical & serial between each other]

Looks very nice.

Pick anything from the above that you like (or even pick nothing, that's
fine too):

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
