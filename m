Received: from eggs.gnu.org ([2001:4830:134:3::10]:46225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1faMIC-0004NX-OD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1faMI6-0005o7-CH
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:28:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1faMI6-0005nU-2b
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:28:26 -0400
Date: Tue, 3 Jul 2018 09:28:17 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180703142817.GA3088@vbusired-vm>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703095825.GC30904@rkaganb.sw.ru>
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
To: Roman Kagan <rkagan@virtuozzo.com>, si-wei liu <si-wei.liu@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 2018-07-03 12:58:25 +0300, Roman Kagan wrote:
> On Mon, Jul 02, 2018 at 02:14:52PM -0700, si-wei liu wrote:
> > On 7/2/2018 9:14 AM, Roman Kagan wrote:
> > > On Fri, Jun 29, 2018 at 05:19:03PM -0500, Venu Busireddy wrote:
> > > > The patch set "Enable virtio_net to act as a standby for a passthru
> > > > device" [1] deals with live migration of guests that use passthrough
> > > > devices. However, that scheme uses the MAC address for pairing
> > > > the virtio device and the passthrough device. The thread "netvsc:
> > > > refactor notifier/event handling code to use the failover framework"
> > > > [2] discusses an alternate mechanism, such as using an UUID, for pairing
> > > > the devices. Based on that discussion, proposals "Add "Group Identifier"
> > > > to virtio PCI capabilities." [3] and "RFC: Use of bridge devices to
> > > > store pairing information..." [4] were made.
> > > > 
> > > > The current patch set includes all the feedback received for proposals [3]
> > > > and [4]. For the sake of completeness, patch for the virtio specification
> > > > is also included here. Following is the updated proposal.
> > > > 
> > > > 1. Extend the virtio specification to include a new virtio PCI capability
> > > >     "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> > > > 
> > > > 2. Enhance the QEMU CLI to include a "failover-group-id" option to the
> > > >     virtio device. The "failover-group-id" is a 64 bit value.
> > > > 
> > > > 3. Enhance the QEMU CLI to include a "failover-group-id" option to the
> > > >     Red Hat PCI bridge device (support for the i440FX model).
> > > > 
> > > > 4. Add a new "pcie-downstream" device, with the option
> > > >     "failover-group-id" (support for the Q35 model).
> > > > 
> > > > 5. The operator creates a 64 bit unique identifier, failover-group-id.
> > > > 
> > > > 6. When the virtio device is created, the operator uses the
> > > >     "failover-group-id" option (for example, '-device
> > > >     virtio-net-pci,failover-group-id=<identifier>') and specifies the
> > > >     failover-group-id created in step 4.
> > > > 
> > > >     QEMU stores the failover-group-id in the virtio device's configuration
> > > >     space in the capability "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> > > > 
> > > > 7. When assigning a PCI device to the guest in passthrough mode, the
> > > >     operator first creates a bridge using the "failover-group-id" option
> > > >     (for example, '-device pcie-downstream,failover-group-id=<identifier>')
> > > >     to specify the failover-group-id created in step 4, and then attaches
> > > >     the passthrough device to the bridge.
> > > > 
> > > >     QEMU stores the failover-group-id in the configuration space of the
> > > >     bridge as Vendor-Specific capability (0x09). The "Vendor" here is
> > > >     not to be confused with a specific organization. Instead, the vendor
> > > >     of the bridge is QEMU.
> > > > 
> > > > 8. Patch 4 in patch series "Enable virtio_net to act as a standby for
> > > >     a passthru device" [1] needs to be modified to use the UUID values
> > > >     present in the bridge's configuration space and the virtio device's
> > > >     configuration space instead of the MAC address for pairing the devices.
> > > I'm still missing a few bits in the overall scheme.
> > > 
> > > Is the guest supposed to acknowledge the support for PT-PV failover?
> > 
> > Yes. We are leveraging virtio's feature negotiation mechanism for that.
> > Guest which does not acknowledge the support will not have PT plugged in.
> > 
> > > Should the PT device be visibile to the guest before it acknowledges the
> > > support for failover?
> > No. QEMU will only expose PT device after guest acknowledges the support
> > through virtio's feature negotiation.
> > 
> > >    How is this supposed to work with legacy guests that don't support it?
> > Only PV device will be exposed on legacy guest.
> 
> So how is this coordination going to work?  One possibility is that the
> PV device emits a QMP event upon the guest driver confirming the support
> for failover, the management layer intercepts the event and performs
> device_add of the PT device.  Another is that the PT device is added
> from the very beginning (e.g. on the QEMU command line) but its parent
> PCI bridge subscribes a callback with the PV device to "activate" the PT
> device upon negotiating the failover feature.
> 
> I think this needs to be decided within the scope of this patchset.
> 
> > > Is the guest supposed to signal the datapath switch to the host?
> > No, guest doesn't need to be initiating datapath switch at all.
> 
> What happens if the guest supports failover in its PV driver, but lacks
> the driver for the PT device?
> 
> > However, QMP
> > events may be generated when exposing or hiding the PT device through hot
> > plug/unplug to facilitate host to switch datapath.
> 
> The PT device hot plug/unplug are initiated by the host, aren't they?  Why
> would it also need QMP events for them?
> 
> > > Is the scheme going to be applied/extended to other transports (vmbus,
> > > virtio-ccw, etc.)?
> > Well, it depends on the use case, and how feasible it can be extended to
> > other transport due to constraints and transport specifics.
> > 
> > > Is the failover group concept going to be used beyond PT-PV network
> > > device failover?
> > Although the concept of failover group is generic, the implementation itself
> > may vary.
> 
> My point with these two questions is that since this patchset is
> defining external interfaces -- with guest OS, with management layer --

This patch set is not defining any external interfaces. All this is doing
is provide the means and locations to store the "group identifier". How
that info will be used, I thought, should be another patch set.

Venu

> which are not easy to change later, it might make sense to try and see
> if the interfaces map to other usecases.  E.g. I think we can get enough
> information on how Hyper-V handles PT-PV network device failover from
> the current Linux implementation; it may be a good idea to share some
> concepts and workflows with virtio-pci.
> 
> Thanks,
> Roman.
