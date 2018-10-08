Received: from eggs.gnu.org ([2001:4830:134:3::10]:58035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9OjH-00050E-6R
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9OaS-0004Sj-6d
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:00:15 -0400
Date: Mon, 8 Oct 2018 13:59:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181008055950.GE18728@xz-x1>
References: <20180913075517.11140-1-peterx@redhat.com>
	<8e8f2a55-7ed0-eee7-a68c-85dde8494fa8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e8f2a55-7ed0-eee7-a68c-85dde8494fa8@redhat.com>
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
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Pei Zhang <pezhang@redhat.com>

On Mon, Oct 01, 2018 at 01:36:50PM +0200, Auger Eric wrote:
> Hi Peter,
> On 9/13/18 9:55 AM, Peter Xu wrote:
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
> > Reported-by: Pei Zhang <pezhang@redhat.com>
> > Tested-by: Pei Zhang <pezhang@redhat.com>
> > CC: Pei Zhang <pezhang@redhat.com>
> > CC: Alex Williamson <alex.williamson@redhat.com>
> > CC: Jason Wang <jasowang@redhat.com>
> > CC: Maxime Coquelin <maxime.coquelin@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > CC: QEMU Stable <qemu-stable@nongnu.org>
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1627272
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c | 54 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 33 insertions(+), 21 deletions(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 3dfada19a6..2509520d6f 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -37,6 +37,8 @@
> >  #include "kvm_i386.h"
> >  #include "trace.h"
> >  
> > +static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
> > +
> >  static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
> >                              uint64_t wmask, uint64_t w1cmask)
> >  {
> Comment above is outdated:
> /* If context entry is NULL, we'll try to fetch it on our own. */

Indeed.

> > @@ -1047,39 +1049,49 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
> >          .notify_unmap = true,
> >          .aw = s->aw_bits,
> >          .as = vtd_as,
> > +        .domain_id = VTD_CONTEXT_ENTRY_DID(ce->hi),
> >      };
> > -    VTDContextEntry ce_cache;
> > +
> > +    return vtd_page_walk(ce, addr, addr + size, &info);
> > +}
> Maybe change would gain in clarity if split into 2 patches, code
> reorganization and fix on the side.

Sure.  Thanks for reviewing!

-- 
Peter Xu
