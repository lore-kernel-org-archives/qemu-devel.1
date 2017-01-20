Received: from eggs.gnu.org ([2001:4830:134:3::10]:58572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUUyQ-0005cy-Bn
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUUyN-0002M2-AN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:55:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUUyN-0002LG-4E
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:55:03 -0500
Date: Fri, 20 Jan 2017 16:54:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170120085457.GI4914@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-2-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14FD2@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190C14FD2@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 01/14] IOMMU: add option to enable
 VTD_CAP_CM to vIOMMU capility exposoed to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>

On Fri, Jan 20, 2017 at 08:32:06AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Friday, January 13, 2017 11:06 AM
> > 
> > From: Aviv Ben-David <bd.aviv@gmail.com>
> > 
> > This capability asks the guest to invalidate cache before each map operation.
> > We can use this invalidation to trap map operations in the hypervisor.
> > 
> > Signed-off-by: Aviv Ben-David <bd.aviv@gmail.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c          | 5 +++++
> >  hw/i386/intel_iommu_internal.h | 1 +
> >  include/hw/i386/intel_iommu.h  | 2 ++
> >  3 files changed, 8 insertions(+)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index ec62239..2868e37 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -2107,6 +2107,7 @@ static Property vtd_properties[] = {
> >      DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
> >                              ON_OFF_AUTO_AUTO),
> >      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
> > +    DEFINE_PROP_BOOL("cache-mode", IntelIOMMUState, cache_mode_enabled,
> > FALSE),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > 
> > @@ -2488,6 +2489,10 @@ static void vtd_init(IntelIOMMUState *s)
> >          s->ecap |= VTD_ECAP_DT;
> >      }
> > 
> > +    if (s->cache_mode_enabled) {
> > +        s->cap |= VTD_CAP_CM;
> > +    }
> > +
> 
> I think some of my old comments are not answered:
> 
> 1) Better to use caching_mode to follow spec

Sure.

> 
> 2) Does it make sense to automatically set this flag if any VFIO device
> has been statically assigned when starting Qemu?

I'm okay with both, considering that people using this flag will be
possibly advanced users. So I would like to hear others' opinion.

> Also for hot-add
> device path, some check of caching mode is required. If not set, 
> should we fail hot-add operation? I don't think we have such physical
> platform with some devices behind IOMMU while others not.

Could you explain in what case will we fail a hot plug?

Thanks,

-- peterx
