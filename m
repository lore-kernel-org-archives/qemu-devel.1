Received: from eggs.gnu.org ([2001:4830:134:3::10]:55386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1q2I-0003Uw-0j
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1q2H-0007Hd-6g
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:37:10 -0400
Date: Tue, 10 Oct 2017 10:36:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010083651.GC4177@dhcp-200-186.str.redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/18] block: BDS deletion during
 bdrv_drain_recurse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Am 13.09.2017 um 20:18 hat Max Reitz geschrieben:
> Drainined a BDS child may lead to both the original BDS and/or its other
> children being deleted (e.g. if the original BDS represents a block
> job).  We should prepare for this in both bdrv_drain_recurse() and
> bdrv_drained_begin() by monitoring whether the BDS we are about to drain
> still exists at all.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

How hard would it be to write a test case for this? qemu-iotests
probably isn't the right tool, but I feel a C unit test would be
possible.

> -    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
> -        BlockDriverState *bs = child->bs;
> -        bool in_main_loop =
> -            qemu_get_current_aio_context() == qemu_get_aio_context();
> -        assert(bs->refcnt > 0);

Would it make sense to keep this assertion for the !deleted case?

> -        if (in_main_loop) {
> -            /* In case the recursive bdrv_drain_recurse processes a
> -             * block_job_defer_to_main_loop BH and modifies the graph,
> -             * let's hold a reference to bs until we are done.
> -             *
> -             * IOThread doesn't have such a BH, and it is not safe to call
> -             * bdrv_unref without BQL, so skip doing it there.
> -             */
> -            bdrv_ref(bs);
> -        }
> -        waited |= bdrv_drain_recurse(bs);
> -        if (in_main_loop) {
> -            bdrv_unref(bs);
> +    /* Draining children may result in other children being removed and maybe
> +     * even deleted, so copy the children list first */

Maybe it's just me, but I failed to understand this correctly at first.
How about "being removed from their parent" to clarify that it's not the
BDS that is removed, but just the reference?

Kevin
