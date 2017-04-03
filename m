Received: from eggs.gnu.org ([2001:4830:134:3::10]:56714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv7MT-0002mU-AQ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv7MO-0000Uc-Bv
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:09:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-8-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fcdf487c-2879-b909-c383-3321374bf1f6@amsat.org>
Date: Mon, 3 Apr 2017 16:09:47 -0300
MIME-Version: 1.0
In-Reply-To: <20170403160936.28293-8-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 07/16] block/file-posix:
 Generalize raw_regular_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 04/03/2017 01:09 PM, Max Reitz wrote:
> Currently, raw_regular_truncate() is intended for setting the size of a
> newly created file. However, we also want to use it for truncating an
> existing file in which case only the newly added space (when growing)
> should be preallocated.
>
> This also means that if resizing failed, we should try to restore the
> original file size. This is important when using preallocation.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 11 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index e6b6fa30ce..d99ca3d6e8 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1407,11 +1407,31 @@ static void raw_close(BlockDriverState *bs)
>      }
>  }
>
> +/**
> + * Truncates the given regular file @fd to @offset and, when growing, fills the
> + * new space according to @prealloc.
> + *
> + * Returns: 0 on success, -errno on failure.
> + */
>  static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
>                                  Error **errp)
>  {
>      int result = 0;
> -    char *buf;
> +    int64_t current_length = 0;
> +    char *buf = NULL;
> +    struct stat st;
> +
> +    if (fstat(fd, &st) < 0) {
> +        result = -errno;
> +        error_setg_errno(errp, -result, "Could not stat file");
> +        return result;
> +    }
> +
> +    current_length = st.st_size;
> +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
> +        error_setg(errp, "Cannot use preallocation for shrinking files");
> +        return -ENOTSUP;
> +    }
>
>      switch (prealloc) {
>  #ifdef CONFIG_POSIX_FALLOCATE
> @@ -1421,17 +1441,17 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
>           * file systems that do not support fallocate(), trying to check if a
>           * block is allocated before allocating it, so don't do that here.
>           */
> -        result = -posix_fallocate(fd, 0, offset);
> +        result = -posix_fallocate(fd, current_length, offset - current_length);
>          if (result != 0) {
>              /* posix_fallocate() doesn't set errno. */
>              error_setg_errno(errp, -result,
> -                             "Could not preallocate data for the new file");
> +                             "Could not preallocate new data");
>          }
> -        return result;
> +        goto out;
>  #endif
>      case PREALLOC_MODE_FULL:
>      {
> -        int64_t num = 0, left = offset;
> +        int64_t num = 0, left = offset - current_length;
>
>          /*
>           * Knowing the final size from the beginning could allow the file
> @@ -1441,19 +1461,27 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
>          if (ftruncate(fd, offset) != 0) {
>              result = -errno;
>              error_setg_errno(errp, -result, "Could not resize file");
> -            return result;
> +            goto out;
>          }
>
>          buf = g_malloc0(65536);
>
> +        result = lseek(fd, current_length, SEEK_SET);
> +        if (result < 0) {
> +            result = -errno;
> +            error_setg_errno(errp, -result,
> +                             "Failed to seek to the old end of file");
> +            goto out;
> +        }
> +
>          while (left > 0) {
>              num = MIN(left, 65536);
>              result = write(fd, buf, num);
>              if (result < 0) {
>                  result = -errno;
>                  error_setg_errno(errp, -result,
> -                                 "Could not write to the new file");
> -                break;
> +                                 "Could not write zeros for preallocation");
> +                goto out;
>              }
>              left -= result;
>          }
> @@ -1462,11 +1490,11 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
>              if (result < 0) {
>                  result = -errno;
>                  error_setg_errno(errp, -result,
> -                                 "Could not flush new file to disk");
> +                                 "Could not flush file to disk");
> +                goto out;
>              }
>          }
> -        g_free(buf);
> -        return result;
> +        goto out;
>      }
>      case PREALLOC_MODE_OFF:
>          if (ftruncate(fd, offset) != 0) {
> @@ -1480,6 +1508,17 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
>                     PreallocMode_lookup[prealloc]);
>          return result;
>      }
> +
> +out:
> +    if (result < 0) {
> +        if (ftruncate(fd, current_length) < 0) {
> +            error_report("Failed to restore old file length: %s",
> +                         strerror(errno));
> +        }
> +    }
> +
> +    g_free(buf);
> +    return result;
>  }
>
>  static int raw_truncate(BlockDriverState *bs, int64_t offset,
>
