Received: from eggs.gnu.org ([2001:4830:134:3::10]:38771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0laQ-00016k-Uv
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0laN-0005XY-ML
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:07:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:58375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d0laN-0005Wk-AQ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:07:39 -0400
Message-ID: <58F72942.3030802@intel.com>
Date: Wed, 19 Apr 2017 17:09:22 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<9ce5d497-c52a-23fc-a43d-ac7c895faedb@siemens.com>
	<58F722EE.7030300@intel.com>
	<d96b8097-b541-9908-8141-86267e726471@siemens.com>
In-Reply-To: <d96b8097-b541-9908-8141-86267e726471@siemens.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, =?windows-1252?Q?Marc-Andr=E9_?= =?windows-1252?Q?Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>

On 04/19/2017 04:49 PM, Jan Kiszka wrote:
> On 2017-04-19 10:42, Wei Wang wrote:
>> On 04/19/2017 03:35 PM, Jan Kiszka wrote:
>>> On 2017-04-19 08:38, Wang, Wei W wrote:
>>>> Hi,
>>>>    We made some design changes to the original vhost-pci design, and want
>>>> to open
>>>> a discussion about the latest design (labelled 2.0) and its extension
>>>> (2.1).
>>>> 2.0 design: One VM shares the entire memory of another VM
>>>> 2.1 design: One VM uses an intermediate memory shared with another VM
>>>> for
>>>>                        packet transmission.
>>>>    For the convenience of discussion, I have some pictures presented at
>>>> this link:
>>>> _https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci-rfc2.0.pdf_
>>>>
>>>>    Fig. 1 shows the common driver frame that we want use to build the 2.0
>>>> and 2.1
>>>> design. A TX/RX engine consists of a local ring and an exotic ring.
>>>> Local ring:
>>>> 1) allocated by the driver itself;
>>>> 2) registered with the device (i.e. virtio_add_queue())
>>>> Exotic ring:
>>>> 1) ring memory comes from the outside (of the driver), and exposed to
>>>> the driver
>>>>        via a BAR MMIO;
>>> Small additional requirement: In order to make this usable with
>>> Jailhouse as well, we need [also] a side-channel configuration for the
>>> regions, i.e. likely via a PCI capability. There are too few BARs, and
>>> they suggest relocatablity, which is not available under Jailhouse for
>>> simplicity reasons (IOW, the shared regions are statically mapped by the
>>> hypervisor into the affected guest address spaces).
>> What kind of configuration would you need for the regions?
>> I think adding a PCI capability should be easy.
> Basically address and size, see
> https://github.com/siemens/jailhouse/blob/wip/ivshmem2/Documentation/ivshmem-v2-specification.md#vendor-specific-capability-id-09h
Got it, thanks. That should be easy to add to 2.1.

>>>> 2) does not have a registration in the device, so no ioeventfd/irqfd,
>>>> configuration
>>>> registers allocated in the device
>>>>    Fig. 2 shows how the driver frame is used to build the 2.0 design.
>>>> 1) Asymmetric: vhost-pci-net <-> virtio-net
>>>> 2) VM1 shares the entire memory of VM2, and the exotic rings are the
>>>> rings
>>>>       from VM2.
>>>> 3) Performance (in terms of copies between VMs):
>>>>       TX: 0-copy (packets are put to VM2’s RX ring directly)
>>>>       RX: 1-copy (the green arrow line in the VM1’s RX engine)
>>>>    Fig. 3 shows how the driver frame is used to build the 2.1 design.
>>>> 1) Symmetric: vhost-pci-net <-> vhost-pci-net
>>> This is interesting!
>>>
>>>> 2) Share an intermediate memory, allocated by VM1’s vhost-pci device,
>>>> for data exchange, and the exotic rings are built on the shared memory
>>>> 3) Performance:
>>>>       TX: 1-copy
>>>> RX: 1-copy
>>> I'm not yet sure I to this right: there are two different MMIO regions
>>> involved, right? One is used for VM1's RX / VM2's TX, and the other for
>>> the reverse path? Would allow our requirement to have those regions
>>> mapped with asymmetric permissions (RX read-only, TX read/write).
>> The design presented here intends to use only one BAR to expose
>> both TX and RX. The two VMs share an intermediate memory
>> here, why couldn't we give the same permission to TX and RX?
>>
> For security and/or safety reasons: the TX side can then safely prepare
> and sign a message in-place because the RX side cannot mess around with
> it while not yet being signed (or check-summed). Saves one copy from a
> secure place into the shared memory.

If we allow guest1 to write to RX, what safety issue would it cause to
guest2?


>>>>    Fig. 4 shows the inter-VM notification path for 2.0 (2.1 is similar).
>>>> The four eventfds are allocated by virtio-net, and shared with
>>>> vhost-pci-net:
>>>> Uses virtio-net’s TX/RX kickfd as the vhost-pci-net’s RX/TX callfd
>>>> Uses virtio-net’s TX/RX callfd as the vhost-pci-net’s RX/TX kickfd
>>>> Example of how it works:
>>>> After packets are put into vhost-pci-net’s TX, the driver kicks TX,
>>>> which
>>>> causes the an interrupt associated with fd3 to be injected to virtio-net
>>>>    The draft code of the 2.0 design is ready, and can be found here:
>>>> Qemu: _https://github.com/wei-w-wang/vhost-pci-device_
>>>> Guest driver: _https://github.com/wei-w-wang/vhost-pci-driver_
>>>>    We tested the 2.0 implementation using the Spirent packet
>>>> generator to transmit 64B packets, the results show that the
>>>> throughput of vhost-pci reaches around 1.8Mpps, which is around
>>>> two times larger than the legacy OVS+DPDK. Also, vhost-pci shows
>>>> better scalability than OVS+DPDK.
>>>>    
>>> Do you have numbers for the symmetric 2.1 case as well? Or is the driver
>>> not yet ready for that yet? Otherwise, I could try to make it work over
>>> a simplistic vhost-pci 2.1 version in Jailhouse as well. That would give
>>> a better picture of how much additional complexity this would mean
>>> compared to our ivshmem 2.0.
>>>
>> Implementation of 2.1 is not ready yet. We can extend it to 2.1 after
>> the common driver frame is reviewed.
> Can you you assess the needed effort?
>
> For us, this is a critical feature, because we need to decide if
> vhost-pci can be an option at all. In fact, the "exotic ring" will be
> the only way to provide secure inter-partition communication on Jailhouse.
>
If what is here for 2.0 is suitable to be upstream-ed, I think it will 
be easy
to extend it to 2.1 (probably within 1 month).

Best,
Wei
