Received: from eggs.gnu.org ([2001:4830:134:3::10]:40236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0N4A-0000J3-Fj
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0N46-0006hz-GO
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:33:34 -0400
Date: Thu, 13 Sep 2018 16:33:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180913083317.GG10763@xz-x1>
References: <20180913075517.11140-1-peterx@redhat.com>
	<2ad9db94-3d74-2879-e0a5-a0c4369d3a7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ad9db94-3d74-2879-e0a5-a0c4369d3a7f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: handle invalid ce for shadow
 sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, Pei Zhang <pezhang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>

On Thu, Sep 13, 2018 at 10:16:20AM +0200, Maxime Coquelin wrote:
> Hi Peter,
> 
> On 09/13/2018 09:55 AM, Peter Xu wrote:
> > There are two callers for vtd_sync_shadow_page_table_range(), one
> > provided a valid context entry and one not.  Move that fetching
> > operation into the caller vtd_sync_shadow_page_table() where we need to
> > fetch the context entry.
> > 
> > Meanwhile, we should handle VTD_FR_CONTEXT_ENTRY_P properly when
> > synchronizing shadow page tables.  Having invalid context entry there is
> > perfectly valid when we move a device out of an existing domain.  When
> > that happens, instead of posting an error we invalidate the whole region.
> > 
> > Without this patch, QEMU will crash if we do these steps:
> > 
> > (1) start QEMU with VT-d IOMMU and two 10G NICs (ixgbe)
> > (2) bind the NICs with vfio-pci in the guest
> > (3) start testpmd with the NICs applied
> > (4) stop testpmd
> > (5) rebind the NIC back to ixgbe kernel driver
> > 
> > The patch should fix it.
> > 
> > Reported-by: Pei Zhang<pezhang@redhat.com>
> > Tested-by: Pei Zhang<pezhang@redhat.com>
> > CC: Pei Zhang<pezhang@redhat.com>
> > CC: Alex Williamson<alex.williamson@redhat.com>
> > CC: Jason Wang<jasowang@redhat.com>
> > CC: Maxime Coquelin<maxime.coquelin@redhat.com>
> > CC: Michael S. Tsirkin<mst@redhat.com>
> > CC: QEMU Stable<qemu-stable@nongnu.org>
> > Fixes:https://bugzilla.redhat.com/show_bug.cgi?id=1627272
> 
> It seems like a regression as it wasn't reported earlier, isn't it?
> If it is, do you know what is the faulty commit?

I think it should be 63b88968f1 ("intel-iommu: rework the page walk
logic", 2018-05-23).  The old code would possibly unmap all (using the
old replay logic) before we introduce the shadow page sync helpers and
I must have overlooked on that point.

> 
> > Signed-off-by: Peter Xu<peterx@redhat.com>
> > ---
> >   hw/i386/intel_iommu.c | 54 ++++++++++++++++++++++++++-----------------
> >   1 file changed, 33 insertions(+), 21 deletions(-)
> 
> Other than that, the patch looks good to me.
> FWIW:
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,

-- 
Peter Xu
