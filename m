Received: from eggs.gnu.org ([2001:4830:134:3::10]:60621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ePDKJ-0001c9-Ot
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ePDKI-0002Il-Kz
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:08:23 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ePDKI-0002IQ-B9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:08:22 -0500
Received: by mail-wr0-x241.google.com with SMTP id v105so3209862wrc.3
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 12:08:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171213165142-mutt-send-email-mst@kernel.org>
References: <CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<20171213165142-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 13 Dec 2017 20:08:19 +0000
Message-ID: <CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On Wed, Dec 13, 2017 at 3:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Dec 13, 2017 at 12:35:21PM +0000, Stefan Hajnoczi wrote:
>> I'm not saying that DPDK should use libvhost-user.  I'm saying that it's
>> easy to add vfio vhost-pci support (for the PCI adapter I described) to
>> DPDK.  This patch series would require writing a completely new slave
>> for vhost-pci because the device interface is so different from
>> vhost-user.
>
> The main question is how appropriate is the vhost user protocol
> for passing to guests. And I am not sure at this point.
>
> Someone should go over vhost user messages and see whether they are safe
> to pass to guest. If most are then we can try the transparent approach.
> If most aren't then we can't and might as well use the proposed protocol
> which at least has code behind it.

I have done that:

Master message types
--------------------

 * VHOST_USER_GET_FEATURES

   Safe to pass through.

 * VHOST_USER_SET_FEATURES

   Safe to pass through.

 * VHOST_USER_GET_PROTOCOL_FEATURES

   QEMU must mask unsupported VHOST_USER_PROTOCOL_F_* bits that the guest set.

 * VHOST_USER_SET_PROTOCOL_FEATURES

   Safe to pass through.

 * VHOST_USER_SET_OWNER

   Safe to pass through.

 * VHOST_USER_RESET_OWNER

   Unused message, ignore and do not pass through.

 * VHOST_USER_SET_MEM_TABLE

   Set up BARs before sending a VHOST_USER_SET_MEM_TABLE to the guest.

 * VHOST_USER_SET_LOG_BASE

   Set up log shared memory region before sending VHOST_USER_SET_LOG_BASE to
   the guest.

 * VHOST_USER_SET_LOG_FD

   Set up log doorbell before sending VHOST_USER_SET_LOG_FD to the guest.

 * VHOST_USER_SET_VRING_NUM

   Safe to pass through.

 * VHOST_USER_SET_VRING_ADDR

   Passthrough if QEMU isn't doing IOMMU.  Otherwise remap the addresses before
   passing them to the guest.

 * VHOST_USER_SET_VRING_BASE

   Safe to pass through.

 * VHOST_USER_GET_VRING_BASE

   Safe to pass through.

 * VHOST_USER_SET_VRING_KICK

   Set up vring kick doorbell (unless bit 8 is set) before sending
   VHOST_USER_SET_VRING_KICK to the guest.

 * VHOST_USER_SET_VRING_CALL

   Set up the vring call doorbell (unless bit 8 is set) before sending
   VHOST_USER_SET_VRING_CALL to the guest.

 * VHOST_USER_SET_VRING_ERR

   Set up the vring err doorbell (unless bit 8 is set) before sending
   VHOST_USER_SET_VRING_ERR to the guest.

 * VHOST_USER_GET_QUEUE_NUM

   Safe to pass through.

 * VHOST_USER_SET_VRING_ENABLE

   Safe to pass through.

 * VHOST_USER_SEND_RARP

   Safe to pass through.

 * VHOST_USER_NET_SET_MTU

   Safe to pass through.

 * VHOST_USER_SET_SLAVE_REQ_FD

   Stash slave req fd so that Slave-to-Master queue messages can be relayed
   before sending VHOST_USER_SET_SLAVE_REQ_FD to guest.

 * VHOST_USER_IOTLB_MSG

   Translate addresses if QEMU implements IOMMU before sending
   VHOST_USER_IOTLB_MSG to the guest.

 * VHOST_USER_SET_VRING_ENDIAN

   Safe to pass through.

Slave message types
-------------------

 * VHOST_USER_SLAVE_IOTLB_MSG

   Handled by QEMU if it implements the IOMMU.

> I took a quick look and I doubt we can do something that is both
> compatible with the existing vhost-user and will make it possible to
> extend the protocol without qemu changes. Let's assume I pass a new
> message over the vhost-user channel.  How do we know it's safe to pass
> it to the guest?
>
> That's why we gate any protocol change on a feature bit and must parse
> all messages.

QEMU must parse all messages and cannot pass through unknown messages.
Think of QEMU vhost-pci as both a vhost-user slave to the other VM and
a vhost-user master to the guest.

QEMU changes are necessary when the vhost protocol is extended.
Device interface changes are only necessary if doorbells or shared
memory regions are added, any other protocol changes do not change the
device interface.

Stefan
