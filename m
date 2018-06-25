Received: from eggs.gnu.org ([2001:4830:134:3::10]:40212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXTFB-00054H-0w
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXTF7-0004ek-JC
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:17:29 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:44758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXTF7-0004eN-81
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:17:25 -0400
Received: from player695.ha.ovh.net (unknown [10.109.108.80])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7C569B4C32
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 17:17:23 +0200 (CEST)
Date: Mon, 25 Jun 2018 17:17:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180625171718.6f51ebf4@bahia.lan>
In-Reply-To: <2fafd9bc91e8104f302eda0bc7da5e90b868c7e3.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
	<2fafd9bc91e8104f302eda0bc7da5e90b868c7e3.1529196703.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/13] 9p: Rename 9p-util ->
 9p-util-linux
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

On Sat, 16 Jun 2018 20:56:46 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> The current file only has the Linux versions of these functions.
> Rename the file accordingly and update the Makefile to only build
> it on Linux. A Darwin version of these will follow later in the
> series.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---

I reviewed this patch during v2:

https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00110.html

Please remember to add any Reviewed-by, Acked-by, Tested-by tags that were
posted. This speeds up the reviewing process when you post a new version.

>  hw/9pfs/9p-util-linux.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/9pfs/9p-util.c       | 59 -------------------------------------------------
>  hw/9pfs/Makefile.objs   |  3 ++-
>  3 files changed, 61 insertions(+), 60 deletions(-)
>  create mode 100644 hw/9pfs/9p-util-linux.c
>  delete mode 100644 hw/9pfs/9p-util.c
> 
> diff --git a/hw/9pfs/9p-util-linux.c b/hw/9pfs/9p-util-linux.c
> new file mode 100644
> index 0000000..defa3a4
> --- /dev/null
> +++ b/hw/9pfs/9p-util-linux.c
> @@ -0,0 +1,59 @@
> +/*
> + * 9p utilities (Linux Implementation)
> + *
> + * Copyright IBM, Corp. 2017
> + *
> + * Authors:
> + *  Greg Kurz <groug@kaod.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/xattr.h"
> +#include "9p-util.h"
> +
> +ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
> +                             void *value, size_t size)
> +{
> +    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> +    int ret;
> +
> +    ret = lgetxattr(proc_path, name, value, size);
> +    g_free(proc_path);
> +    return ret;
> +}
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
> diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
> deleted file mode 100644
> index 614b7fc..0000000
> --- a/hw/9pfs/9p-util.c
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -/*
> - * 9p utilities
> - *
> - * Copyright IBM, Corp. 2017
> - *
> - * Authors:
> - *  Greg Kurz <groug@kaod.org>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/xattr.h"
> -#include "9p-util.h"
> -
> -ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
> -                             void *value, size_t size)
> -{
> -    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> -    int ret;
> -
> -    ret = lgetxattr(proc_path, name, value, size);
> -    g_free(proc_path);
> -    return ret;
> -}
> -
> -ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
> -                              char *list, size_t size)
> -{
> -    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> -    int ret;
> -
> -    ret = llistxattr(proc_path, list, size);
> -    g_free(proc_path);
> -    return ret;
> -}
> -
> -ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
> -                                const char *name)
> -{
> -    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
> -    int ret;
> -
> -    ret = lremovexattr(proc_path, name);
> -    g_free(proc_path);
> -    return ret;
> -}
> -
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
> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> index e3fa673..95e3bc0 100644
> --- a/hw/9pfs/Makefile.objs
> +++ b/hw/9pfs/Makefile.objs
> @@ -1,5 +1,6 @@
>  ifeq ($(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN)),y)
> -common-obj-y  = 9p.o 9p-util.o
> +common-obj-y  = 9p.o
> +common-obj-$(CONFIG_LINUX) += 9p-util-linux.o
>  common-obj-y += 9p-local.o 9p-xattr.o
>  common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
>  common-obj-y += coth.o cofs.o codir.o cofile.o
