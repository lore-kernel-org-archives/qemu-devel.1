Received: from eggs.gnu.org ([2001:4830:134:3::10]:38209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMcKW-0002Np-7b
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMcKU-0002Ow-Kn
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:13:52 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eMcKU-0002MT-Aj
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:13:50 -0500
Received: by mail-wm0-x231.google.com with SMTP id b76so8122519wmg.1
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 08:13:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171206134957.GD12584@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171206134957.GD12584@stefanha-x1.localdomain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Dec 2017 16:13:48 +0000
Message-ID: <CAJSP0QVGLRnm8xQPLomJ5xdO1mTO3mgTx9VMQutw+gxyV8UTFw@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, zhiyong.yang@intel.com, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, avi.cohen@huawei.com, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Dec 6, 2017 at 1:49 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Tue, Dec 05, 2017 at 11:33:09AM +0800, Wei Wang wrote:
>> Vhost-pci is a point-to-point based inter-VM communication solution. This
>> patch series implements the vhost-pci-net device setup and emulation. The
>> device is implemented as a virtio device, and it is set up via the
>> vhost-user protocol to get the neessary info (e.g the memory info of the
>> remote VM, vring info).
>>
>> Currently, only the fundamental functions are implemented. More features,
>> such as MQ and live migration, will be updated in the future.
>>
>> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
>> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>
> I have asked questions about the scope of this feature.  In particular,
> I think it's best to support all device types rather than just
> virtio-net.  Here is a design document that shows how this can be
> achieved.
>
> What I'm proposing is different from the current approach:
> 1. It's a PCI adapter (see below for justification)
> 2. The vhost-user protocol is exposed by the device (not handled 100% in
>    QEMU).  Ultimately I think your approach would also need to do this.

Michael asked me to provide more information on the differences
between this patch series and my proposal:

My understanding of this patch series is: it adds a new virtio device
type called vhost-pci-net.  The QEMU vhost-pci-net code implements the
vhost-user protocol and then exposes virtio-net-specific functionality
to the guest.  This means the vhost-pci-net driver inside the guest
doesn't speak vhost-user, it speaks vhost-pci-net.  Currently no
virtqueues are defined so this is a very unusual virtio device.  It
also relies on a PCI BAR for shared memory access.  Some vhost-user
features like multiple virtqueues, logging (migration), etc are not
supported.

This proposal takes a different approach.  Instead of create a new
virtio device type (e.g. vhost-pci-net) for each device type (e.g.
virtio-net, virtio-scsi, virtio-blk), it defines a vhost-pci PCI
adapter that allows the guest to speak the vhost-user protocol.  The
vhost-pci device maps the vhost-user protocol to a PCI adapter so that
software running inside the guest can basically speak the vhost-user
protocol.  It requires less logic inside QEMU except to handle
vhost-user file descriptor passing.  It allows guests to decide
whether logging (migration) and other features are supported.  It
allows optimized irqfd <-> ioeventfd signalling which cannot be done
with regular virtio devices.

> I'm not implementing this and not asking you to implement it.  Let's
> just use this for discussion so we can figure out what the final
> vhost-pci will look like.
>
> Please let me know what you think, Wei, Michael, and others.
>
> ---
> vhost-pci device specification
> -------------------------------
> The vhost-pci device allows guests to act as vhost-user slaves.  This
> enables appliance VMs like network switches or storage targets to back
> devices in other VMs.  VM-to-VM communication is possible without
> vmexits using polling mode drivers.
>
> The vhost-user protocol has been used to implement virtio devices in
> userspace processes on the host.  vhost-pci maps the vhost-user protocol
> to a PCI adapter so guest software can perform virtio device emulation.
> This is useful in environments where high-performance VM-to-VM
> communication is necessary or where it is preferrable to deploy device
> emulation as VMs instead of host userspace processes.
>
> The vhost-user protocol involves file descriptor passing and shared
> memory.  This precludes vhost-user slave implementations over
> virtio-vsock, virtio-serial, or TCP/IP.  Therefore a new device type is
> needed to expose the vhost-user protocol to guests.
>
> The vhost-pci PCI adapter has the following resources:
>
> Queues (used for vhost-user protocol communication):
> 1. Master-to-slave messages
> 2. Slave-to-master messages
>
> Doorbells (used for slave->guest/master events):
> 1. Vring call (one doorbell per virtqueue)
> 2. Vring err (one doorbell per virtqueue)
> 3. Log changed
>
> Interrupts (used for guest->slave events):
> 1. Vring kick (one MSI per virtqueue)
>
> Shared Memory BARs:
> 1. Guest memory
> 2. Log
>
> Master-to-slave queue:
> The following vhost-user protocol messages are relayed from the
> vhost-user master.  Each message follows the vhost-user protocol
> VhostUserMsg layout.
>
> Messages that include file descriptor passing are relayed but do not
> carry file descriptors.  The relevant resources (doorbells, interrupts,
> or shared memory BARs) are initialized from the file descriptors prior
> to the message becoming available on the Master-to-Slave queue.
>
> Resources must only be used after the corresponding vhost-user message
> has been received.  For example, the Vring call doorbell can only be
> used after VHOST_USER_SET_VRING_CALL becomes available on the
> Master-to-Slave queue.
>
> Messages must be processed in order.
>
> The following vhost-user protocol messages are relayed:
>  * VHOST_USER_GET_FEATURES
>  * VHOST_USER_SET_FEATURES
>  * VHOST_USER_GET_PROTOCOL_FEATURES
>  * VHOST_USER_SET_PROTOCOL_FEATURES
>  * VHOST_USER_SET_OWNER
>  * VHOST_USER_SET_MEM_TABLE
>    The shared memory is available in the corresponding BAR.
>  * VHOST_USER_SET_LOG_BASE
>    The shared memory is available in the corresponding BAR.
>  * VHOST_USER_SET_LOG_FD
>    The logging file descriptor can be signalled through the logging
>    virtqueue.
>  * VHOST_USER_SET_VRING_NUM
>  * VHOST_USER_SET_VRING_ADDR
>  * VHOST_USER_SET_VRING_BASE
>  * VHOST_USER_GET_VRING_BASE
>  * VHOST_USER_SET_VRING_KICK
>    This message is still needed because it may indicate only polling
>    mode is supported.
>  * VHOST_USER_SET_VRING_CALL
>    This message is still needed because it may indicate only polling
>    mode is supported.
>  * VHOST_USER_SET_VRING_ERR
>  * VHOST_USER_GET_QUEUE_NUM
>  * VHOST_USER_SET_VRING_ENABLE
>  * VHOST_USER_SEND_RARP
>  * VHOST_USER_NET_SET_MTU
>  * VHOST_USER_SET_SLAVE_REQ_FD
>  * VHOST_USER_IOTLB_MSG
>  * VHOST_USER_SET_VRING_ENDIAN
>
> Slave-to-Master queue:
> Messages added to the Slave-to-Master queue are sent to the vhost-user
> master.  Each message follows the vhost-user protocol VhostUserMsg
> layout.
>
> The following vhost-user protocol messages are relayed:
>
>  * VHOST_USER_SLAVE_IOTLB_MSG
>
> Theory of Operation:
> When the vhost-pci adapter is detected the queues must be set up by the
> driver.  Once the driver is ready the vhost-pci device begins relaying
> vhost-user protocol messages over the Master-to-Slave queue.  The driver
> must follow the vhost-user protocol specification to implement
> virtio device initialization and virtqueue processing.
>
> Notes:
> The vhost-user UNIX domain socket connects two host processes.  The
> slave process interprets messages and initializes vhost-pci resources
> (doorbells, interrupts, shared memory BARs) based on them before
> relaying via the Master-to-Slave queue.  All messages are relayed, even
> if they only pass a file descriptor, because the message itself may act
> as a signal (e.g. virtqueue is now enabled).
>
> vhost-pci is a PCI adapter instead of a virtio device to allow doorbells
> and interrupts to be connected to the virtio device in the master VM in
> the most efficient way possible.  This means the Vring call doorbell can
> be an ioeventfd that signals an irqfd inside the host kernel without
> host userspace involvement.  The Vring kick interrupt can be an irqfd
> that is signalled by the master VM's virtqueue ioeventfd.
>
> It may be possible to write a Linux vhost-pci driver that implements the
> drivers/vhost/ API.  That way existing vhost drivers could work with
> vhost-pci in the kernel.
>
> Guest userspace vhost-pci drivers will be similar to QEMU's
> contrib/libvhost-user/ except they will probably use vfio to access the
> vhost-pci device directly from userspace.
>
> TODO:
>  * Queue memory layout and hardware registers
>  * vhost-pci-level negotiation and configuration so the hardware
>    interface can be extended in the future.
>  * vhost-pci <-> driver initialization procedure
>  * Master<->Slave disconnected & reconnect
