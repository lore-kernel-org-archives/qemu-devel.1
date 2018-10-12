Received: from eggs.gnu.org ([2001:4830:134:3::10]:60231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB0pI-0007Fd-9e
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB0pH-0007vs-9n
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:02:12 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e61301c2-5865-fb02-c45b-56b4a3622dc3@redhat.com>
Date: Fri, 12 Oct 2018 12:02:04 -0500
MIME-Version: 1.0
In-Reply-To: <20181012115532.12645-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/8] block: Require auto-read-only for
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

On 10/12/18 6:55 AM, Kevin Wolf wrote:
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

> +++ b/block.c
> @@ -266,27 +266,36 @@ int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
>       return 0;
>   }
>   
> -/* TODO Remove (deprecated since 2.11)
> - * Block drivers are not supposed to automatically change bs->read_only.
> - * Instead, they should just check whether they can provide what the user
> - * explicitly requested and error out if read-write is requested, but they can
> - * only provide read-only access. */
> -int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
> +/*
> + * Called by a driver that can only provide a read-only image.
> + *
> + * Returns 0 if the node is already read-only or it could switch the node to
> + * read-only because BDRV_O_AUTO_RDONLY is set.
> + *
> + * Returns -EACCES if the node is read-write and BDRV_O_AUTO_RDONLY is not set.
> + * If @errmsg is not NULL, it is used as the error message for the Error
> + * object.

I like it.

Worth documenting the -EINVAL (copy-on-read prevents setting read-only) 
failure as well?  (The -EPERM failure of bdrv_can_set_read_only() is not 
reachable, since this new function never clears readonly).

> + */
> +int bdrv_apply_auto_read_only(BlockDriverState *bs, const char *errmsg,
> +                              Error **errp)
>   {
>       int ret = 0;
>   
> -    ret = bdrv_can_set_read_only(bs, read_only, false, errp);
> +    if (!(bs->open_flags & BDRV_O_RDWR)) {
> +        return 0;
> +    }
> +    if (!(bs->open_flags & BDRV_O_AUTO_RDONLY)) {
> +        error_setg(errp, "%s", errmsg ?: "Image is read-only");
> +        return -EACCES;
> +    }
> +
> +    ret = bdrv_can_set_read_only(bs, true, false, errp);
>       if (ret < 0) {
>           return ret;
>       }

Makes sense.

> +++ b/block/vvfat.c
> @@ -1262,16 +1262,10 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>                          "Unable to set VVFAT to 'rw' when drive is read-only");
>               goto fail;
>           }
> -    } else  if (!bdrv_is_read_only(bs)) {
> -        error_report("Opening non-rw vvfat images without an explicit "
> -                     "read-only=on option is deprecated. Future versions "
> -                     "will refuse to open the image instead of "
> -                     "automatically marking the image read-only.");
> -        /* read only is the default for safety */
> -        ret = bdrv_set_read_only(bs, true, &local_err);
> +    } else {
> +        ret = bdrv_apply_auto_read_only(bs, NULL, errp);
>           if (ret < 0) {
> -            error_propagate(errp, local_err);
> -            goto fail;
> +            return ret;

Don't you still need the goto fail, to avoid leaking opts?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
