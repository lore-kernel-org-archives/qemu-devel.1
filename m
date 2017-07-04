Received: from eggs.gnu.org ([2001:4830:134:3::10]:47123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHvF-0007Gd-0O
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHvE-00058w-0e
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:06:56 -0400
Date: Tue, 4 Jul 2017 15:06:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704070643.GB10298@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703221456.30817-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On Mon, 07/03 17:14, Eric Blake wrote:
> @@ -1717,6 +1718,10 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
>   * Drivers not implementing the functionality are assumed to not support
>   * backing files, hence all their sectors are reported as allocated.
>   *
> + * If 'allocation' is true, the caller only cares about allocation
> + * status; this is a hint that a larger 'pnum' result is more
> + * important than including BDRV_BLOCK_OFFSET_VALID in the return.
> + *

This is slightly unintuitive. I would guess "allocation == false" means "I don't
care about the allocation status" but it actually is "I don't care about the
consecutiveness". The "only" semantics is missing in the parameter name.

Maybe rename it to "consecutive" and invert the logic?  I.e. "consecutive ==
true" means BDRV_BLOCK_OFFSET_VALID is wanted.

Sorry for bikeshedding.

Fam
