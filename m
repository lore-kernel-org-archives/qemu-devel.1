Received: from eggs.gnu.org ([2001:4830:134:3::10]:41699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fafCV-0006BN-6S
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fafCO-0004uk-AV
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:39:55 -0400
Date: Wed, 4 Jul 2018 12:39:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180704103918.GC4334@localhost.localdomain>
References: <20180703180751.243496-1-vsementsov@virtuozzo.com>
	<20180703180751.243496-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703180751.243496-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/backup: fix fleecing scheme: use
 serialized writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org

Am 03.07.2018 um 20:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Fleecing scheme works as follows: we want a kind of temporary snapshot
> of active drive A. We create temporary image B, with B->backing = A.
> Then we start backup(sync=none) from A to B. From this point, B reads
> as point-in-time snapshot of A (A continues to be active drive,
> accepting guest IO).
> 
> This scheme needs some additional synchronization between reads from B
> and backup COW operations, otherwise, the following situation is
> theoretically possible:
> 
> (assume B is qcow2, client is NBD client, reading from B)
> 
> 1. client starts reading and take qcow2 mutex in qcow2_co_preadv, and
>    goes up to l2 table loading (assume cache miss)
> 
> 2) guest write => backup COW => qcow2 write =>
>    try to take qcow2 mutex => waiting
> 
> 3. l2 table loaded, we see that cluster is UNALLOCATED, go to
>    "case QCOW2_CLUSTER_UNALLOCATED" and unlock mutex before
>    bdrv_co_preadv(bs->backing, ...)
> 
> 4) aha, mutex unlocked, backup COW continues, and we finally finish
>    guest write and change cluster in our active disk A
> 
> 5. actually, do bdrv_co_preadv(bs->backing, ...) and read
>    _new updated_ data.
> 
> To avoid this, let's make all COW writes serializing, to not intersect
> with reads from B.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I think this should work, even though we can still improve it a bit.

First, I don't think we need to disable copy offloading as long as we
add BDRV_REQ_SERIALISING support to bdrv_co_copy_range_internal(). The
thing that's a bit strange there is that there is only a single flags
parameter for both source and target. We may need to split that so
that we can pass BDRV_REQ_NO_SERIALISING for the source and
BDRV_REQ_SERIALISING for the target.

> +    /* Detect image fleecing */
> +    fleecing = sync_mode == MIRROR_SYNC_MODE_NONE && target->backing->bs == bs;

The other thing is that I'm not convinced of the condition here. This is
the narrowest thinkable condition to recognise the exact fleecing setup
we have in mind right now. However, it is not the condition to flag all
setups that are affected by the same problem.

I don't think sync_mode actually makes a meaningful difference here. If
someone wants to create a full backup and already access it while the
job is still in progress, they will still want it to be consistent.

It also doesn't make a difference whether the fleecing overlay has the
source directly attached as a backing node or whether there is a filter
node between them.

So while I'm not sure whether it really covers all interesting cases,
this condition would already be a lot better:

    fleecing = bdrv_chain_contains(target, bs);

Maybe rename the variable to serialise_target_writes because it's no
longer restricted to the exact fleecing case.

> +    if (fleecing) {
> +        if (compress) {
> +            error_setg(errp, "Image fleecing doesn't support compressed mode.");
> +            return NULL;
> +        }
> +    }

Why not fleecing && compress instead of a nested if? And why is
fleecing even at odds with compression?

Kevin
