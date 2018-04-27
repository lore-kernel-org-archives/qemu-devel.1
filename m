Received: from eggs.gnu.org ([2001:4830:134:3::10]:54673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3NF-0007lr-IF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3NB-0007J0-Gb
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:25:17 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:37556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC3NB-0007Iw-BX
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:25:13 -0400
Received: by mail-ot0-x22f.google.com with SMTP id 77-v6so2001984otd.4
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:25:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313211441.5179-12-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
	<20180313211441.5179-12-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 14:24:52 +0100
Message-ID: <CAFEAcA_XGor0OxNJTy5bezAsLLyDkLq=xfJYkTkegn9C_J9OMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 11/13] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 13 March 2018 at 21:14, John Snow <jsnow@redhat.com> wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Postcopy migration of dirty bitmaps. Only named dirty bitmaps are migrated.
>
> If destination qemu is already containing a dirty bitmap with the same name
> as a migrated bitmap (for the same node), then, if their granularities are
> the same the migration will be done, otherwise the error will be generated.
>
> If destination qemu doesn't contain such bitmap it will be created.

Hi. Coverity complains (CID1390627) about a resource leak in this function;

> +static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
> +{
> +    uint64_t first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
> +    uint64_t nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
> +    trace_dirty_bitmap_load_bits_enter(first_byte >> BDRV_SECTOR_BITS,
> +                                       nr_bytes >> BDRV_SECTOR_BITS);
> +
> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
> +        trace_dirty_bitmap_load_bits_zeroes();
> +        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
> +                                             false);
> +    } else {
> +        size_t ret;
> +        uint8_t *buf;
> +        uint64_t buf_size = qemu_get_be64(f);
> +        uint64_t needed_size =
> +            bdrv_dirty_bitmap_serialization_size(s->bitmap,
> +                                                 first_byte, nr_bytes);
> +
> +        if (needed_size > buf_size ||
> +            buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
> +             /* Here used same alignment as in send_bitmap_bits */
> +        ) {
> +            error_report("Migrated bitmap granularity doesn't "
> +                         "match the destination bitmap '%s' granularity",
> +                         bdrv_dirty_bitmap_name(s->bitmap));
> +            return -EINVAL;
> +        }
> +
> +        buf = g_malloc(buf_size);

Here we allocate memory into buf...

> +        ret = qemu_get_buffer(f, buf, buf_size);
> +        if (ret != buf_size) {
> +            error_report("Failed to read bitmap bits");
> +            return -EIO;

...but in this error-exit path we do not free it.

> +        }
> +
> +        bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
> +                                           false);
> +        g_free(buf);
> +    }
> +
> +    return 0;
> +}

thanks
-- PMM
