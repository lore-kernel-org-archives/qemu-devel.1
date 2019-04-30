Received: from eggs.gnu.org ([209.51.188.92]:60091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLPWp-0004g0-8V
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLPWn-0006wt-Bc
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:58:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hLPWl-0006vQ-N4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:58:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so4601642wrb.9
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:58:19 -0700 (PDT)
Date: Tue, 30 Apr 2019 11:58:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190430095815.kzdqv4rnatw65hqw@steredhat>
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] [RFC] qcow2: add compression type feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com

Hi Denis,
few simple comments below regarding the CODING_STYLE (point 7. Comment style)

On Tue, Feb 05, 2019 at 12:08:25PM +0300, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type
> feature into QCOW2 header that indicates that *all* compressed clusters
> must be (de)compressed using a certain compression type.
> 
> It is implied that the compression type is set on the image creation and
> can be changed only later by image convertion, thus the only compression
> algorithm is used for the image.
> 
> The plan is to add support for ZSTD and then may be something more effective
> in the future.
> 
> ZSDT compression algorithm consumes 3-5 times less CPU power with a
> comparable comression ratio with zlib. It would be wise to use it for
> data compression f.e. for backups.
> 
> The default compression is ZLIB.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 25 +++++++++++++++++++++++++
>  block/qcow2.h | 26 ++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8c91b92865..cb3d6cc1c0 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
> +#define  QCOW2_EXT_MAGIC_COMPRESSION_TYPE 0x434D5052
>  
>  static int coroutine_fn
>  qcow2_co_preadv_compressed(BlockDriverState *bs,
> @@ -397,6 +398,9 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>  #endif
>              break;
>  
> +        case QCOW2_EXT_MAGIC_COMPRESSION_TYPE:
> +            /* Setting compression type to BDRVQcow2State->compression_type */
> +            /* from the image header is going to be here */

I'd use a multiline comment block here.

>          default:
>              /* unknown magic - save it in case we need to rewrite the header */
>              /* If you add a new feature, make sure to also update the fast
> @@ -2431,6 +2435,11 @@ int qcow2_update_header(BlockDriverState *bs)
>                  .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
>                  .name = "lazy refcounts",
>              },
> +            {
> +                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
> +                .bit  = QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
> +                .name = "compression type",
> +            },
>          };
>  
>          ret = header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
> @@ -2461,6 +2470,22 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -= ret;
>      }
>  
> +    /* Compression type extension */
> +    if (s->compression_type != 0) {
> +        Qcow2CompressionTypeExt comp_header = {
> +            .compression_type = cpu_to_be32(s->compression_type),
> +        };
> +        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_COMPRESSION_TYPE,
> +                             &comp_header,
> +                             cpu_to_be64(sizeof(comp_header)),
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
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 32cce9eee2..fdde5bbefd 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -112,6 +112,10 @@
>  #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
>  #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
>  
> +/* Compression types */
> +#define QCOW2_COMPRESSION_TYPE_ZLIB    0
> +#define QCOW2_COMPRESSION_TYPE_ZSTD    1
> +
>  typedef struct QCowHeader {
>      uint32_t magic;
>      uint32_t version;
> @@ -197,10 +201,13 @@ enum {
>  
>  /* Incompatible feature bits */
>  enum {
> -    QCOW2_INCOMPAT_DIRTY_BITNR   = 0,
> -    QCOW2_INCOMPAT_CORRUPT_BITNR = 1,
> -    QCOW2_INCOMPAT_DIRTY         = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> -    QCOW2_INCOMPAT_CORRUPT       = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
> +    QCOW2_INCOMPAT_DIRTY_BITNR            = 0,
> +    QCOW2_INCOMPAT_CORRUPT_BITNR          = 1,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR = 2,
> +    QCOW2_INCOMPAT_DIRTY                  = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> +    QCOW2_INCOMPAT_CORRUPT                = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE       =
> +                                    1 << QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
>  
>      QCOW2_INCOMPAT_MASK          = QCOW2_INCOMPAT_DIRTY
>                                   | QCOW2_INCOMPAT_CORRUPT,
> @@ -256,6 +263,10 @@ typedef struct Qcow2BitmapHeaderExt {
>      uint64_t bitmap_directory_offset;
>  } QEMU_PACKED Qcow2BitmapHeaderExt;
>  
> +typedef struct Qcow2CompressionTypeExt {
> +    uint32_t compression_type;
> +} QEMU_PACKED Qcow2CompressionTypeExt;
> +
>  typedef struct BDRVQcow2State {
>      int cluster_bits;
>      int cluster_size;
> @@ -340,6 +351,13 @@ typedef struct BDRVQcow2State {
>  
>      CoQueue compress_wait_queue;
>      int nb_compress_threads;
> +    /**

I'd remove the second asterisk here.

> +     * Compression type used for the image. Default: 0 - ZLIB
> +     * The image compression type is set on image creation.
> +     * The only way to change the compression type is to convert the image
> +     * with the desired compresion type set
> +     */
> +    uint32_t compression_type;
>  } BDRVQcow2State;
>  
>  typedef struct Qcow2COWRegion {
> -- 
> 2.17.0
> 
> 

Thanks,
Stefano
