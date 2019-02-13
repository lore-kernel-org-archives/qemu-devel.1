Received: from eggs.gnu.org ([209.51.188.92]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtpvv-0004mG-CA
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtpu4-0006Eo-7g
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:28:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gtpu3-00068U-7v
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:28:24 -0500
Date: Wed, 13 Feb 2019 16:28:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190213082812.GB6228@xz-x1>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-2-git-send-email-yi.y.sun@linux.intel.com>
	<20190211101213.GF1011@xz-x1> <20190213073855.GE16968@yi.y.sun>
	<20190213080305.GA6228@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190213080305.GA6228@xz-x1>
Subject: Re: [Qemu-devel] [RFC v1 1/3] intel_iommu: scalable mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Sun <yi.y.sun@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On Wed, Feb 13, 2019 at 04:03:05PM +0800, Peter Xu wrote:
> On Wed, Feb 13, 2019 at 03:38:55PM +0800, Yi Sun wrote:
> 
> [...]
> 
> > > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > > index 8b72735..396ac8e 100644
> > > > --- a/hw/i386/intel_iommu.c
> > > > +++ b/hw/i386/intel_iommu.c
> > > > @@ -37,6 +37,34 @@
> > > >  #include "kvm_i386.h"
> > > >  #include "trace.h"
> > > >  
> > > > +#define vtd_devfn_check(devfn) ((devfn & VTD_DEVFN_CHECK_MASK) ? true : false)
> > > 
> > > "vtd_devfn_check(devfn)" is merely as long as "devfn &
> > > VTD_DEVFN_CHECK_MASK", isn't it? :)
> > > 
> > > I would just drop the macro.
> > > 
> > There are two places to call this macro. Is that valuable to keep it?
> 
> The point here is "A ? true : false" is exactly "A" when used in
> condition checks.  So IMHO it's clean enough to write:
> 
>   if (devfn & VTD_DEVFN_CHECK_MASK) {
>     ...
>   }
> 
> Comparing to:
> 
>   if (vtd_devfn_check(devfn)) {
>     ...
>   }
> 
> And imho actually the name "check"/"mask" is confusing itself
> already...  So maybe even dropping both vtd_devfn_check() and
> VTD_DEVFN_CHECK_MASK (note: there's nothing about any validity checks,
> and it's not a mask at all!) and simply:
> 
>   if (devfn >= UINT8_MAX / 2)
> 
> That's even clearer to me that it's splitted into two halves.

Sorry I didn't notice UINT8_MAX is 255 rather than 256, then it should
be ">"...  anyway, these are a bit nitpicking, feel free to use your
own preference at last.

> 
> [...]
> 
> > > > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> > > > index a321cc9..ff13ff27 100644
> > > > --- a/include/hw/i386/intel_iommu.h
> > > > +++ b/include/hw/i386/intel_iommu.h
> > > > @@ -66,11 +66,12 @@ typedef struct VTDIOTLBEntry VTDIOTLBEntry;
> > > >  typedef struct VTDBus VTDBus;
> > > >  typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
> > > >  typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
> > > > +typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
> > > > +typedef struct VTDPASIDEntry VTDPASIDEntry;
> > > >  
> > > >  /* Context-Entry */
> > > >  struct VTDContextEntry {
> > > > -    uint64_t lo;
> > > > -    uint64_t hi;
> > > > +    uint64_t val[4];
> > > 
> > > You can actually make it an enum, two benefits:
> > > 
> > Thanks for the suggestion! DYM 'union'?
> 
> Yes. :)
> 
> Regards,
> 
> -- 
> Peter Xu

Regards,

-- 
Peter Xu
