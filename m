Received: from eggs.gnu.org ([2001:4830:134:3::10]:48326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOi0S-0001yc-Bh
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOi0N-0002fY-CV
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:14:04 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:37088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOi0N-0002ea-44
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:13:59 -0400
Received: from player728.ha.ovh.net (unknown [10.109.105.46])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1991DE5B42
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 13:13:56 +0200 (CEST)
Date: Fri, 1 Jun 2018 13:13:52 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180601131352.6ab033aa@bahia.lan>
In-Reply-To: <5d222847166f7f3f2b05e7e8a0a0ab3d7520b49d.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
	<5d222847166f7f3f2b05e7e8a0a0ab3d7520b49d.1527814874.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/20] 9p: darwin: *xattr_nofollow
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

On Thu, 31 May 2018 21:26:10 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> This implements the darwin equivalent of the functions that were
> moved to 9p-util(-linux) earlier in this series in the new
> 9p-util-darwin file.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
> 

The patch looks good but...

> Changes from v1:
>  * New 9p-util-darwin.c rather than ifdefs in 9p-util.c
>  * Drop incorrect AT_NOFOLLOW from the actual call
> 
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

... I now realize that flags may come from the client, ie, it should be
translated before being passed to the backends, pretty much like the other
patch with unlinkat.

The specification for 9p2000.L says it is derived from "Linux setxattr".

https://github.com/chaos/diod/blob/master/protocol.md#xattrcreate----prepare-to-set-extended-attribute

ie,

include/uapi/linux/xattr.h:#define XATTR_CREATE 0x1     /* set value, fail if attr already exists */
include/uapi/linux/xattr.h:#define XATTR_REPLACE        0x2     /* set value, fail if attr does not exist */

I guess this calls for some defines in 9p.h:

/* 9p2000.L says that the 'flags' argument of operation 'xattrcreate'
 * are derived from Linux setxattr.
 */
#define P9_XATTR_CREATE  1
#define P9_XATTR_REPLACE 2

Please do that in a preparatory patch.

I would also appreciate you look at other 9P operations and
check if we have other places where we need to translate
some flags.

> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> index 083508f..24a8695 100644
> --- a/hw/9pfs/Makefile.objs
> +++ b/hw/9pfs/Makefile.objs
> @@ -1,5 +1,6 @@
>  common-obj-y  = 9p.o
>  common-obj-$(CONFIG_LINUX) += 9p-util-linux.o
> +common-obj-$(CONFIG_DARWIN) += 9p-util-darwin.o
>  common-obj-y += 9p-local.o 9p-xattr.o
>  common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
>  common-obj-y += coth.o cofs.o codir.o cofile.o
