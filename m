Received: from eggs.gnu.org ([209.51.188.92]:36444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjmHO-00077b-Oc
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjmHM-0007Ap-Kw
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:34:53 -0500
Date: Wed, 16 Jan 2019 15:34:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190116153427.32da5da1.cohuck@redhat.com>
In-Reply-To: <1188d21d-3603-c291-e69b-38d341ae90f4@linux.ibm.com>
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
	<1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
	<f6a5491a-1859-8e0a-7357-901d47ee8304@linux.ibm.com>
	<20190116134011.1189b027@oc2783563651>
	<1188d21d-3603-c291-e69b-38d341ae90f4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: Set the iommu region size
 mpcifc request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On Wed, 16 Jan 2019 15:16:44 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 16/01/2019 13:40, Halil Pasic wrote:
> > On Tue, 15 Jan 2019 10:35:42 -0500
> > Collin Walling <walling@linux.ibm.com> wrote:
> >   
> >> On 1/10/19 8:00 AM, Pierre Morel wrote:  
> >>> The size of the accessible iommu memory region in the guest
> >>> is given to the IOMMU by the guest through the mpcifc request
> >>> specifying the PCI Base Address and the PCI Address Limit.
> >>>
> >>> Let set the size of the IOMMU region to:
> >>>       (PCI Address Limit) - (PCI Base Address) + 1.
> >>>
> >>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >>> ---
> >>>    hw/s390x/s390-pci-bus.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> >>> index 69e0671..e97696a 100644
> >>> --- a/hw/s390x/s390-pci-bus.c
> >>> +++ b/hw/s390x/s390-pci-bus.c
> >>> @@ -660,7 +660,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
> >>>        char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
> >>>        memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
> >>>                                 TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
> >>> -                             name, iommu->pal + 1);
> >>> +                             name, iommu->pal - iommu->pba + 1);  
> > 
> >  From the the look of this, I would say we basically used the address
> > denoting the end of the region as the size of the region. This smells
> > like a bug to me, but the commit message and the title ain't clear about
> > this, and there is no fixes tag. Because of the latter I did some digging
> > and came to commit f7c40aa "s390x/pci: fix failures of dma
> > map/unmap" (Yi Min Zhao, 2016-06-19) which basically did the inverse of
> > this commit!
> > 
> > My initial motivation was to check if this is stable material. But now
> > I'm very confused. I'm admittedly zPCI incompetent. Could some of the
> > people that understand what is going on help me feel better about this
> > patch?
> > 
> > Regards,
> > Halil  
> 
> 
> The patch you speak about corrected the problem described in its comment 
> by setting the offset address of the subregion to 0, making sure 
> VFIO_PCI works for Z but introduced a bug we did not see at that time by 
> making the subregion too large.
> 
> This patch correct the bug, I can add a reference to this with:
> fixing: commit f7c40aa1e7feb50bc4d4bc171fa811bdd9a93e51

The patch is already queued, but I can add

Fixes: f7c40aa1e7 ("s390x/pci: fix failures of dma map/unmap")

> 
> Regards,
> Pierre
> 
> > 
> > 
> >   
> >>>        iommu->enabled = true;
> >>>        memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
> >>>        g_free(name);
> >>>  
> >>
> >> Acked-by: Collin Walling <walling@linux.ibm.com>
> >>
> >>  
> >   
> 
> 
