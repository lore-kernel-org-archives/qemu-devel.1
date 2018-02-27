Received: from eggs.gnu.org ([2001:4830:134:3::10]:57439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqbE6-0002IG-0t
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqbE5-0006Fw-0o
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:07:10 -0500
Date: Tue, 27 Feb 2018 17:06:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180227090639.GC25412@lemon.usersys.redhat.com>
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-12-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122220806.22154-12-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 11/16] block/dirty-bitmap: Add
 bdrv_dirty_iter_next_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 01/22 23:08, Max Reitz wrote:
> This new function allows to look for a consecutively dirty area in a
> dirty bitmap.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/dirty-bitmap.h |  2 ++
>  block/dirty-bitmap.c         | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index a591c27213..35f3ccc44c 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -79,6 +79,8 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>  void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>                                      int64_t offset, int64_t bytes);
>  int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
> +bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
> +                               uint64_t *offset, int *bytes);
>  void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t offset);
>  int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
>  int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 50564fa1e2..484b5dda43 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -501,6 +501,57 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
>      return hbitmap_iter_next(&iter->hbi, true);
>  }
>  
> +/**
> + * Return the next consecutively dirty area in the dirty bitmap
> + * belonging to the given iterator @iter.
> + *
> + * @max_offset: Maximum value that may be returned for
> + *              *offset + *bytes
> + * @offset:     Will contain the start offset of the next dirty area
> + * @bytes:      Will contain the length of the next dirty area
> + *
> + * Returns: True if a dirty area could be found before max_offset
> + *          (which means that *offset and *bytes then contain valid
> + *          values), false otherwise.

Also document the change to the iter cursor depending on the return value?

Fam
