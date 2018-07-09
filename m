Received: from eggs.gnu.org ([2001:4830:134:3::10]:32811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fcVmj-00059x-MZ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fcVmf-0004i5-Q3
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:00:57 -0400
Received: from mail-db3eur04hn0209.outbound.protection.outlook.com
	([104.47.12.209]:61600
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fcVme-0004gw-Vc
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:00:53 -0400
Date: Mon, 9 Jul 2018 16:00:36 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180709130035.GA6271@rkaganb.sw.ru>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
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
To: si-wei liu <si-wei.liu@oracle.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Tue, Jul 03, 2018 at 03:27:23PM -0700, si-wei liu wrote:
> On 7/3/2018 2:58 AM, Roman Kagan wrote:
> > So how is this coordination going to work?  One possibility is that the
> > PV device emits a QMP event upon the guest driver confirming the support
> > for failover, the management layer intercepts the event and performs
> > device_add of the PT device.  Another is that the PT device is added
> > from the very beginning (e.g. on the QEMU command line) but its parent
> > PCI bridge subscribes a callback with the PV device to "activate" the PT
> > device upon negotiating the failover feature.
> > 
> > I think this needs to be decided within the scope of this patchset.
> As what had been discussed in previous thread below, we would go with the
> approach that QEMU manages the visibility of the PT device automatically.
> Management layer supplies PT device to QEMU from the very beginning. This PT
> device won't be exposed to guest immediately, unless or until the guest
> virtio driver acknowledges the backup feature already. Once virtio driver in
> the guest initiates a device reset, the corresponding PT device must be
> taken out from guest. Then add it back later on after guest virtio completes
> negotiation for the backup feature.

This means that the parent bridge of the PT device (or whatever else can
control the visibility of the PT device to the guest) will need to
cooperate with the PV device *within* QEMU.  The most natural way to
specify this connection is to have a property of one device to refer to
the other by device-id.

Another benefit of this approach is that it will allow to hide the
(possibly transport-specific) device matching identifiers from the QEMU
caller, as it won't need to be persistent nor visible to the management
layer.  In particular, this will allow to move forward with the
implementation of this PT-PV cooperation while the discussion of the
matching scheme is still ongoing, because matching by MAC will certainly
work as a first approximation.

> > > > Is the guest supposed to signal the datapath switch to the host?
> > > No, guest doesn't need to be initiating datapath switch at all.
> > What happens if the guest supports failover in its PV driver, but lacks
> > the driver for the PT device?
> The assumption of failover driver is that the primary (PT device) will be
> able to get a datapath once it shows up in the guest .

I wonder how universal this assumption is, given the variety of possible
network configurations, including filters, VLANs, etc.  For whatever
reason Hyper-V defines a control message over the PV device from guest
to host for that.

> If adding a PT device
> to an unsupported guest, the result will be same as that without a standby
> PV driver - basically got no networking as you don't get a working driver.
> 
> Then perhaps don't add the PT device in the first place if guest lacks
> driver support?

You don't know this in advance.

> > > However, QMP
> > > events may be generated when exposing or hiding the PT device through hot
> > > plug/unplug to facilitate host to switch datapath.
> > The PT device hot plug/unplug are initiated by the host, aren't they?  Why
> > would it also need QMP events for them?
> As indicated above, the hot plug/unplug are initiated by QEMU not the
> management layer. Hence the QMP hot plug event is used as an indicator to
> switch host datapath. Unlike Windows Hyper-V SR-IOV driver model, the Linux
> host network stack does not offer a fine grained PF driver API to move
> MAC/VLAN filter, and the VF driver has to start with some initial MAC
> address filter programmed in when present in the guest. The QMP event is
> served as a checkpoint to switch MAC filter and/or VLAN filter between the
> PV and the VF.
> 

I'd appreciate something like a sequence diagram to better understand
the whole picture...

> > > > Is the scheme going to be applied/extended to other transports (vmbus,
> > > > virtio-ccw, etc.)?
> > > Well, it depends on the use case, and how feasible it can be extended to
> > > other transport due to constraints and transport specifics.
> > > 
> > > > Is the failover group concept going to be used beyond PT-PV network
> > > > device failover?
> > > Although the concept of failover group is generic, the implementation itself
> > > may vary.
> > My point with these two questions is that since this patchset is
> > defining external interfaces -- with guest OS, with management layer --
> > which are not easy to change later, it might make sense to try and see
> > if the interfaces map to other usecases.  E.g. I think we can get enough
> > information on how Hyper-V handles PT-PV network device failover from
> > the current Linux implementation; it may be a good idea to share some
> > concepts and workflows with virtio-pci.
> As you may see from above, the handshake of virtio failover depends on hot
> plug (PCI or ACPI) and virtio specifics (feature negotiation). So far as I
> see the Hyper-V uses a completely different handshake protocol of its own
> (guest initiated datapath switch, Serial number in VMBus PCI bridge) than
> that of virtio. I can barely imagine how code could be implemented in a
> shared manner, although I agree conceptually failover group between these
> two is similar or the same.

I actually think there must be a lot in common: the way for the
management layer to specify the binding between the PT and PV devices;
the overall sequence of state transitions of every component, the QMP
events and the points in time when they are emitted, the way to adjust
host-side network configuration and the time when to do it, and so on.
It's unfortunate that the implementation of PV-PT failover in guest
Linux happens to have diverged between virtio and hyperv, but I don't
see any fundamental difference and I wouldn't be surprised if they
eventually converged sooner rather than later.

There are a few things that need to be specific for PT and/or PV
transport, the matching identifier among them, but I guess a lot can
still be in common.

Roman.
