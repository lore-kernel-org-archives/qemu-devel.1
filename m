Received: from eggs.gnu.org ([2001:4830:134:3::10]:53090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMXV1-0007QI-Bb
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 04:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMXUy-00062O-8L
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 04:59:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMXUy-00062K-2c
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 04:59:48 -0500
Date: Thu, 29 Dec 2016 17:59:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161229095940.GB4195@pxdev.xzpeter.org>
References: <A2975661238FB949B60364EF0F2C257438FEF893@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257438FEF893@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 12/13] intel_iommu: do replay when
 context invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>

On Thu, Dec 29, 2016 at 07:38:38AM +0000, Liu, Yi L wrote:
> > Before this one we only invalidate context cache when we receive context
> > entry invalidations. However it's possible that the invalidation also
> > contains a domain switch (only if cache-mode is enabled for vIOMMU). In
> > that case we need to notify all the registered components about the new
> > mapping.
> > 
> > Signed-off-by: Peter Xu <address@hidden>
> > ---
> >  hw/i386/intel_iommu.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 2fcd7af..0220e63 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -1188,6 +1188,7 @@ static void vtd_context_device_invalidate(IntelIOMMUState 
> > *s,
> >                  trace_vtd_inv_desc_cc_device(bus_n, (devfn_it >> 3) & 0x1f,
> >                                               devfn_it & 3);
> >                  vtd_as->context_cache_entry.context_cache_gen = 0;
> > +                memory_region_iommu_replay_all(&vtd_as->iommu);
> 
> Hi Peter,
> 
> It looks like all the device context invalidation would result in replay even the
> device is not an assigned device. Is it necessary to do replay for a virtual device?

Normal emulated devices won't register for IOMMU notifier. For these
devices, MemoryRegion.iommu_notify will be empty. So replay on those
memory regions should not affect them at all.

Thanks,

-- peterx
