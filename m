Received: from eggs.gnu.org ([2001:4830:134:3::10]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fO008-000183-Pe
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fO004-0001Xa-Ji
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:14:48 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:44608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fO004-0001XF-D1
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:14:44 -0400
Received: from player694.ha.ovh.net (unknown [10.109.122.112])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id D89F9C012A
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:14:42 +0200 (CEST)
Date: Wed, 30 May 2018 14:14:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180530141439.24619dbc@bahia.lan>
In-Reply-To: <4e5e163637c9c696eb43d46a08a0aad5cd818d8a.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<4e5e163637c9c696eb43d46a08a0aad5cd818d8a.1527310210.git.keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/13] 9p: darwin: Provide a fallback
 implementation for utimensat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keno@juliacomputing.com
Cc: qemu-devel@nongnu.org, Keno Fischer <keno@alumni.harvard.edu>

On Sat, 26 May 2018 01:23:14 -0400
keno@juliacomputing.com wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
> 
> This function is new in Mac OS 10.13. Provide a fallback implementation
> when building against older SDKs.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---

As with patch 10, this should go to 9p-util-darwin.c

>  hw/9pfs/9p-local.c |  2 +-
>  hw/9pfs/9p-util.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  hw/9pfs/9p-util.h  |  7 +++++++
>  hw/9pfs/9p.c       |  1 +
>  4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 3e358b7..70ab541 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1082,7 +1082,7 @@ static int local_utimensat(FsContext *s, V9fsPath *fs_path,
>          goto out;
>      }
>  
> -    ret = utimensat(dirfd, name, buf, AT_SYMLINK_NOFOLLOW);
> +    ret = utimensat_nofollow(dirfd, name, buf);
>      close_preserve_errno(dirfd);
>  out:
>      g_free(dirpath);
> diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
> index 98004ac..8403f5f 100644
> --- a/hw/9pfs/9p-util.c
> +++ b/hw/9pfs/9p-util.c
> @@ -104,3 +104,41 @@ int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
>  #endif
>      return ret;
>  }
> +
> +#ifndef __has_builtin
> +#define __has_builtin(x) 0
> +#endif
> +
> +int utimensat_nofollow(int dirfd, const char *filename, const struct timespec times[2])
> +{
> +#ifdef CONFIG_DARWIN
> +#if defined(__MAC_10_13) /* Check whether we have an SDK version that defines utimensat */
> +#if __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_13
> +#define UTIMENSAT_AVAILABLE 1
> +#elif __has_builtin(__builtin_available)
> +#define UTIMENSAT_AVAILABLE __builtin_available(macos 10.13, *)
> +#else
> +#define UTIMENSAT_AVAILABLE 0
> +#endif
> +    if (UTIMENSAT_AVAILABLE)
> +    {
> +        return utimensat(dirfd, filename, times, AT_SYMLINK_NOFOLLOW);
> +    }
> +#endif
> +    // utimensat not available. Use futimes.
> +    int fd = openat_file(dirfd, filename, O_PATH_9P_UTIL | O_NOFOLLOW, 0);
> +    if (fd == -1)
> +        return -1;
> +
> +    struct timeval futimes_buf[2];
> +    futimes_buf[0].tv_sec = times[0].tv_sec;
> +    futimes_buf[0].tv_usec = times[0].tv_nsec * 1000;
> +    futimes_buf[1].tv_sec = times[1].tv_sec;
> +    futimes_buf[1].tv_usec = times[1].tv_nsec * 1000;
> +    int ret = futimes(fd, futimes_buf);
> +    close_preserve_errno(fd);
> +    return ret;
> +#else
> +    return utimensat(dirfd, filename, times, AT_SYMLINK_NOFOLLOW);
> +#endif
> +}
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index cb26343..2329c82 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -19,6 +19,12 @@
>  #define O_PATH_9P_UTIL 0
>  #endif
>  
> +/* Compatibility with OLD SDK Versions for Darwin */
> +#if defined(CONFIG_DARWIN) && !defined(UTIME_NOW)
> +#define UTIME_NOW -1
> +#define UTIME_OMIT -2
> +#endif
> +
>  static inline void close_preserve_errno(int fd)
>  {
>      int serrno = errno;
> @@ -66,5 +72,6 @@ ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
>                                char *list, size_t size);
>  ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
>                                  const char *name);
> +int utimensat_nofollow(int dirfd, const char *filename, const struct timespec times[2]);
>  
>  #endif
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 4ae4da6..8e0594a 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -21,6 +21,7 @@
>  #include "virtio-9p.h"
>  #include "fsdev/qemu-fsdev.h"
>  #include "9p-xattr.h"
> +#include "9p-util.h"
>  #include "coth.h"
>  #include "trace.h"
>  #include "migration/blocker.h"
