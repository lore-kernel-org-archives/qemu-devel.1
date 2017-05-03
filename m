Received: from eggs.gnu.org ([2001:4830:134:3::10]:47670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d5nLA-0001Vn-AI
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d5nL6-0004WU-Dl
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:00:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:41521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d5nL5-0004Vp-QW
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:00:40 -0400
Message-ID: <59097274.6050204@intel.com>
Date: Wed, 03 May 2017 14:02:28 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<20170419095748.GE3343@stefanha-x1.localdomain>
	<58F73F22.50108@intel.com>
	<CAJSP0QWUFNH4ac7-1H5PSp_psByCvXH7gq_vzuqmXRmzXGo_ww@mail.gmail.com>
	<58F84C5C.5050701@intel.com>
	<20170502124804.GB22502@stefanha-x1.localdomain>
In-Reply-To: <20170502124804.GB22502@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?windows-1252?Q?Marc-Andr=E9_?= =?windows-1252?Q?Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>

On 05/02/2017 08:48 PM, Stefan Hajnoczi wrote:
> On Thu, Apr 20, 2017 at 01:51:24PM +0800, Wei Wang wrote:
>> On 04/19/2017 11:24 PM, Stefan Hajnoczi wrote:
>>> On Wed, Apr 19, 2017 at 11:42 AM, Wei Wang <wei.w.wang@intel.com> wrote:
>>>> On 04/19/2017 05:57 PM, Stefan Hajnoczi wrote:
>>>>> On Wed, Apr 19, 2017 at 06:38:11AM +0000, Wang, Wei W wrote:
>>>>>> We made some design changes to the original vhost-pci design, and want to
>>>>>> open
>>>>>> a discussion about the latest design (labelled 2.0) and its extension
>>>>>> (2.1).
>>>>>> 2.0 design: One VM shares the entire memory of another VM
>>>>>> 2.1 design: One VM uses an intermediate memory shared with another VM for
>>>>>>                         packet transmission.
>>>>> Hi,
>>>>> Can you talk a bit about the motivation for the 2.x design and major
>>>>> changes compared to 1.x?
>>>> 1.x refers to the design we presented at KVM Form before. The major
>>>> change includes:
>>>> 1) inter-VM notification support
>>>> 2) TX engine and RX engine, which is the structure built in the driver. From
>>>> the device point of view, the local rings of the engines need to be
>>>> registered.
>>> It would be great to support any virtio device type.
>> Yes, the current design already supports the creation of devices of
>> different types.
>> The support is added to the vhost-user protocol and the vhost-user slave.
>> Once the slave handler receives the request to create the device (with
>> the specified device type), the remaining process (e.g. device realize)
>> is device specific.
>> This part remains the same as presented before
>> (i.e.Page 12 @ http://www.linux-kvm.org/images/5/55/02x07A-Wei_Wang-Design_of-Vhost-pci.pdf).
>>> The use case I'm thinking of is networking and storage appliances in
>>> cloud environments (e.g. OpenStack).  vhost-user doesn't fit nicely
>>> because users may not be allowed to run host userspace processes.  VMs
>>> are first-class objects in compute clouds.  It would be natural to
>>> deploy networking and storage appliances as VMs using vhost-pci.
>>>
>>> In order to achieve this vhost-pci needs to be a virtio transport and
>>> not a virtio-net-specific PCI device.  It would extend the VIRTIO 1.x
>>> spec alongside virtio-pci, virtio-mmio, and virtio-ccw.
>> Actually it is designed as a device under virtio-pci transport. I'm
>> not sure about the value of having a new transport.
>>
>>> When you say TX and RX I'm not sure if the design only supports
>>> virtio-net devices?
>> Current design focuses on the vhost-pci-net device. That's the
>> reason that we have TX/RX here. As mention above, when the
>> slave invokes the device creation function, the execution
>> goes to each device specific code.
>>
>> The TX/RX is the design after the device creation, so it is specific
>> to vhost-pci-net. For the future vhost-pci-blk, that design can
>> have its own request queue.
> Here is my understanding based on your vhost-pci GitHub repo:
>
> VM1 sees a normal virtio-net-pci device.  VM1 QEMU is invoked with a
> vhost-user netdev.
>
> VM2 sees a hotplugged vhost-pci-net virtio-pci device once VM1
> initializes the device and a message is sent over vhost-user.

Right.

>
> There is no integration with Linux drivers/vhost/ code for VM2.  Instead
> you are writing a 3rd virtio-net driver specifically for vhost-pci.  Not
> sure if it's possible to reuse drivers/vhost/ cleanly but that would be
> nicer than implementing virtio-net again.

vhost-pci-net is a standalone network device with its own unique
device id, and the device itself is different from virtio-net (e.g.
different virtqueues), so I think it would be more reasonable to
let vhost-pci-net have its own driver.

There are indeed some functions in vhost-pci-net that looks
similar to those in virtio-net (e.g. try_fill_recv()). I haven't thought
of a good way to reuse them yet, because the interfaces are not
completely the same, for example, vpnet_info and virtnet_info,
which need to be passed to the functions, are different.

>
> Is the VM1 vhost-user netdev a normal vhost-user device or does it know
> about vhost-pci?

Share the QEMU booting commands, which would be helpful:
VM1(vhost-pci-net):
-chardev socket,id=slave1,server,wait=off,path=${PATH_SLAVE1} \
-vhost-pci-slave socket,chardev=slave1

VM2(virtio-net):
-chardev socket,id=sock2,path=${PATH_SLAVE1} \
-netdev type=vhost-user,id=net2,chardev=sock2,vhostforce \
-device virtio-net-pci,mac=52:54:00:00:00:02,netdev=net2

The netdev doesn't know about vhost_pci, but the vhost_dev knows
it via
vhost_dev->protocol_features &
     (1ULL << VHOST_USER_PROTOCOL_F_VHOST_PCI),

The vhost-pci specific messages need to be sent in the vhost-pci
case. For example, at the end of vhost_net_start(), if it detects the
slave is vhost-pci, it will send a
VHOST_USER_SET_VHOST_PCI_START message to the slave(VM1).

>
> It's hard to study code changes in your vhost-pci repo because
> everything (QEMU + Linux + your changes) was committed in a single
> commit.  Please keep your changes in separate commits so it's easy to
> find them.
>
Thanks a lot for reading the draft code. I'm working to do some
cleanup and split it into patches. I will post out the QEMU side
patches soon.


Best,
Wei
