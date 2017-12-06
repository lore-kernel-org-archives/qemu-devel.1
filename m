Received: from eggs.gnu.org ([2001:4830:134:3::10]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMcGb-0007Wz-1A
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMcGX-0006vW-MU
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:09:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:6056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eMcGX-0006v6-9C
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:09:45 -0500
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Wed, 6 Dec 2017 16:09:40 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171206134957.GD12584@stefanha-x1.localdomain>
In-Reply-To: <20171206134957.GD12584@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "Yang, Zhiyong" <zhiyong.yang@intel.com>

On Wednesday, December 6, 2017 9:50 PM, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 11:33:09AM +0800, Wei Wang wrote:
> > Vhost-pci is a point-to-point based inter-VM communication solution.
> > This patch series implements the vhost-pci-net device setup and
> > emulation. The device is implemented as a virtio device, and it is set
> > up via the vhost-user protocol to get the neessary info (e.g the
> > memory info of the remote VM, vring info).
> >
> > Currently, only the fundamental functions are implemented. More
> > features, such as MQ and live migration, will be updated in the future.
> >
> > The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
> > http://dpdk.org/ml/archives/dev/2017-November/082615.html
>=20
> I have asked questions about the scope of this feature.  In particular, I=
 think
> it's best to support all device types rather than just virtio-net.  Here =
is a
> design document that shows how this can be achieved.
>=20
> What I'm proposing is different from the current approach:
> 1. It's a PCI adapter (see below for justification) 2. The vhost-user pro=
tocol is
> exposed by the device (not handled 100% in
>    QEMU).  Ultimately I think your approach would also need to do this.
>=20
> I'm not implementing this and not asking you to implement it.  Let's just=
 use
> this for discussion so we can figure out what the final vhost-pci will lo=
ok like.
>=20
> Please let me know what you think, Wei, Michael, and others.
>=20

Thanks for sharing the thoughts. If I understand it correctly, the key diff=
erence is that this approach tries to relay every vhost-user msg to the gue=
st. I'm not sure about the benefits of doing this.=20
To make data plane (i.e. driver to send/receive packets) work, I think, mos=
tly, the memory info and vring info are enough. Other things like callfd, k=
ickfd don't need to be sent to the guest, they are needed by QEMU only for =
the eventfd and irqfd setup.



> ---
> vhost-pci device specification
> -------------------------------
> The vhost-pci device allows guests to act as vhost-user slaves.  This ena=
bles
> appliance VMs like network switches or storage targets to back devices in
> other VMs.  VM-to-VM communication is possible without vmexits using
> polling mode drivers.
>=20
> The vhost-user protocol has been used to implement virtio devices in
> userspace processes on the host.  vhost-pci maps the vhost-user protocol =
to
> a PCI adapter so guest software can perform virtio device emulation.
> This is useful in environments where high-performance VM-to-VM
> communication is necessary or where it is preferrable to deploy device
> emulation as VMs instead of host userspace processes.
>=20
> The vhost-user protocol involves file descriptor passing and shared memor=
y.
> This precludes vhost-user slave implementations over virtio-vsock, virtio=
-
> serial, or TCP/IP.  Therefore a new device type is needed to expose the
> vhost-user protocol to guests.
>=20
> The vhost-pci PCI adapter has the following resources:
>=20
> Queues (used for vhost-user protocol communication):
> 1. Master-to-slave messages
> 2. Slave-to-master messages
>=20
> Doorbells (used for slave->guest/master events):
> 1. Vring call (one doorbell per virtqueue) 2. Vring err (one doorbell per
> virtqueue) 3. Log changed
>=20
> Interrupts (used for guest->slave events):
> 1. Vring kick (one MSI per virtqueue)
>=20
> Shared Memory BARs:
> 1. Guest memory
> 2. Log
>=20
> Master-to-slave queue:
> The following vhost-user protocol messages are relayed from the vhost-use=
r
> master.  Each message follows the vhost-user protocol VhostUserMsg layout=
.
>=20
> Messages that include file descriptor passing are relayed but do not carr=
y file
> descriptors.  The relevant resources (doorbells, interrupts, or shared me=
mory
> BARs) are initialized from the file descriptors prior to the message beco=
ming
> available on the Master-to-Slave queue.
>=20
> Resources must only be used after the corresponding vhost-user message
> has been received.  For example, the Vring call doorbell can only be used
> after VHOST_USER_SET_VRING_CALL becomes available on the Master-to-
> Slave queue.
>=20
> Messages must be processed in order.
>=20
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
>=20
> Slave-to-Master queue:
> Messages added to the Slave-to-Master queue are sent to the vhost-user
> master.  Each message follows the vhost-user protocol VhostUserMsg layout=
.
>=20
> The following vhost-user protocol messages are relayed:
>=20
>  * VHOST_USER_SLAVE_IOTLB_MSG
>=20
> Theory of Operation:
> When the vhost-pci adapter is detected the queues must be set up by the
> driver.  Once the driver is ready the vhost-pci device begins relaying vh=
ost-
> user protocol messages over the Master-to-Slave queue.  The driver must
> follow the vhost-user protocol specification to implement virtio device
> initialization and virtqueue processing.
>=20
> Notes:
> The vhost-user UNIX domain socket connects two host processes.  The slave
> process interprets messages and initializes vhost-pci resources (doorbell=
s,
> interrupts, shared memory BARs) based on them before relaying via the
> Master-to-Slave queue.  All messages are relayed, even if they only pass =
a
> file descriptor, because the message itself may act as a signal (e.g. vir=
tqueue
> is now enabled).
>=20
> vhost-pci is a PCI adapter instead of a virtio device to allow doorbells =
and
> interrupts to be connected to the virtio device in the master VM in the m=
ost
> efficient way possible.  This means the Vring call doorbell can be an
> ioeventfd that signals an irqfd inside the host kernel without host users=
pace
> involvement.  The Vring kick interrupt can be an irqfd that is signalled =
by the
> master VM's virtqueue ioeventfd.
>=20


This looks the same as the implementation of inter-VM notification in v2:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg450005.html
which is fig. 4 here: https://github.com/wei-w-wang/vhost-pci-discussion/bl=
ob/master/vhost-pci-rfc2.0.pdf

When the vhost-pci driver kicks its tx, the host signals the irqfd of virti=
o-net's rx. I think this has already bypassed the host userspace (thanks to=
 the fast mmio implementation)

Best,
Wei
