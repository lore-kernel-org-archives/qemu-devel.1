Received: from eggs.gnu.org ([2001:4830:134:3::10]:36180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dhbqS-00011j-LB
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dhbqP-0000cQ-Uy
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:25:20 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170809140256.25584-2-el13635@mail.ntua.gr>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-2-el13635@mail.ntua.gr>
Date: Tue, 15 Aug 2017 15:24:38 +0200
Message-ID: <w51fuctyne1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/6] block: skip implicit nodes in
 snapshots, blockjobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Wed 09 Aug 2017 04:02:51 PM CEST, Manos Pitsidianakis wrote:
> @@ -2988,6 +3004,9 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>          return;
>      }
>  
> +    /* Skip implicit filter nodes */
> +    bs = bdrv_get_first_explicit(bs);
> +
>      aio_context = bdrv_get_aio_context(bs);
>      aio_context_acquire(aio_context);

This change works here because right now the only implicit node that we
could have in practice is the throttle node, but I wonder if this is
good enough for any kind of implicit node in general.

> +static inline BlockDriverState *child_bs(BlockDriverState *bs)
> +{
> +    BdrvChild *child = QLIST_FIRST(&bs->children);
> +    assert(child && !QLIST_NEXT(child, next));
> +    return child->bs;
> +}

This aborts if the bs has a number of children != 1. That's not
something that I would expect from a function named like that.

Considering that you're only using it in bdrv_get_first_explicit(), why
don't you simply move the code there?

The other question is of course whether we can rely for the future on
the assumption that implicit nodes only have one children.

Berto
