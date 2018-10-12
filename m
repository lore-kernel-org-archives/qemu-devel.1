Received: from eggs.gnu.org ([2001:4830:134:3::10]:38193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1Ax-00079a-1t
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1Aw-0005tT-Ak
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:24:35 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <697375fb-0ef4-0bee-73fe-ddbc6a015207@redhat.com>
Date: Fri, 12 Oct 2018 12:24:27 -0500
MIME-Version: 1.0
In-Reply-To: <20181012115532.12645-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/8] file-posix: Support auto-read-only
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
>   block/file-posix.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 2da3a76355..eead3f2df3 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -527,6 +527,19 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>   
>       s->fd = -1;
>       fd = qemu_open(filename, s->open_flags, 0644);
> +
> +    if (fd < 0 && (errno == EACCES || errno == EROFS)) {
> +        /* Try to degrade to read-only, but if it doesn't work, still use the
> +         * normal error message. */
> +        ret = bdrv_apply_auto_read_only(bs, NULL, NULL);

No guarantees what errno is after this call...

> +        if (ret == 0) {
> +            bdrv_flags &= ~BDRV_O_RDWR;
> +            raw_parse_flags(bdrv_flags, &s->open_flags);
> +            assert(!(s->open_flags & O_CREAT));
> +            fd = qemu_open(filename, s->open_flags);
> +        }
> +    }
> +
>       if (fd < 0) {
>           ret = -errno;
>           error_setg_errno(errp, errno, "Could not open '%s'", filename);

...even though you still rely on it here.

Possible solution:

fd = qemu_open();
if (fd < 0) {
     ret = -errno;
     if ((errno == EACCES || errno == EROFS) &&
         !bdrv_apply_auto_read_only(bs, NULL, NULL)) {
         bdrv_flags ...
         fd = qemu_open();
         ret = fd < 0 ? -errno : 0;
     }
}
if (fd < 0) {
     error_setg_errno(errp, -ret, "Could not open '%s'

Another possible solution: change the contract of 
bdrv_apply_auto_read_only() to leave errno unchanged (a bit odd, if the 
return value is different than the incoming errno value).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
