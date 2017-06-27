Received: from eggs.gnu.org ([2001:4830:134:3::10]:55121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmhz-00059a-4h
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmhv-0002la-6N
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:22:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPmhu-0002lW-TI
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:22:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9A8EC04D28D
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:22:49 +0000 (UTC)
Date: Tue, 27 Jun 2017 17:22:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170627092244.GA14652@pxdev.xzpeter.org>
References: <1498554219-4942-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498554219-4942-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/8] VT-d: some enhancements on iotlb and
 tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Tue, Jun 27, 2017 at 05:03:31PM +0800, Peter Xu wrote:
> Patch 1: fixes a very rare PT path issue on iova value. It didn't
> break anything since it's merely not touched (only if when IOMMU
> enabled, then set one device to PT), but still better fix it.
> 
> Patch 2-5: added "info iommu" hmp command, and implemented for VT-d.
> Meanwhile, added some statistics for iotlb.

For patch 2,3,5 I should CC Dave. Sorry to have forgotten.

> 
> Patch 6: introduce "x-iotlb-size" to tune iotlb size, or to turn it
> off (e.g., when we want to measure how iotlb affects one payload).
> 
> Patch 7: some refine on iotlb entry.
> 
> Patch 8: implemented MRU list algorithm for iotlb.
> 
> For the last patch, it's logically making more sense than the old
> algo, however the performance is merely the same as before (as far as
> I tested with simple netperf payloads, in either streaming, rr,
> reverse, etc.) since in most normal cases we cannot really let iotlb
> overflow especially when size is 1024 by default, e.g., guest kernel
> driver will release buffer when after used, and unstrict
> intel_iommu=on parameter will also send periodic global iotlb flush
> which will reset the whole cache. If anyone has suggestion on specific
> workload, please shoot. Anyway, I'm posting this out for review to see
> any possible comments/suggestions.
> 
> Thanks,
> 
> Peter Xu (8):
>   intel_iommu: fix VTD_PAGE_MASK
>   hmp: add info iommu
>   intel_iommu: support "info iommu"
>   intel_iommu: add iotlb/context cache statistics
>   intel_iommu: hmp: allow "-c" for "info iommu"
>   intel_iommu: let iotlb size tunable
>   intel_iommu: use access_flags for iotlb
>   intel_iommu: implement mru list for iotlb
> 
>  hmp-commands-info.hx           |  14 ++++
>  hmp.c                          |   6 ++
>  hmp.h                          |   1 +
>  hw/i386/intel_iommu.c          | 169 +++++++++++++++++++++++++++++++----------
>  hw/i386/intel_iommu_internal.h |  11 +--
>  hw/i386/trace-events           |   1 -
>  hw/i386/x86-iommu.c            |  17 +++++
>  include/hw/i386/intel_iommu.h  |  20 ++++-
>  include/hw/i386/x86-iommu.h    |   5 ++
>  include/hw/iommu.h             |   9 +++
>  stubs/Makefile.objs            |   1 +
>  stubs/iommu.c                  |   9 +++
>  12 files changed, 209 insertions(+), 54 deletions(-)
>  create mode 100644 include/hw/iommu.h
>  create mode 100644 stubs/iommu.c
> 
> -- 
> 2.7.4
> 
> 

-- 
Peter Xu
