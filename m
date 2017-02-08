Received: from eggs.gnu.org ([2001:4830:134:3::10]:59591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbX3G-0006cd-RL
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbX3F-0005BA-K6
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:33:10 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbX3F-0005Az-Db
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:33:09 -0500
Received: by mail-wr0-x22d.google.com with SMTP id k90so65505175wrc.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 10:33:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486575331-14455-3-git-send-email-abologna@redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Feb 2017 18:32:47 +0000
Message-ID: <CAFEAcA8+wfPQXXhoYZDv8LAOS6=4_P9kyaHONuMQcb7VmkVyxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Andrew Jones <drjones@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 8 February 2017 at 17:35, Andrea Bolognani <abologna@redhat.com> wrote:
> These are very much like the sample configuration files
> for q35, and can be used both as documentation and as
> a starting point for creating your own guest.

> --- /dev/null
> +++ b/docs/mach-virt-graphical.cfg
> @@ -0,0 +1,245 @@
> +# mach-virt - VirtIO guest (graphical console)
> +# =========================================================
> +#
> +# You will probably need to tweak the lines marked as
> +# CHANGE ME before being able to use this configuration!
> +#
> +# Usage:
> +#
> +#   $ qemu-system-aarch64 \
> +#     -nodefaults \
> +#     -readconfig mach-virt-graphical.cfg \
> +#     -cpu host

What does nodefaults disable on the virt board?
(I've never looked into exactly what nodefaults does...)

There doesn't seem to be any specification of the GIC
version (unless I missed it in the config file); you
probably want -machine gic-version=host if you're using
-cpu host.

> +# Using -nodefaults is required to have full control over
> +# the virtual hardware: when it's specified, QEMU will
> +# create a bare machine with just the very essential
> +# chipset devices being present:

The theory of 'virt' is it only has the essential
devices anyway.

> +#   00:00.0 Host bridge

I'm pretty sure -nodefaults isn't going to disable
the GIC, the UART, the flash devices, etc etc that
the virt board has. Not everything in the world is
a PCI device :-)

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

> +# Firmware configuration
> +# =========================================================
> +#
> +# There are two parts to the firmware: a read-only image
> +# containing the executable code, which is shared between
> +# guests, and a read/write variable store that is used by
> +# to record information such as the boot device. An empty
> +# variable store can be created by simply copying a
> +# template provided as part of AAVMF.
> +#
> +# Depending on the distribution you're using on the host,
> +# paths to the firmware itself and variable store template
> +# will be different. Some examples:
> +#
> +# Fedora:
> +#   /usr/share/edk2/aarch64/QEMU_EFI.fd
> +#   /usr/share/edk2/aarch64/QEMU_VARS.fd
> +# RHEL:
> +#   /usr/share/AAVMF/AAVMF_CODE.fd
> +#   /usr/share/AAVMF/AAVMF_VARS.fd

It's a shame that we've ended up with different
firmware names (even between RHEL and Fedora, without
getting to Debian or SUSE). Would making UEFI a
more "official" rom image in pc-bios/ help to
harmonise things, or just introduce yet another
possibility to the mix?

> +# Communication controller (serial console)
> +# =========================================================
> +#
> +# We use virtconsole along with virtio-serial, and connect
> +# it with the host's standard input / output channels. In
> +# this configuration, the guest will behave pretty much
> +# like any other Unix utility: that includes terminating
> +# as soon as Ctrl-C is pressed, so caution is advised.
> +#
> +# If you want to use the platform's native serial console
> +# instead, you should comment out this section and append
> +#
> +#   -serial stdio
> +#
> +# to the QEMU command line. Doing so might be needed to be
> +# able to access the GRUB menu or see the output from the
> +# boot process.
> +
> +[chardev "hostconsole"]
> +  backend = "stdio"
> +
> +[device "serial"]
> +  driver = "virtio-serial-pci"
> +  bus = "pci.3"
> +  addr = "00.0"
> +
> +[device "console"]
> +  driver = "virtconsole"
> +  chardev = "hostconsole"

Won't most guests expect serial to be the default
PL011 UART ?

thanks
-- PMM
