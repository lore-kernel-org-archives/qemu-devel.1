Received: from eggs.gnu.org ([209.51.188.92]:45318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goQ4I-0004IJ-B8
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goQ4G-00038E-Er
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:52:33 -0500
Date: Tue, 29 Jan 2019 10:52:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190129095224.GA4467@dhcp-200-176.str.redhat.com>
References: <1548705688-1027522-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548705688-1027522-2-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548705688-1027522-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 1/2] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Am 28.01.2019 um 21:01 hat Andrey Shinkevich geschrieben:
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
> 
> image: /vz/vmprivate/VM1/harddisk.hdd
> file format: qcow2
> virtual size: 64G (68719476736 bytes)
> disk size: 3.0M
> cluster_size: 1048576
> Format specific information:
>     compat: 1.1
>     lazy refcounts: true
>     bitmaps:
>         [0]:
>             flags:
>                 [0]: in-use
>                 [1]: auto
>             name: back-up1
>             unknown flags: 4
>             granularity: 65536
>         [1]:
>             flags:
>                 [0]: in-use
>                 [1]: auto
>             name: back-up2
>             unknown flags: 8
>             granularity: 65536
>     refcount bits: 16
>     corrupt: false
> 
> As the print of the qcow2 specific information expanded by adding
> the bitmap parameters to the 'qemu-img info' command output,
> it requires amendment of the output benchmark in the following
> tests: 060, 065, 082, 198, and 206.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/qapi.c               |  6 +++++
>  block/qcow2-bitmap.c       | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c              | 13 ++++++++++
>  block/qcow2.h              |  2 ++
>  qapi/block-core.json       | 42 +++++++++++++++++++++++++++++-
>  tests/qemu-iotests/060.out |  1 +
>  tests/qemu-iotests/065     | 16 ++++++------
>  tests/qemu-iotests/082.out |  7 +++++
>  tests/qemu-iotests/198.out |  2 ++
>  tests/qemu-iotests/206.out |  5 ++++
>  10 files changed, 149 insertions(+), 9 deletions(-)
> 
> diff --git a/block/qapi.c b/block/qapi.c
> index c66f949..0fde98c 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -38,6 +38,7 @@
>  #include "qapi/qmp/qstring.h"
>  #include "sysemu/block-backend.h"
>  #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>  
>  BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>                                          BlockDriverState *bs, Error **errp)
> @@ -868,6 +869,11 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
>  
>      if (info->has_format_specific) {
>          func_fprintf(f, "Format specific information:\n");
> +        if (info->format_specific &&
> +            info->format_specific->type == IMAGE_INFO_SPECIFIC_KIND_QCOW2 &&
> +            info->format_specific->u.qcow2.data->has_bitmaps == false) {
> +            warn_report("Failed to load bitmap list");
> +        }
>          bdrv_image_info_specific_dump(func_fprintf, f, info->format_specific);
>      }
>  }

Is it really necessary to introduce qcow2 specific knowledge in
block/qapi.c (where it definitely doesn't belong), just to emit a
warning?

Why can't you print the warning in qcow2_get_specific_info()?

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 4897aba..07b99ee 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4386,8 +4386,14 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
>          *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
>              .compat             = g_strdup("0.10"),
>              .refcount_bits      = s->refcount_bits,
> +            .has_bitmaps        = true, /* To handle error check properly */
> +            .bitmaps            = NULL, /* Unsupported for version 2 */

.has_bitmaps = false would be nicer if the format doesn't even support
bitmaps. You only need this here because you put the warning in the
wrong place.

>          };
>      } else if (s->qcow_version == 3) {
> +        Qcow2BitmapInfoList *bitmaps;
> +        Error *local_err = NULL;
> +
> +        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);

Here you even had a good error message to print...

>          *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
>              .compat             = g_strdup("1.1"),
>              .lazy_refcounts     = s->compatible_features &
> @@ -4397,7 +4403,14 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
>                                    QCOW2_INCOMPAT_CORRUPT,
>              .has_corrupt        = true,
>              .refcount_bits      = s->refcount_bits,
> +            .has_bitmaps        = !local_err,
> +            .bitmaps            = bitmaps,
>          };
> +        /*
> +         * If an error occurs in obtaining bitmaps, ignore
> +         * it to show other QCOW2 specific information.
> +         */
> +        error_free(local_err);

...but you decided to discard it.

How about you do this here:

    warn_reportf_err(local_err, "Failed to load bitmap list: ");

And then get rid of the code in block/qapi.c and the version 2 path?

Actually, should this really only be a warning, or in fact an error?
What's the case where we expect that loading the bitmap list can fail,
but the management tool doesn't need to know that and we just want to
log a message?

>      } else {
>          /* if this assertion fails, this probably means a new version was
>           * added without having it covered here */

Kevin
