Received: from eggs.gnu.org ([209.51.188.92]:48811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAtUC-0003Pv-Lc
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAtUB-0006u4-J7
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:44:12 -0400
Date: Mon, 1 Apr 2019 10:39:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190401093904.GB3524@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190401082655.8272-1-aruna.15@cse.mrt.ac.lk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190401082655.8272-1-aruna.15@cse.mrt.ac.lk>
Subject: Re: [Qemu-devel] [PATCH 1/2] Header cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Mon, Apr 01, 2019 at 01:56:54PM +0530, Aruna Jayasena wrote:
> Declarations were moved out of qemu-common.h for functions declared in utils/ files.
> This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> 
> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> 
> ---
>  include/qemu-common.h        | 6 ------
>  include/qemu/id.h            | 3 +++
>  include/qemu/iov.h           | 6 ++++++
>  include/qemu/readline.h      | 2 ++
>  util/aio-posix.c             | 1 -
>  util/aio-win32.c             | 1 -
>  util/async.c                 | 1 -
>  util/bufferiszero.c          | 1 -
>  util/compatfd.c              | 1 -
>  util/coroutine-sigaltstack.c | 1 -
>  util/coroutine-ucontext.c    | 1 -
>  util/coroutine-win32.c       | 1 -
>  util/crc32c.c                | 1 -
>  util/cutils.c                | 1 -
>  util/envlist.c               | 1 -
>  util/error.c                 | 1 -
>  util/event_notifier-posix.c  | 1 -
>  util/event_notifier-win32.c  | 1 -
>  util/fifo8.c                 | 1 -
>  util/getauxval.c             | 1 -
>  util/hexdump.c               | 2 +-
>  util/id.c                    | 1 -
>  util/iohandler.c             | 1 -
>  util/iov.c                   | 1 -
>  util/log.c                   | 1 -
>  util/module.c                | 1 -
>  util/notify.c                | 1 -
>  util/qemu-coroutine-io.c     | 1 -
>  util/qemu-coroutine.c        | 1 -
>  util/qemu-openpty.c          | 2 +-
>  util/qemu-option.c           | 1 -
>  util/qemu-progress.c         | 2 +-
>  util/qemu-thread-win32.c     | 1 -
>  util/rcu.c                   | 1 -
>  util/readline.c              | 1 -
>  util/thread-pool.c           | 1 -
>  util/uuid.c                  | 1 -
>  37 files changed, 14 insertions(+), 39 deletions(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index a102245519..9543c469b6 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -141,12 +141,6 @@ int os_parse_cmd_args(int index, const char *optarg);
>  
>  #include "qemu/module.h"
>  
> -/*
> - * Hexdump a buffer to a file. An optional string prefix is added to every line
> - */
> -
> -void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
> -
>  /*
>   * helper to parse debug environment variables
>   */

You forgot to remove

> diff --git a/include/qemu/id.h b/include/qemu/id.h
> index 40c70103e4..3a651fb9d2 100644
> --- a/include/qemu/id.h
> +++ b/include/qemu/id.h
> @@ -1,6 +1,9 @@
>  #ifndef QEMU_ID_H
>  #define QEMU_ID_H
>  
> +#define qemu_isalnum(c)		isalnum((unsigned char)(c))
> +#define qemu_isalpha(c)		isalpha((unsigned char)(c))

If we want to move these, they would be better off living in
include/qemu/cutils.h   You should move *all* of the qemu_is*
functions at the same time, not just 2 lof them & they should
be removed from qemu-common.h.

Ideally you would have multiple commits here, each doing a separate part of
the cleanup.

  1. Move the qemu-hexdump declaration
  2. Move the qemu_is* macros
  3. Remove qemu-common.h from source files which don't need it contents.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
