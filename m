Received: from eggs.gnu.org ([2001:4830:134:3::10]:41908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eMyAn-0001DI-7z
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eMyAj-0003MP-8U
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:33:17 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:45334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eMyAj-0003LV-2I
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:33:13 -0500
Received: by mail-wm0-x242.google.com with SMTP id 9so13722793wme.4
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 07:33:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511419276-31212-1-git-send-email-yang.zhong@intel.com>
References: <1511419276-31212-1-git-send-email-yang.zhong@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Dec 2017 16:33:10 +0100
Message-ID: <CAJ+F1C+CHLLncN9uWS9wHQ7vAk26Y98TKJ38RZtrtbFEPdO57Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, Gonglei <arei.gonglei@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, weidong.huang@huawei.com

Hi

On Thu, Nov 23, 2017 at 7:41 AM, Yang Zhong <yang.zhong@intel.com> wrote:
> Since there are some issues in memory alloc/free machenism
> in glibc for little chunk memory, if Qemu frequently
> alloc/free little chunk memory, the glibc doesn't alloc
> little chunk memory from free list of glibc and still
> allocate from OS, which make the heap size bigger and bigger.
>
> This patch introduce malloc_trim(), which will free heap memory.
>
> Below are test results from smaps file.
> (1)without patch
> 55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
> Size:              21796 kB
> Rss:               14260 kB
> Pss:               14260 kB
>
> (2)with patch
> 55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
> Size:              21668 kB
> Rss:                6940 kB
> Pss:                6940 kB

Have you opened a bug to glibc malloc (or discussed that issue with
the glibc malloc developpers) ?

Or is there a justification that qemu should have its own trim
heuristic on top of malloc?

>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  configure  | 4 ++++
>  util/rcu.c | 6 ++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/configure b/configure
> index 0e856bb..5b463d4 100755
> --- a/configure
> +++ b/configure
> @@ -6012,6 +6012,10 @@ if test "$opengl" =3D "yes" ; then
>    fi
>  fi
>
> +if test "$tcmalloc" =3D "yes" || test "$jemalloc" =3D "yes" ; then
> +  echo "CONFIG_NONGLIBMALLOC=3Dy" >> $config_host_mak
> +fi
> +
>  if test "$avx2_opt" =3D "yes" ; then
>    echo "CONFIG_AVX2_OPT=3Dy" >> $config_host_mak
>  fi
> diff --git a/util/rcu.c b/util/rcu.c
> index ca5a63e..f3e96a8 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -32,6 +32,9 @@
>  #include "qemu/atomic.h"
>  #include "qemu/thread.h"
>  #include "qemu/main-loop.h"
> +#if defined(CONFIG_LINUX)
> +#include <malloc.h>
> +#endif
>
>  /*
>   * Global grace period counter.  Bit 0 is always one in rcu_gp_ctr.
> @@ -272,6 +275,9 @@ static void *call_rcu_thread(void *opaque)
>              node->func(node);
>          }
>          qemu_mutex_unlock_iothread();
> +#if defined(CONFIG_LINUX) && !defined(CONFIG_NONGLIBMALLOC)
> +        malloc_trim(4 * 1024 * 1024);
> +#endif
>      }
>      abort();
>  }
> --
> 1.9.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
