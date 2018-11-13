Received: from eggs.gnu.org ([2001:4830:134:3::10]:49547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMShR-0000XK-62
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMShN-0003Fd-Kw
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:01:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:26635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gMShM-0002sX-R0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:01:21 -0500
Date: Tue, 13 Nov 2018 14:59:02 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181113065901.vvg2uegaxoiejn5y@linux.intel.com>
References: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1541764187-10732-3-git-send-email-yu.c.zhang@linux.intel.com>
	<20181112083634.GC20675@xz-x1>
	<20181112094201.qzeateh35cfozu7n@linux.intel.com>
	<20181113033707.GH20675@xz-x1> <20181113050451.GI20675@xz-x1>
	<20181113054544.y7gbcf6wkyud2igw@linux.intel.com>
	<20181113061216.GK20675@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113061216.GK20675@xz-x1>
Subject: Re: [Qemu-devel] [PATCH v1 2/3] intel-iommu: extend VTD emulation
 to allow 57-bit IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Nov 13, 2018 at 02:12:17PM +0800, Peter Xu wrote:
> On Tue, Nov 13, 2018 at 01:45:44PM +0800, Yu Zhang wrote:
> 
> [...]
> 
> > > > Since at it, another thing I thought about is making sure the IOMMU
> > > > capabilities will match between host and guest IOMMU, which I think
> > > > this series has ignorred so far.  E.g., when we're having assigned
> > > > devices in the guest and with 5-level IOVA, we should make sure the
> > > > host IOMMU supports 5-level as well before the guest starts since
> > > > otherwise the shadow page synchronization could potentially fail when
> > > > the requested IOVA address goes beyond 4-level.  One simple solution
> > > > is just to disable device assignment for now when we're with 57bits
> > > > vIOMMU but I'm not sure whether that's what you want, especially you
> > > > mentioned the DPDK case (who may use assigned devices).
> > > 
> > > Ok I totally forgot that we don't even support any kind of check like
> > > this before... So feel free to skip this comment if you want, or it
> > > would be even nicer if you want to fix it as a whole. :)
> > > 
> > 
> > Indeed. We have talked about this before. How about we focus on the 5-level
> > extension for now, and solve the check issue in the future? I still do not
> > have any clean solutions in mind. BTW, any suggestions on this issue? :)
> 
> I started to remember our discussions, sorry I should remember them
> earlier... :)
> 
> The only thing in my mind (I think I also suggested the same thing
> during that discussion, but I don't trust my memory any more...) is to
> use sysfs.  Say:
> 
>   1. Scan /sys/class/iommu/dmarN for all the host IOMMUs, read cap of
>      each IOMMU from /sys/class/iommu/dmar0/intel-iommu/cap,
> 
>   2. For each host iommu, scan /sys/class/iommu/dmarN/devices for all
>      the devices under each host IOMMU, then we can know which IOMMU
>      owns which device,
> 
>   3. For each assigned device to the guest, we lookup the previous
>      information to know the mgaw for each host device, raise error
>      and stop QEMU from booting if any of the host device has less
>      level supported than the guest vIOMMU (possibly some more checks
>      in vtd_iommu_notify_flag_changed)
> 
> (we still have some issue on vtd_iommu_notify_flag_changed since it's
>  only run until the first enablement of vIOMMU, so we'll only raise
>  the error during guest Linux boots with vIOMMU on. But that's another
>  issue)

Thanks for the explanation, Peter. You do have a better memory than I am.:)


> 
> Regards,
> 
> -- 
> Peter Xu
> 

B.R.
Yu
