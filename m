Received: from eggs.gnu.org ([2001:4830:134:3::10]:59667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCqwg-0006FE-IR
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCqwf-00040C-I1
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:53:26 -0400
References: <20181017164200.22344-1-kwolf@redhat.com>
	<20181017164200.22344-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d7cef744-9dee-1445-b219-b01404051543@redhat.com>
Date: Wed, 17 Oct 2018 13:53:13 -0500
MIME-Version: 1.0
In-Reply-To: <20181017164200.22344-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/9] block: Require auto-read-only for
 existing fallbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/17/18 11:41 AM, Kevin Wolf wrote:
> Some block drivers have traditionally changed their node to read-only
> mode without asking the user. This behaviour has been marked deprecated
> since 2.11, expecting users to provide an explicit read-only=on option.
> 
> Now that we have auto-read-only=on, enable these drivers to make use of
> the option.
> 
> This is the only use of bdrv_set_read_only(), so we can make it a bit
> more specific and turn it into a bdrv_apply_auto_read_only() that is
> more convenient for drivers to use.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +/*
> + * Called by a driver that can only provide a read-only image.
> + *
> + * Returns 0 if the node is already read-only or it could switch the node to
> + * read-only because BDRV_O_AUTO_RDONLY is set.
> + *
> + * Returns -EACCES if the node is read-write and BDRV_O_AUTO_RDONLY is not set
> + * or bdrv_can_set_read_only() forbids making the node read-only. If @errmsg
> + * is not NULL, it is used as the error message for the Error object.

Works for me.

> +++ b/block/rbd.c
> @@ -780,16 +780,10 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>       /* If we are using an rbd snapshot, we must be r/o, otherwise
>        * leave as-is */
>       if (s->snap != NULL) {
> -        if (!bdrv_is_read_only(bs)) {
> -            error_report("Opening rbd snapshots without an explicit "
> -                         "read-only=on option is deprecated. Future versions "
> -                         "will refuse to open the image instead of "
> -                         "automatically marking the image read-only.");
> -            r = bdrv_set_read_only(bs, true, &local_err);
> -            if (r < 0) {
> -                error_propagate(errp, local_err);
> -                goto failed_open;
> -            }
> +        r = bdrv_apply_auto_read_only(bs, "rbd snapshots are read-only", errp);
> +        if (r < 0) {
> +            rbd_close(s->image);
> +            goto failed_open;

That rbd_close() is an independent bugfix.  Should probably be split to 
a separate commit, or at a minimum called out in the commit message as 
intentional.

Actually, is it really needed to prevent a leak, or does the existing 
rados_shutdown() in failed_open already implicitly cover the actions of 
rbd_close()?

With the RBD issue touched up,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
