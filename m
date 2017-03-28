Received: from eggs.gnu.org ([2001:4830:134:3::10]:57266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cstxG-0004FZ-Se
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cstxF-0006XF-Ox
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:26:46 -0400
Date: Tue, 28 Mar 2017 18:26:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170328162620.GD11725@noname.redhat.com>
References: <1490625488-7980-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490625488-7980-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] parallels: wrong call to bdrv_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

[ Cc: qemu-block ]

Am 27.03.2017 um 16:38 hat Denis V. Lunev geschrieben:
> Parallels driver should not call bdrv_truncate if the image was opened
> in the read-only mode. Without the patch
>     qemu-img check harddisk.hds
> asserts with
>     bdrv_truncate: Assertion `child->perm & BLK_PERM_RESIZE' failed.
> 
> Parameters used on the write path are not needed if the image is opened
> in the read-only mode.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reported-by: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/parallels.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 6bf9375..4173b3f 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -687,7 +687,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>      if (local_err != NULL) {
>          goto fail_options;
>      }
> -    if (!bdrv_has_zero_init(bs->file->bs) ||
> +
> +    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
>              bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs)) != 0) {
>          s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
>      }

Relying on BDRV_O_RESIZE in block drivers is wrong. It is set in some
paths (specifically the users of blk_new_open), but not in others. We
should probably have filtered out the flag before passing it to the
drivers.

As a concrete example, if you're using -blockdev, the bdrv_truncate()
call won't be executed after applying this patch.

I think the correct way would be to check bdrv_is_read_only() instead.

Kevin
