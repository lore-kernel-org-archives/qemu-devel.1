Received: from eggs.gnu.org ([2001:4830:134:3::10]:40739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc70-00023l-Gq
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc6u-0002aN-J2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:03:14 -0500
References: <20180213130356.8885-1-mreitz@redhat.com>
	<20180213130356.8885-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4dfa85c3-26ed-8144-0591-3fc679d33f47@redhat.com>
Date: Tue, 13 Feb 2018 09:02:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180213130356.8885-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] sheepdog: Make sd_prealloc() take a BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, sheepdog@lists.wpkg.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Liu Yuan <namei.unix@gmail.com>

On 02/13/2018 07:03 AM, Max Reitz wrote:
> We want to use this function in sd_truncate() later on, so taking a
> filename is not exactly ideal.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/sheepdog.c | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
> 

> @@ -1837,10 +1837,11 @@ static int sd_prealloc(const char *filename, Error **errp)
>       void *buf = NULL;
>       int ret;
>   
> -    blk = blk_new_open(filename, NULL, NULL,
> -                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
> -    if (blk == NULL) {
> -        ret = -EIO;
> +    blk = blk_new(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM_RESIZE,
> +                  BLK_PERM_ALL);
> +
> +    ret = blk_insert_bs(blk, bs, errp);
> +    if (ret < 0) {


>       if (prealloc) {
> -        ret = sd_prealloc(filename, errp);
> +        BlockDriverState *bs;
> +        QDict *opts;
> +
> +        opts = qdict_new();
> +        qdict_put_str(opts, "driver", "sheepdog");
> +        bs = bdrv_open(filename, NULL, opts, BDRV_O_PROTOCOL | BDRV_O_RDWR,
> +                       errp);

I'm a bit weak on ensuring the same ending flags result after the new 
bdrv_open()/blk_new() as what you used to get on blk_new_open(), so 
someone that can actually test this is appreciated.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
