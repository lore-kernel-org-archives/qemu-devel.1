Received: from eggs.gnu.org ([2001:4830:134:3::10]:47422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eNCLQ-0002UE-66
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eNCLN-0008MN-1t
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:41:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:45174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eNCLM-0008Lb-MY
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:41:08 -0500
Message-ID: <5A2A347B.9070006@intel.com>
Date: Fri, 08 Dec 2017 14:43:07 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <5A28BC2D.6000308@intel.com>
	<CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
	<5A290398.60508@intel.com>
	<CAJSP0QURjdD8BnOmJo83fzJn_zCijSKQh==Pz+Xu4r6Q2i3SkQ@mail.gmail.com>
	<20171207153454-mutt-send-email-mst@kernel.org>
	<CAJSP0QVu4iwAu01Sth84VZshQde97x3FW1E1ua_YXVKs-65vhQ@mail.gmail.com>
	<20171207183945-mutt-send-email-mst@kernel.org>
	<CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
	<20171207193003-mutt-send-email-mst@kernel.org>
	<CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171207213420-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On 12/08/2017 07:54 AM, Michael S. Tsirkin wrote:
> On Thu, Dec 07, 2017 at 06:28:19PM +0000, Stefan Hajnoczi wrote:
>> On Thu, Dec 7, 2017 at 5:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Thu, Dec 07, 2017 at 05:29:14PM +0000, Stefan Hajnoczi wrote:
>>>> On Thu, Dec 7, 2017 at 4:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> On Thu, Dec 07, 2017 at 04:29:45PM +0000, Stefan Hajnoczi wrote:
>>>>>> On Thu, Dec 7, 2017 at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>> On Thu, Dec 07, 2017 at 01:08:04PM +0000, Stefan Hajnoczi wrote:
>>>>>>>> Instead of responding individually to these points, I hope this will
>>>>>>>> explain my perspective.  Let me know if you do want individual
>>>>>>>> responses, I'm happy to talk more about the points above but I think
>>>>>>>> the biggest difference is our perspective on this:
>>>>>>>>
>>>>>>>> Existing vhost-user slave code should be able to run on top of
>>>>>>>> vhost-pci.  For example, QEMU's
>>>>>>>> contrib/vhost-user-scsi/vhost-user-scsi.c should work inside the guest
>>>>>>>> with only minimal changes to the source file (i.e. today it explicitly
>>>>>>>> opens a UNIX domain socket and that should be done by libvhost-user
>>>>>>>> instead).  It shouldn't be hard to add vhost-pci vfio support to
>>>>>>>> contrib/libvhost-user/ alongside the existing UNIX domain socket code.
>>>>>>>>
>>>>>>>> This seems pretty easy to achieve with the vhost-pci PCI adapter that
>>>>>>>> I've described but I'm not sure how to implement libvhost-user on top
>>>>>>>> of vhost-pci vfio if the device doesn't expose the vhost-user
>>>>>>>> protocol.
>>>>>>>>
>>>>>>>> I think this is a really important goal.  Let's use a single
>>>>>>>> vhost-user software stack instead of creating a separate one for guest
>>>>>>>> code only.
>>>>>>>>
>>>>>>>> Do you agree that the vhost-user software stack should be shared
>>>>>>>> between host userspace and guest code as much as possible?
>>>>>>>
>>>>>>>
>>>>>>> The sharing you propose is not necessarily practical because the security goals
>>>>>>> of the two are different.
>>>>>>>
>>>>>>> It seems that the best motivation presentation is still the original rfc
>>>>>>>
>>>>>>> http://virtualization.linux-foundation.narkive.com/A7FkzAgp/rfc-vhost-user-enhancements-for-vm2vm-communication
>>>>>>>
>>>>>>> So comparing with vhost-user iotlb handling is different:
>>>>>>>
>>>>>>> With vhost-user guest trusts the vhost-user backend on the host.
>>>>>>>
>>>>>>> With vhost-pci we can strive to limit the trust to qemu only.
>>>>>>> The switch running within a VM does not have to be trusted.
>>>>>> Can you give a concrete example?
>>>>>>
>>>>>> I have an idea about what you're saying but it may be wrong:
>>>>>>
>>>>>> Today the iotlb mechanism in vhost-user does not actually enforce
>>>>>> memory permissions.  The vhost-user slave has full access to mmapped
>>>>>> memory regions even when iotlb is enabled.  Currently the iotlb just
>>>>>> adds an indirection layer but no real security.  (Is this correct?)
>>>>> Not exactly. iotlb protects against malicious drivers within guest.
>>>>> But yes, not against a vhost-user driver on the host.
>>>>>
>>>>>> Are you saying the vhost-pci device code in QEMU should enforce iotlb
>>>>>> permissions so the vhost-user slave guest only has access to memory
>>>>>> regions that are allowed by the iotlb?
>>>>> Yes.
>>>> Okay, thanks for confirming.
>>>>
>>>> This can be supported by the approach I've described.  The vhost-pci
>>>> QEMU code has control over the BAR memory so it can prevent the guest
>>>> from accessing regions that are not allowed by the iotlb.
>>>>
>>>> Inside the guest the vhost-user slave still has the memory region
>>>> descriptions and sends iotlb messages.  This is completely compatible
>>>> with the libvirt-user APIs and existing vhost-user slave code can run
>>>> fine.  The only unique thing is that guest accesses to memory regions
>>>> not allowed by the iotlb do not work because QEMU has prevented it.
>>> I don't think this can work since suddenly you need
>>> to map full IOMMU address space into BAR.
>> The BAR covers all guest RAM
>> but QEMU can set up MemoryRegions that
>> hide parts from the guest (e.g. reads produce 0xff).  I'm not sure how
>> expensive that is but implementing a strict IOMMU is hard to do
>> without performance overhead.
> I'm worried about leaking PAs.
> fundamentally if you want proper protection you
> need your device driver to use VA for addressing,
>
> On the one hand BAR only needs to be as large as guest PA then.
> On the other hand it must cover all of guest PA,
> not just what is accessible to the device.
>
>
>>> Besides, this means implementing iotlb in both qemu and guest.
>> It's free in the guest, the libvhost-user stack already has it.
> That library is designed to work with a unix domain socket
> though. We'll need extra kernel code to make a device
> pretend it's a socket.
>
>>>> If better performance is needed then it might be possible to optimize
>>>> this interface by handling most or even all of the iotlb stuff in QEMU
>>>> vhost-pci code and not exposing it to the vhost-user slave in the
>>>> guest.  But it doesn't change the fact that the vhost-user protocol
>>>> can be used and the same software stack works.
>>> For one, the iotlb part would be out of scope then.
>>> Instead you would have code to offset from BAR.
>>>
>>>> Do you have a concrete example of why sharing the same vhost-user
>>>> software stack inside the guest can't work?
>>> With enough dedication some code might be shared.  OTOH reusing virtio
>>> gains you a ready feature negotiation and discovery protocol.
>>>
>>> I'm not convinced which has more value, and the second proposal
>>> has been implemented already.
>> Thanks to you and Wei for the discussion.  I've learnt a lot about
>> vhost-user.  If you have questions about what I've posted, please let
>> me know and we can discuss further.
>>
>> The decision is not up to me so I'll just summarize what the vhost-pci
>> PCI adapter approach achieves:
>> 1. Just one device and driver
>> 2. Support for all device types (net, scsi, blk, etc)
>> 3. Reuse of software stack so vhost-user slaves can run in both host
>> userspace and the guest
>> 4. Simpler to debug because the vhost-user protocol used by QEMU is
>> also used by the guest
>>
>> Stefan

Thanks Stefan and Michael for the sharing and discussion. I think above 
3 and 4 are debatable (e.g. whether it is simpler really depends). 1 and 
2 are implementations, I think both approaches could implement the 
device that way. We originally thought about one device and driver to 
support all types (called it transformer sometimes :-) ), that would 
look interesting from research point of view, but from real usage point 
of view, I think it would be better to have them separated, because:
- different device types have different driver logic, mixing them 
together would cause the driver to look messy. Imagine that a networking 
driver developer has to go over the block related code to debug, that 
also increases the difficulty.
- For the kernel driver (looks like some people from Huawei are 
interested in that), I think users may want to see a standard network 
device and driver. If we mix all the types together, not sure what type 
of device will it be (misc?).
Please let me know if you have a different viewpoint.

Btw, from your perspective, what would be the practical usage of 
vhost-pci-blk?


Best,
Wei
