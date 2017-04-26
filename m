Received: from eggs.gnu.org ([2001:4830:134:3::10]:38837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jacob.jun.pan@intel.com>) id 1d3RhN-00065f-6K
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 14:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jacob.jun.pan@intel.com>) id 1d3RhJ-0002fu-Su
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 14:29:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:63142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jacob.jun.pan@intel.com>)
	id 1d3RhJ-0002dL-GR
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 14:29:53 -0400
Date: Wed, 26 Apr 2017 11:29:48 -0700
From: jacob pan <jacob.jun.pan@intel.com>
Message-ID: <20170426112948.00004520@intel.com>
In-Reply-To: <c042bf90-d48b-4ebf-c01a-fca7c4875277@arm.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-2-git-send-email-yi.l.liu@intel.com>
	<c042bf90-d48b-4ebf-c01a-fca7c4875277@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, tianyu.lan@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, jacob.jun.pan@intel.com

On Wed, 26 Apr 2017 17:56:45 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi Yi, Jacob,
> 
> On 26/04/17 11:11, Liu, Yi L wrote:
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > 
> > Virtual IOMMU was proposed to support Shared Virtual Memory (SVM)
> > use case in the guest:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> > 
> > As part of the proposed architecture, when a SVM capable PCI
> > device is assigned to a guest, nested mode is turned on. Guest owns
> > the first level page tables (request with PASID) and performs
> > GVA->GPA translation. Second level page tables are owned by the
> > host for GPA->HPA translation for both request with and without
> > PASID.
> > 
> > A new IOMMU driver interface is therefore needed to perform tasks as
> > follows:
> > * Enable nested translation and appropriate translation type
> > * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> > 
> > This patch introduces new functions called
> > iommu_(un)bind_pasid_table() to IOMMU APIs. Architecture specific
> > IOMMU function can be added later to perform the specific steps for
> > binding pasid table of assigned devices.
> > 
> > This patch also adds model definition in iommu.h. It would be used
> > to check if the bind request is from a compatible entity. e.g. a
> > bind request from an intel_iommu emulator may not be supported by
> > an ARM SMMU driver.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 19 +++++++++++++++++++
> >  include/linux/iommu.h | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index dbe7f65..f2da636 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1134,6 +1134,25 @@ int iommu_attach_device(struct iommu_domain
> > *domain, struct device *dev) }
> >  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >  
> > +int iommu_bind_pasid_table(struct iommu_domain *domain, struct
> > device *dev,
> > +			struct pasid_table_info *pasidt_binfo)
> 
> I guess that domain can always be deduced from dev using
> iommu_get_domain_for_dev, and doesn't need to be passed as argument?
> 
true. device should have attached a domain before calling this API.
> For the next version of my SVM series, I was thinking of passing group
> instead of device to iommu_bind. Since all devices in a group are
> expected to share the same mappings (whether they want it or not),
> users will have to do iommu_group_for_each_dev anyway (as you do in
> patch 6/8). So it might be simpler to let the IOMMU core take the
> group lock and do group->domain->ops->bind_task(dev...) for each
> device. The question also holds for iommu_do_invalidate in patch 3/8.
> 
> This way the prototypes would be:
> int iommu_bind...(struct iommu_group *group, struct ... *info)
> int iommu_unbind...(struct iommu_group *group, struct ...*info)
> int iommu_invalidate...(struct iommu_group *group, struct ...*info)
> 
Just to understand this granularity implication of fault notification
(e.g. page request) of this change. PRI for all devices in the group
will be enabled. IOMMU driver receives page request per device with the
same PASID bond to the group. There can be two scenarios:
1. If iommu_bind() to a task, IOMMU driver handles page fault
internally per device, there is no need to do group level, true?
2. If the device iommu_bind_pasid_table() is called, then we propagate
PRQ to VFIO per device.


> For PASID table binding it might not matter much, as VFIO will most
> likely be the only user. But task binding will be called by device
> drivers, which by now should be encouraged to do things at
> iommu_group granularity. Alternatively it could be done implicitly
> like in iommu_attach_device, with "iommu_bind_device_x" calling
> "iommu_bind_group_x".
> 
> 
> Extending this reasoning, since groups in a domain are also supposed
> to have the same mappings, then similarly to map/unmap,
> bind/unbind/invalidate should really be done with an iommu_domain (and
> nothing else) as target argument. However this requires the IOMMU
> core to keep a group list in each domain, which might complicate
> things a little too much.
> 
> But "all devices in a domain share the same PASID table" is the
> paradigm I'm currently using in the guts of arm-smmu-v3. And I wonder
> if, as with iommu_group, it should be made more explicit to users, so
> they don't assume that devices within a domain are isolated from each
> others with regard to PASID DMA.
> 
> > +{
> > +	if (unlikely(!domain->ops->bind_pasid_table))
> > +		return -EINVAL;
> > +
> > +	return domain->ops->bind_pasid_table(domain, dev,
> > pasidt_binfo); +}
> > +EXPORT_SYMBOL_GPL(iommu_bind_pasid_table);
> > +
> > +int iommu_unbind_pasid_table(struct iommu_domain *domain, struct
> > device *dev) +{
> > +	if (unlikely(!domain->ops->unbind_pasid_table))
> > +		return -EINVAL;
> > +
> > +	return domain->ops->unbind_pasid_table(domain, dev);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 0ff5111..491a011 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -131,6 +131,15 @@ struct iommu_dm_region {
> >  	int			prot;
> >  };
> >  
> > +struct pasid_table_info {
> > +	__u64	ptr;	/* PASID table ptr */
> > +	__u64	size;	/* PASID table size*/
> > +	__u32	model;	/* magic number */
> > +#define INTEL_IOMMU	(1 << 0)
> > +#define ARM_SMMU	(1 << 1)
> 
> Not sure if there is any advantage in this being a bitfield rather
> than simple values (1, 2, 3, etc).
> The names should also have a prefix, such as "PASID_TABLE_MODEL_"
> 
> Thanks a lot for doing this,
> Jean
