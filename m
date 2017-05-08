Received: from eggs.gnu.org ([2001:4830:134:3::10]:50373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d80Z7-0006P9-0J
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d80Z3-0004UL-0y
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:32:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:57330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d80Z2-0004Sm-Mk
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:32:12 -0400
Date: Mon, 8 May 2017 16:15:48 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20170508081548.GC2931@gmail.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-4-git-send-email-yi.l.liu@linux.intel.com>
	<20170427105317.GE1542@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C25743906890D@shsmsx102.ccr.corp.intel.com>
	<20170508112034.GE2820@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170508112034.GE2820@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC PATCH 03/20] intel_iommu: add "svm" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>

On Mon, May 08, 2017 at 07:20:34PM +0800, Peter Xu wrote:
> On Mon, May 08, 2017 at 10:38:09AM +0000, Liu, Yi L wrote:
> > On Thu, 27 Apr 2017 18:53:17 +0800
> > Peter Xu <peterx@redhat.com> wrote:
> > 
> > > On Wed, Apr 26, 2017 at 06:06:33PM +0800, Liu, Yi L wrote:
> > > > Expose "Shared Virtual Memory" to guest by using "svm" option.
> > > > Also use "svm" to expose SVM related capabilities to guest.
> > > > e.g. "-device intel-iommu, svm=on"
> > > >
> > > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > > > ---
> > > >  hw/i386/intel_iommu.c          | 10 ++++++++++
> > > >  hw/i386/intel_iommu_internal.h |  5 +++++
> > > > include/hw/i386/intel_iommu.h  |  1 +
> > > >  3 files changed, 16 insertions(+)
> > > >
> > > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > > > bf98fa5..ba1e7eb 100644
> > > > --- a/hw/i386/intel_iommu.c
> > > > +++ b/hw/i386/intel_iommu.c
> > > > @@ -2453,6 +2453,7 @@ static Property vtd_properties[] = {
> > > >      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
> > > >      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode,
> > > FALSE),
> > > >      DEFINE_PROP_BOOL("ecs", IntelIOMMUState, ecs, FALSE),
> > > > +    DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, FALSE),
> > > >      DEFINE_PROP_END_OF_LIST(),
> > > >  };
> > > >
> > > > @@ -2973,6 +2974,15 @@ static void vtd_init(IntelIOMMUState *s)
> > > >          s->ecap |= VTD_ECAP_ECS;
> > > >      }
> > > >
> > > > +    if (s->svm) {
> > > > +        if (!s->ecs || !x86_iommu->pt_supported || !s->caching_mode) {
> > > > +            error_report("Need to set ecs, pt, caching-mode for svm");
> > > > +            exit(1);
> > > > +        }
> > > > +        s->cap |= VTD_CAP_DWD | VTD_CAP_DRD;
> > > > +        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PTS | VTD_ECAP_PASID28;
> > > > +    }
> > > > +
> > > >      if (s->caching_mode) {
> > > >          s->cap |= VTD_CAP_CM;
> > > >      }
> > > > diff --git a/hw/i386/intel_iommu_internal.h
> > > > b/hw/i386/intel_iommu_internal.h index 71a1c1e..f2a7d12 100644
> > > > --- a/hw/i386/intel_iommu_internal.h
> > > > +++ b/hw/i386/intel_iommu_internal.h
> > > > @@ -191,6 +191,9 @@
> > > >  #define VTD_ECAP_PT                 (1ULL << 6)
> > > >  #define VTD_ECAP_MHMV               (15ULL << 20)
> > > >  #define VTD_ECAP_ECS                (1ULL << 24)
> > > > +#define VTD_ECAP_PASID28            (1ULL << 28)
> > > 
> > > Could I ask what's this bit? On my spec, it says this bit is reserved and defunct (spec
> > > version: June 2016).
> > 
> > As Ashok confirmed, yes it should be bit 40. would update it.
> 
> Ok.
> 
> > 
> > > > +#define VTD_ECAP_PRS                (1ULL << 29)
> > > > +#define VTD_ECAP_PTS                (0xeULL << 35)
> > > 
> > > Would it better we avoid using 0xe here, or at least add some comment?
> > 
> > For this value, it must be no more than the bits host supports. So it may be
> > better to have a default value and meanwhile expose an option to let user
> > set it. how about your opinion?
> 
> I think a more important point is that we need to make sure this value
> is no larger than hardware support? 

Agree. If it is larger, sanity check would fail.

> Since you are also working on the
> vfio interface for virt-svm... would it be possible that we can talk
> to kernel in some way so that we can know the supported pasid size in
> host IOMMU? So that when guest specifies something bigger, we can stop
> the user.

If it is just to stop when the size is not valid, I think we already have
such sanity check in host when trying to bind guest pasid table. Not sure
if it is practical to talk with kernel on the supported pasid size. But
may think about it. It is very likely that we need to do it through VFIO.

> 
> I don't know the practical value for this field, if it's static
> enough, I think it's also okay we make it static here as well. But
> again, I would prefer at least some comment, like:
> 
>   /* Value N indicates PASID field of N+1 bits, here 0xe stands for.. */

yes, at least we need to add such comments. Would add it.

> > 
> > > 
> > > >
> > > >  /* CAP_REG */
> > > >  /* (offset >> 4) << 24 */
> > > > @@ -207,6 +210,8 @@
> > > >  #define VTD_CAP_PSI                 (1ULL << 39)
> > > >  #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
> > > >  #define VTD_CAP_CM                  (1ULL << 7)
> > > > +#define VTD_CAP_DWD                 (1ULL << 54)
> > > > +#define VTD_CAP_DRD                 (1ULL << 55)
> > > 
> > > Just to confirm: after this series, we should support drain read/write then, right?
> > 
> > I haven’t done special process against it in IOMMU emulator. It's set to keep
> > consistence with VT-d spec since DWD and DRW is required capability when
> > PASID it reported as Set. However, I think it should be fine if guest issue QI
> > with drain read/write set in the descriptor. Host should be able to process it.
> 
> I see. IIUC the point here is we need to deliver these requests to
> host IOMMU, and I guess we need to be able to do this in a synchronous
> way as well.

yes, deliver request to host. For assigned devices, it is ok. BTW. do you
think we need to consider it for emulated devices?

Thanks,
Yi L
