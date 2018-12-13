Received: from eggs.gnu.org ([2001:4830:134:3::10]:47143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXQG4-0000Yg-R0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXQG3-0006vx-34
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXQG2-0006nb-Nz
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:26 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
Date: Thu, 13 Dec 2018 13:38:20 +0100
In-Reply-To: <1544701071-2922-1-git-send-email-liq3ea@gmail.com> (Li Qiang's
	message of "Thu, 13 Dec 2018 03:37:51 -0800")
Message-ID: <87k1kda9fn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Li Qiang <liq3ea@gmail.com> writes:

> Also add diagnostics info in 'qemu_set_cloexec' so that we can know
> what happen when error occurs.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
> Change since v1: add diagnostics info
>  
>  util/oslib-posix.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index c1bee2a581..14cbef1e35 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -38,6 +38,7 @@
>  #include <libgen.h>
>  #include <sys/signal.h>
>  #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>  
>  #ifdef CONFIG_LINUX
>  #include <sys/syscall.h>
> @@ -233,14 +234,32 @@ void qemu_set_block(int fd)
>  {
>      int f;
>      f = fcntl(fd, F_GETFL);
> -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> +    if (f < 0) {
> +        error_report("Unable to get file status flag on fd %d: %s(errno=%d)",
> +                    fd, strerror(errno), errno);
> +        abort();
> +    }
> +    if (fcntl(fd, F_SETFL, f & ~O_NONBLOCK) < 0) {
> +        error_report("Unable to set blocking flag on fd %d: %s(errno=%d)",
> +                    fd, strerror(errno), errno);
> +        abort();
> +    }
>  }

If this is a programming error, i.e. one that can happen only when the
function gets misused, then abort() is appropriate, but error_report()
is putting lipstick on the pig.

If it's not a programming error, but something outside QEMU misbehaves
(user error, network outage, ...), then error_report() is appropriate,
but abort() is not.  exit(1) then.

[...]
