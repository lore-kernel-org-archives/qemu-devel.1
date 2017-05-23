Received: from eggs.gnu.org ([2001:4830:134:3::10]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1dD4qQ-0007nl-1O
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1dD4qM-0004mr-Ky
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:07:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:27607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1dD4qM-0004ll-9H
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:07:02 -0400
Date: Tue, 23 May 2017 15:50:49 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20170523075049.GA3955@sky-dev>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-2-git-send-email-yi.l.liu@intel.com>
	<c042bf90-d48b-4ebf-c01a-fca7c4875277@arm.com>
	<20170428090458.GB15484@sky-dev>
	<3adb4e33-db96-4133-0510-412c3bfb24fe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3adb4e33-db96-4133-0510-412c3bfb24fe@arm.com>
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
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, ashok.raj@intel.com, jasowang@redhat.com, qemu-devel@nongnu.org, jacob.jun.pan@intel.com

On Fri, Apr 28, 2017 at 01:51:42PM +0100, Jean-Philippe Brucker wrote:
> On 28/04/17 10:04, Liu, Yi L wrote:
Hi Jean,

Sorry for the delay response. Still have some follow-up comments on
per-device or per-group. Pls refer to comments inline.

> > On Wed, Apr 26, 2017 at 05:56:45PM +0100, Jean-Philippe Brucker wrote:
> >> Hi Yi, Jacob,
> >>
> >> On 26/04/17 11:11, Liu, Yi L wrote:
> >>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>>
> >>> Virtual IOMMU was proposed to support Shared Virtual Memory (SVM) use
> >>> case in the guest:
> >>> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> >>>
> >>> As part of the proposed architecture, when a SVM capable PCI
> >>> device is assigned to a guest, nested mode is turned on. Guest owns the
> >>> first level page tables (request with PASID) and performs GVA->GPA
> >>> translation. Second level page tables are owned by the host for GPA->HPA
> >>> translation for both request with and without PASID.
> >>>
> >>> A new IOMMU driver interface is therefore needed to perform tasks as
> >>> follows:
> >>> * Enable nested translation and appropriate translation type
> >>> * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> >>>
> >>> This patch introduces new functions called iommu_(un)bind_pasid_table()
> >>> to IOMMU APIs. Architecture specific IOMMU function can be added later
> >>> to perform the specific steps for binding pasid table of assigned devices.
> >>>
> >>> This patch also adds model definition in iommu.h. It would be used to
> >>> check if the bind request is from a compatible entity. e.g. a bind
> >>> request from an intel_iommu emulator may not be supported by an ARM SMMU
> >>> driver.
> >>>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> >>> ---
> >>>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
> >>>  include/linux/iommu.h | 31 +++++++++++++++++++++++++++++++
> >>>  2 files changed, 50 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >>> index dbe7f65..f2da636 100644
> >>> --- a/drivers/iommu/iommu.c
> >>> +++ b/drivers/iommu/iommu.c
> >>> @@ -1134,6 +1134,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >>>  
> >>> +int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
> >>> +			struct pasid_table_info *pasidt_binfo)
> >>
> >> I guess that domain can always be deduced from dev using
> >> iommu_get_domain_for_dev, and doesn't need to be passed as argument?
> >>
> >> For the next version of my SVM series, I was thinking of passing group
> >> instead of device to iommu_bind. Since all devices in a group are expected
> >> to share the same mappings (whether they want it or not), users will have
> > 
> > Virtual address space is not tied to protection domain as I/O virtual address
> > space does. Is it really necessary to affect all the devices in this group.
> > Or it is just for consistence?
> 
> It's mostly about consistency, and also avoid hiding implicit behavior in
> the IOMMU driver. I have the following example, described using group and
> domain structures from the IOMMU API:
>                  ____________________
>                 |IOMMU  ____________ |
>                 |      |DOM  ______ ||
>                 |      |    |GRP   |||     bind
>                 |      |    |    A<-----------------Task 1
>                 |      |    |    B |||
>                 |      |    |______|||
>                 |      |     ______ ||
>                 |      |    |GRP   |||
>                 |      |    |    C |||
>                 |      |    |______|||
>                 |      |____________||
>                 |       ____________ |
>                 |      |DOM  ______ ||
>                 |      |    |GRP   |||
>                 |      |    |    D |||
>                 |      |    |______|||
>                 |      |____________||
>                 |____________________|
> 
> Let's take PCI functions A, B, C, and D, all with PASID capabilities. Due
> to some hardware limitation (in the bus, the device or the IOMMU), B can
> see all DMA transactions issued by A. A and B are therefore in the same
> IOMMU group. C and D can be isolated by the IOMMU, so they each have their
> own group.
> 
> (As far as I know, in the SVM world at the moment, devices are neatly
> integrated and there is no need for putting multiple devices in the same
> IOMMU group, but I don't think we should expect all future SVM systems to
> be well-behaved.)
>
> So when a user binds Task 1 to device A, it is *implicitly* giving device
> B access to Task 1 as well. Simply because the IOMMU is unable to isolate
> A from B, PASID or not. B could access the same address space as A, even
> if you don't call bind again to explicitly attach the PASID table to B.
> 
> If the bind is done with device as argument, maybe users will believe that
> using PASIDs provides an additional level of isolation within a group,
> when it really doesn't. That's why I'm inclined to have the whole bind API
> be on groups rather than devices, if only for clarity.

This may depend on how the user understand the isolation. I think different
PASID does mean different address space. From this perspective, it does look
like isolation.

> But I don't know, maybe a comment explaining the above would be sufficient.
> 
> To be frank my comment about group versus device is partly to make sure
> that I grasp the various concepts correctly and that we're on the same
> page. Doing the bind on groups is less significant in your case, for PASID
> table binding, because VFIO already takes care of IOMMU group properly. In
> my case I expect DRM, network, DMA drivers to use the API as well for
> binding tasks, and I don't want to introduce ambiguity in the API that
> would lead to security holes later.

For this part, would you provide more detail about why it would be more
significant to bind on group level in your case? I think we need strong
reason to support it. Currently, the other map_page APIs are passing
device as argument. Would it also be recommended to use group as argument?

Thanks,
Yi L

> >> to do iommu_group_for_each_dev anyway (as you do in patch 6/8). So it
> >> might be simpler to let the IOMMU core take the group lock and do
> >> group->domain->ops->bind_task(dev...) for each device. The question also
> >> holds for iommu_do_invalidate in patch 3/8.
> > 
> > In my understanding, it is moving the for_each_dev loop into iommu driver?
> > Is it?
> 
> Yes, that's what I meant
> 
> >> This way the prototypes would be:
> >> int iommu_bind...(struct iommu_group *group, struct ... *info)
> >> int iommu_unbind...(struct iommu_group *group, struct ...*info)
> >> int iommu_invalidate...(struct iommu_group *group, struct ...*info)
> > 
> > For PASID table binding from guest, I think it'd better to be per-device op
> > since the bind operation wants to modify the host context entry. But we may
> > still share the API and do things differently in iommu driver.
> 
> Sure, as said above the use cases for PASID table and single PASID binding
> are different, sharing the API is not strictly necessary.
> 
> > For invalidation, I think it'd better to be per-group. Actually, with guest
> > IOMMU exists, there is only one group in a domain on Intel platform. Do it for
> > each device is not expected. How about it on ARM?
> 
> In ARM systems with the DMA API (IOMMU_DOMAIN_DMA), there is one group per
> domain. But with VFIO (IOMMU_DOMAIN_UNMANAGED), VFIO will try to attach
> multiple groups in the same container to the same domain when possible.
> 
> >> For PASID table binding it might not matter much, as VFIO will most likely
> >> be the only user. But task binding will be called by device drivers, which
> >> by now should be encouraged to do things at iommu_group granularity.
> >> Alternatively it could be done implicitly like in iommu_attach_device,
> >> with "iommu_bind_device_x" calling "iommu_bind_group_x".
> > 
> > Do you mean the bind task from userspace driver? I guess you're trying to do
> > different types of binding request in a single svm_bind API?
> > 
> >>
> >> Extending this reasoning, since groups in a domain are also supposed to
> >> have the same mappings, then similarly to map/unmap,
> >> bind/unbind/invalidate should really be done with an iommu_domain (and
> >> nothing else) as target argument. However this requires the IOMMU core to
> >> keep a group list in each domain, which might complicate things a little
> >> too much.
> >>
> >> But "all devices in a domain share the same PASID table" is the paradigm
> >> I'm currently using in the guts of arm-smmu-v3. And I wonder if, as with
> >> iommu_group, it should be made more explicit to users, so they don't
> >> assume that devices within a domain are isolated from each others with
> >> regard to PASID DMA.
> > 
> > Is the isolation you mentioned means forbidding to do PASID DMA to the same
> > virtual address space when the device comes from different domain?
> 
> In the above example, devices A, B and C are in the same IOMMU domain
> (because, for instance, user put the two groups in the same VFIO
> container.) Then in the SMMUv3 driver they would all share the same PASID
> table. A, B and C can access Task 1 with the PASID obtained during the
> depicted bind. They don't need to call bind again for device C, though it
> would be good practice.
> 
> But D is in a different domain, so unless you also call bind on Task 1 for
> device D, there is no way that D can access Task 1.
> 
> Thanks,
> Jean
> 
