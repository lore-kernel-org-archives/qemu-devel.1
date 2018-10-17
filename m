Received: from eggs.gnu.org ([2001:4830:134:3::10]:52818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1gCqdj-0006F4-Dy
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1gCqdh-0008U8-BT
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:33:51 -0400
Date: Wed, 17 Oct 2018 20:33:15 +0200
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20181017183315.GF18987@ndevos-x270>
References: <20181017164200.22344-1-kwolf@redhat.com>
	<20181017164200.22344-8-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017164200.22344-8-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 7/9] gluster: Support
 auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On Wed, Oct 17, 2018 at 06:41:58PM +0200, Kevin Wolf wrote:
> If read-only=off, but auto-read-only=on is given, open the file
> read-write if we have the permissions, but instead of erroring out for
> read-only files, just degrade to read-only.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/gluster.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index 4fd55a9cc5..5e300c96c8 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -849,8 +849,16 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
>      qemu_gluster_parse_flags(bdrv_flags, &open_flags);
>  
>      s->fd = glfs_open(s->glfs, gconf->path, open_flags);
> -    if (!s->fd) {
> -        ret = -errno;
> +    ret = s->fd ? 0 : -errno;
> +
> +    if (ret == -EACCES || ret == -EROFS) {
> +        /* Try to degrade to read-only, but if it doesn't work, still use the
> +         * normal error message. */
> +        if (bdrv_apply_auto_read_only(bs, NULL, NULL) == 0) {
> +            open_flags = (open_flags & ~O_RDWR) | O_RDONLY;
> +            s->fd = glfs_open(s->glfs, gconf->path, open_flags);
> +            ret = s->fd ? 0 : -errno;
> +        }
>      }
>  
>      s->supports_seek_data = qemu_gluster_test_seek(s->fd);
> -- 

Looks good to me, thanks.

Reviewed-by: Niels de Vos <ndevos@redhat.com>
