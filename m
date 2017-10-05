Received: from eggs.gnu.org ([2001:4830:134:3::10]:59485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e08D3-00008N-1f
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e08D0-0003m8-AK
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:37:12 -0400
Date: Thu, 5 Oct 2017 11:36:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171005153652.GH10969@stefanha-x1.localdomain>
References: <20171004014347.25099-1-eblake@redhat.com>
	<20171004014347.25099-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004014347.25099-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] block: Perform copy-on-read in loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Oct 03, 2017 at 08:43:46PM -0500, Eric Blake wrote:
> Improve our braindead copy-on-read implementation.  Pre-patch,
> we have multiple issues:
> - we create a bounce buffer and perform a write for the entire
> request, even if the active image already has 99% of the
> clusters occupied, and really only needs to copy-on-read the
> remaining 1% of the clusters
> - our bounce buffer was as large as the read request, and can
> needlessly exhaust our memory by using double the memory of
> the request size (the original request plus our bounce buffer),
> rather than a capped maximum overhead beyond the original
> - if a driver has a max_transfer limit, we are bypassing the
> normal code in bdrv_aligned_preadv() that fragments to that
> limit, and instead attempt to read the entire buffer from the
> driver in one go, which some drivers may assert on
> - a client can request a large request of nearly 2G such that
> rounding the request out to cluster boundaries results in a
> byte count larger than 2G.  While this cannot exceed 32 bits,
> it DOES have some follow-on problems:
> -- the call to bdrv_driver_pread() can assert for exceeding
> BDRV_REQUEST_MAX_BYTES, if the driver is old and lacks
> .bdrv_co_preadv
> -- if the buffer is all zeroes, the subsequent call to
> bdrv_co_do_pwrite_zeroes is a no-op due to a negative size,
> which means we did not actually copy on read
> 
> Fix all of these issues by breaking up the action into a loop,
> where each iteration is capped to sane limits.  Also, querying
> the allocation status allows us to optimize: when data is
> already present in the active layer, we don't need to bounce.
> 
> Note that the code has a telling comment that copy-on-read
> should probably be a filter driver rather than a bolt-in hack
> in io.c; but that remains a task for another day.
> 
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: avoid uninit ret on 0-length op [patchew, Kevin]
> ---
>  block/io.c | 120 +++++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 82 insertions(+), 38 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
