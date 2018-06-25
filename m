Received: from eggs.gnu.org ([2001:4830:134:3::10]:55346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXVTr-00015G-2N
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXVTp-0002IZ-U7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:40:47 -0400
References: <20180625033643.14404-1-13466399134@163.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ec4fc783-78b4-ba71-e36e-73149a2f7b06@redhat.com>
Date: Mon, 25 Jun 2018 13:40:39 -0400
MIME-Version: 1.0
In-Reply-To: <20180625033643.14404-1-13466399134@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] block/dirty-bitmap: Useless bitmaps in image can
 be removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 13466399134@163.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 06/24/2018 11:36 PM, 13466399134@163.com wrote:
> If qemu-kvm quit without saving bitmaps to image(coredump, host kernel panic,
> or host pooweroff), bitmaps in image can not be safely used anymore, and also
> can not be removed. Useless bitmaps should be removed.
> 
> Signed-off-by: yaoxu <13466399134@163.com>

I count at least ten copies of this same patch in my inbox. Please send
just ONE copy, and make sure it has [PATCH] in the title, like other
patches do.

> ---
> diff --git a/blockdev.c b/blockdev.c
> index 58d7570932..c85056a74b 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2837,31 +2837,35 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>      Error *local_err = NULL;
>  
>      bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
> -    if (!bitmap || !bs) {
> +    if (!bs) {

In what cases are we going to fail to find a bitmap but manage to return
a BlockDriverState?

>          return;
>      }
>  
> -    if (bdrv_dirty_bitmap_frozen(bitmap)) {
> -        error_setg(errp,
> -                   "Bitmap '%s' is currently frozen and cannot be removed",
> -                   name);
> -        return;
> -    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
> -        error_setg(errp,
> -                   "Bitmap '%s' is currently locked and cannot be removed",
> -                   name);
> +    if (bitmap) {
> +        if (bdrv_dirty_bitmap_frozen(bitmap)) {
> +            error_setg(errp,
> +                       "Bitmap '%s' is currently frozen and cannot be removed",
> +                       name);
> +            return;
> +        } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
> +            error_setg(errp,
> +                       "Bitmap '%s' is currently locked and cannot be removed",
> +                       name);
> +            return;
> +        }
> +    }
> +
> +    bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
>          return;
>      }
>  
> -    if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
> -        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
> -        if (local_err != NULL) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +    if (bitmap) {
> +        bdrv_release_dirty_bitmap(bs, bitmap);
>      }
>  
> -    bdrv_release_dirty_bitmap(bs, bitmap);
> +    if (*errp) {
> +        error_free(*errp);
> +        *errp = NULL;
> +    }
>  }
>  
>  /**
> 

Even if bitmap was null and bs was set, this is going to forward
requests for any bitmap, whether it exists or not, straight along to the
persistence layer, which does not give you an error if the bitmap didn't
exist.

We also can't open images with corrupted bitmaps in them for editing, so
this won't work there, either.

We are otherwise aware of the problem and intend to address it via
`qemu-img check -r`.

--js
