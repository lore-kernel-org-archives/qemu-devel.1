Received: from eggs.gnu.org ([2001:4830:134:3::10]:32774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMpiR-0003n7-8z
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMpiP-000691-OF
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:31:27 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:42727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eMpiP-00068k-AX
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:31:25 -0500
Received: by mail-wr0-x230.google.com with SMTP id s66so6246074wrc.9
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 22:31:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5A28BC2D.6000308@intel.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171206134957.GD12584@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
	<CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
	<5A28BC2D.6000308@intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Dec 2017 06:31:23 +0000
Message-ID: <CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Thu, Dec 7, 2017 at 3:57 AM, Wei Wang <wei.w.wang@intel.com> wrote:
> On 12/07/2017 12:27 AM, Stefan Hajnoczi wrote:
>>
>> On Wed, Dec 6, 2017 at 4:09 PM, Wang, Wei W <wei.w.wang@intel.com> wrote:
>>>
>>> On Wednesday, December 6, 2017 9:50 PM, Stefan Hajnoczi wrote:
>>>>
>>>> On Tue, Dec 05, 2017 at 11:33:09AM +0800, Wei Wang wrote:
>>>>>
>>>>> Vhost-pci is a point-to-point based inter-VM communication solution.
>>>>> This patch series implements the vhost-pci-net device setup and
>>>>> emulation. The device is implemented as a virtio device, and it is set
>>>>> up via the vhost-user protocol to get the neessary info (e.g the
>>>>> memory info of the remote VM, vring info).
>>>>>
>>>>> Currently, only the fundamental functions are implemented. More
>>>>> features, such as MQ and live migration, will be updated in the future.
>>>>>
>>>>> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
>>>>> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>>>>
>>>> I have asked questions about the scope of this feature.  In particular,
>>>> I think
>>>> it's best to support all device types rather than just virtio-net.  Here
>>>> is a
>>>> design document that shows how this can be achieved.
>>>>
>>>> What I'm proposing is different from the current approach:
>>>> 1. It's a PCI adapter (see below for justification) 2. The vhost-user
>>>> protocol is
>>>> exposed by the device (not handled 100% in
>>>>     QEMU).  Ultimately I think your approach would also need to do this.
>>>>
>>>> I'm not implementing this and not asking you to implement it.  Let's
>>>> just use
>>>> this for discussion so we can figure out what the final vhost-pci will
>>>> look like.
>>>>
>>>> Please let me know what you think, Wei, Michael, and others.
>>>>
>>> Thanks for sharing the thoughts. If I understand it correctly, the key
>>> difference is that this approach tries to relay every vhost-user msg to the
>>> guest. I'm not sure about the benefits of doing this.
>>> To make data plane (i.e. driver to send/receive packets) work, I think,
>>> mostly, the memory info and vring info are enough. Other things like callfd,
>>> kickfd don't need to be sent to the guest, they are needed by QEMU only for
>>> the eventfd and irqfd setup.
>>
>> Handling the vhost-user protocol inside QEMU and exposing a different
>> interface to the guest makes the interface device-specific.  This will
>> cause extra work to support new devices (vhost-user-scsi,
>> vhost-user-blk).  It also makes development harder because you might
>> have to learn 3 separate specifications to debug the system (virtio,
>> vhost-user, vhost-pci-net).
>>
>> If vhost-user is mapped to a PCI device then these issues are solved.
>
>
> I intend to have a different opinion about this:
>
> 1) Even relaying the msgs to the guest, QEMU still need to handle the msg
> first, for example, it needs to decode the msg to see if it is the ones
> (e.g. SET_MEM_TABLE, SET_VRING_KICK, SET_VRING_CALL) that should be used for
> the device setup (e.g. mmap the memory given via SET_MEM_TABLE). In this
> case, we will be likely to have 2 slave handlers - one in the guest, another
> in QEMU device.

In theory the vhost-pci PCI adapter could decide not to relay certain
messages.  As explained in the document, I think it's better to relay
everything because some messages that only carry an fd still have a
meaning.  They are a signal that the master has entered a new state.

The approach in this patch series doesn't really solve the 2 handler
problem, it still needs to notify the guest when certain vhost-user
messages are received from the master.  The difference is just that
it's non-trivial in this patch series because each message is handled
on a case-by-case basis and has a custom interface (does not simply
relay a vhost-user protocol message).

A 1:1 model is simple and consistent.  I think it will avoid bugs and
design mistakes.

> 2) If people already understand the vhost-user protocol, it would be natural
> for them to understand the vhost-pci metadata - just the obtained memory and
> vring info are put to the metadata area (no new things).

This is debatable.  It's like saying if you understand QEMU
command-line options you will understand libvirt domain XML.  They map
to each other but how obvious that mapping is depends on the details.
I'm saying a 1:1 mapping (reusing the vhost-user protocol message
layout) is the cleanest option.

> Inspired from your sharing, how about the following:
> we can actually factor out a common vhost-pci layer, which handles all the
> features that are common to all the vhost-pci series of devices
> (vhost-pci-net, vhost-pci-blk,...)
> Coming to the implementation, we can have a VhostpciDeviceClass (similar to
> VirtioDeviceClass), the device realize sequence will be
> virtio_device_realize()-->vhost_pci_device_realize()-->vhost_pci_net_device_realize()

Why have individual device types (vhost-pci-net, vhost-pci-blk, etc)
instead of just a vhost-pci device?

>>>> vhost-pci is a PCI adapter instead of a virtio device to allow doorbells
>>>> and
>>>> interrupts to be connected to the virtio device in the master VM in the
>>>> most
>>>> efficient way possible.  This means the Vring call doorbell can be an
>>>> ioeventfd that signals an irqfd inside the host kernel without host
>>>> userspace
>>>> involvement.  The Vring kick interrupt can be an irqfd that is signalled
>>>> by the
>>>> master VM's virtqueue ioeventfd.
>>>>
>>>
>>> This looks the same as the implementation of inter-VM notification in v2:
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg450005.html
>>> which is fig. 4 here:
>>> https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci-rfc2.0.pdf
>>>
>>> When the vhost-pci driver kicks its tx, the host signals the irqfd of
>>> virtio-net's rx. I think this has already bypassed the host userspace
>>> (thanks to the fast mmio implementation)
>>
>> Yes, I think the irqfd <-> ioeventfd mapping is good.  Perhaps it even
>> makes sense to implement a special fused_irq_ioevent_fd in the host
>> kernel to bypass the need for a kernel thread to read the eventfd so
>> that an interrupt can be injected (i.e. to make the operation
>> synchronous).
>>
>> Is the tx virtqueue in your inter-VM notification v2 series a real
>> virtqueue that gets used?  Or is it just a dummy virtqueue that you're
>> using for the ioeventfd doorbell?  It looks like vpnet_handle_vq() is
>> empty so it's really just a dummy.  The actual virtqueue is in the
>> vhost-user master guest memory.
>
>
>
> Yes, that tx is a dummy actually, just created to use its doorbell.
> Currently, with virtio_device, I think ioeventfd comes with virtqueue only.
> Actually, I think we could have the issues solved by vhost-pci. For example,
> reserve a piece of  the BAR area for ioeventfd. The bar layout can be:
> BAR 2:
> 0~4k: vhost-pci device specific usages (ioeventfd etc)
> 4k~8k: metadata (memory info and vring info)
> 8k~64GB: remote guest memory
> (we can make the bar size (64GB is the default value used) configurable via
> qemu cmdline)

Why use a virtio device?  The doorbell and shared memory don't fit the
virtio architecture.  There are no real virtqueues.  This makes it a
strange virtio device.

Stefan
