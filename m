Received: from eggs.gnu.org ([2001:4830:134:3::10]:46529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAy8G-00015r-9f
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAy8F-0007ZV-Gt
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:09:36 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37775ffb-7a4c-5e17-1d5f-363f570e3f28@redhat.com>
Date: Fri, 12 Oct 2018 09:09:19 -0500
MIME-Version: 1.0
In-Reply-To: <20181012115532.12645-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/8] nbd: Support auto-read-only option
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
> If read-only=off, but auto-read-only=on is given, open a read-write NBD
> connection if the server provides a read-write export, but instead of
> erroring out for read-only exports, just degrade to read-only.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/nbd-client.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 9686ecbd5e..76e9ca3abe 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -992,11 +992,11 @@ int nbd_client_init(BlockDriverState *bs,
>           logout("Failed to negotiate with the NBD server\n");
>           return ret;
>       }
> -    if (client->info.flags & NBD_FLAG_READ_ONLY &&
> -        !bdrv_is_read_only(bs)) {
> -        error_setg(errp,
> -                   "request for write access conflicts with read-only export");
> -        return -EACCES;
> +    if (client->info.flags & NBD_FLAG_READ_ONLY) {
> +        ret = bdrv_apply_auto_read_only(bs, "NBD export is read-only", errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
>       }
>       if (client->info.flags & NBD_FLAG_SEND_FUA) {
>           bs->supported_write_flags = BDRV_REQ_FUA;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
