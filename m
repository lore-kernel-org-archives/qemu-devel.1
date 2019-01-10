Received: from eggs.gnu.org ([209.51.188.92]:35072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ghQkv-0007ow-8f
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ghQku-0003Fj-Eo
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:11:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ghQku-0003EV-5D
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:11:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 669334024B
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 03:11:38 +0000 (UTC)
Date: Thu, 10 Jan 2019 11:11:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190110031132.GB11601@xz-x1>
References: <154707542737.22183.7160770678781819267.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154707542737.22183.7160770678781819267.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH] vfio/common: Work around kernel overflow
 bug in DMA unmap
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

On Wed, Jan 09, 2019 at 04:10:51PM -0700, Alex Williamson wrote:
> A kernel bug was introduced in v4.15 via commit 71a7d3d78e3c which
> adds a test for address space wrap-around in the vfio DMA unmap path.
> Unfortunately due to overflow, the kernel detects an unmap of the last
> page in the 64-bit address space as a wrap-around.  In QEMU, a Q35
> guest with VT-d emulation and guest IOMMU enabled will attempt to make
> such an unmap request during VM system reset, triggering an error:
> 
>   qemu-kvm: VFIO_UNMAP_DMA: -22
>   qemu-kvm: vfio_dma_unmap(0x561f059948f0, 0xfef00000, 0xffffffff01100000) = -22 (Invalid argument)
> 
> Here the IOVA start address (0xfef00000) and the size parameter
> (0xffffffff01100000) add to exactly 2^64, triggering the bug.  A
> kernel fix is queued for the Linux v5.0 release to address this.
> 
> This patch implements a workaround to retry the unmap, excluding the
> final page of the range when we detect an unmap failing which matches
> the requirements for this issue.  This is expected to be a safe and
> complete workaround as the VT-d address space does not extend to the
> full 64-bit space and therefore the last page should never be mapped.
> 
> This workaround can be removed once all kernels with this bug are
> sufficiently deprecated.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
> Reported-by: Pei Zhang <pezhang@redhat.com>
> Debugged-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
