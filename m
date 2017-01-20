Received: from eggs.gnu.org ([2001:4830:134:3::10]:39415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYHq-0005YO-6i
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYHp-0005tq-Fi
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:27:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUYHp-0005tN-9s
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:27:21 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78B31C057FA5
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 12:27:21 +0000 (UTC)
Date: Fri, 20 Jan 2017 20:27:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170120122718.GB13810@pxdev.xzpeter.org>
References: <1484817932-14452-1-git-send-email-peterx@redhat.com>
	<20170119105437.5b17d979@t450s.home>
	<20170120034328.GG4914@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170120034328.GG4914@pxdev.xzpeter.org>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Jan 20, 2017 at 11:43:28AM +0800, Peter Xu wrote:

[...]

> > What I don't want to see is for this API bug to leak out into the rest
> > of the QEMU code such that intel_iommu code, or iommu code in general
> > subtly avoids it by artificially using a smaller range.  VT-d hardware
> > has an actual physical address space of either 2^39 or 2^48 bits, so if
> > you want to make the iommu address space match the device we're trying
> > to emulate, that's perfectly fine.  AIUI, AMD-Vi does actually have a
> > 64-bit address space on the IOMMU, so to handle that case I'd expect
> > the simplest solution would be to track the and mapped iova high water
> > mark per container in vfio and truncate unmaps to that high water end
> > address.  Realistically we're probably not going to see iovas at the end
> > of the 64-bit address space, but we can come up with some other
> > workaround in the vfio code or update the kernel API if we do.  Thanks,
> 
> Agree that high watermark can be a good solution for VT-d. I'll use
> that instead of 2^63-1.

Okay when I replied I didn't notice this "watermark" may need more
than several (even tens of) LOCs. :(

Considering that I see no further usage of this watermark, I'm
thinking whether it's okay I directly use (1ULL << VTD_MGAW) here as
the watermark - it's simple, efficient and secure imho.

Thanks,

-- peterx
