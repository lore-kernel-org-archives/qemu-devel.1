Received: from eggs.gnu.org ([2001:4830:134:3::10]:54518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceK1k-0007Ci-PA
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceK1j-0001yU-6F
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:15:08 -0500
Date: Thu, 16 Feb 2017 12:14:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170216111457.GA4869@noname.redhat.com>
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-8-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487153430-17260-8-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v15 07/25] qcow2: add bitmaps extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Add bitmap extension as specified in docs/specs/qcow2.txt.
> For now, just mirror extension header into Qcow2 state and check
> constraints.
> 
> For now, disable image resize if it has bitmaps. It will be fixed later.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  block/qcow2.h |  24 ++++++++++++
>  2 files changed, 142 insertions(+), 5 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 96fb8a8..289eead 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -63,6 +63,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_END 0
>  #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
>  #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
> +#define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>  
>  static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>  {
> @@ -86,12 +87,17 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>   */
>  static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>                                   uint64_t end_offset, void **p_feature_table,
> -                                 Error **errp)
> +                                 bool *need_update_header, Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      QCowExtension ext;
>      uint64_t offset;
>      int ret;
> +    Qcow2BitmapHeaderExt bitmaps_ext;
> +
> +    if (need_update_header != NULL) {
> +        *need_update_header = false;
> +    }
>  
>  #ifdef DEBUG_EXT
>      printf("qcow2_read_extensions: start=%ld end=%ld\n", start_offset, end_offset);
> @@ -162,6 +168,85 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>              }
>              break;
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

Wouldn't it be better to use error_report() here?

> +                        "WARNING: a program lacking bitmap support modified "
> +                        "this file, so all bitmaps are now considered "
> +                        "inconsistent. Some clusters may be leaked, run "
> +                        "'qemu-img check -r' on the image file to fix.");
> +                if (need_update_header != NULL) {
> +                    *need_update_header = true;
> +                }

What is the goal with updating the header? Getting rid of the invalid
bitmap extension? Worth a comment?

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

Don't mention the filename here, it will be duplicated in the error
message because the caller already prefixes the filename. (Apart from
that it's inconsistent with all other errors in this function.)

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
>          default:
>              /* unknown magic - save it in case we need to rewrite the header */
>              {
> @@ -824,6 +909,7 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
>      Error *local_err = NULL;
>      uint64_t ext_end;
>      uint64_t l1_vm_state_index;
> +    bool need_update_header = false;
>  
>      ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
>      if (ret < 0) {
> @@ -929,7 +1015,7 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
>      if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
>          void *feature_table = NULL;
>          qcow2_read_extensions(bs, header.header_length, ext_end,
> -                              &feature_table, NULL);
> +                              &feature_table, NULL, NULL);
>          report_unsupported_feature(errp, feature_table,
>                                     s->incompatible_features &
>                                     ~QCOW2_INCOMPAT_MASK);
> @@ -1116,7 +1202,7 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      /* read qcow2 extensions */
>      if (qcow2_read_extensions(bs, header.header_length, ext_end, NULL,
> -        &local_err)) {
> +        &need_update_header, &local_err)) {
>          error_propagate(errp, local_err);
>          ret = -EINVAL;
>          goto fail;
> @@ -1152,8 +1238,10 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>  
>      /* Clear unknown autoclear feature bits */
> -    if (!bs->read_only && !(flags & BDRV_O_INACTIVE) && s->autoclear_features) {
> -        s->autoclear_features = 0;
> +    need_update_header |= s->autoclear_features & ~QCOW2_AUTOCLEAR_MASK;
> +
> +    if (need_update_header && !bs->read_only && !(flags & BDRV_O_INACTIVE)) {
> +        s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
>          ret = qcow2_update_header(bs);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret, "Could not update qcow2 header");
> @@ -1953,6 +2041,24 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -= ret;
>      }

All other parts of qcow2_update_header() are introduced with a comment
line, so we should add one here, too. Could be as simple as:

/* Bitmap extension */

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
>      /* Keep unknown header extensions */
>      QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
>          ret = header_ext_add(buf, uext->magic, uext->data, uext->len, buflen);
> @@ -2528,6 +2634,13 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset)
>          return -ENOTSUP;
>      }
>  
> +    /* cannot proceed if image has bitmaps */
> +    if (s->nb_bitmaps) {
> +        /* TODO: resize bitmaps in the image */
> +        error_report("Can't resize an image which has bitmaps");
> +        return -ENOTSUP;
> +    }
> +
>      /* shrinking is currently not supported */
>      if (offset < bs->total_sectors * 512) {
>          error_report("qcow2 doesn't support shrinking images yet");
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 1823414..861b501 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -52,6 +52,10 @@
>   * space for snapshot names and IDs */
>  #define QCOW_MAX_SNAPSHOTS_SIZE (1024 * QCOW_MAX_SNAPSHOTS)
>  
> +/* Bitmap header extension constraints */
> +#define QCOW2_MAX_BITMAPS 65535
> +#define QCOW2_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW2_MAX_BITMAPS)
> +
>  /* indicate that the refcount of the referenced cluster is exactly one. */
>  #define QCOW_OFLAG_COPIED     (1ULL << 63)
>  /* indicate that the cluster is compressed (they never have the copied flag) */
> @@ -195,6 +199,15 @@ enum {
>      QCOW2_COMPAT_FEAT_MASK            = QCOW2_COMPAT_LAZY_REFCOUNTS,
>  };
>  
> +/* Autoclear feature bits */
> +enum {
> +    QCOW2_AUTOCLEAR_BITMAPS_BITNR = 0,
> +    QCOW2_AUTOCLEAR_BITMAPS       =
> +        1 << QCOW2_AUTOCLEAR_BITMAPS_BITNR,

This fits in a single line (which makes it look much nicer).

> +    QCOW2_AUTOCLEAR_MASK                = QCOW2_AUTOCLEAR_BITMAPS,

What is the = in this line aligned to?

> +};
> +
>  enum qcow2_discard_type {
>      QCOW2_DISCARD_NEVER = 0,
>      QCOW2_DISCARD_ALWAYS,

Kevin
