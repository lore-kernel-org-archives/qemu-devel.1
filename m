Received: from eggs.gnu.org ([2001:4830:134:3::10]:37686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw52Q-0005sV-Sm
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw52Q-0000M1-1R
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:53:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cw52P-0000La-SW
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:53:13 -0400
Date: Thu, 6 Apr 2017 18:52:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170406105255.GA3981@pxdev.xzpeter.org>
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
	<1491462524-1617-2-git-send-email-peterx@redhat.com>
	<0fc836bc-499b-f6b9-f862-9ba26a96beda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fc836bc-499b-f6b9-f862-9ba26a96beda@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/9] memory: add section range info for
 IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, bd.aviv@gmail.com, David Gibson <david@gibson.dropbear.id.au>

On Thu, Apr 06, 2017 at 12:42:54PM +0200, Auger Eric wrote:
> Hi Peter,
> On 06/04/2017 09:08, Peter Xu wrote:
> > In this patch, IOMMUNotifier.{start|end} are introduced to store section
> > information for a specific notifier. When notification occurs, we not
> > only check the notification type (MAP|UNMAP), but also check whether the
> > notified iova range overlaps with the range of specific IOMMU notifier,
> > and skip those notifiers if not in the listened range.
> > 
> > When removing an region, we need to make sure we removed the correct
> > VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.
> > 
> > This patch is solving the problem that vfio-pci devices receive
> > duplicated UNMAP notification on x86 platform when vIOMMU is there. The
> > issue is that x86 IOMMU has a (0, 2^64-1) IOMMU region, which is
> > splitted by the (0xfee00000, 0xfeefffff) IRQ region. AFAIK
> > this (splitted IOMMU region) is only happening on x86.
> I think this is likely to happen on other architectures too as "reserved
> regions" are now exported to the user space.

Good to know this.

> > 
> > This patch also helps vhost to leverage the new interface as well, so
> > that vhost won't get duplicated cache flushes. In that sense, it's an
> > slight performance improvement.
> > 
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> Looks good to me.
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

-- peterx
