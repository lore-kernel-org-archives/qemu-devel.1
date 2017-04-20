Received: from eggs.gnu.org ([2001:4830:134:3::10]:57231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1AES-0000ht-PU
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 07:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1AER-0003ct-Kb
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 07:26:40 -0400
Date: Thu, 20 Apr 2017 13:26:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170420112629.GF4747@noname.redhat.com>
References: <20170420075237.18219-1-famz@redhat.com>
	<20170420075237.18219-20-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420075237.18219-20-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 19/20] file-posix: Add image locking in
 perm operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 20.04.2017 um 09:52 hat Fam Zheng geschrieben:
> virtlockd in libvirt locks the first byte, so we start looking at the
> file bytes from 0x10.
> 
> The complication is in the transactional interface.  To make the reopen
> logic managable, and allow better reuse, the code is internally
> organized with a table from old mode to the new one.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Looking at the very early patches in this series, I think it quickly
becomes obvious that we need to discuss one thing first:

> +static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
> +                          Error **errp)
> +{
> +    bool is_shared;
> +    BDRVRawState *s = bs->opaque;
> +
> +    if (!RAW_LOCK_SUPPORTED) {
> +        return 0;
> +    }
> +    if (s->lock_update) {
> +        /* Override the previously stashed update. */
> +        g_free(s->lock_update);
> +        s->lock_update = NULL;
> +    }
> +    is_shared = !(perm & BLK_PERM_CONSISTENT_READ) && (shared & BLK_PERM_WRITE);

Why do you check BLK_PERM_CONSISTENT_READ? The locks that we said we
would take on the image file represent BLK_PERM_WRITE, both in perm and
in shared, so this is what they should be checked against. Opening the
image in another process is fine if BLK_PERM_WRITE is set in shared,
even if BLK_PERM_CONSISTENT_READ is also set in perm.

BLK_PERM_CONSISTENT_READ is for cases where the contents of an image
is inherently invalid, not just because of a concurrent writer that we
might not be aware of, but because the image just doesn't makes sense on
it own. It may make sense as part of larger backing chain, though (the
only place where we clear the flag is for intermediate nodes in the
commit job). This semantics is more or less separate from what we want
to achieve here.

Of course, if we wanted, I guess we could individually map all 64
bits of each perm and shared to bytes to be locked in the file, so that
all permissions would be shared between qemu instances. That's probably
not worth the effort though.

And even if we did that, most likely you still wouldn't need any special
exceptions for BLK_PERM_CONSISTENT_READ, because it is always shared
except when one process wants to run a commit job - and for a commit
job, making sure that nobody else uses the image would probably be
right.

So if we really treat the file system level locks just as a mapping of
BLK_PERM_WRITE, things should become a bit easier in the early patches
of this series.

Kevin
