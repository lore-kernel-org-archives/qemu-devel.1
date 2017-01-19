Received: from eggs.gnu.org ([2001:4830:134:3::10]:49588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUGv5-00012a-3l
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUGv1-0007Qo-R5
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:54:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cUGv1-0007Pt-Kc
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:54:39 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B4E480466
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 17:54:39 +0000 (UTC)
Date: Thu, 19 Jan 2017 10:54:37 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170119105437.5b17d979@t450s.home>
In-Reply-To: <1484817932-14452-1-git-send-email-peterx@redhat.com>
References: <1484817932-14452-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 0/3] vfio: allow to notify unmap for
 very big region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 19 Jan 2017 17:25:29 +0800
Peter Xu <peterx@redhat.com> wrote:

> This requirement originates from the VT-d vfio series:
> 
>   https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03495.html
> 
> The goal of this series is to allow IOMMU to notify unmap with very
> big IOTLB range, for example, with base=0 and size=2^63-1 (to unmap
> the whole address space).
> 
> The first patch is a good to have, for traces.
> 
> The second one is a cleanup of existing code, only.

Sort of, it does add some overhead to the unmap path, but you remove
that and more in the third patch.
 
> The third one moves the further RAM translation and check into map
> operation logic, so that it'll free unmap operations.
> 
> The series is marked as RFC since I am not sure whether this is a
> workable way. Anyway, please review to help confirm it.

It seems reasonable to me, except for the example here of using 2^63-1,
which I expect is to work around the vfio {un}map API bug as we
discussed on irc.  For everyone, the root of the problem is that the
ioctls use:

        __u64   iova;                           /* IO virtual address */
        __u64   size;                           /* Size of mapping (bytes) */

So we can only express a size of 2^64-1 and we have an off-by-one error
trying to perform a map/unmap of an entire 64-bit space.  Note when
designing an API, use start/end rather than base/size to avoid this.

What I don't want to see is for this API bug to leak out into the rest
of the QEMU code such that intel_iommu code, or iommu code in general
subtly avoids it by artificially using a smaller range.  VT-d hardware
has an actual physical address space of either 2^39 or 2^48 bits, so if
you want to make the iommu address space match the device we're trying
to emulate, that's perfectly fine.  AIUI, AMD-Vi does actually have a
64-bit address space on the IOMMU, so to handle that case I'd expect
the simplest solution would be to track the and mapped iova high water
mark per container in vfio and truncate unmaps to that high water end
address.  Realistically we're probably not going to see iovas at the end
of the 64-bit address space, but we can come up with some other
workaround in the vfio code or update the kernel API if we do.  Thanks,

Alex
