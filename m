Received: from eggs.gnu.org ([2001:4830:134:3::10]:34383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5F0l-0005fP-9N
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5F0k-0001d6-I0
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:53:39 -0400
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<7f741376b50552aa58c943b710fffa3c24f28b2f.1508390588.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <51df0812-0119-412e-6017-935a6c226e3a@redhat.com>
Date: Thu, 19 Oct 2017 19:53:15 +0200
MIME-Version: 1.0
In-Reply-To: <7f741376b50552aa58c943b710fffa3c24f28b2f.1508390588.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 42/46] util: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 19.10.2017 18:18, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 5946ac09f0..29fff51fcf 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -15,6 +15,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "qemu/error-report.h"
>  #include "block/block.h"
>  #include "qemu/rcu_queue.h"
>  #include "qemu/sockets.h"
> @@ -703,8 +704,8 @@ void aio_context_setup(AioContext *ctx)
>  {
>      /* TODO remove this in final patch submission */
>      if (getenv("QEMU_AIO_POLL_MAX_NS")) {
> -        fprintf(stderr, "The QEMU_AIO_POLL_MAX_NS environment variable has "
> -                "been replaced with -object iothread,poll-max-ns=NUM\n");
> +        error_report("The QEMU_AIO_POLL_MAX_NS environment variable has "
> +                "been replaced with -object iothread,poll-max-ns=NUM");
>          exit(1);
>      }

The comment in front of this code block indicates that this should
rather be removed completely. Stefan, do you agree?

> diff --git a/util/error.c b/util/error.c
> index 3efdd69162..e423368ca0 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -32,7 +32,7 @@ Error *error_fatal;
>  static void error_handle_fatal(Error **errp, Error *err)
>  {
>      if (errp == &error_abort) {
> -        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
> +        error_report("Unexpected error in %s() at %s:%d:",
>                  err->func, err->src, err->line);

Indentation is still wrong if the statement spans more than one line :-(

 Thomas
