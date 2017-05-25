Received: from eggs.gnu.org ([2001:4830:134:3::10]:48590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dDrtm-0004VK-Pz
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dDrtj-0006l8-Kh
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:29:50 -0400
Received: from foss.arm.com ([217.140.101.70]:57040)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dDrtj-0006kJ-Ce
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:29:47 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-2-git-send-email-yi.l.liu@intel.com>
	<c042bf90-d48b-4ebf-c01a-fca7c4875277@arm.com>
	<20170428090458.GB15484@sky-dev>
	<3adb4e33-db96-4133-0510-412c3bfb24fe@arm.com>
	<20170523075049.GA3955@sky-dev>
Message-ID: <e076dbd6-05bd-b13b-d457-24a0cff48fd6@arm.com>
Date: Thu, 25 May 2017 13:33:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170523075049.GA3955@sky-dev>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/8] iommu: Introduce bind_pasid_table
 API function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, ashok.raj@intel.com, jasowang@redhat.com, qemu-devel@nongnu.org, jacob.jun.pan@intel.com

On 23/05/17 08:50, Liu, Yi L wrote:
> On Fri, Apr 28, 2017 at 01:51:42PM +0100, Jean-Philippe Brucker wrote:
[...]
>>>>
>>>> For the next version of my SVM series, I was thinking of passing group
>>>> instead of device to iommu_bind. Since all devices in a group are expected
>>>> to share the same mappings (whether they want it or not), users will have
>>>
>>> Virtual address space is not tied to protection domain as I/O virtual address
>>> space does. Is it really necessary to affect all the devices in this group.
>>> Or it is just for consistence?
>>
>> It's mostly about consistency, and also avoid hiding implicit behavior in
>> the IOMMU driver. I have the following example, described using group and
>> domain structures from the IOMMU API:
>>                  ____________________
>>                 |IOMMU  ____________ |
>>                 |      |DOM  ______ ||
>>                 |      |    |GRP   |||     bind
>>                 |      |    |    A<-----------------Task 1
>>                 |      |    |    B |||
>>                 |      |    |______|||
>>                 |      |     ______ ||
>>                 |      |    |GRP   |||
>>                 |      |    |    C |||
>>                 |      |    |______|||
>>                 |      |____________||
>>                 |       ____________ |
>>                 |      |DOM  ______ ||
>>                 |      |    |GRP   |||
>>                 |      |    |    D |||
>>                 |      |    |______|||
>>                 |      |____________||
>>                 |____________________|
>>
>> Let's take PCI functions A, B, C, and D, all with PASID capabilities. Due
>> to some hardware limitation (in the bus, the device or the IOMMU), B can
>> see all DMA transactions issued by A. A and B are therefore in the same
>> IOMMU group. C and D can be isolated by the IOMMU, so they each have their
>> own group.
>>
>> (As far as I know, in the SVM world at the moment, devices are neatly
>> integrated and there is no need for putting multiple devices in the same
>> IOMMU group, but I don't think we should expect all future SVM systems to
>> be well-behaved.)
>>
>> So when a user binds Task 1 to device A, it is *implicitly* giving device
>> B access to Task 1 as well. Simply because the IOMMU is unable to isolate
>> A from B, PASID or not. B could access the same address space as A, even
>> if you don't call bind again to explicitly attach the PASID table to B.
>>
>> If the bind is done with device as argument, maybe users will believe that
>> using PASIDs provides an additional level of isolation within a group,
>> when it really doesn't. That's why I'm inclined to have the whole bind API
>> be on groups rather than devices, if only for clarity.
> 
> This may depend on how the user understand the isolation. I think different
> PASID does mean different address space. From this perspective, it does look
> like isolation.

Yes, and it isn't isolation. Not at device granularity, that is. IOMMU has
the concept of group because sometimes the hardware simply cannot isolate
devices. Different PASIDs does mean different address spaces, but two
devices in the same group may be able to access each other's address
spaces, regardless of the presence of a PASID.

To illustrate the problem with PASIDs, let's say that for whatever reason
(e.g. lack of ACS Source Validation in a PCI switch), device B (0x0100)
can spoof device A's RID (0x0200). Therefore we put A and B in the same
IOMMU group.

User binds Task 1 to device A and Task 2 to device B. They use PASIDs X
and Y, so user thinks that they are isolated. But given the physical
properties of the system, device B can pretend it is device A, and access
the whole address space of Task 1 by sending transactions with RID 0x0200
and PASID X. So user effectively created a backdoor between tasks 1 and 2
without knowing it, and using PASIDs didn't add any protection.

>> But I don't know, maybe a comment explaining the above would be sufficient.
>>
>> To be frank my comment about group versus device is partly to make sure
>> that I grasp the various concepts correctly and that we're on the same
>> page. Doing the bind on groups is less significant in your case, for PASID
>> table binding, because VFIO already takes care of IOMMU group properly. In
>> my case I expect DRM, network, DMA drivers to use the API as well for
>> binding tasks, and I don't want to introduce ambiguity in the API that
>> would lead to security holes later.
> 
> For this part, would you provide more detail about why it would be more
> significant to bind on group level in your case? I think we need strong
> reason to support it. Currently, the other map_page APIs are passing
> device as argument. Would it also be recommended to use group as argument?

Well I'm only concerned about the API we're introducing at the moment, I'm
not suggesting we change existing ones. Because PASID is a new concept and
is currently unregulated, it would be good for new users to understand
what kind of isolation they are getting from it. And it is more important
than previous APIs because SVM's main objective is to simplify userspace
programming model, and therefore bring e.g. GPU programming to users that
will be more naive with regard to hardware properties and limitations.

I'm thinking for instance about GPU drivers using the bind API to provide
OpenCL SVM to userspace. If the person writing the driver has to pass
IOMMU groups instead of devices, they will have less chance to fall into
the trap described above. They would have to follow the VFIO model, and
propagate the concept of IOMMU groups all the way to userspace.

As I said, maybe we can just add a comment warning future users about the
limitations of PASID isolation and that will be enough, I really don't
know what's best. Since VFIO will likely stay the only user of PASID
tables binding and handles IOMMU groups well, I think it boils down to
stylistic decision in your case.

Thanks,
Jean

>>>> to do iommu_group_for_each_dev anyway (as you do in patch 6/8). So it
>>>> might be simpler to let the IOMMU core take the group lock and do
>>>> group->domain->ops->bind_task(dev...) for each device. The question also
>>>> holds for iommu_do_invalidate in patch 3/8.
>>>
>>> In my understanding, it is moving the for_each_dev loop into iommu driver?
>>> Is it?
>>
>> Yes, that's what I meant
>>
>>>> This way the prototypes would be:
>>>> int iommu_bind...(struct iommu_group *group, struct ... *info)
>>>> int iommu_unbind...(struct iommu_group *group, struct ...*info)
>>>> int iommu_invalidate...(struct iommu_group *group, struct ...*info)
>>>
>>> For PASID table binding from guest, I think it'd better to be per-device op
>>> since the bind operation wants to modify the host context entry. But we may
>>> still share the API and do things differently in iommu driver.
>>
>> Sure, as said above the use cases for PASID table and single PASID binding
>> are different, sharing the API is not strictly necessary.
>>
>>> For invalidation, I think it'd better to be per-group. Actually, with guest
>>> IOMMU exists, there is only one group in a domain on Intel platform. Do it for
>>> each device is not expected. How about it on ARM?
>>
>> In ARM systems with the DMA API (IOMMU_DOMAIN_DMA), there is one group per
>> domain. But with VFIO (IOMMU_DOMAIN_UNMANAGED), VFIO will try to attach
>> multiple groups in the same container to the same domain when possible.
>>
>>>> For PASID table binding it might not matter much, as VFIO will most likely
>>>> be the only user. But task binding will be called by device drivers, which
>>>> by now should be encouraged to do things at iommu_group granularity.
>>>> Alternatively it could be done implicitly like in iommu_attach_device,
>>>> with "iommu_bind_device_x" calling "iommu_bind_group_x".
>>>
>>> Do you mean the bind task from userspace driver? I guess you're trying to do
>>> different types of binding request in a single svm_bind API?
>>>
>>>>
>>>> Extending this reasoning, since groups in a domain are also supposed to
>>>> have the same mappings, then similarly to map/unmap,
>>>> bind/unbind/invalidate should really be done with an iommu_domain (and
>>>> nothing else) as target argument. However this requires the IOMMU core to
>>>> keep a group list in each domain, which might complicate things a little
>>>> too much.
>>>>
>>>> But "all devices in a domain share the same PASID table" is the paradigm
>>>> I'm currently using in the guts of arm-smmu-v3. And I wonder if, as with
>>>> iommu_group, it should be made more explicit to users, so they don't
>>>> assume that devices within a domain are isolated from each others with
>>>> regard to PASID DMA.
>>>
>>> Is the isolation you mentioned means forbidding to do PASID DMA to the same
>>> virtual address space when the device comes from different domain?
>>
>> In the above example, devices A, B and C are in the same IOMMU domain
>> (because, for instance, user put the two groups in the same VFIO
>> container.) Then in the SMMUv3 driver they would all share the same PASID
>> table. A, B and C can access Task 1 with the PASID obtained during the
>> depicted bind. They don't need to call bind again for device C, though it
>> would be good practice.
>>
>> But D is in a different domain, so unless you also call bind on Task 1 for
>> device D, there is no way that D can access Task 1.
>>
>> Thanks,
>> Jean
>>
