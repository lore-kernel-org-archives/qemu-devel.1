Received: from eggs.gnu.org ([2001:4830:134:3::10]:43916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fYNb4-0004GD-J9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fYNaz-0004JP-KI
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:27:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fYNaz-0004Hn-8x
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:27:45 -0400
Date: Wed, 27 Jun 2018 22:27:33 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180628032733.GA32239@troi>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
	<20180627122457.GA19714@rkaganb.sw.ru>
	<20180627192958.GA17236@vbusired-vm>
	<20180627224418-mutt-send-email-mst@kernel.org>
	<20180627195901.GA11772@vbusired-vm>
	<20180627230536-mutt-send-email-mst@kernel.org>
	<20180627223417.GA17004@vbusired-vm>
	<20180628045305-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628045305-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 2018-06-28 04:54:16 +0300, Michael S. Tsirkin wrote:
> On Wed, Jun 27, 2018 at 05:34:17PM -0500, Venu Busireddy wrote:
> > On 2018-06-27 23:12:12 +0300, Michael S. Tsirkin wrote:
> > > On Wed, Jun 27, 2018 at 02:59:01PM -0500, Venu Busireddy wrote:
> > > > On 2018-06-27 22:47:05 +0300, Michael S. Tsirkin wrote:
> > > > > On Wed, Jun 27, 2018 at 02:29:58PM -0500, Venu Busireddy wrote:
> > > > > > On 2018-06-27 15:24:58 +0300, Roman Kagan wrote:
> > > > > > > On Tue, Jun 26, 2018 at 10:49:30PM -0500, Venu Busireddy wrote:
> > > > > > > > The patch set "Enable virtio_net to act as a standby for a passthru
> > > > > > > > device" [1] deals with live migration of guests that use passthrough
> > > > > > > > devices. However, that scheme uses the MAC address for pairing
> > > > > > > > the virtio device and the passthrough device. The thread "netvsc:
> > > > > > > > refactor notifier/event handling code to use the failover framework"
> > > > > > > > [2] discusses an alternate mechanism, such as using an UUID, for pairing
> > > > > > > > the devices. Based on that discussion, proposals "Add "Group Identifier"
> > > > > > > > to virtio PCI capabilities." [3] and "RFC: Use of bridge devices to
> > > > > > > > store pairing information..." [4] were made.
> > > > > > > 
> > > > > > > I must have missed something in those threads, but where does this UUID
> > > > > > > thing come about?  AFAICS this identifier doesn't need to be
> > > > > > > "universally" unique, nor persistent; it only has to be unique across
> > > > > > > the VM and stable throughout the VM lifetime.
> > > > > > 
> > > > > > The notion of using UUID came up in the thread
> > > > > > 
> > > > > >    https://www.spinics.net/lists/netdev/msg499011.html
> > > > > 
> > > > > That's probably because it was expected one of standard serial number capabilities
> > > > > (VPD or PCI Express serial #) will be used, which are expected to be unique.
> > > > > 
> > > > > If you are rolling your own vendor specific one, it's just an ID and
> > > > > does not have to be unique.
> > > > > 
> > > > > > > FWIW Hyper-V uses a 32-bit integer for this purpose, not a UUID as seems
> > > > > > > to be implied in the thread you refer to.
> > > > > > 
> > > > > > Yes, Hyper-V uses a serial number (but I think it is 64-bit value).
> > > > > > However, what we are doing is similar to that. Instead of 32 bits,
> > > > > > we are using 128 bits.
> > > > > 
> > > > > That's OK. The name is confusing though. It's a failover group id,
> > > > > not a UUID.
> > > > 
> > > > Sure, we can name it whatever we want. I can change it to
> > > > "failover-group-id", if that is what we want to call it.
> > > > 
> > > > But what is more important is, what is represented by that name? I thought
> > > > we were going to use UUID. The QEMU command line changes in this patch
> > > > set expect the user to specify an UUID as the value for this option
> > > > (whatever we name it). Are we still in agreement about that, or do you
> > > > propose something else to be used? If so, what is it? A 32-bit number, a
> > > > 64-bit number, or an arbitrary string?
> > > > 
> > > > Regards,
> > > > 
> > > > Venu
> > > 
> > > If we don't really need a UUID, I'd avoid that requirement.
> > 
> > I don't see the need for a 128-bit UUID. I just took that approach because
> > UUID was mentioned in "https://www.spinics.net/lists/netdev/msg499011.html".
> > Since it is unlikely to have more than 4 billion devices in the system,
> > a 32-bit value would be more than enough to uniquely identify devices!
> > 
> > I am looking for direction from you :-). Roman already opined that UUID
> > may be an overkill. It appears that you too are leaning that way. Would
> > it be acceptable if I change the group identifier ("failover-group-id")
> > to a 32-bit value? If you concur, I will start reworking my patch. Could
> > you please confirm?
> > 
> > Thanks,
> > 
> > Venu
> 
> I would do a 64 bit one, just in case we want to use PCI Express Device
> Serial Number down the road.

Will do.

Venu

> > > 
> > > 
> > > > > 
> > > > > > > > The current patch set includes all the feedback received for proposals [3]
> > > > > > > > and [4]. For the sake of completeness, patch for the virtio specification
> > > > > > > > is also included here. Following is the updated proposal.
> > > > > > > > 
> > > > > > > > 1. Extend the virtio specification to include a new virtio PCI capability
> > > > > > > >    "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> > > > > > > > 
> > > > > > > > 2. Enhance the QEMU CLI to include a "uuid" option to the virtio device.
> > > > > > > >    The "uuid" is a string in UUID format.
> > > > > > > > 
> > > > > > > > 3. Enhance the QEMU CLI to include a "uuid" option to the bridge device.
> > > > > > > >    The "uuid" is a string in UUID format. Currently, PCIe bridge for
> > > > > > > >    the Q35 model is supported.
> > > > > > > > 
> > > > > > > > 4. The operator creates a unique identifier string using 'uuidgen'.
> > > > > > > > 
> > > > > > > > 5. When the virtio device is created, the operator uses the "uuid" option
> > > > > > > >    (for example, '-device virtio-net-pci,uuid="string"') and specifies
> > > > > > > >    the UUID created in step 4.
> > > > > > > > 
> > > > > > > >    QEMU stores the UUID in the virtio device's configuration space
> > > > > > > >    in the capability "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> > > > > > > > 
> > > > > > > > 6. When assigning a PCI device to the guest in passthrough mode, the
> > > > > > > >    operator first creates a bridge using the "uuid" option (for example,
> > > > > > > >    '-device pcie-downstream,uuid="string"') to specify the UUID created
> > > > > > > >    in step 4, and then attaches the passthrough device to the bridge.
> > > > > > > > 
> > > > > > > >    QEMU stores the UUID in the configuration space of the bridge as
> > > > > > > >    Vendor-Specific capability (0x09). The "Vendor" here is not to be
> > > > > > > >    confused with a specific organization. Instead, the vendor of the
> > > > > > > >    bridge is QEMU. To avoid mixing up with other bridges, the bridge
> > > > > > > >    will be created with vendor ID 0x1b36 (PCI_VENDOR_ID_REDHAT) and
> > > > > > > >    device ID 0x000e (PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE) if the "uuid"
> > > > > > > >    option is specified. Otherwise, current defaults are used.
> > > > > > > 
> > > > > > > I wonder if it makes more sense to drop the concept of failover groups,
> > > > > > > and just refer to the standby device by device-id, like 
> > > > > > > 
> > > > > > >   -device virtio-net-pci,id=foo \
> > > > > > >   -device pcie-downstream,failover=foo
> > > > > > 
> > > > > > Isn't this the same as what this patch series proposes? In your
> > > > > > suggestion, "foo" is the entity that connects the passthrough device
> > > > > > and the failover device. In this patch set, that "foo" is the UUID,
> > > > > > and the options "id" and "failover" are replaced by "uuid". Do you agree?
> > > > > > 
> > > > > > Regards,
> > > > > > 
> > > > > > Venu
> > > > > > 
> > > > > > > The bridge device will then lookup the failover device, figure out the
> > > > > > > common identifier to expose to the guest, and defer the visibility of
> > > > > > > the PT device behind the bridge until the guest acknowledged the support
> > > > > > > for failover on the PV device.
> > > > > > > 
> > > > > > > Roman.
