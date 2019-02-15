Received: from eggs.gnu.org ([209.51.188.92]:60523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1guW0f-0006w9-Jz
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 00:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1guW0b-0008E7-LR
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 00:26:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:49560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1guW0Z-0007qf-Or
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 00:25:57 -0500
Date: Fri, 15 Feb 2019 13:22:34 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20190215052234.GI16968@yi.y.sun>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-4-git-send-email-yi.y.sun@linux.intel.com>
	<20190212064629.GL1011@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212064629.GL1011@xz-x1>
Subject: Re: [Qemu-devel] [RFC v1 3/3] intel_iommu: add scalable-mode option
 to make scalable mode work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On 19-02-12 14:46:29, Peter Xu wrote:

[...]

> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 3664a00..447fdf3 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -2492,6 +2492,17 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
> >          }
> >          break;
> >  
> > +    /*
> > +     * TODO: the entity of below two cases will be implemented in future series.
> > +     * To make guest (which integrates scalable mode support patch set in
> > +     * iommu driver) work, just return true is enough so far.
> 
> When you repost, could you mention about what tests have you done?  I
> can think of some general usages:
> 
> Device matrix:
> 
> - virtio-net, vhost=on|off
> - device assignment
> 
> Configuration matrix:
> 
> - legacy/scalable
> - passthrough=on|off
> 
> I believe smoke test (like netperf a few seconds, or even ping) would
> be enough, cover some (or all, which would be very nice to have :) of
> above scenarios.
> 
Thanks for the test cases! I have covered some of them but I think I
can do more tests.

> > +     */
> > +    case VTD_INV_DESC_PC:
> > +        break;
> > +
> > +    case VTD_INV_DESC_PIOTLB:
> > +        break;
> > +
> >      case VTD_INV_DESC_WAIT:
> >          trace_vtd_inv_desc("wait", inv_desc.val[1], inv_desc.val[0]);
> >          if (!vtd_process_wait_desc(s, &inv_desc)) {
> > @@ -3051,6 +3062,7 @@ static Property vtd_properties[] = {
> >      DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> >                        VTD_HOST_ADDRESS_WIDTH),
> >      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
> > +    DEFINE_PROP_BOOL("scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
> 
> Let's start with x-scalable-mode?  Less burden for all.
> 
Sure.

> >      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > @@ -3583,6 +3595,16 @@ static void vtd_init(IntelIOMMUState *s)
> >          s->cap |= VTD_CAP_CM;
> >      }
> >  
> > +    /* TODO: read cap/ecap from host to decide which cap to be exposed. */
> > +    if (s->scalable_mode) {
> > +        if (!s->caching_mode) {
> > +            error_report("Need to set caching-mode for scalable mode");
> 
> Could I ask why?
> 
My intention is to make guest explicitly send to make sure SLT shadowing
correctly.

For this point, I also have question. Why does legacy mode not check CM?
If CM is not set, may the DMA remapping be wrong because SLT cannot
match guest's latest change?

> > +            exit(1);
> > +        }
> > +        s->cap |= VTD_CAP_DWD | VTD_CAP_DRD;
> 
> Draining is supported now so this line is not needed.
> 
Got it, thanks!

> > +        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> > +    }
> > +
> >      vtd_reset_caches(s);
> >  
> >      /* Define registers with default values and bit semantics */
> > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > index 2a753c5..b01953a 100644
> > --- a/hw/i386/intel_iommu_internal.h
> > +++ b/hw/i386/intel_iommu_internal.h
> > @@ -190,7 +190,9 @@
> >  #define VTD_ECAP_EIM                (1ULL << 4)
> >  #define VTD_ECAP_PT                 (1ULL << 6)
> >  #define VTD_ECAP_MHMV               (15ULL << 20)
> > +#define VTD_ECAP_SRS                (1ULL << 31)
> >  #define VTD_ECAP_SMTS               (1ULL << 43)
> > +#define VTD_ECAP_SLTS               (1ULL << 46)
> >  
> >  /* CAP_REG */
> >  /* (offset >> 4) << 24 */
> > @@ -209,6 +211,8 @@
> >  #define VTD_CAP_DRAIN_READ          (1ULL << 55)
> >  #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
> >  #define VTD_CAP_CM                  (1ULL << 7)
> > +#define VTD_CAP_DWD                 (1ULL << 54)
> > +#define VTD_CAP_DRD                 (1ULL << 55)
> 
> These can be dropped too (see VTD_CAP_DRAIN above).
> 
Thanks!

[...]

> > -- 
> > 1.9.1
> > 
> 
> Regards,
> 
> -- 
> Peter Xu
