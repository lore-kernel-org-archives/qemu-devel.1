Received: from eggs.gnu.org ([2001:4830:134:3::10]:45489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDZIJ-0004qi-NO
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDZIJ-0006IV-0e
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:14:43 -0400
References: <20181019163013.11787-1-kwolf@redhat.com>
	<20181019163013.11787-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bf5d464e-fafe-a90d-ebda-d45aa7b8b092@redhat.com>
Date: Fri, 19 Oct 2018 13:14:35 -0500
MIME-Version: 1.0
In-Reply-To: <20181019163013.11787-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/11] rbd: Close image in
 qemu_rbd_open() error path
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

On 10/19/18 11:30 AM, Kevin Wolf wrote:
> Commit e2b8247a322 introduced an error path in qemu_rbd_open() after
> calling rbd_open(), but neglected to close the image again in this error
> path. The error path should contain everything that the regular close
> function qemu_rbd_close() contains.
> 
> This adds the missing rbd_close() call.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/rbd.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/rbd.c b/block/rbd.c
> index 014c68d629..27c9a1e81c 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -787,6 +787,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>                            "automatically marking the image read-only.");
>               r = bdrv_set_read_only(bs, true, &local_err);
>               if (r < 0) {
> +                rbd_close(s->image);
>                   error_propagate(errp, local_err);
>                   goto failed_open;
>               }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
