Received: from eggs.gnu.org ([2001:4830:134:3::10]:33014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eP26x-0004f7-Mx
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 03:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eP26t-00046T-Pl
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 03:09:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:56321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eP26t-00045A-Aa
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 03:09:47 -0500
Message-ID: <5A30E0C1.3070905@intel.com>
Date: Wed, 13 Dec 2017 16:11:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171207183945-mutt-send-email-mst@kernel.org>
	<CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
	<20171207193003-mutt-send-email-mst@kernel.org>
	<CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
In-Reply-To: <20171212101440.GB6985@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/12/2017 06:14 PM, Stefan Hajnoczi wrote:
> On Mon, Dec 11, 2017 at 01:53:40PM +0000, Wang, Wei W wrote:
>> On Monday, December 11, 2017 7:12 PM, Stefan Hajnoczi wrote:
>>> On Sat, Dec 09, 2017 at 04:23:17PM +0000, Wang, Wei W wrote:
>>>> On Friday, December 8, 2017 4:34 PM, Stefan Hajnoczi wrote:
>>>>> On Fri, Dec 8, 2017 at 6:43 AM, Wei Wang <wei.w.wang@intel.com>
>>> wrote:
>>>>>> On 12/08/2017 07:54 AM, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Dec 07, 2017 at 06:28:19PM +0000, Stefan Hajnoczi wrote:
>>>>>>>> On Thu, Dec 7, 2017 at 5:38 PM, Michael S. Tsirkin
>>>>>>>> <mst@redhat.com>
>>>>>> Thanks Stefan and Michael for the sharing and discussion. I
>>>>>> think above 3 and 4 are debatable (e.g. whether it is simpler
>>>>>> really depends). 1 and 2 are implementations, I think both
>>>>>> approaches could implement the device that way. We originally
>>>>>> thought about one device and driver to support all types (called
>>>>>> it transformer sometimes :-) ), that would look interesting from
>>>>>> research point of view, but from real usage point of view, I
>>>>>> think it would be better to have them separated,
>>>>> because:
>>>>>> - different device types have different driver logic, mixing
>>>>>> them together would cause the driver to look messy. Imagine that
>>>>>> a networking driver developer has to go over the block related
>>>>>> code to debug, that also increases the difficulty.
>>>>> I'm not sure I understand where things get messy because:
>>>>> 1. The vhost-pci device implementation in QEMU relays messages but
>>>>> has no device logic, so device-specific messages like
>>>>> VHOST_USER_NET_SET_MTU are trivial at this layer.
>>>>> 2. vhost-user slaves only handle certain vhost-user protocol messages.
>>>>> They handle device-specific messages for their device type only.
>>>>> This is like vhost drivers today where the ioctl() function
>>>>> returns an error if the ioctl is not supported by the device.  It's not messy.
>>>>>
>>>>> Where are you worried about messy driver logic?
>>>> Probably I didn’t explain well, please let me summarize my thought a
>>>> little
>>> bit, from the perspective of the control path and data path.
>>>> Control path: the vhost-user messages - I would prefer just have the
>>>> interaction between QEMUs, instead of relaying to the GuestSlave,
>>>> because
>>>> 1) I think the claimed advantage (easier to debug and develop)
>>>> doesn’t seem very convincing
>>> You are defining a mapping from the vhost-user protocol to a custom
>>> virtio device interface.  Every time the vhost-user protocol (feature
>>> bits, messages,
>>> etc) is extended it will be necessary to map this new extension to the
>>> virtio device interface.
>>>
>>> That's non-trivial.  Mistakes are possible when designing the mapping.
>>> Using the vhost-user protocol as the device interface minimizes the
>>> effort and risk of mistakes because most messages are relayed 1:1.
>>>
>>>> 2) some messages can be directly answered by QemuSlave , and some
>>> messages are not useful to give to the GuestSlave (inside the VM),
>>> e.g. fds, VhostUserMemoryRegion from SET_MEM_TABLE msg (the device
>>> first maps the master memory and gives the offset (in terms of the
>>> bar, i.e., where does it sit in the bar) of the mapped gpa to the
>>> guest. if we give the raw VhostUserMemoryRegion to the guest, that wouldn’t be usable).
>>>
>>> I agree that QEMU has to handle some of messages, but it should still
>>> relay all (possibly modified) messages to the guest.
>>>
>>> The point of using the vhost-user protocol is not just to use a
>>> familiar binary encoding, it's to match the semantics of vhost-user
>>> 100%.  That way the vhost-user software stack can work either in host
>>> userspace or with vhost-pci without significant changes.
>>>
>>> Using the vhost-user protocol as the device interface doesn't seem any
>>> harder than defining a completely new virtio device interface.  It has
>>> the advantages that I've pointed out:
>>>
>>> 1. Simple 1:1 mapping for most that is easy to maintain as the
>>>     vhost-user protocol grows.
>>>
>>> 2. Compatible with vhost-user so slaves can run in host userspace
>>>     or the guest.
>>>
>>> I don't see why it makes sense to define new device interfaces for
>>> each device type and create a software stack that is incompatible with vhost-user.
>>
>> I think this 1:1 mapping wouldn't be easy:
>>
>> 1) We will have 2 Qemu side slaves to achieve this bidirectional relaying, that is, the working model will be
>> - master to slave: Master->QemuSlave1->GuestSlave; and
>> - slave to master: GuestSlave->QemuSlave2->Master
>> QemuSlave1 and QemuSlave2 can't be the same piece of code, because QemuSlave1 needs to do some setup with some messages, and QemuSlave2 is more likely to be a true "relayer" (receive and directly pass on)
> I mostly agree with this.  Some messages cannot be passed through.  QEMU
> needs to process some messages so that makes it both a slave (on the
> host) and a master (to the guest).
>
>> 2) poor re-usability of the QemuSlave and GuestSlave
>> We couldn’t reuse much of the QemuSlave handling code for GuestSlave.
>> For example, for the VHOST_USER_SET_MEM_TABLE msg, all the QemuSlave handling code (please see the vp_slave_set_mem_table function), won't be used by GuestSlave. On the other hand, GuestSlave needs an implementation to reply back to the QEMU device, and this implementation isn't needed by QemuSlave.
>>   If we want to run the same piece of the slave code in both QEMU and guest, then we may need "if (QemuSlave) else" in each msg handling entry to choose the code path for QemuSlave and GuestSlave separately.
>> So, ideally we wish to run (reuse) one slave implementation in both QEMU and guest. In practice, we will still need to handle them each case by case, which is no different than maintaining two separate slaves for QEMU and guest, and I'm afraid this would be much more complex.
> Are you saying QEMU's vhost-pci code cannot be reused by guest slaves?
> If so, I agree and it was not my intention to run the same slave code in
> QEMU and the guest.

Yes, it is too difficult to reuse in practice.

>
> When I referred to reusing the vhost-user software stack I meant
> something else:
>
> 1. contrib/libvhost-user/ is a vhost-user slave library.  QEMU itself
> does not use it but external programs may use it to avoid reimplementing
> vhost-user and vrings.  Currently this code handles the vhost-user
> protocol over UNIX domain sockets, but it's possible to add vfio
> vhost-pci support.  Programs using libvhost-user would be able to take
> advantage of vhost-pci easily (no big changes required).
>
> 2. DPDK and other codebases that implement custom vhost-user slaves are
> also easy to update for vhost-pci since the same protocol is used.  Only
> the lowest layer of vhost-user slave code needs to be touched.

I'm not sure if libvhost-user would be limited to be used by QEMU only 
in practice. For example, DPDK currently implements its own vhost-user 
slave, and changing to use libvhost-user may require dpdk to be bound 
with QEMU, that is, applications like OVS-DPDK will have a dependency on 
QEMU. Probably people wouldn't want it this way.

On the other side, vhost-pci is more coupled with the QEMU 
implementation, because some of the msg handling will need to do some 
device setup (e.g. mmap memory and add sub MemoryRegion to the bar). 
This device emulation related code is specific to QEMU, so I think 
vhost-pci slave may not be reused by applications other than QEMU.

Would it be acceptable to use the vhost-pci slave from this patch series 
as the initial solution? It is already implemented, and we can 
investigate the possibility of integrating it into the libvhost-user as 
the next step.

Best,
Wei
