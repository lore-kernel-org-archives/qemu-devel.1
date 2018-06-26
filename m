Received: from eggs.gnu.org ([2001:4830:134:3::10]:58245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXlrM-0002Wm-Lk
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXlrH-0003Ju-MO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:10:08 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:60577)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXlrH-0003Ie-FK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:10:03 -0400
Received: from player729.ha.ovh.net (unknown [10.109.120.49])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 539A81A7F0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 13:10:00 +0200 (CEST)
Date: Tue, 26 Jun 2018 13:09:54 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180626130954.658ec4f1@bahia.lan>
In-Reply-To: <d2e05ff145f160cb99454f98821dc0250247f1f8.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
	<d2e05ff145f160cb99454f98821dc0250247f1f8.1529196703.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/13] 9p: darwin: *xattr_nofollow
 implementations
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

On Sat, 16 Jun 2018 20:56:52 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> This implements the darwin equivalent of the functions that were
> moved to 9p-util(-linux) earlier in this series in the new
> 9p-util-darwin file.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p-util-darwin.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/9pfs/Makefile.objs    |  1 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 hw/9pfs/9p-util-darwin.c
> 
> diff --git a/hw/9pfs/9p-util-darwin.c b/hw/9pfs/9p-util-darwin.c
> new file mode 100644
> index 0000000..cdb4c9e
> --- /dev/null
> +++ b/hw/9pfs/9p-util-darwin.c
> @@ -0,0 +1,64 @@
> +/*
> + * 9p utilities (Darwin Implementation)
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
> +    int ret;
> +    int fd = openat_file(dirfd, filename,
> +                         O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +    ret = fgetxattr(fd, name, value, size, 0, 0);

Hmm... I had said it looked good, but not that good actually. This isn't
strictly equivalent of what we have with Linux, because it requires the
file to have appropriate access rights.

Why not just use the magic sycall from patch 11 and call getxattr() ?

> +    close_preserve_errno(fd);
> +    return ret;
> +}
> +
> +ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
> +                              char *list, size_t size)
> +{
> +    int ret;
> +    int fd = openat_file(dirfd, filename,
> +                         O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +    ret = flistxattr(fd, list, size, 0);
> +    close_preserve_errno(fd);
> +    return ret;
> +}
> +
> +ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
> +                                const char *name)
> +{
> +    int ret;
> +    int fd = openat_file(dirfd, filename, O_PATH_9P_UTIL | O_NOFOLLOW, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +    ret = fremovexattr(fd, name, 0);
> +    close_preserve_errno(fd);
> +    return ret;
> +}
> +
> +int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
> +                         void *value, size_t size, int flags)
> +{
> +    int ret;
> +    int fd = openat_file(dirfd, filename, O_PATH_9P_UTIL | O_NOFOLLOW, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +    ret = fsetxattr(fd, name, value, size, 0, flags);
> +    close_preserve_errno(fd);
> +    return ret;
> +}
> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> index 95e3bc0..0de39af 100644
> --- a/hw/9pfs/Makefile.objs
> +++ b/hw/9pfs/Makefile.objs
> @@ -1,6 +1,7 @@
>  ifeq ($(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN)),y)
>  common-obj-y  = 9p.o
>  common-obj-$(CONFIG_LINUX) += 9p-util-linux.o
> +common-obj-$(CONFIG_DARWIN) += 9p-util-darwin.o
>  common-obj-y += 9p-local.o 9p-xattr.o
>  common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
>  common-obj-y += coth.o cofs.o codir.o cofile.o
