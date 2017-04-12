Received: from eggs.gnu.org ([2001:4830:134:3::10]:50903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyEtp-0004Z0-LY
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyEto-0003yM-Nu
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:49:17 -0400
Date: Wed, 12 Apr 2017 11:49:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170412094909.GC4955@noname.str.redhat.com>
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411011718.9152-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 01/13] qcow2: Unallocate unmapped zero
 clusters if no backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 11.04.2017 um 03:17 hat Eric Blake geschrieben:
> 'qemu-img map' already coalesces information about unallocated
> clusters (those with status 0) and pure zero clusters (those
> with status BDRV_BLOCK_ZERO and no offset).  Furthermore, all
> qcow2 images with no backing file already report all unallocated
> clusters (in the preallocation sense of clusters with no offset)
> as BDRV_BLOCK_ZERO, regardless of whether the QCOW_OFLAG_ZERO was
> set in that L2 entry (QCOW_OFLAG_ZERO also implies a return of
> BDRV_BLOCK_ALLOCATED, but we intentionally do not expose that bit
> to external users), thanks to generic block layer code in
> bdrv_co_get_block_status().
> 
> So, for an image with no backing file, having bdrv_pwrite_zeroes
> mark clusters as unallocated (defer to backing file) rather than
> reads-as-zero (regardless of backing file) makes no difference
> to normal behavior, but may potentially allow for fewer writes to
> the L2 table of a freshly-created image where the L2 table is
> initially written to all-zeroes (although I don't actually know
> if we skip an L2 update and flush when re-writing the same
> contents as already present).

I don't get this. Allocating a cluster always involves an L2 update, no
matter whether it was previously unallocated or a zero cluster.

> Furthermore, this matches the behavior of discard_single_l2(), in
> favoring an unallocated cluster over a zero cluster when full
> discard is requested.

The only use for "full discard" is qcow2_make_empty(). It explicitly
requests that the backing file becomes visible again. This is a
completely different case.

In other words, in order to stay consistent between discard and
write_zeroes from a guest POV, we need to leave this code alone.

> Meanwhile, version 2 qcow2 files (compat=0.10) lack support for an
> explicit zero cluster.  This minor tweak therefore allows us to turn
> write zeroes with unmap into an actual unallocation on those files,
> where they used to return -ENOTSUP and cause an allocation due to
> the fallback to explicitly written zeroes.

Okay, this is true.

But I doubt that making write_zeroes more efficient on v2 images without
a backing file is really worth any extra complexity at this point...

Kevin
