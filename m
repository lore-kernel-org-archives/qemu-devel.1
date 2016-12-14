Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGzhZ-0003HS-R6
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGzhU-0005Pw-Qw
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:53:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGzhU-0005Ph-L7
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:53:48 -0500
Date: Wed, 14 Dec 2016 10:53:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161214025343.GG32222@pxdev.xzpeter.org>
References: <1481681345-32424-1-git-send-email-peterx@redhat.com>
	<1481681345-32424-2-git-send-email-peterx@redhat.com>
	<20161214044741-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214044741-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] intel_iommu: check validity for GAW
 bits in CE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, famz@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com

On Wed, Dec 14, 2016 at 04:48:42AM +0200, Michael S. Tsirkin wrote:
> On Wed, Dec 14, 2016 at 10:09:04AM +0800, Peter Xu wrote:
> > Currently vt-d Context Entry (CE) only allows 39/48 bits address width.
> > If guest software configured more than that, we complain and report.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c          | 17 ++++++++++++++++-
> >  hw/i386/intel_iommu_internal.h |  2 ++
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 5f3e351..517a2a3 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -599,9 +599,19 @@ static inline uint32_t vtd_get_level_from_context_entry(VTDContextEntry *ce)
> >      return 2 + (ce->hi & VTD_CONTEXT_ENTRY_AW);
> >  }
> >  
> > +/* Return 0 if failed to fetch valid aw */
> >  static inline uint32_t vtd_get_agaw_from_context_entry(VTDContextEntry *ce)
> >  {
> > -    return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
> > +    uint8_t aw = (ce->hi & VTD_CONTEXT_ENTRY_AW);
> > +    /*
> > +     * According to vt-d spec 10.4.2 bits 12:8, SAGAW only allows
> > +     * 39/48 bits.
> > +     */
> > +    if (aw > VTD_CE_AW_48BIT) {
> 
> 5-level is almost sure to allow more. I don't see the point of this test.

Please check above comment - spec only allow 3/4 level page table.

My version of vt-d spec is 2016 Oct. I suppose that's new enough...

-- peterx
