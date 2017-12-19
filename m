Received: from eggs.gnu.org ([2001:4830:134:3::10]:53769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eRIaD-0007mh-HR
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eRIaA-0001Xo-OH
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:09:25 -0500
Date: Tue, 19 Dec 2017 07:09:19 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171219070919.42d90b94@w520.home>
In-Reply-To: <ca9cd686-ea2f-716e-b909-f6e22d1c704c@redhat.com>
References: <20171212051853.24583-1-aik@ozlabs.ru>
	<20171211224650.71237179@w520.home>
	<ca9cd686-ea2f-716e-b909-f6e22d1c704c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: spapr/iommu: Enable in-kernel
 TCE acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 19 Dec 2017 12:12:35 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 12/12/2017 06:46, Alex Williamson wrote:
> >> +enum IOMMUMemoryRegionAttr {
> >> +    IOMMU_ATTR_KVM_FD  
> > 
> > You're generalizing the wrong thing here, this is specifically a
> > SPAPR_TCE_FD, call it that.  
> 
> ... and you're not even implementing set_attr, so let's drop it.
> 
> My suggestion is to add a function in hw/vfio:
> 
>     int vfio_container_attach_kvm_spapr_tce(VFIOContainer *cont,
>                                             int tablefd);
> 
> and an IOMMUMemoryRegionClass member:
> 
>     int (*set_vfio_container_attrs)(IOMMUMemoryRegion *iommu,
>                                     VFIOContainer *cont)
> 
> Then your implementation for the latter is as simple as this:
> 
>     if (!kvm_enabled() || !kvmppc_has_cap_spapr_vfio()) {
>         sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
>         return vfio_container_attach_kvm_spapr_tce(cont, tcet->fd);
>     }

Ugh, exactly the sort of interface I've been trying to avoid, vfio
specific callbacks on common data structures handing out vfio private
data pointers, requiring additional exported functions from vfio for
each new user of it.  Why is this better?  Thanks,

Alex
