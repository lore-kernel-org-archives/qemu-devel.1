Received: from eggs.gnu.org ([2001:4830:134:3::10]:48616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAIm4-0007rq-1t
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAIm3-0008Nn-0v
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:55:24 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:47274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAIm2-0008NP-PT
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:55:22 -0400
Received: by mail-wm0-x244.google.com with SMTP id r196so283229wmf.2
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 09:55:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171028194833.23858-1-n54@gmx.com>
References: <20171028194833.23858-1-n54@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 16:55:00 +0000
Message-ID: <CAFEAcA8Rw99f6aB-=4bahwyxpPMYiyG0aCCAyqBmva3vMYrJDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use sysctl(2) call to resolve
 exec_dir on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 October 2017 at 20:48, Kamil Rytarowski <n54@gmx.com> wrote:
> NetBSD 8.0(beta) ships with KERN_PROC_PATHNAME in sysctl(2).
> Older NetBSD versions can use argv[0] parsing fallback.
>
> This code section is partly shared with FreeBSD.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  util/oslib-posix.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 382bd4a231..77369c92ce 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -49,6 +49,10 @@
>  #include <libutil.h>
>  #endif
>
> +#ifdef __NetBSD__
> +#include <sys/sysctl.h>
> +#endif
> +
>  #include "qemu/mmap-alloc.h"
>
>  #ifdef CONFIG_DEBUG_STACK_USAGE
> @@ -250,9 +254,14 @@ void qemu_init_exec_dir(const char *argv0)
>              p = buf;
>          }
>      }
> -#elif defined(__FreeBSD__)
> +#elif defined(__FreeBSD__) \
> +      || (defined(__NetBSD__) && defined(KERN_PROC_PATHNAME))
>      {
> +#if defined(__FreeBSD__)
>          static int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_PATHNAME, -1};
> +#else
> +        static int mib[4] = {CTL_KERN, KERN_PROC_ARGS, -1, KERN_PROC_PATHNAME};
> +#endif
>          size_t len = sizeof(buf) - 1;
>
>          *buf = '\0';

It's a shame the BSDs can't agree on a single way to implement this :-(

I had a look at how Go implements this:
https://github.com/golang/go/commit/2fc67e71af142bfa1e7662a4fde361f43509d2d7

and for NetBSD it uses readlink("/proc/curproc/exe"), which would be
a better fallback for "sysctl not implemented" than the argv[0]
stuff, perhaps (but then nobody's complained much so perhaps not
worth the effort now). It also has /proc/curproc/file for OpenBSD, but
my OpenBSD VM doesn't mount /proc/, which reduces my enthusiasm
for trying for a "generic for BSDs try various /proc/ paths" approach.

In any case, I think this is better than what we have today,
so I've applied it to master.

thanks
-- PMM
