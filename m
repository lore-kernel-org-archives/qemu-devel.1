Received: from eggs.gnu.org ([2001:4830:134:3::10]:52248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXN8Q-0002Bj-UM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXN8M-0007u1-S1
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:18:22 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXN8M-0007se-EP
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:18:18 -0500
Received: by mail-wr1-f41.google.com with SMTP id z5so1164636wrt.11
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 01:18:18 -0800 (PST)
References: <20181212194009.2951-1-lvivier@redhat.com>
	<20181212194009.2951-4-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2282b7a4-70fb-bcb1-bc06-3265a2ab6a67@redhat.com>
Date: Thu, 13 Dec 2018 10:18:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181212194009.2951-4-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] block/file-posix: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Liu Yuan <namei.unix@gmail.com>, Max Reitz <mreitz@redhat.com>

On 12/12/18 8:40 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  block/file-posix.c | 25 ++++++-------------------
>  block/trace-events |  7 +++++++
>  2 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 07bbdab953..cf90899a6e 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -102,19 +102,7 @@
>  #include <xfs/xfs.h>
>  #endif
>  
> -//#define DEBUG_BLOCK
> -
> -#ifdef DEBUG_BLOCK
> -# define DEBUG_BLOCK_PRINT 1
> -#else
> -# define DEBUG_BLOCK_PRINT 0
> -#endif
> -#define DPRINTF(fmt, ...) \
> -do { \
> -    if (DEBUG_BLOCK_PRINT) { \
> -        printf(fmt, ## __VA_ARGS__); \
> -    } \
> -} while (0)
> +#include "trace.h"
>  
>  /* OS X does not have O_DSYNC */
>  #ifndef O_DSYNC
> @@ -1386,7 +1374,7 @@ static int xfs_write_zeroes(BDRVRawState *s, int64_t offset, uint64_t bytes)
>  
>      if (xfsctl(NULL, s->fd, XFS_IOC_ZERO_RANGE, &fl) < 0) {
>          err = errno;
> -        DPRINTF("cannot write zero range (%s)\n", strerror(errno));
> +        trace_file_xfs_write_zeroes(strerror(errno));
>          return -err;
>      }
>  
> @@ -1405,7 +1393,7 @@ static int xfs_discard(BDRVRawState *s, int64_t offset, uint64_t bytes)
>  
>      if (xfsctl(NULL, s->fd, XFS_IOC_UNRESVSP64, &fl) < 0) {
>          err = errno;
> -        DPRINTF("cannot punch hole (%s)\n", strerror(errno));
> +        trace_file_xfs_discard(strerror(errno));
>          return -err;
>      }
>  
> @@ -2798,7 +2786,7 @@ static char *FindEjectableOpticalMedia(io_iterator_t *mediaIterator)
>  
>          /* If a match was found, leave the loop */
>          if (*mediaIterator != 0) {
> -            DPRINTF("Matching using %s\n", matching_array[index]);
> +            trace_file_FindEjectableOpticalMedia(matching_array[index]);
>              mediaType = g_strdup(matching_array[index]);
>              break;
>          }
> @@ -2858,7 +2846,7 @@ static bool setup_cdrom(char *bsd_path, Error **errp)
>      if (partition_found == false) {
>          error_setg(errp, "Failed to find a working partition on disc");
>      } else {
> -        DPRINTF("Using %s as optical disc\n", test_partition);
> +        trace_file_setup_cdrom(test_partition);
>          pstrcpy(bsd_path, MAXPATHLEN, test_partition);
>      }
>      return partition_found;
> @@ -2953,8 +2941,7 @@ static bool hdev_is_sg(BlockDriverState *bs)
>  
>      ret = ioctl(s->fd, SG_GET_SCSI_ID, &scsiid);
>      if (ret >= 0) {
> -        DPRINTF("SG device found: type=%d, version=%d\n",
> -            scsiid.scsi_type, sg_version);
> +        trace_file_hdev_is_sg(scsiid.scsi_type, sg_version);
>          return true;
>      }
>  
> diff --git a/block/trace-events b/block/trace-events
> index 5b83280b02..49f31966e7 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -182,3 +182,10 @@ curl_open(const char *file) "opening %s"
>  curl_open_size(uint64_t size) "size = %" PRIu64
>  curl_setup_preadv(uint64_t bytes, uint64_t start, const char *range) "reading %" PRIu64 " at %" PRIu64 " (%s)"
>  curl_close(void) "close"
> +
> +# block/file-posix.c
> +file_xfs_write_zeroes(const char *error) "cannot write zero range (%s)"
> +file_xfs_discard(const char* error) "cannot punch hole (%s)"
> +file_FindEjectableOpticalMedia(const char *media) "Matching using %s"
> +file_setup_cdrom(const char *partition) "Using %s as optical disc"
> +file_hdev_is_sg(int type, int version) "SG device found: type=%d, version=%d"
> 
