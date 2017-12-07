Received: from eggs.gnu.org ([2001:4830:134:3::10]:59775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMs2d-0007K7-Bl
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 04:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMs2W-0007gP-Qj
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 04:00:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:30526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eMs2W-0007dr-AY
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 04:00:20 -0500
Message-ID: <5A290398.60508@intel.com>
Date: Thu, 07 Dec 2017 17:02:16 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>	<20171206134957.GD12584@stefanha-x1.localdomain>	<286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>	<CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>	<5A28BC2D.6000308@intel.com>
	<CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
In-Reply-To: <CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On 12/07/2017 02:31 PM, Stefan Hajnoczi wrote:
> On Thu, Dec 7, 2017 at 3:57 AM, Wei Wang <wei.w.wang@intel.com> wrote:
>> On 12/07/2017 12:27 AM, Stefan Hajnoczi wrote:
>>> On Wed, Dec 6, 2017 at 4:09 PM, Wang, Wei W <wei.w.wang@intel.com> wrote:
>>>> On Wednesday, December 6, 2017 9:50 PM, Stefan Hajnoczi wrote:
>>>>> On Tue, Dec 05, 2017 at 11:33:09AM +0800, Wei Wang wrote:
>>>>>> Vhost-pci is a point-to-point based inter-VM communication solution.
>>>>>> This patch series implements the vhost-pci-net device setup and
>>>>>> emulation. The device is implemented as a virtio device, and it is set
>>>>>> up via the vhost-user protocol to get the neessary info (e.g the
>>>>>> memory info of the remote VM, vring info).
>>>>>>
>>>>>> Currently, only the fundamental functions are implemented. More
>>>>>> features, such as MQ and live migration, will be updated in the future.
>>>>>>
>>>>>> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
>>>>>> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>>>>> I have asked questions about the scope of this feature.  In particular,
>>>>> I think
>>>>> it's best to support all device types rather than just virtio-net.  Here
>>>>> is a
>>>>> design document that shows how this can be achieved.
>>>>>
>>>>> What I'm proposing is different from the current approach:
>>>>> 1. It's a PCI adapter (see below for justification) 2. The vhost-user
>>>>> protocol is
>>>>> exposed by the device (not handled 100% in
>>>>>      QEMU).  Ultimately I think your approach would also need to do this.
>>>>>
>>>>> I'm not implementing this and not asking you to implement it.  Let's
>>>>> just use
>>>>> this for discussion so we can figure out what the final vhost-pci will
>>>>> look like.
>>>>>
>>>>> Please let me know what you think, Wei, Michael, and others.
>>>>>
>>>> Thanks for sharing the thoughts. If I understand it correctly, the key
>>>> difference is that this approach tries to relay every vhost-user msg to the
>>>> guest. I'm not sure about the benefits of doing this.
>>>> To make data plane (i.e. driver to send/receive packets) work, I think,
>>>> mostly, the memory info and vring info are enough. Other things like callfd,
>>>> kickfd don't need to be sent to the guest, they are needed by QEMU only for
>>>> the eventfd and irqfd setup.
>>> Handling the vhost-user protocol inside QEMU and exposing a different
>>> interface to the guest makes the interface device-specific.  This will
>>> cause extra work to support new devices (vhost-user-scsi,
>>> vhost-user-blk).  It also makes development harder because you might
>>> have to learn 3 separate specifications to debug the system (virtio,
>>> vhost-user, vhost-pci-net).
>>>
>>> If vhost-user is mapped to a PCI device then these issues are solved.
>>
>> I intend to have a different opinion about this:
>>
>> 1) Even relaying the msgs to the guest, QEMU still need to handle the msg
>> first, for example, it needs to decode the msg to see if it is the ones
>> (e.g. SET_MEM_TABLE, SET_VRING_KICK, SET_VRING_CALL) that should be used for
>> the device setup (e.g. mmap the memory given via SET_MEM_TABLE). In this
>> case, we will be likely to have 2 slave handlers - one in the guest, another
>> in QEMU device.
> In theory the vhost-pci PCI adapter could decide not to relay certain
> messages.  As explained in the document, I think it's better to relay
> everything because some messages that only carry an fd still have a
> meaning.

It has its meaning, which is useful for the device setup, but that's not 
useful for the guest. I think the point is most of the mgs are not 
useful for the guest.

IMHO, the relay mechanism is useful when

1) the QEMU slave handler doesn't need to process the messages at all 
(receive and directly pass on to the guest)

2) most of the msgs are useful for the guest (say we have more than 20 
msgs, only 2 or 3 of them are useful for the guest, why let the device 
pass all of them to the guest)

Also the relay mechanism complicates the vhost-user protocol 
interaction: normally, only master<->QemuSlave. With the relay 
mechanism, it will be master<->QemuSlave<->GuestSlave. For example, when 
the master sends VHOST_USER_GET_QUEUE_NUM, normally it can be answered 
by QemuSlave directly. Why complicate it by passing the msg the 
GuestSlave, and then get the same answer from GuestSlave.


>   They are a signal that the master has entered a new state.

Actually vhost-user isn't state-machine based.

> Why have individual device types (vhost-pci-net, vhost-pci-blk, etc)
> instead of just a vhost-pci device?

This is the same as virtio - we don't have a single virtio device, we 
have virtio-net, virtio-blk etc.

So, the same way, we can have a common TYPE_VHOST_PCI_DEVICE parent 
device (like TYPE_VIRTIO_DEVICE), but net may have its own special 
features like MRG_RXBUF, and own config registers like mac[6] etc, so we 
can have TYPE_VHOST_PCI_NET under TYPE_VHOST_PCI_DEVICE.


>
>>>>> vhost-pci is a PCI adapter instead of a virtio device to allow doorbells
>>>>> and
>>>>> interrupts to be connected to the virtio device in the master VM in the
>>>>> most
>>>>> efficient way possible.  This means the Vring call doorbell can be an
>>>>> ioeventfd that signals an irqfd inside the host kernel without host
>>>>> userspace
>>>>> involvement.  The Vring kick interrupt can be an irqfd that is signalled
>>>>> by the
>>>>> master VM's virtqueue ioeventfd.
>>>>>
>>>> This looks the same as the implementation of inter-VM notification in v2:
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg450005.html
>>>> which is fig. 4 here:
>>>> https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci-rfc2.0.pdf
>>>>
>>>> When the vhost-pci driver kicks its tx, the host signals the irqfd of
>>>> virtio-net's rx. I think this has already bypassed the host userspace
>>>> (thanks to the fast mmio implementation)
>>> Yes, I think the irqfd <-> ioeventfd mapping is good.  Perhaps it even
>>> makes sense to implement a special fused_irq_ioevent_fd in the host
>>> kernel to bypass the need for a kernel thread to read the eventfd so
>>> that an interrupt can be injected (i.e. to make the operation
>>> synchronous).
>>>
>>> Is the tx virtqueue in your inter-VM notification v2 series a real
>>> virtqueue that gets used?  Or is it just a dummy virtqueue that you're
>>> using for the ioeventfd doorbell?  It looks like vpnet_handle_vq() is
>>> empty so it's really just a dummy.  The actual virtqueue is in the
>>> vhost-user master guest memory.
>>
>>
>> Yes, that tx is a dummy actually, just created to use its doorbell.
>> Currently, with virtio_device, I think ioeventfd comes with virtqueue only.
>> Actually, I think we could have the issues solved by vhost-pci. For example,
>> reserve a piece of  the BAR area for ioeventfd. The bar layout can be:
>> BAR 2:
>> 0~4k: vhost-pci device specific usages (ioeventfd etc)
>> 4k~8k: metadata (memory info and vring info)
>> 8k~64GB: remote guest memory
>> (we can make the bar size (64GB is the default value used) configurable via
>> qemu cmdline)
> Why use a virtio device?  The doorbell and shared memory don't fit the
> virtio architecture.  There are no real virtqueues.  This makes it a
> strange virtio device.


The virtio spec doesn't seem to require the device to have at lease one 
virtqueue. It doesn't make a huge difference to me whether it is a 
virtio device or a regular PCI device. We use it as a virtio device 
because it acts as a backend of virtio devices, not sure if it could be 
used by other devices (I guess virtio would be the main 
paravirtualized-like device here)
