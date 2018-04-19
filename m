Received: from eggs.gnu.org ([2001:4830:134:3::10]:37729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9Gcd-00020U-S9
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9Gcc-0002We-Jt
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:57:39 -0400
References: <20180319080705.10310-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8416e4e1-da91-8631-164f-cca680cb8d20@redhat.com>
Date: Thu, 19 Apr 2018 16:57:28 -0400
MIME-Version: 1.0
In-Reply-To: <20180319080705.10310-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com



On 03/19/2018 04:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> If it appropriate for 2.12, let's push it. If not - then for 2.13.
> 

I wonder if I can make the case that this should be in 2.12.1; arguably
it is important to prevent corruption no matter how unlikely it is to
ever happen.

Moving it into stable increases the likelihood it shows up in
downstreams, so maybe let's see what we can get away with.

> 
> v2: - squash 02 (indentation fix) to 01
>     - drop comment from qcow2_check_metadata_overlap()
>     - set @ign to QCOW2_OL_BITMAP_DIRECTORY for in-place case in
>       bitmap_list_store. I don't think non-inplace case should be changed,
>       as it don't touch active bitmap directory.
> 
>  block/qcow2.h          | 45 ++++++++++++++++++++++++---------------------
>  block/qcow2-bitmap.c   |  7 ++++++-
>  block/qcow2-refcount.c | 10 ++++++++++
>  block/qcow2.c          | 22 ++++++++++++++--------
>  4 files changed, 54 insertions(+), 30 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 6f0ff15dd0..896ad08e5b 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -98,6 +98,7 @@
>  #define QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE "overlap-check.snapshot-table"
>  #define QCOW2_OPT_OVERLAP_INACTIVE_L1 "overlap-check.inactive-l1"
>  #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-l2"
> +#define QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY "overlap-check.bitmap-directory"
>  #define QCOW2_OPT_CACHE_SIZE "cache-size"
>  #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
>  #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
> @@ -398,34 +399,36 @@ typedef enum QCow2ClusterType {
>  } QCow2ClusterType;
>  
>  typedef enum QCow2MetadataOverlap {
> -    QCOW2_OL_MAIN_HEADER_BITNR    = 0,
> -    QCOW2_OL_ACTIVE_L1_BITNR      = 1,
> -    QCOW2_OL_ACTIVE_L2_BITNR      = 2,
> -    QCOW2_OL_REFCOUNT_TABLE_BITNR = 3,
> -    QCOW2_OL_REFCOUNT_BLOCK_BITNR = 4,
> -    QCOW2_OL_SNAPSHOT_TABLE_BITNR = 5,
> -    QCOW2_OL_INACTIVE_L1_BITNR    = 6,
> -    QCOW2_OL_INACTIVE_L2_BITNR    = 7,
> -
> -    QCOW2_OL_MAX_BITNR            = 8,
> -
> -    QCOW2_OL_NONE           = 0,
> -    QCOW2_OL_MAIN_HEADER    = (1 << QCOW2_OL_MAIN_HEADER_BITNR),
> -    QCOW2_OL_ACTIVE_L1      = (1 << QCOW2_OL_ACTIVE_L1_BITNR),
> -    QCOW2_OL_ACTIVE_L2      = (1 << QCOW2_OL_ACTIVE_L2_BITNR),
> -    QCOW2_OL_REFCOUNT_TABLE = (1 << QCOW2_OL_REFCOUNT_TABLE_BITNR),
> -    QCOW2_OL_REFCOUNT_BLOCK = (1 << QCOW2_OL_REFCOUNT_BLOCK_BITNR),
> -    QCOW2_OL_SNAPSHOT_TABLE = (1 << QCOW2_OL_SNAPSHOT_TABLE_BITNR),
> -    QCOW2_OL_INACTIVE_L1    = (1 << QCOW2_OL_INACTIVE_L1_BITNR),
> +    QCOW2_OL_MAIN_HEADER_BITNR      = 0,
> +    QCOW2_OL_ACTIVE_L1_BITNR        = 1,
> +    QCOW2_OL_ACTIVE_L2_BITNR        = 2,
> +    QCOW2_OL_REFCOUNT_TABLE_BITNR   = 3,
> +    QCOW2_OL_REFCOUNT_BLOCK_BITNR   = 4,
> +    QCOW2_OL_SNAPSHOT_TABLE_BITNR   = 5,
> +    QCOW2_OL_INACTIVE_L1_BITNR      = 6,
> +    QCOW2_OL_INACTIVE_L2_BITNR      = 7,
> +    QCOW2_OL_BITMAP_DIRECTORY_BITNR = 8,
> +

A bit hard to read due to the formatting, but you've added #8 here, and

> +    QCOW2_OL_MAX_BITNR              = 9,
> +> +    QCOW2_OL_NONE             = 0,
> +    QCOW2_OL_MAIN_HEADER      = (1 << QCOW2_OL_MAIN_HEADER_BITNR),
> +    QCOW2_OL_ACTIVE_L1        = (1 << QCOW2_OL_ACTIVE_L1_BITNR),
> +    QCOW2_OL_ACTIVE_L2        = (1 << QCOW2_OL_ACTIVE_L2_BITNR),
> +    QCOW2_OL_REFCOUNT_TABLE   = (1 << QCOW2_OL_REFCOUNT_TABLE_BITNR),
> +    QCOW2_OL_REFCOUNT_BLOCK   = (1 << QCOW2_OL_REFCOUNT_BLOCK_BITNR),
> +    QCOW2_OL_SNAPSHOT_TABLE   = (1 << QCOW2_OL_SNAPSHOT_TABLE_BITNR),
> +    QCOW2_OL_INACTIVE_L1      = (1 << QCOW2_OL_INACTIVE_L1_BITNR),
>      /* NOTE: Checking overlaps with inactive L2 tables will result in bdrv
>       * reads. */
> -    QCOW2_OL_INACTIVE_L2    = (1 << QCOW2_OL_INACTIVE_L2_BITNR),
> +    QCOW2_OL_INACTIVE_L2      = (1 << QCOW2_OL_INACTIVE_L2_BITNR),
> +    QCOW2_OL_BITMAP_DIRECTORY = (1 << QCOW2_OL_BITMAP_DIRECTORY_BITNR),

and this one down here.

>  } QCow2MetadataOverlap;
>  
>  /* Perform all overlap checks which can be done in constant time */
>  #define QCOW2_OL_CONSTANT \
>      (QCOW2_OL_MAIN_HEADER | QCOW2_OL_ACTIVE_L1 | QCOW2_OL_REFCOUNT_TABLE | \
> -     QCOW2_OL_SNAPSHOT_TABLE)
> +     QCOW2_OL_SNAPSHOT_TABLE | QCOW2_OL_BITMAP_DIRECTORY)
>  
>  /* Perform all overlap checks which don't require disk access */
>  #define QCOW2_OL_CACHED \
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index f45e46cfbd..fb750ba8d3 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -776,7 +776,12 @@ static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
>          }
>      }
>  
> -    ret = qcow2_pre_write_overlap_check(bs, 0, dir_offset, dir_size);
> +    /* Actually, even in in-place case ignoring QCOW2_OL_BITMAP_DIRECTORY is not
> +     * necessary, because we drop QCOW2_AUTOCLEAR_BITMAPS when updating bitmap
> +     * directory in-place (actually, turn-off the extension), which is checked
> +     * in qcow2_check_metadata_overlap() */

I might need you to rephrase this for me.

I guess we're ignoring QCOW2_OL_BITMAP_DIRECTORY if in_place is true,
but only as an optimization. Why is it not required?

> +    ret = qcow2_pre_write_overlap_check(
> +            bs, in_place ? QCOW2_OL_BITMAP_DIRECTORY : 0, dir_offset, dir_size);
>      if (ret < 0) {
>          goto fail;
>      }
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 3de1ab51ba..275a303cfa 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -2585,6 +2585,16 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
>          }
>      }
>  
> +    if ((chk & QCOW2_OL_BITMAP_DIRECTORY) &&
> +        (s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS))
> +    {
> +        if (overlaps_with(s->bitmap_directory_offset,
> +                          s->bitmap_directory_size))
> +        {
> +            return QCOW2_OL_BITMAP_DIRECTORY;
> +        }
> +    }
> +
>      return 0;
>  }
>  
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 1914a940e5..23f36a67c7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -655,6 +655,11 @@ static QemuOptsList qcow2_runtime_opts = {
>              .help = "Check for unintended writes into an inactive L2 table",
>          },
>          {
> +            .name = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
> +            .type = QEMU_OPT_BOOL,
> +            .help = "Check for unintended writes into the bitmap directory",
> +        },
> +        {
>              .name = QCOW2_OPT_CACHE_SIZE,
>              .type = QEMU_OPT_SIZE,
>              .help = "Maximum combined metadata (L2 tables and refcount blocks) "
> @@ -682,14 +687,15 @@ static QemuOptsList qcow2_runtime_opts = {
>  };
>  
>  static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
> -    [QCOW2_OL_MAIN_HEADER_BITNR]    = QCOW2_OPT_OVERLAP_MAIN_HEADER,
> -    [QCOW2_OL_ACTIVE_L1_BITNR]      = QCOW2_OPT_OVERLAP_ACTIVE_L1,
> -    [QCOW2_OL_ACTIVE_L2_BITNR]      = QCOW2_OPT_OVERLAP_ACTIVE_L2,
> -    [QCOW2_OL_REFCOUNT_TABLE_BITNR] = QCOW2_OPT_OVERLAP_REFCOUNT_TABLE,
> -    [QCOW2_OL_REFCOUNT_BLOCK_BITNR] = QCOW2_OPT_OVERLAP_REFCOUNT_BLOCK,
> -    [QCOW2_OL_SNAPSHOT_TABLE_BITNR] = QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
> -    [QCOW2_OL_INACTIVE_L1_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L1,
> -    [QCOW2_OL_INACTIVE_L2_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L2,
> +    [QCOW2_OL_MAIN_HEADER_BITNR]      = QCOW2_OPT_OVERLAP_MAIN_HEADER,
> +    [QCOW2_OL_ACTIVE_L1_BITNR]        = QCOW2_OPT_OVERLAP_ACTIVE_L1,
> +    [QCOW2_OL_ACTIVE_L2_BITNR]        = QCOW2_OPT_OVERLAP_ACTIVE_L2,
> +    [QCOW2_OL_REFCOUNT_TABLE_BITNR]   = QCOW2_OPT_OVERLAP_REFCOUNT_TABLE,
> +    [QCOW2_OL_REFCOUNT_BLOCK_BITNR]   = QCOW2_OPT_OVERLAP_REFCOUNT_BLOCK,
> +    [QCOW2_OL_SNAPSHOT_TABLE_BITNR]   = QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
> +    [QCOW2_OL_INACTIVE_L1_BITNR]      = QCOW2_OPT_OVERLAP_INACTIVE_L1,
> +    [QCOW2_OL_INACTIVE_L2_BITNR]      = QCOW2_OPT_OVERLAP_INACTIVE_L2,

Just churn, and

> +    [QCOW2_OL_BITMAP_DIRECTORY_BITNR] = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,

this is the only new line.

>  };
>  
>  static void cache_clean_timer_cb(void *opaque)
> 

Looks okay to me overall, apart from needing a comment rephrase.

--js
