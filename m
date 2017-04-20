Received: from eggs.gnu.org ([2001:4830:134:3::10]:36345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d12RP-0006ES-Lg
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d12RL-00017J-Ia
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:07:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d12RL-000177-Ai
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:07:27 -0400
Date: Thu, 20 Apr 2017 11:07:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170420030714.GB26087@pxdev.xzpeter.org>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-8-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439054CF5@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439054CF5@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, Apr 19, 2017 at 07:13:47AM +0000, Liu, Yi L wrote:
> Peter,
> 
> Besides the gPA->hPA mapping, pt mode enabling requires some sanity check on
> s->pt_supported. See comments inline.
> 
> > -----Original Message-----
> > From: Qemu-devel [mailto:qemu-devel-bounces+yi.l.liu=intel.com@nongnu.org] On
> > Behalf Of Peter Xu
> > Sent: Monday, April 17, 2017 7:32 PM
> > To: qemu-devel@nongnu.org
> > Cc: Lan, Tianyu <tianyu.lan@intel.com>; Michael S . Tsirkin <mst@redhat.com>;
> > Jason Wang <jasowang@redhat.com>; peterx@redhat.com; Marcel Apfelbaum
> > <marcel@redhat.com>; David Gibson <david@gibson.dropbear.id.au>
> > Subject: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough (PT)
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c          | 109 +++++++++++++++++++++++++++++++++--------
> >  hw/i386/intel_iommu_internal.h |   1 +
> >  hw/i386/trace-events           |   1 +
> >  hw/i386/x86-iommu.c            |   1 +
> >  include/hw/i386/x86-iommu.h    |   1 +
> >  5 files changed, 93 insertions(+), 20 deletions(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > 05ae631..deb2007 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -872,7 +872,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s,
> > uint8_t bus_num,
> >      } else {
> >          switch (vtd_ce_get_type(ce)) {
> >          case VTD_CONTEXT_TT_MULTI_LEVEL:
> > -            /* fall through */
> > +        case VTD_CONTEXT_TT_PASS_THROUGH:
> 
> Passthru type is a reserved type if ecap.PT=0, so add a check here. If s->pt_supported
> is false, report this translation type as unsupported and report an invalid context 
> programming to guest.
> 
> >          case VTD_CONTEXT_TT_DEV_IOTLB:
> >              break;
> >          default:
> > @@ -883,6 +883,73 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s,
> > uint8_t bus_num,
> >      return 0;
> >  }
> > 
> > +/* Fetch translation type for specific device. Returns <0 if error
> > + * happens, otherwise return the shifted type to check against
> > + * VTD_CONTEXT_TT_*. */
> > +static int vtd_dev_get_trans_type(VTDAddressSpace *as) {
> > +    IntelIOMMUState *s;
> > +    VTDContextEntry ce;
> > +    int ret;
> > +
> > +    s = as->iommu_state;
> > +
> > +    ret = vtd_dev_to_context_entry(s, pci_bus_num(as->bus),
> > +                                   as->devfn, &ce);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    return vtd_ce_get_type(&ce);
> > +}
> > +
> > +static bool vtd_dev_pt_enabled(VTDAddressSpace *as) {
> > +    int ret;
> > +
> > +    assert(as);
> > +
> > +    ret = vtd_dev_get_trans_type(as);
> > +    if (ret < 0) {
> > +        /*
> > +         * Possibly failed to parse the context entry for some reason
> > +         * (e.g., during init, or any guest configuration errors on
> > +         * context entries). We should assume PT not enabled for
> > +         * safety.
> > +         */
> > +        return false;
> > +    }
> > +
> > +    return ret == VTD_CONTEXT_TT_PASS_THROUGH; }
> > +
> > +static void vtd_switch_address_space(VTDAddressSpace *as) {
> > +    bool use_iommu;
> > +
> > +    assert(as);
> > +
> > +    use_iommu = as->iommu_state->dmar_enabled;
> > +    if (use_iommu) {
> 
> if s->pt_supported is false, no need to check the context.TT, even
> context.TT=pt, then it should be an invalid context programming.

Agree with you on both comments. Thanks. :-)

-- 
Peter Xu
