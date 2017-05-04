Received: from eggs.gnu.org ([2001:4830:134:3::10]:49275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashok.raj@intel.com>) id 1d6NYt-0007Vg-7E
	for qemu-devel@nongnu.org; Thu, 04 May 2017 16:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashok.raj@intel.com>) id 1d6NYp-0001RL-9J
	for qemu-devel@nongnu.org; Thu, 04 May 2017 16:41:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:45285)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ashok.raj@intel.com>) id 1d6NYp-0001Qz-0R
	for qemu-devel@nongnu.org; Thu, 04 May 2017 16:41:15 -0400
Date: Thu, 4 May 2017 13:37:50 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
Message-ID: <20170504203750.GA7308@otc-nc-03>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-4-git-send-email-yi.l.liu@linux.intel.com>
	<20170427105317.GE1542@pxdev.xzpeter.org>
	<20170504142853.1537028c@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504142853.1537028c@t450s.home>
Subject: Re: [Qemu-devel] [RFC PATCH 03/20] intel_iommu: add "svm" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com

On Thu, May 04, 2017 at 02:28:53PM -0600, Alex Williamson wrote:
> On Thu, 27 Apr 2017 18:53:17 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Apr 26, 2017 at 06:06:33PM +0800, Liu, Yi L wrote:
> > > Expose "Shared Virtual Memory" to guest by using "svm" option.
> > > Also use "svm" to expose SVM related capabilities to guest.
> > > e.g. "-device intel-iommu, svm=on"
> > > 
> > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 10 ++++++++++
> > >  hw/i386/intel_iommu_internal.h |  5 +++++
> > >  include/hw/i386/intel_iommu.h  |  1 +
> > >  3 files changed, 16 insertions(+)
> > > 
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index bf98fa5..ba1e7eb 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -2453,6 +2453,7 @@ static Property vtd_properties[] = {
> > >      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
> > >      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
> > >      DEFINE_PROP_BOOL("ecs", IntelIOMMUState, ecs, FALSE),
> > > +    DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, FALSE),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >  
> > > @@ -2973,6 +2974,15 @@ static void vtd_init(IntelIOMMUState *s)
> > >          s->ecap |= VTD_ECAP_ECS;
> > >      }
> > >  
> > > +    if (s->svm) {
> > > +        if (!s->ecs || !x86_iommu->pt_supported || !s->caching_mode) {
> > > +            error_report("Need to set ecs, pt, caching-mode for svm");
> > > +            exit(1);
> > > +        }
> > > +        s->cap |= VTD_CAP_DWD | VTD_CAP_DRD;
> > > +        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PTS | VTD_ECAP_PASID28;
> > > +    }
> > > +
> > >      if (s->caching_mode) {
> > >          s->cap |= VTD_CAP_CM;
> > >      }
> > > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > > index 71a1c1e..f2a7d12 100644
> > > --- a/hw/i386/intel_iommu_internal.h
> > > +++ b/hw/i386/intel_iommu_internal.h
> > > @@ -191,6 +191,9 @@
> > >  #define VTD_ECAP_PT                 (1ULL << 6)
> > >  #define VTD_ECAP_MHMV               (15ULL << 20)
> > >  #define VTD_ECAP_ECS                (1ULL << 24)
> > > +#define VTD_ECAP_PASID28            (1ULL << 28)  
> > 
> > Could I ask what's this bit? On my spec, it says this bit is reserved
> > and defunct (spec version: June 2016).
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d42fde70849c5ba2f00c37a0666305eb507a47b8
> 
> Do we really need to emulate the buggy implementation?  Seems like we
> could just pretend bit28 never happened here and use bit40 instead.
> 

Agree, bit28 can be gone.  
