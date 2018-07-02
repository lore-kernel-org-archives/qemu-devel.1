Received: from eggs.gnu.org ([2001:4830:134:3::10]:40960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa1T8-0000z1-Sn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa1T4-0001ga-Pz
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:14:26 -0400
Received: from mail-db3eur04hn0205.outbound.protection.outlook.com
	([104.47.12.205]:24047
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fa1T4-0001fx-8O
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:14:22 -0400
Date: Mon, 2 Jul 2018 19:14:05 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180702161404.GA2339@rkaganb.sw.ru>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629221907.3662-1-venu.busireddy@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Use of unique identifier for
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

On Fri, Jun 29, 2018 at 05:19:03PM -0500, Venu Busireddy wrote:
> The patch set "Enable virtio_net to act as a standby for a passthru
> device" [1] deals with live migration of guests that use passthrough
> devices. However, that scheme uses the MAC address for pairing
> the virtio device and the passthrough device. The thread "netvsc:
> refactor notifier/event handling code to use the failover framework"
> [2] discusses an alternate mechanism, such as using an UUID, for pairing
> the devices. Based on that discussion, proposals "Add "Group Identifier"
> to virtio PCI capabilities." [3] and "RFC: Use of bridge devices to
> store pairing information..." [4] were made.
> 
> The current patch set includes all the feedback received for proposals [3]
> and [4]. For the sake of completeness, patch for the virtio specification
> is also included here. Following is the updated proposal.
> 
> 1. Extend the virtio specification to include a new virtio PCI capability
>    "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> 
> 2. Enhance the QEMU CLI to include a "failover-group-id" option to the
>    virtio device. The "failover-group-id" is a 64 bit value.
> 
> 3. Enhance the QEMU CLI to include a "failover-group-id" option to the
>    Red Hat PCI bridge device (support for the i440FX model).
> 
> 4. Add a new "pcie-downstream" device, with the option
>    "failover-group-id" (support for the Q35 model).
> 
> 5. The operator creates a 64 bit unique identifier, failover-group-id.
> 
> 6. When the virtio device is created, the operator uses the
>    "failover-group-id" option (for example, '-device
>    virtio-net-pci,failover-group-id=<identifier>') and specifies the
>    failover-group-id created in step 4.
> 
>    QEMU stores the failover-group-id in the virtio device's configuration
>    space in the capability "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> 
> 7. When assigning a PCI device to the guest in passthrough mode, the
>    operator first creates a bridge using the "failover-group-id" option
>    (for example, '-device pcie-downstream,failover-group-id=<identifier>')
>    to specify the failover-group-id created in step 4, and then attaches
>    the passthrough device to the bridge.
> 
>    QEMU stores the failover-group-id in the configuration space of the
>    bridge as Vendor-Specific capability (0x09). The "Vendor" here is
>    not to be confused with a specific organization. Instead, the vendor
>    of the bridge is QEMU.
> 
> 8. Patch 4 in patch series "Enable virtio_net to act as a standby for
>    a passthru device" [1] needs to be modified to use the UUID values
>    present in the bridge's configuration space and the virtio device's
>    configuration space instead of the MAC address for pairing the devices.

I'm still missing a few bits in the overall scheme.

Is the guest supposed to acknowledge the support for PT-PV failover?

Should the PT device be visibile to the guest before it acknowledges the
support for failover?  How is this supposed to work with legacy guests
that don't support it?

Is the guest supposed to signal the datapath switch to the host?

Is the scheme going to be applied/extended to other transports (vmbus,
virtio-ccw, etc.)?

Is the failover group concept going to be used beyond PT-PV network
device failover?

Thanks,
Roman.
