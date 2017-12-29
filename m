Received: from eggs.gnu.org ([2001:4830:134:3::10]:50832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUkWp-0004V7-UY
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 21:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUkWo-0006B4-RZ
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 21:36:11 -0500
Date: Fri, 29 Dec 2017 10:35:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229023555.GB13004@lemon>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 01/20] block: Add
 .bdrv_co_block_status() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, 12/07 14:30, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based. Now that the block layer exposes byte-based allocation,
> it's time to tackle the drivers.  Add a new callback that operates
> on as small as byte boundaries. Subsequent patches will then update
> individual drivers, then finally remove .bdrv_co_get_block_status().
> 
> The new code also passes through the 'want_zero' hint, which will
> allow subsequent patches to further optimize callers that only care
> about how much of the image is allocated (want_zero is false),
> rather than full details about runs of zeroes and which offsets the
> allocation actually maps to (want_zero is true).  As part of this
> effort, fix another part of the documentation: the claim in commit
> 4c41cb4 that BDRV_BLOCK_ALLOCATED is short for 'DATA || ZERO' is a
> lie at the block layer (see commit e88ae2264), even though it is
> how the bit is computed from the driver layer.  After all, there
> are intentionally cases where we return ZERO but not ALLOCATED at
> the block layer, when we know that a read sees zero because the
> backing file is too short.  Note that the driver interface is thus
> slightly different than the public interface with regards to which
> bits will be set, and what guarantees are provided on input.
> 
> We also add an assertion that any driver using the new callback will
> make progress (the only time pnum will be 0 is if the block layer
> already handled an out-of-bounds request, or if there is an error);
> the old driver interface did not provide this guarantee, which
> could lead to some inf-loops in drastic corner-case failures.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v6: drop now-useless rounding of mid-sector end-of-file hole [Kevin],
> better documentation of 'want_zero' [Kevin]

Reviewed-by: Fam Zheng <famz@redhat.com>
