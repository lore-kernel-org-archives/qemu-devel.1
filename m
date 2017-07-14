Received: from eggs.gnu.org ([2001:4830:134:3::10]:51504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVy40-0004t8-OX
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVy3z-0004C2-SL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:43:12 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVy3z-0004Bp-K2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:43:11 -0400
Received: by mail-wm0-x234.google.com with SMTP id i127so18588958wma.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:43:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711160814.20941-51-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
	<20170711160814.20941-51-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 11:42:49 +0100
Message-ID: <CAFEAcA90jG=vzGX0xKQh5ZkDsnNw6mMQb5QDip7+sAqd8HVTSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 50/85] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 11 July 2017 at 17:07, Max Reitz <mreitz@redhat.com> wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Realize .bdrv_remove_persistent_dirty_bitmap interface.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Message-id: 20170628120530.31251-29-vsementsov@virtuozzo.com
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> +                                          const char *name,
> +                                          Error **errp)
> +{
> +    int ret;
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2Bitmap *bm;
> +    Qcow2BitmapList *bm_list;
> +
> +    if (s->nb_bitmaps == 0) {
> +        /* Absence of the bitmap is not an error: see explanation above
> +         * bdrv_remove_persistent_dirty_bitmap() definition. */
> +        return;
> +    }
> +
> +    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, errp);
> +    if (bm_list == NULL) {
> +        return;
> +    }
> +
> +    bm = find_bitmap_by_name(bm_list, name);
> +    if (bm == NULL) {
> +        goto fail;
> +    }
> +
> +    QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
> +
> +    ret = update_ext_header_and_dir(bs, bm_list);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to update bitmap extension");
> +        goto fail;
> +    }
> +
> +    free_bitmap_clusters(bs, &bm->table);
> +
> +fail:
> +    bitmap_free(bm);
> +    bitmap_list_free(bm_list);
> +}

Coverity points out that this can crash in the error-exit paths,
because bitmap_free() doesn't handle being passed a NULL pointer.
(CID 1377700).

Probably the best fix for this is to make bitmap_free() do
nothing when handed NULL.

thanks
-- PMM
