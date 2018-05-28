Received: from eggs.gnu.org ([2001:4830:134:3::10]:39246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNHJO-0006w6-9w
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNHJL-0008LV-6C
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:31:42 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:35404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNHJK-0008KW-Ut
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:31:39 -0400
Received: from player763.ha.ovh.net (unknown [10.109.105.80])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id C7837FF17B
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 14:31:36 +0200 (CEST)
Date: Mon, 28 May 2018 14:31:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180528143132.6733e0db@bahia.lan>
In-Reply-To: <b8019eac434b2e61813a2061090d85401c6c44c4.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<b8019eac434b2e61813a2061090d85401c6c44c4.1527310210.git.keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/13] 9p: linux: Fix a couple Linux
 assumptions
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

On Sat, 26 May 2018 01:23:03 -0400
keno@juliacomputing.com wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
> 
>  - Guard two Linux only headers.
>  - Define `ENOATTR` only if not only defined
>    (it's defined in system headers on Darwin).
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  fsdev/file-op-9p.h   | 2 ++
>  hw/9pfs/9p-local.c   | 2 ++
>  include/qemu/xattr.h | 4 +++-

Irrespectively of the discussion on checking this in configure, 
there's another user of <sys/vfs.h> in fsdev/virtfs-proxy-helper.c.
I see in patch 13 that the helper won't be built on Darwin, but
this could change, and anyway, I'd like the handling of <sys/vfs.h>
to stay consistent across the VirtFS code.

>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 3fa062b..a13e729 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -16,7 +16,9 @@
>  
>  #include <dirent.h>
>  #include <utime.h>
> +#ifdef CONFIG_LINUX
>  #include <sys/vfs.h>
> +#endif
>  #include "qemu-fsdev-throttle.h"
>  
>  #define SM_LOCAL_MODE_BITS    0600
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index b37b1db..f6c7526 100644
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
>  
>  #ifndef XFS_SUPER_MAGIC
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
>  
