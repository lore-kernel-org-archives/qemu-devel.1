Received: from eggs.gnu.org ([2001:4830:134:3::10]:35788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOgtv-0006lu-SK
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOgtr-0002Ma-Qk
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:03:15 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:37053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOgtr-0002Lt-G1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:03:11 -0400
Received: from player699.ha.ovh.net (unknown [10.109.120.110])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id E68EB17AE2
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 12:03:09 +0200 (CEST)
Date: Fri, 1 Jun 2018 12:03:07 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180601120307.57b17b4b@bahia.lan>
In-Reply-To: <d15d9bc9680d7769ebf5eb0c79cc8f59829ddaab.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
	<d15d9bc9680d7769ebf5eb0c79cc8f59829ddaab.1527814874.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/20] 9p: Move a couple xattr functions
 to 9p-util
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org

On Thu, 31 May 2018 21:26:02 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> These functions will need custom implementations on Darwin. Since the
> implementation is very similar among all of them, and 9p-util already
> has the _nofollow version of fgetxattrat, let's move them all there.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
> 

This cleanup makes sense irrespective of the rest of the series.

Applied to 9p-next.

Thanks!

> Changes since v1:
>  * fgetxattr_follow is dropped in favor of a different approach
>    later in the series.
> 
>  hw/9pfs/9p-util.c  | 33 +++++++++++++++++++++++++++++++++
>  hw/9pfs/9p-util.h  |  4 ++++
>  hw/9pfs/9p-xattr.c | 33 ---------------------------------
>  3 files changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
> index f709c27..614b7fc 100644
> --- a/hw/9pfs/9p-util.c
> +++ b/hw/9pfs/9p-util.c
> @@ -24,3 +24,36 @@ ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
>      g_free(proc_path);
>      return ret;
>  }
> +
> +ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
> +                              char *list, size_t size)
> +{
> +    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> +    int ret;
> +
> +    ret = llistxattr(proc_path, list, size);
> +    g_free(proc_path);
> +    return ret;
> +}
> +
> +ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
> +                                const char *name)
> +{
> +    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> +    int ret;
> +
> +    ret = lremovexattr(proc_path, name);
> +    g_free(proc_path);
> +    return ret;
> +}
> +
> +int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
> +                         void *value, size_t size, int flags)
> +{
> +    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> +    int ret;
> +
> +    ret = lsetxattr(proc_path, name, value, size, flags);
> +    g_free(proc_path);
> +    return ret;
> +}
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index dc0d2e2..79ed6b2 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -60,5 +60,9 @@ ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
>                               void *value, size_t size);
>  int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
>                           void *value, size_t size, int flags);
> +ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
> +                              char *list, size_t size);
> +ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
> +                                const char *name);
>  
>  #endif
> diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
> index d05c1a1..c696d8f 100644
> --- a/hw/9pfs/9p-xattr.c
> +++ b/hw/9pfs/9p-xattr.c
> @@ -60,17 +60,6 @@ ssize_t pt_listxattr(FsContext *ctx, const char *path,
>      return name_size;
>  }
>  
> -static ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
> -                                     char *list, size_t size)
> -{
> -    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> -    int ret;
> -
> -    ret = llistxattr(proc_path, list, size);
> -    g_free(proc_path);
> -    return ret;
> -}
> -
>  /*
>   * Get the list and pass to each layer to find out whether
>   * to send the data or not
> @@ -196,17 +185,6 @@ ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
>      return local_getxattr_nofollow(ctx, path, name, value, size);
>  }
>  
> -int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
> -                         void *value, size_t size, int flags)
> -{
> -    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> -    int ret;
> -
> -    ret = lsetxattr(proc_path, name, value, size, flags);
> -    g_free(proc_path);
> -    return ret;
> -}
> -
>  ssize_t local_setxattr_nofollow(FsContext *ctx, const char *path,
>                                  const char *name, void *value, size_t size,
>                                  int flags)
> @@ -235,17 +213,6 @@ int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
>      return local_setxattr_nofollow(ctx, path, name, value, size, flags);
>  }
>  
> -static ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
> -                                       const char *name)
> -{
> -    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> -    int ret;
> -
> -    ret = lremovexattr(proc_path, name);
> -    g_free(proc_path);
> -    return ret;
> -}
> -
>  ssize_t local_removexattr_nofollow(FsContext *ctx, const char *path,
>                                     const char *name)
>  {
