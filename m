Received: from eggs.gnu.org ([209.51.188.92]:59112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghWGR-0002J3-MI
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghWGQ-0008PC-J8
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:04:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ghWGQ-0008C0-Bf
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:04:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93455C070E10
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:04:16 +0000 (UTC)
Date: Thu, 10 Jan 2019 10:04:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190110100409.1acaf5e8.cohuck@redhat.com>
In-Reply-To: <154707542737.22183.7160770678781819267.stgit@gimli.home>
References: <154707542737.22183.7160770678781819267.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com

On Wed, 09 Jan 2019 16:10:51 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

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
> ---
>  hw/vfio/common.c     |   20 +++++++++++++++++++-
>  hw/vfio/trace-events |    1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
