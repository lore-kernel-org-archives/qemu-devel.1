Received: from eggs.gnu.org ([2001:4830:134:3::10]:41800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYX0q-0005z7-BS
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYX0n-000775-8S
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:54:16 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:2770 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cYX0m-00076p-PM
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:54:13 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-8-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <10711909-e7a0-bdb6-49a2-46fe16ca0f15@virtuozzo.com>
Date: Tue, 31 Jan 2017 14:53:57 +0300
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/24] qcow2: add bitmaps extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

23.01.2017 15:10, Vladimir Sementsov-Ogievskiy wrote:
> Add bitmap extension as specified in docs/specs/qcow2.txt.
> For now, just mirror extension header into Qcow2 state and check
> constraints.
>
> For now, disable image resize if it has bitmaps. It will be fixed later.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   block/qcow2.h |  24 ++++++++++++
>   2 files changed, 141 insertions(+), 2 deletions(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 96fb8a8f16..a8835988c7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -63,6 +63,7 @@ typedef struct {
>   #define  QCOW2_EXT_MAGIC_END 0
>   #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
>   #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
> +#define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>   
>   static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>   {
> @@ -92,6 +93,8 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>       QCowExtension ext;
>       uint64_t offset;
>       int ret;
> +    Qcow2BitmapHeaderExt bitmaps_ext;
> +    bool need_update;
>   
>   #ifdef DEBUG_EXT
>       printf("qcow2_read_extensions: start=%ld end=%ld\n", start_offset, end_offset);
> @@ -162,6 +165,83 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>               }
>               break;
>   
> +        case QCOW2_EXT_MAGIC_BITMAPS:
> +            if (ext.len != sizeof(bitmaps_ext)) {
> +                error_setg_errno(errp, -ret, "bitmaps_ext: "
> +                                 "Invalid extension length");
> +                return -EINVAL;
> +            }
> +
> +            if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS)) {
> +                fprintf(stderr,
> +                        "WARNING: a program lacking bitmap support modified "
> +                        "this file, so all bitmaps are now considered "
> +                        "inconsistent. Some clusters may be leaked, run "
> +                        "'qemu-img check -r' on the image file to fix.");
> +                need_update = true;
> +                break;
> +            }
> +
> +            ret = bdrv_pread(bs->file, offset, &bitmaps_ext, ext.len);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "bitmaps_ext: "
> +                                 "Could not read ext header");
> +                return ret;
> +            }
> +
> +            if (bitmaps_ext.reserved32 != 0) {
> +                error_setg_errno(errp, -ret, "bitmaps_ext: "
> +                                 "Reserved field is not zero");
> +                return -EINVAL;
> +            }
> +
> +            be32_to_cpus(&bitmaps_ext.nb_bitmaps);
> +            be64_to_cpus(&bitmaps_ext.bitmap_directory_size);
> +            be64_to_cpus(&bitmaps_ext.bitmap_directory_offset);
> +
> +            if (bitmaps_ext.nb_bitmaps > QCOW2_MAX_BITMAPS) {
> +                error_setg(errp,
> +                           "bitmaps_ext: File %s has %" PRIu32 " bitmaps, "
> +                           "exceeding the QEMU supported maximum of %d",
> +                           bs->filename, bitmaps_ext.nb_bitmaps,
> +                           QCOW2_MAX_BITMAPS);
> +                return -EINVAL;
> +            }
> +
> +            if (bitmaps_ext.nb_bitmaps == 0) {
> +                error_setg(errp, "found bitmaps extension with zero bitmaps");
> +                return -EINVAL;
> +            }
> +
> +            if (bitmaps_ext.bitmap_directory_offset & (s->cluster_size - 1)) {
> +                error_setg(errp, "bitmaps_ext: "
> +                                 "invalid bitmap directory offset");
> +                return -EINVAL;
> +            }
> +
> +            if (bitmaps_ext.bitmap_directory_size >
> +                QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
> +                error_setg(errp, "bitmaps_ext: "
> +                                 "bitmap directory size (%" PRIu64 ") exceeds "
> +                                 "the maximum supported size (%d)",
> +                                 bitmaps_ext.bitmap_directory_size,
> +                                 QCOW2_MAX_BITMAP_DIRECTORY_SIZE);
> +                return -EINVAL;
> +            }
> +
> +            s->nb_bitmaps = bitmaps_ext.nb_bitmaps;
> +            s->bitmap_directory_offset =
> +                    bitmaps_ext.bitmap_directory_offset;
> +            s->bitmap_directory_size =
> +                    bitmaps_ext.bitmap_directory_size;
> +
> +#ifdef DEBUG_EXT
> +            printf("Qcow2: Got bitmaps extension: "
> +                   "offset=%" PRIu64 " nb_bitmaps=%" PRIu32 "\n",
> +                   s->bitmap_directory_offset, s->nb_bitmaps);
> +#endif
> +            break;
> +
>           default:
>               /* unknown magic - save it in case we need to rewrite the header */
>               {
> @@ -185,6 +265,15 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>           offset += ((ext.len + 7) & ~7);
>       }
>   
> +    if (need_update && !bdrv_is_root_node(bs) &&

bdrv_is_read_only() I think)

> +        !(bdrv_get_flags(bs) & BDRV_O_INACTIVE))
> +    {
> +        ret = qcow2_update_header(bs);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
>       return 0;
>   }
>   
> @@ -1152,8 +1241,9 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
>       }
>   
>       /* Clear unknown autoclear feature bits */
> -    if (!bs->read_only && !(flags & BDRV_O_INACTIVE) && s->autoclear_features) {
> -        s->autoclear_features = 0;
> +    if (!bs->read_only && !(flags & BDRV_O_INACTIVE) &&
> +        (s->autoclear_features & ~QCOW2_AUTOCLEAR_MASK)) {
> +        s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
>           ret = qcow2_update_header(bs);
>           if (ret < 0) {
>               error_setg_errno(errp, -ret, "Could not update qcow2 header");
> @@ -1953,6 +2043,24 @@ int qcow2_update_header(BlockDriverState *bs)
>           buflen -= ret;
>       }
>   
> +    if (s->nb_bitmaps > 0) {
> +        Qcow2BitmapHeaderExt bitmaps_header = {
> +            .nb_bitmaps = cpu_to_be32(s->nb_bitmaps),
> +            .bitmap_directory_size =
> +                    cpu_to_be64(s->bitmap_directory_size),
> +            .bitmap_directory_offset =
> +                    cpu_to_be64(s->bitmap_directory_offset)
> +        };
> +        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_BITMAPS,
> +                             &bitmaps_header, sizeof(bitmaps_header),
> +                             buflen);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +        buf += ret;
> +        buflen -= ret;
> +    }
> +
>       /* Keep unknown header extensions */
>       QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
>           ret = header_ext_add(buf, uext->magic, uext->data, uext->len, buflen);
> @@ -2528,6 +2636,13 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset)
>           return -ENOTSUP;
>       }
>   
> +    /* cannot proceed if image has bitmaps */
> +    if (s->nb_bitmaps) {
> +        /* TODO: resize bitmaps in the image */
> +        error_report("Can't resize an image which has bitmaps");
> +        return -ENOTSUP;
> +    }
> +
>       /* shrinking is currently not supported */
>       if (offset < bs->total_sectors * 512) {
>           error_report("qcow2 doesn't support shrinking images yet");
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 182341483a..861b5011dd 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -52,6 +52,10 @@
>    * space for snapshot names and IDs */
>   #define QCOW_MAX_SNAPSHOTS_SIZE (1024 * QCOW_MAX_SNAPSHOTS)
>   
> +/* Bitmap header extension constraints */
> +#define QCOW2_MAX_BITMAPS 65535
> +#define QCOW2_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW2_MAX_BITMAPS)
> +
>   /* indicate that the refcount of the referenced cluster is exactly one. */
>   #define QCOW_OFLAG_COPIED     (1ULL << 63)
>   /* indicate that the cluster is compressed (they never have the copied flag) */
> @@ -195,6 +199,15 @@ enum {
>       QCOW2_COMPAT_FEAT_MASK            = QCOW2_COMPAT_LAZY_REFCOUNTS,
>   };
>   
> +/* Autoclear feature bits */
> +enum {
> +    QCOW2_AUTOCLEAR_BITMAPS_BITNR = 0,
> +    QCOW2_AUTOCLEAR_BITMAPS       =
> +        1 << QCOW2_AUTOCLEAR_BITMAPS_BITNR,
> +
> +    QCOW2_AUTOCLEAR_MASK                = QCOW2_AUTOCLEAR_BITMAPS,
> +};
> +
>   enum qcow2_discard_type {
>       QCOW2_DISCARD_NEVER = 0,
>       QCOW2_DISCARD_ALWAYS,
> @@ -222,6 +235,13 @@ typedef uint64_t Qcow2GetRefcountFunc(const void *refcount_array,
>   typedef void Qcow2SetRefcountFunc(void *refcount_array,
>                                     uint64_t index, uint64_t value);
>   
> +typedef struct Qcow2BitmapHeaderExt {
> +    uint32_t nb_bitmaps;
> +    uint32_t reserved32;
> +    uint64_t bitmap_directory_size;
> +    uint64_t bitmap_directory_offset;
> +} QEMU_PACKED Qcow2BitmapHeaderExt;
> +
>   typedef struct BDRVQcow2State {
>       int cluster_bits;
>       int cluster_size;
> @@ -263,6 +283,10 @@ typedef struct BDRVQcow2State {
>       unsigned int nb_snapshots;
>       QCowSnapshot *snapshots;
>   
> +    uint32_t nb_bitmaps;
> +    uint64_t bitmap_directory_size;
> +    uint64_t bitmap_directory_offset;
> +
>       int flags;
>       int qcow_version;
>       bool use_lazy_refcounts;


-- 
Best regards,
Vladimir
