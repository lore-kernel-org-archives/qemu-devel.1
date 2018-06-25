Received: from eggs.gnu.org ([2001:4830:134:3::10]:55524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXST1-0001zt-Sz
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXSSy-0002Jk-KJ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:27:43 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:41822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXSSy-0002JM-Ay
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:27:40 -0400
Received: from player793.ha.ovh.net (unknown [10.109.122.16])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A9CF81C4B28
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 16:27:38 +0200 (CEST)
Date: Mon, 25 Jun 2018 16:27:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180625162733.41cd605b@bahia.lan>
In-Reply-To: <603b0ffda828e4c6a7ac9799853df0d6a5be3822.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
	<603b0ffda828e4c6a7ac9799853df0d6a5be3822.1529196703.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/13] 9p: linux: Fix a couple Linux
 assumptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org, Keno Fischer <keno@alumni.harvard.edu>

On Sat, 16 Jun 2018 20:56:45 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
>=20
>  - Guard Linux only headers.
>  - Add qemu/statfs.h header to abstract over the which
>    headers are needed for struct statfs

I've suggested in some other mail that you introduce a QEMU type
for struct statfs with per-OS helpers. I guess this would cover
this part as well.

>  - Define `ENOATTR` only if not only defined
>    (it's defined in system headers on Darwin).
>=20

The ENOATTR part is independent from the others. Please move it
to its own patch.

> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  fsdev/file-op-9p.h          |  2 +-
>  fsdev/virtfs-proxy-helper.c |  4 +++-
>  hw/9pfs/9p-local.c          |  2 ++
>  include/qemu/statfs.h       | 19 +++++++++++++++++++
>  include/qemu/xattr.h        |  4 +++-
>  5 files changed, 28 insertions(+), 3 deletions(-)
>  create mode 100644 include/qemu/statfs.h
>=20
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 3fa062b..111f804 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -16,7 +16,7 @@
> =20
>  #include <dirent.h>
>  #include <utime.h>
> -#include <sys/vfs.h>
> +#include "qemu/statfs.h"
>  #include "qemu-fsdev-throttle.h"
> =20
>  #define SM_LOCAL_MODE_BITS    0600
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index 6f132c5..94fb069 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -13,17 +13,19 @@
>  #include <sys/resource.h>
>  #include <getopt.h>
>  #include <syslog.h>
> +#ifdef CONFIG_LINUX
>  #include <sys/capability.h>

I'd rather leave this to the other patch where you implement the
setuid logic for Darwin.

>  #include <sys/fsuid.h>

=46rom the setfsuid(2) manual page:

Thus, setfsuid() is nowadays unneeded and should be avoided in new
applications (likewise for setfsgid(2)).

So this header can be safely dropped, along with the big "from man7
capabilities" which is basically explaining why we don't use setfsuid(),
and should rather appear in a commit message, than in the code.

> -#include <sys/vfs.h>
>  #include <sys/ioctl.h>

This is needed for ioctl(), which is used for FS_IOC_GETVERSION,
so this should rather be guarded by FS_IOC_GETVERSION than by
CONFIG_LINUX... or maybe not guarded at all if Darwin has this
header, for the sake of simplicity.

>  #include <linux/fs.h>
>  #ifdef CONFIG_LINUX_MAGIC_H
>  #include <linux/magic.h>
>  #endif
> +#endif
>  #include "qemu-common.h"
>  #include "qemu/sockets.h"
>  #include "qemu/xattr.h"
> +#include "qemu/statfs.h"
>  #include "9p-iov-marshal.h"
>  #include "hw/9pfs/9p-proxy.h"
>  #include "fsdev/9p-iov-marshal.h"
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 828e8d6..d713983 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -27,10 +27,12 @@
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
>  #include <libgen.h>
> +#ifdef CONFIG_LINUX
>  #include <linux/fs.h>
>  #ifdef CONFIG_LINUX_MAGIC_H
>  #include <linux/magic.h>
>  #endif
> +#endif
>  #include <sys/ioctl.h>
> =20
>  #ifndef XFS_SUPER_MAGIC
> diff --git a/include/qemu/statfs.h b/include/qemu/statfs.h
> new file mode 100644
> index 0000000..dde289f
> --- /dev/null
> +++ b/include/qemu/statfs.h
> @@ -0,0 +1,19 @@
> +/*
> + * Host statfs header abstraction
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2, or a=
ny
> + * later version.  See the COPYING file in the top-level directory.
> + *
> + */
> +#ifndef QEMU_STATFS_H
> +#define QEMU_STATFS_H
> +
> +#ifdef CONFIG_LINUX
> +# include <sys/vfs.h>
> +#endif
> +#ifdef CONFIG_DARWIN
> +# include <sys/param.h>
> +# include <sys/mount.h>
> +#endif
> +
> +#endif
> diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
> index a83fe8e..f1d0f7b 100644
> --- a/include/qemu/xattr.h
> +++ b/include/qemu/xattr.h
> @@ -22,7 +22,9 @@
>  #ifdef CONFIG_LIBATTR
>  #  include <attr/xattr.h>
>  #else
> -#  define ENOATTR ENODATA
> +#  if !defined(ENOATTR)
> +#    define ENOATTR ENODATA
> +#  endif
>  #  include <sys/xattr.h>
>  #endif
> =20
