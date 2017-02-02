Received: from eggs.gnu.org ([2001:4830:134:3::10]:36978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZIbK-0004IO-3H
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZIbF-0000KD-4H
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:43:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cZIbE-0000Iv-Ra
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:43:01 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FA01804E4
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:43:00 +0000 (UTC)
References: <1485969640-8149-1-git-send-email-abologna@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <25c8a78b-1d81-2a62-61ac-722d22999c41@redhat.com>
Date: Thu, 2 Feb 2017 16:42:52 +0200
MIME-Version: 1.0
In-Reply-To: <1485969640-8149-1-git-send-email-abologna@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, drjones@redhat.com

On 02/01/2017 07:20 PM, Andrea Bolognani wrote:
> Instead of having a single sample configuration file,
> we now have several:
>
>   * q35-emulated.cfg documents the default devices QEMU
>     adds to a q35 guest and the additional devices that
>     are pretty much guaranteed to be present in a
>     physical q35-based machine;
>

Hi Andrea,



>   * q35-virtio-graphical.cfg can be used to start a
>     fully-featured (USB, graphical console, audio, etc.)
>     guest that uses VirtIO instead of emulated devices;
>
>   * q35-virtio-serial.cfg is similar but has a minimal
>     set of devices and uses the serial console.
>
> All configuration files are fully commented and neatly
> organized.

Appreciated.

> ---
> Changes since [v1]
>
>   * Address review comments:
>     - improve the existing configuration file instead
>       of removing it;
>     - split off the common part for VirtIO guests;
>     - plug all ioh3420 devices in a single slot;
>     - use slot 1c for ioh3420 devices;
>     - remove useless USB keyboard.
>
>   * Improve usage description:
>     - make sure the OS disk actually uses the VirtIO
>       SCSI controller, as intended, rather than the
>       built-in SATA one;
>     - provide a command line for running live CDs.
>
>   * Document more devices:
>     - the video card is added by default;
>     - so is the Ethernet adapter, apparently.
>
> The last part seems to clash with some of Gerd's comments,
> so I'm kinda puzzled.
>
>
> [v1] http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg06342.html
>
>

[...]

> +
> +# Machine options
> +# =========================================================
> +#
> +# We use the q35 machine type and enable KVM acceleration
> +# for better performance.
> +
> +[machine]
> +  type = "q35"
> +  accel = "kvm"
> +
> +
> +# PCI Express controllers
> +# =========================================================
> +#
> +# We add four PCIe Root Ports, all sharing the same slot
> +# on the PCIe Root Bus. These ports support hotplug.
> +
> +[device "ich9-pcie-port-1"]

I would use the new generic root port.

> +  driver = "ioh3420"
> +  multifunction = "on"
> +  bus = "pcie.0"
> +  addr = "1c.0"
> +  port = "1"
> +  chassis = "1"
> +
> +[device "ich9-pcie-port-2"]
> +  driver = "ioh3420"
> +  multifunction = "on"
> +  bus = "pcie.0"
> +  addr = "1c.1"
> +  port = "2"
> +  chassis = "2"
> +
> +[device "ich9-pcie-port-3"]
> +  driver = "ioh3420"
> +  multifunction = "on"
> +  bus = "pcie.0"
> +  addr = "1c.2"
> +  port = "3"
> +  chassis = "3"
> +
> +[device "ich9-pcie-port-4"]
> +  driver = "ioh3420"
> +  multifunction = "on"
> +  bus = "pcie.0"
> +  addr = "1c.3"
> +  port = "4"
> +  chassis = "4"
> +
> +
> +# Legacy PCI controllers
> +# =========================================================
> +#
> +# This bridge can be used to build an independent topology
> +# for legacy PCI devices.
> +
> +[device "ich9-pci-bridge"]
> +  driver = "i82801b11-bridge"
> +  bus = "pcie.0"
> +  addr = "1e.0"
> +

I am not sure about having the DMI-PCI bridge "by default".
Users can understand is actually a good idea to have it by default
while we don't really want them to use legacy PCI devices on Q35;
and even if so, they should use them as Integrated Endpoints.
They don't have hotplug for the DMI-PCI bridge anyway.

[...]

> --- /dev/null
> +++ b/docs/q35-virtio-common.cfg
> @@ -0,0 +1,82 @@
> +# q35 - VirtIO guest (common bits)
> +# =========================================================
> +#
> +# Not very useful on its own. See q35-virtio-graphical.cfg
> +# and q35-virtio-serial.cfg for usage instructions.
> +
> +
> +# Machine options
> +# =========================================================
> +#
> +# We use the q35 machine type and enable KVM acceleration
> +# for better performance.
> +
> +[machine]
> +  type = "q35"
> +  accel = "kvm"
> +
> +
> +# PCIe controllers
> +# =========================================================
> +#
> +# We create eight PCIe Root Ports, and we plug them all
> +# into separate functions of the same slot. Some of them
> +# will be used by devices, the rest will remain available
> +# for hotplug.
> +
> +[device "pci.1"]
> +  driver = "ioh3420"

Same here, maybe we can use the new generic port.

Thanks for taking your time to update the configuration files!
Marcel


I personally don't use them because every time I try, I
find something with no config support....


> +  bus = "pcie.0"
> +  addr = "0x1c.0x0"
> +  port = "0x10"
> +  chassis = "1"
> +  multifunction = "on"
> +
> +[device "pci.2"]
> +  driver = "ioh3420"
> +  bus = "pcie.0"
> +  addr = "0x1c.0x1"
> +  port = "0x11"
> +  chassis = "2"
> +
> +[device "pci.3"]
> +  driver = "ioh3420"
> +  bus = "pcie.0"
> +  addr = "0x1c.0x2"
> +  port = "0x12"
> +  chassis = "3"
> +
> +[device "pci.4"]
> +  driver = "ioh3420"
> +  bus = "pcie.0"
> +  addr = "0x1c.0x3"
> +  port = "0x13"
> +  chassis = "4"
> +
> +[device "pci.5"]
> +  driver = "ioh3420"
> +  bus = "pcie.0"
> +  addr = "0x1c.0x4"
> +  port = "0x14"
> +  chassis = "5"
> +
> +[device "pci.6"]
> +  driver = "ioh3420"
> +  bus = "pcie.0"
> +  addr = "0x1c.0x5"
> +  port = "0x15"
> +  chassis = "6"
> +
> +[device "pci.7"]
> +  driver = "ioh3420"
> +  bus = "pcie.0"
> +  addr = "0x1c.0x6"
> +  port = "0x16"
> +  chassis = "7"
> +
> +[device "pci.8"]
> +  driver = "ioh3420"
> +  bus = "pcie.0"
> +  addr = "0x1c.0x7"
> +  port = "0x17"
> +  chassis = "8"

[...]
