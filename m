Received: from eggs.gnu.org ([2001:4830:134:3::10]:41733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fY9Vc-0004Du-2o
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fY9VY-0001Pe-Sr
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:25:16 -0400
Received: from mail-vi1eur04hn032c.outbound.protection.outlook.com
	([2a01:111:f400:fe0e::32c]:22669
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fY9VX-0001Li-V3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:25:12 -0400
Date: Wed, 27 Jun 2018 15:24:58 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180627122457.GA19714@rkaganb.sw.ru>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627034935.20276-1-venu.busireddy@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Use of unique identifier for
 pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Tue, Jun 26, 2018 at 10:49:30PM -0500, Venu Busireddy wrote:
> The patch set "Enable virtio_net to act as a standby for a passthru
> device" [1] deals with live migration of guests that use passthrough
> devices. However, that scheme uses the MAC address for pairing
> the virtio device and the passthrough device. The thread "netvsc:
> refactor notifier/event handling code to use the failover framework"
> [2] discusses an alternate mechanism, such as using an UUID, for pairing
> the devices. Based on that discussion, proposals "Add "Group Identifier"
> to virtio PCI capabilities." [3] and "RFC: Use of bridge devices to
> store pairing information..." [4] were made.

I must have missed something in those threads, but where does this UUID
thing come about?  AFAICS this identifier doesn't need to be
"universally" unique, nor persistent; it only has to be unique across
the VM and stable throughout the VM lifetime.

FWIW Hyper-V uses a 32-bit integer for this purpose, not a UUID as seems
to be implied in the thread you refer to.

> The current patch set includes all the feedback received for proposals [3]
> and [4]. For the sake of completeness, patch for the virtio specification
> is also included here. Following is the updated proposal.
> 
> 1. Extend the virtio specification to include a new virtio PCI capability
>    "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> 
> 2. Enhance the QEMU CLI to include a "uuid" option to the virtio device.
>    The "uuid" is a string in UUID format.
> 
> 3. Enhance the QEMU CLI to include a "uuid" option to the bridge device.
>    The "uuid" is a string in UUID format. Currently, PCIe bridge for
>    the Q35 model is supported.
> 
> 4. The operator creates a unique identifier string using 'uuidgen'.
> 
> 5. When the virtio device is created, the operator uses the "uuid" option
>    (for example, '-device virtio-net-pci,uuid="string"') and specifies
>    the UUID created in step 4.
> 
>    QEMU stores the UUID in the virtio device's configuration space
>    in the capability "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> 
> 6. When assigning a PCI device to the guest in passthrough mode, the
>    operator first creates a bridge using the "uuid" option (for example,
>    '-device pcie-downstream,uuid="string"') to specify the UUID created
>    in step 4, and then attaches the passthrough device to the bridge.
> 
>    QEMU stores the UUID in the configuration space of the bridge as
>    Vendor-Specific capability (0x09). The "Vendor" here is not to be
>    confused with a specific organization. Instead, the vendor of the
>    bridge is QEMU. To avoid mixing up with other bridges, the bridge
>    will be created with vendor ID 0x1b36 (PCI_VENDOR_ID_REDHAT) and
>    device ID 0x000e (PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE) if the "uuid"
>    option is specified. Otherwise, current defaults are used.

I wonder if it makes more sense to drop the concept of failover groups,
and just refer to the standby device by device-id, like 

  -device virtio-net-pci,id=foo \
  -device pcie-downstream,failover=foo

The bridge device will then lookup the failover device, figure out the
common identifier to expose to the guest, and defer the visibility of
the PT device behind the bridge until the guest acknowledged the support
for failover on the PV device.

Roman.
