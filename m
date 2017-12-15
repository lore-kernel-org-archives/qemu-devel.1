Received: from eggs.gnu.org ([2001:4830:134:3::10]:59381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePlz2-0002xQ-UK
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePlyy-0003UK-Td
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:08:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:62155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ePlyy-0003Od-Gl
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:08:40 -0500
Message-ID: <5A33918D.5040500@intel.com>
Date: Fri, 15 Dec 2017 17:10:37 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<5A3211CC.60607@intel.com>
	<20171214173231.GS14433@stefanha-x1.localdomain>
In-Reply-To: <20171214173231.GS14433@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On 12/15/2017 01:32 AM, Stefan Hajnoczi wrote:
> On Thu, Dec 14, 2017 at 01:53:16PM +0800, Wei Wang wrote:
>> On 12/13/2017 08:35 PM, Stefan Hajnoczi wrote:
>>> On Wed, Dec 13, 2017 at 04:11:45PM +0800, Wei Wang wrote:
>>>
>>> I think the current approach is fine for a prototype but is not suitable
>>> for wider use by the community because it:
>>> 1. Does not scale to multiple device types (net, scsi, blk, etc)
>>> 2. Does not scale as the vhost-user protocol changes
>>> 3. It is hard to make slaves run in both host userspace and the guest
>>>
>>> It would be good to solve these problems so that vhost-pci can become
>>> successful.  It's very hard to fix these things after the code is merged
>>> because guests will depend on the device interface.
>>>
>>> Here are the points in detail (in order of importance):
>>>
>>> 1. Does not scale to multiple device types (net, scsi, blk, etc)
>>>
>>> vhost-user is being applied to new device types beyond virtio-net.
>>> There will be demand for supporting other device types besides
>>> virtio-net with vhost-pci.
>>>
>>> This patch series requires defining a new virtio device type for each
>>> vhost-user device type.  It is a lot of work to design a new virtio
>>> device.  Additionally, the new virtio device type should become part of
>>> the VIRTIO standard, which can also take some time and requires writing
>>> a standards document.
>>>
>>> 2. Does not scale as the vhost-user protocol changes
>>>
>>> When the vhost-user protocol changes it will be necessary to update the
>>> vhost-pci device interface to reflect those changes.  Each protocol
>>> change requires thinking how the virtio devices need to look in order to
>>> support the new behavior.  Changes to the vhost-user protocol will
>>> result in changes to the VIRTIO specification for the vhost-pci virtio
>>> devices.
>>>
>>> 3. It is hard to make slaves run in both host userspace and the guest
>>>
>>> If a vhost-user slave wishes to support running in host userspace and
>>> the guest then not much code can be shared between these two modes since
>>> the interfaces are so different.
>>>
>>> How would you solve these issues?
>> 1st one: I think we can factor out a common vhost-pci device layer in QEMU.
>> Specific devices (net, scsi etc) emulation comes on top of it. The
>> vhost-user protocol sets up VhostPCIDev only. So we will have something like
>> this:
>>
>> struct VhostPCINet {
>>      struct VhostPCIDev vp_dev;
>>      u8 mac[8];
>>      ....
>> }
> Defining VhostPCIDev is an important step to making it easy to implement
> other device types.  I'm interested is seeing how this would look either
> in code or in a more detailed outline.
>
> I wonder what the device-specific parts will be.  This patch series does
> not implement a fully functional vhost-user-net device so I'm not sure.

I think we can move most of the fields from this series' VhostPCINet to 
VhostPCIDev:

struct VhostPCIDev {
VirtIODevice parent_obj;
MemoryRegion bar_region;
MemoryRegion metadata_region;
struct vhost_pci_metadata *metadata;
void *remote_mem_base[MAX_REMOTE_REGION];
uint64_t remote_mem_map_size[MAX_REMOTE_REGION];
CharBackend chr_be;
};

struct VhostPCINet {
struct VhostPCIDev vp_dev;
uint32_t host_features;
struct vpnet_config config;
size_t config_size;
uint16_t status;
}




>
>> 2nd one: I think we need to view it the other way around: If there is a
>> demand to change the protocol, then where is the demand from? I think mostly
>> it is because there is some new features from the device/driver. That is, we
>> first have already thought about how the virtio device looks like with the
>> new feature, then we add the support to the protocol.
> The vhost-user protocol will change when people using host userspace
> slaves decide to change it.  They may not know or care about vhost-pci,
> so the virtio changes will be an afterthought that falls on whoever
> wants to support vhost-pci.
>
> This is why I think it makes a lot more sense to stick to the vhost-user
> protocol as the vhost-pci slave interface instead of inventing a new
> interface on top of it.

I don't think it is different in practice. If the added protocol msg 
needs some setup on the vhost-pci device side, then we will also need to 
think about how to use it for the device setup explicitly, with the 
possibility of delivering the modified msg to the guest (like 
SET_MEM_TABLE) if using the relaying method.

Vhost-pci takes "advantage" of the vhost-user protocol for the inter-VM 
data path setup. If the added vhost-user message isn't useful for 
vhost-pci setup, I think the slave don't need to handle it even.



>
>> I'm not sure how would
>> it cause not scaling well, and how using another GuestSlave-to-QemuMaster
>> changes the story (we will also need to patch the GuestSlave inside the VM
>> to support the vhost-user negotiation of the new feature), in comparison to
>> the standard virtio feature negotiation.
> Plus the VIRTIO specification needs to be updated.
>
> And if the vhost-user protocol change affects all device types then it
> may be necessary to change multiple virtio devices!  This is O(1) vs
> O(N).
>

If this change is common to all the vhost-pci series devices, the change 
will be made to the vhost-pci layer (i.e. VhostPCIDev) only.


Best,
Wei
