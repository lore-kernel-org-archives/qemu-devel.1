Received: from eggs.gnu.org ([209.51.188.92]:58025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hBxtr-0006xf-85
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hBxtp-0001tX-CY
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:39:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hBxto-0001lK-91
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:39:05 -0400
Date: Thu, 4 Apr 2019 10:29:33 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
References: <20190322134447.14831-1-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190322134447.14831-1-jfreimann@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] implement the failover feature for
 assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pkrempa@redhat.com, ehabkost@redhat.com, mst@redhat.com, mdroth@linux.vnet.ibm.com, liran.alon@oracle.com, laine@redhat.com, ogerlitz@mellanox.com, ailan@redhat.com, dgilbert@redhat.com

ping 

FYI: I'm also working on a few related tools to detect driver behaviour when
assigning a MAC to the vf device. Code is at https://github.com/jensfr/netfailover_driver_detect

regards,
Jens 

On Fri, Mar 22, 2019 at 02:44:45PM +0100, Jens Freimann wrote:
>This is another attempt at implementing the host side of the
>net_failover concept
>(https://www.kernel.org/doc/html/latest/networking/net_failover.html)
>
>The general idea is that we have a pair of devices, a vfio-pci and a
>emulated device. Before migration the vfio device is unplugged and data
>flows to the emulated device, on the target side another vfio-pci device
>is plugged in to take over the data-path. In the guest the net_failover
>module will pair net devices with the same MAC address.
>
>* In the first patch the infrastructure for hiding the device is added
>  for the qbus and qdev APIs. A "hidden" boolean is added to the device
>  state and it is set based on a callback to the standby device which
>  registers itself for handling the assessment: "should the primary device
>  be hidden?" by cross validating the ids of the devices.
>
>* In the second patch the virtio-net uses the API to hide the vfio
>  device and unhides it when the feature is acked.
>
>Previous discussion: https://patchwork.ozlabs.org/cover/989098/
>
>To summarize concerns/feedback from previous discussion:
>1.- guest OS can reject or worse _delay_ unplug by any amount of time.
>  Migration might get stuck for unpredictable time with unclear reason.
>  This approach combines two tricky things, hot/unplug and migration.
>  -> We can surprise-remove the PCI device and in QEMU we can do all
>     necessary rollbacks transparent to management software. Will it be
>     easy, probably not.
>2. PCI devices are a precious ressource. The primary device should never
>  be added to QEMU if it won't be used by guest instead of hiding it in
>  QEMU.
>  -> We only hotplug the device when the standby feature bit was
>     negotiated. We save the device cmdline options until we need it for
>     qdev_device_add()
>     Hiding a device can be a useful concept to model. For example a
>     pci device in a powered-off slot could be marked as hidden until the slot is
>     powered on (mst).
>3. Management layer software should handle this. Open Stack already has
>  components/code to handle unplug/replug VFIO devices and metadata to
>  provide to the guest for detecting which devices should be paired.
>  -> An approach that includes all software from firmware to
>     higher-level management software wasn't tried in the last years. This is
>     an attempt to keep it simple and contained in QEMU as much as possible.
>4. Hotplugging a device and then making it part of a failover setup is
>   not possible
>  -> addressed by extending qdev hotplug functions to check for hidden
>     attribute, so e.g. device_add can be used to plug a device.
>
>There are still some open issues:
>
>Migration: I'm looking for something like a pre-migration hook that I
>could use to unplug the vfio-pci device. I tried with a migration
>notifier but it is called to late, i.e. after migration is aborted due
>to vfio-pci marked unmigrateable. I worked around this by setting it
>to migrateable and used a migration notifier on the virtio-net device.
>
>Commandline: There is a dependency between vfio-pci and virtio-net
>devices. One points to the other via new parameters
>primar=<primary qdev id> and standby='<standby qdev id>'. This means
>that the primary device needs to be specified after standby device on
>the qemu command line. Not sure how to solve this.
>
>Error handling: Patches don't cover all possible error scenarios yet.
>
>I have tested this with a mlx5 NIC and was able to migrate the VM with
>above mentioned workarounds for open problems.
>
>Command line example:
>
>qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
>        -machine q35,kernel-irqchip=split -cpu host   \
>        -k fr   \
>        -serial stdio   \
>        -net none \
>        -qmp unix:/tmp/qmp.socket,server,nowait \
>        -monitor telnet:127.0.0.1:5555,server,nowait \
>        -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
>        -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
>        -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
>        -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
>        -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,primary=hostdev0 \
>        -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1 \
>        /root/rhel-guest-image-8.0-1781.x86_64.qcow2
>
>I'm grateful for any remarks or ideas!
>
>Thanks!
>
>regards,
>Jens
>
>Sameeh Jubran (2):
>  qdev/qbus: Add hidden device support
>  net/virtio: add failover support
>
> hw/core/qdev.c                 | 27 ++++++++++
> hw/net/virtio-net.c            | 95 ++++++++++++++++++++++++++++++++++
> hw/pci/pci.c                   |  1 +
> include/hw/pci/pci.h           |  2 +
> include/hw/qdev-core.h         |  8 +++
> include/hw/virtio/virtio-net.h |  7 +++
> qdev-monitor.c                 | 48 +++++++++++++++--
> vl.c                           |  7 ++-
> 8 files changed, 189 insertions(+), 6 deletions(-)
>
>-- 
>2.20.1
>
>
