Received: from eggs.gnu.org ([2001:4830:134:3::10]:53328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePMQT-0000hJ-OL
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 00:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePMQO-0007E6-P4
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 00:51:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:29020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ePMQO-00079u-ET
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 00:51:16 -0500
Message-ID: <5A3211CC.60607@intel.com>
Date: Thu, 14 Dec 2017 13:53:16 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171207193003-mutt-send-email-mst@kernel.org>
	<CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
In-Reply-To: <20171213123521.GL16782@stefanha-x1.localdomain>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On 12/13/2017 08:35 PM, Stefan Hajnoczi wrote:
> On Wed, Dec 13, 2017 at 04:11:45PM +0800, Wei Wang wrote:
>
> I think the current approach is fine for a prototype but is not suitable
> for wider use by the community because it:
> 1. Does not scale to multiple device types (net, scsi, blk, etc)
> 2. Does not scale as the vhost-user protocol changes
> 3. It is hard to make slaves run in both host userspace and the guest
>
> It would be good to solve these problems so that vhost-pci can become
> successful.  It's very hard to fix these things after the code is merged
> because guests will depend on the device interface.
>
> Here are the points in detail (in order of importance):
>
> 1. Does not scale to multiple device types (net, scsi, blk, etc)
>
> vhost-user is being applied to new device types beyond virtio-net.
> There will be demand for supporting other device types besides
> virtio-net with vhost-pci.
>
> This patch series requires defining a new virtio device type for each
> vhost-user device type.  It is a lot of work to design a new virtio
> device.  Additionally, the new virtio device type should become part of
> the VIRTIO standard, which can also take some time and requires writing
> a standards document.
>
> 2. Does not scale as the vhost-user protocol changes
>
> When the vhost-user protocol changes it will be necessary to update the
> vhost-pci device interface to reflect those changes.  Each protocol
> change requires thinking how the virtio devices need to look in order to
> support the new behavior.  Changes to the vhost-user protocol will
> result in changes to the VIRTIO specification for the vhost-pci virtio
> devices.
>
> 3. It is hard to make slaves run in both host userspace and the guest
>
> If a vhost-user slave wishes to support running in host userspace and
> the guest then not much code can be shared between these two modes since
> the interfaces are so different.
>
> How would you solve these issues?

1st one: I think we can factor out a common vhost-pci device layer in 
QEMU. Specific devices (net, scsi etc) emulation comes on top of it. The 
vhost-user protocol sets up VhostPCIDev only. So we will have something 
like this:

struct VhostPCINet {
     struct VhostPCIDev vp_dev;
     u8 mac[8];
     ....
}


2nd one: I think we need to view it the other way around: If there is a 
demand to change the protocol, then where is the demand from? I think 
mostly it is because there is some new features from the device/driver. 
That is, we first have already thought about how the virtio device looks 
like with the new feature, then we add the support to the protocol. I'm 
not sure how would it cause not scaling well, and how using another 
GuestSlave-to-QemuMaster changes the story (we will also need to patch 
the GuestSlave inside the VM to support the vhost-user negotiation of 
the new feature), in comparison to the standard virtio feature negotiation.


3rd one: I'm not able to solve this one, as discussed, there are too 
many differences and it's too complex. I prefer the direction of simply 
gating the vhost-user protocol and deliver to the guest what it should 
see (just what this patch series shows). You would need to solve this 
issue to show this direction is simpler :)


Best,
Wei
