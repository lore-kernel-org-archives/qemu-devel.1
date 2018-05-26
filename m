Received: from eggs.gnu.org ([2001:4830:134:3::10]:44243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMSip-00068g-GF
	for qemu-devel@nongnu.org; Sat, 26 May 2018 02:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMSim-0002t6-BW
	for qemu-devel@nongnu.org; Sat, 26 May 2018 02:30:35 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:46766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMSil-0002rM-PR
	for qemu-devel@nongnu.org; Sat, 26 May 2018 02:30:31 -0400
Received: by mail-qt0-x22e.google.com with SMTP id h5-v6so1248151qtm.13
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 23:30:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<b8019eac434b2e61813a2061090d85401c6c44c4.1527310210.git.keno@alumni.harvard.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ee73c66b-2a36-ffbc-ba2e-9b01386a54d0@amsat.org>
Date: Sat, 26 May 2018 03:30:26 -0300
MIME-Version: 1.0
In-Reply-To: <b8019eac434b2e61813a2061090d85401c6c44c4.1527310210.git.keno@alumni.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: keno@juliacomputing.com, qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org

Hi Keno,

On 05/26/2018 02:23 AM, keno@juliacomputing.com wrote:
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

What about a less restrictive:

#ifndef __APPLE__

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

Rest looks correct.
