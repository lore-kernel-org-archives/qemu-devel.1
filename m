Received: from eggs.gnu.org ([2001:4830:134:3::10]:32817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d14yh-0003QZ-LU
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d14ye-0006kE-Fl
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:50:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:57332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d14yK-0006b7-Iv
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:50:00 -0400
Message-ID: <58F84C5C.5050701@intel.com>
Date: Thu, 20 Apr 2017 13:51:24 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<20170419095748.GE3343@stefanha-x1.localdomain>
	<58F73F22.50108@intel.com>
	<CAJSP0QWUFNH4ac7-1H5PSp_psByCvXH7gq_vzuqmXRmzXGo_ww@mail.gmail.com>
In-Reply-To: <CAJSP0QWUFNH4ac7-1H5PSp_psByCvXH7gq_vzuqmXRmzXGo_ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVy?= =?UTF-8?B?ZWF1?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>

On 04/19/2017 11:24 PM, Stefan Hajnoczi wrote:
> On Wed, Apr 19, 2017 at 11:42 AM, Wei Wang <wei.w.wang@intel.com> wrote:
>> On 04/19/2017 05:57 PM, Stefan Hajnoczi wrote:
>>> On Wed, Apr 19, 2017 at 06:38:11AM +0000, Wang, Wei W wrote:
>>>> We made some design changes to the original vhost-pci design, and want to
>>>> open
>>>> a discussion about the latest design (labelled 2.0) and its extension
>>>> (2.1).
>>>> 2.0 design: One VM shares the entire memory of another VM
>>>> 2.1 design: One VM uses an intermediate memory shared with another VM for
>>>>                        packet transmission.
>>> Hi,
>>> Can you talk a bit about the motivation for the 2.x design and major
>>> changes compared to 1.x?
>>
>> 1.x refers to the design we presented at KVM Form before. The major
>> change includes:
>> 1) inter-VM notification support
>> 2) TX engine and RX engine, which is the structure built in the driver. From
>> the device point of view, the local rings of the engines need to be
>> registered.
> It would be great to support any virtio device type.

Yes, the current design already supports the creation of devices of
different types.
The support is added to the vhost-user protocol and the vhost-user slave.
Once the slave handler receives the request to create the device (with
the specified device type), the remaining process (e.g. device realize)
is device specific.
This part remains the same as presented before
(i.e.Page 12 @ 
http://www.linux-kvm.org/images/5/55/02x07A-Wei_Wang-Design_of-Vhost-pci.pdf).
>
> The use case I'm thinking of is networking and storage appliances in
> cloud environments (e.g. OpenStack).  vhost-user doesn't fit nicely
> because users may not be allowed to run host userspace processes.  VMs
> are first-class objects in compute clouds.  It would be natural to
> deploy networking and storage appliances as VMs using vhost-pci.
>
> In order to achieve this vhost-pci needs to be a virtio transport and
> not a virtio-net-specific PCI device.  It would extend the VIRTIO 1.x
> spec alongside virtio-pci, virtio-mmio, and virtio-ccw.

Actually it is designed as a device under virtio-pci transport. I'm
not sure about the value of having a new transport.

> When you say TX and RX I'm not sure if the design only supports
> virtio-net devices?

Current design focuses on the vhost-pci-net device. That's the
reason that we have TX/RX here. As mention above, when the
slave invokes the device creation function, the execution
goes to each device specific code.

The TX/RX is the design after the device creation, so it is specific
to vhost-pci-net. For the future vhost-pci-blk, that design can
have its own request queue.


>> The motivation is to build a common design for 2.0 and 2.1.
>>
>>> What is the relationship between 2.0 and 2.1?  Do you plan to upstream
>>> both?
>> 2.0 and 2.1 use different ways to share memory.
>>
>> 2.0: VM1 shares the entire memory of VM2, which achieves 0 copy
>> between VMs while being less secure.
>> 2.1: VM1 and VM2 use an intermediate shared memory to transmit
>> packets, which results in 1 copy between VMs while being more secure.
>>
>> Yes, plan to upstream both. Since the difference is the way to share memory,
>> I think it wouldn't have too many patches to upstream 2.1 if 2.0 is ready
>> (or
>> changing the order if needed).
> Okay.  "Asymmetric" (vhost-pci <-> virtio-pci) and "symmetric"
> (vhost-pci <-> vhost-pci) mode might be a clearer way to distinguish
> between the two.  Or even "compatibility" mode and "native" mode since
> existing guests only work in vhost-pci <-> virtio-pci mode.  Using
> version numbers to describe two different modes of operation could be
> confusing.
>
OK. I'll take your suggestion to use "asymmetric" and
"asymmetric". Thanks.


Best,
Wei
