Received: from eggs.gnu.org ([2001:4830:134:3::10]:40013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1Ho-0001v7-UN
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1Hl-0000OR-O0
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:40 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-8-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b377575-4838-c436-3867-a875bc8bab76@redhat.com>
Date: Fri, 12 Oct 2018 12:31:21 -0500
MIME-Version: 1.0
In-Reply-To: <20181012115532.12645-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/8] gluster: Support auto-read-only
 option
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
> If read-only=off, but auto-read-only=on is given, open the file
> read-write if we have the permissions, but instead of erroring out for
> read-only files, just degrade to read-only.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/gluster.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index 4fd55a9cc5..68d20c8830 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -849,6 +849,15 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
>       qemu_gluster_parse_flags(bdrv_flags, &open_flags);
>   
>       s->fd = glfs_open(s->glfs, gconf->path, open_flags);
> +    if (!s->fd && errno == EACCES) {

EROFS is not possible as it was for posix file?

> +        /* Try to degrade to read-only, but if it doesn't work, still use the
> +         * normal error message. */
> +        ret = bdrv_apply_auto_read_only(bs, NULL, NULL);

No guarantees on what errno is on failure...

> +        if (ret == 0) {
> +            open_flags = (open_flags & ~O_RDWR) | O_RDONLY;
> +            s->fd = glfs_open(s->glfs, gconf->path, open_flags);
> +        }
> +    }
>       if (!s->fd) {
>           ret = -errno;

...but you are relying on it here.  (Same story as in the posix driver)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
