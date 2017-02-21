Received: from eggs.gnu.org ([2001:4830:134:3::10]:40744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg5YT-0005dy-Ct
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg5YS-0006tV-57
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:12:13 -0500
MIME-Version: 1.0
References: <20170221024248.11027-1-eblake@redhat.com>
	<20170221024248.11027-4-eblake@redhat.com>
In-Reply-To: <20170221024248.11027-4-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Feb 2017 08:11:59 +0000
Message-ID: <CAJ+F1CLE-tUO9F1tALobhEDteik_oVSo6v0qVU8mjzitc6EhPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/8] block: Add blk_get_opt_transfer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com

On Tue, Feb 21, 2017 at 6:45 AM Eric Blake <eblake@redhat.com> wrote:

> The NBD protocol would like to advertise the optimal I/O
> size to the client; but it would be a layering violation to
> peek into blk_bs(blk)->bl, when we only have a BB.
>
> This copies the existing blk_get_max_transfer() in reading
> a value from the top BDS; where that value was picked via
> bdrv_refresh_limits() to reflect the overall constraints of
> the entire BDS chain.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>



Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



>
> ---
> v4: retitle, as part of rebasing to byte limits
> v3: new patch
> ---
>  include/sysemu/block-backend.h |  1 +
>  block/block-backend.c          | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/include/sysemu/block-backend.h
> b/include/sysemu/block-backend.h
> index 6444e41..882480a 100644
> --- a/include/sysemu/block-backend.h
> +++ b/include/sysemu/block-backend.h
> @@ -174,6 +174,7 @@ void blk_lock_medium(BlockBackend *blk, bool locked);
>  void blk_eject(BlockBackend *blk, bool eject_flag);
>  int blk_get_flags(BlockBackend *blk);
>  uint32_t blk_get_max_transfer(BlockBackend *blk);
> +uint32_t blk_get_opt_transfer(BlockBackend *blk);
>  int blk_get_max_iov(BlockBackend *blk);
>  void blk_set_guest_block_size(BlockBackend *blk, int align);
>  void *blk_try_blockalign(BlockBackend *blk, size_t size);
> diff --git a/block/block-backend.c b/block/block-backend.c
> index efbf398..4d91ff8 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1426,6 +1426,18 @@ uint32_t blk_get_max_transfer(BlockBackend *blk)
>      return MIN_NON_ZERO(max, INT_MAX);
>  }
>
> +/* Returns the optimum transfer length, in bytes; may be 0 if no optimum
> */
> +uint32_t blk_get_opt_transfer(BlockBackend *blk)
> +{
> +    BlockDriverState *bs =3D blk_bs(blk);
> +
> +    if (bs) {
> +        return bs->bl.opt_transfer;
> +    } else {
> +        return 0;
> +    }
> +}
> +
>  int blk_get_max_iov(BlockBackend *blk)
>  {
>      return blk->root->bs->bl.max_iov;
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
