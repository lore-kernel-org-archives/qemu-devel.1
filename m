Received: from eggs.gnu.org ([2001:4830:134:3::10]:48228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1fchCJ-0007NQ-77
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1fchCF-0000TM-5O
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:12:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <si-wei.liu@oracle.com>)
	id 1fchCE-0000TD-Rf
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:12:03 -0400
From: si-wei liu <si-wei.liu@oracle.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
	<20180709130035.GA6271@rkaganb.sw.ru>
Message-ID: <9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
Date: Mon, 9 Jul 2018 18:11:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180709130035.GA6271@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Roman Kagan <rkagan@virtuozzo.com>, Venu Busireddy <venu.busireddy@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: sridhar.samudrala@intel.com, alexander.h.duyck@intel.com, netdev@vger.kernel.org



On 7/9/2018 6:00 AM, Roman Kagan wrote:
> On Tue, Jul 03, 2018 at 03:27:23PM -0700, si-wei liu wrote:
>> On 7/3/2018 2:58 AM, Roman Kagan wrote:
>>> So how is this coordination going to work?  One possibility is that the
>>> PV device emits a QMP event upon the guest driver confirming the support
>>> for failover, the management layer intercepts the event and performs
>>> device_add of the PT device.  Another is that the PT device is added
>>> from the very beginning (e.g. on the QEMU command line) but its parent
>>> PCI bridge subscribes a callback with the PV device to "activate" the PT
>>> device upon negotiating the failover feature.
>>>
>>> I think this needs to be decided within the scope of this patchset.
>> As what had been discussed in previous thread below, we would go with the
>> approach that QEMU manages the visibility of the PT device automatically.
>> Management layer supplies PT device to QEMU from the very beginning. This PT
>> device won't be exposed to guest immediately, unless or until the guest
>> virtio driver acknowledges the backup feature already. Once virtio driver in
>> the guest initiates a device reset, the corresponding PT device must be
>> taken out from guest. Then add it back later on after guest virtio completes
>> negotiation for the backup feature.
> This means that the parent bridge of the PT device (or whatever else can
> control the visibility of the PT device to the guest) will need to
> cooperate with the PV device *within* QEMU.  The most natural way to
> specify this connection is to have a property of one device to refer to
> the other by device-id.
This scheme has the problem that one device has to depend on the 
presence of the other - QEMU has the implication of the enumeration 
order if the two are not placed in the same birdge or PCI hierarchy. You 
can't get it reliably working if the bridge is going to be realized 
while the dependent PV device hadn't been yet, or vice versa.

> Another benefit of this approach is that it will allow to hide the
> (possibly transport-specific) device matching identifiers from the QEMU
> caller, as it won't need to be persistent nor visible to the management
> layer.  In particular, this will allow to move forward with the
> implementation of this PT-PV cooperation while the discussion of the
> matching scheme is still ongoing, because matching by MAC will certainly
> work as a first approximation.
The plan is to enable group ID based matching in the first place rather 
than match by MAC, the latter of which is fragile and problematic. I 
have made the Linux side changes and will get it posted once the QEMU 
discussion for grouping is finalized.

>
>>>>> Is the guest supposed to signal the datapath switch to the host?
>>>> No, guest doesn't need to be initiating datapath switch at all.
>>> What happens if the guest supports failover in its PV driver, but lacks
>>> the driver for the PT device?
>> The assumption of failover driver is that the primary (PT device) will be
>> able to get a datapath once it shows up in the guest .
> I wonder how universal this assumption is, given the variety of possible
> network configurations, including filters, VLANs, etc.  For whatever
> reason Hyper-V defines a control message over the PV device from guest
> to host for that.
These scenarios are different than the case with no driver support at 
all within guest. I think I particularly raised this as part of doing 
proper error handling when reviewing the original virtio failover patch 
- if failover module fails to enslave the VF due to guest network 
configurations, it has to signal virtio-net to propagate the error back 
to host. One way to handle that is to have virtio-net kick out a device 
reset and clear the feature bit upon re-negotiation, such that VF will 
be plugged out and won't get plugged in. I don't know for what reason 
the patch submitter did not incorporate that change. But it's in our 
plan to enhance that part, no worries.

>> If adding a PT device
>> to an unsupported guest, the result will be same as that without a standby
>> PV driver - basically got no networking as you don't get a working driver.
>>
>> Then perhaps don't add the PT device in the first place if guest lacks
>> driver support?
> You don't know this in advance.
 From migration point of view, it does not matter if guest lacks driver 
support for VF. I like to avoid duplicating hyper-v concept if at all 
possible. What makes sense with Hyper-V's accelerated networking doesn't 
have to work with KVM/QEMU SR-IOV live migration. Are you sure that the 
Hyper-V control message was added for this sole purpose? Seems to me an 
overkill for such an edge scenario.

>
>>>> However, QMP
>>>> events may be generated when exposing or hiding the PT device through hot
>>>> plug/unplug to facilitate host to switch datapath.
>>> The PT device hot plug/unplug are initiated by the host, aren't they?  Why
>>> would it also need QMP events for them?
>> As indicated above, the hot plug/unplug are initiated by QEMU not the
>> management layer. Hence the QMP hot plug event is used as an indicator to
>> switch host datapath. Unlike Windows Hyper-V SR-IOV driver model, the Linux
>> host network stack does not offer a fine grained PF driver API to move
>> MAC/VLAN filter, and the VF driver has to start with some initial MAC
>> address filter programmed in when present in the guest. The QMP event is
>> served as a checkpoint to switch MAC filter and/or VLAN filter between the
>> PV and the VF.
>>
> I'd appreciate something like a sequence diagram to better understand
> the whole picture...
>
>>>>> Is the scheme going to be applied/extended to other transports (vmbus,
>>>>> virtio-ccw, etc.)?
>>>> Well, it depends on the use case, and how feasible it can be extended to
>>>> other transport due to constraints and transport specifics.
>>>>
>>>>> Is the failover group concept going to be used beyond PT-PV network
>>>>> device failover?
>>>> Although the concept of failover group is generic, the implementation itself
>>>> may vary.
>>> My point with these two questions is that since this patchset is
>>> defining external interfaces -- with guest OS, with management layer --
>>> which are not easy to change later, it might make sense to try and see
>>> if the interfaces map to other usecases.  E.g. I think we can get enough
>>> information on how Hyper-V handles PT-PV network device failover from
>>> the current Linux implementation; it may be a good idea to share some
>>> concepts and workflows with virtio-pci.
>> As you may see from above, the handshake of virtio failover depends on hot
>> plug (PCI or ACPI) and virtio specifics (feature negotiation). So far as I
>> see the Hyper-V uses a completely different handshake protocol of its own
>> (guest initiated datapath switch, Serial number in VMBus PCI bridge) than
>> that of virtio. I can barely imagine how code could be implemented in a
>> shared manner, although I agree conceptually failover group between these
>> two is similar or the same.
> I actually think there must be a lot in common: the way for the
> management layer to specify the binding between the PT and PV devices;
> the overall sequence of state transitions of every component, the QMP
> events and the points in time when they are emitted, the way to adjust
> host-side network configuration and the time when to do it, and so on.
> It's unfortunate that the implementation of PV-PT failover in guest
> Linux happens to have diverged between virtio and hyperv, but I don't
> see any fundamental difference and I wouldn't be surprised if they
> eventually converged sooner rather than later.
(loop in Intel folks and Linux netdev)

Actually it's not without reason that Linux/virtio has to diverge from 
Hyper-V. The Hyper-V SR-IOV driver model allows VF be plugged in and 
registered with the stack without a MAC address filter programmed in the 
NIC, while Windows Hyper-V at the host side is able to move a MAC filter 
around from the NIC PV backend to VF upon receiving the DATAPATH_SWITCH 
control message initiated by guest. Windows NDIS has 
OID_RECEIVE_FILTER_MOVE_FILTER API to have PF update the MAC filter for 
the VF without involving guest or VF. For all of these there are no 
equivalent in the Linux SR-IOV driver model. How do you propose to have 
guest initiate the datapath switching at any point in time when you're 
dealing with Linux host network stack?

One may say we can plug in a VF with a random MAC filter programmed in 
prior, and initially use that random MAC within guest. This would require:

a) not relying on permanent MAC address to do pairing during the initial 
discovery, e.g. use the failover group ID as in this discussion
b) host to toggle the MAC address filter: which includes taking down the 
tap device to return the MAC back to PF, followed by assigning that MAC 
to VF using "ip link ... set vf ..."
c) notify guest to reload/reset VF driver for the change of hardware MAC 
address
d) until VF reloads the driver it won't be able to use the datapath, so 
very short period of network outage is (still) expected

But as you see this still diverges from the Hyper-V model. What do we 
buy for using a random address during initial discovery and requiring VF 
to complete the handshake? Less network downtime during datapath 
switching? Sorry but that's not a key factor at all for our main goal - 
live migration.

Regards,
-Siwei

>
> There are a few things that need to be specific for PT and/or PV
> transport, the matching identifier among them, but I guess a lot can
> still be in common.
>
> Roman.
>
