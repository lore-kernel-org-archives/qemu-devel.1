Received: from eggs.gnu.org ([2001:4830:134:3::10]:55765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx9TY-0007iH-DE
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx9TU-0001xI-Hb
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:26:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52126 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fx9TU-0001wn-BO
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:26:24 -0400
Date: Tue, 4 Sep 2018 12:26:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180904112620.GG22349@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-2-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180904110822.12863-2-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org

On Tue, Sep 04, 2018 at 07:08:18PM +0800, Fei Li wrote:
> Currently, when qemu_signal_init() fails it only returns a non-zero
> value but without propagating any Error. But its callers need a
> non-null err when runs error_report_err(err), or else 0->msg occurs.
> 
> To avoid such segmentation fault, add a new Error parameter to make
> the call trace to propagate the err to the final caller.
> 
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  include/qemu/osdep.h |  2 +-
>  util/compatfd.c      | 17 ++++++++++++-----
>  util/main-loop.c     | 11 +++++++----
>  3 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index a91068df0e..09ed85fcb8 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -421,7 +421,7 @@ struct qemu_signalfd_siginfo {
>                               additional fields in the future) */
>  };
>  
> -int qemu_signalfd(const sigset_t *mask);
> +int qemu_signalfd(const sigset_t *mask, Error **errp);
>  void sigaction_invoke(struct sigaction *action,
>                        struct qemu_signalfd_siginfo *info);
>  #endif
> diff --git a/util/compatfd.c b/util/compatfd.c
> index 980bd33e52..65501de622 100644
> --- a/util/compatfd.c
> +++ b/util/compatfd.c
> @@ -16,6 +16,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/thread.h"
> +#include "qapi/error.h"
>  
>  #include <sys/syscall.h>
>  
> @@ -65,7 +66,7 @@ static void *sigwait_compat(void *opaque)
>      }
>  }
>  
> -static int qemu_signalfd_compat(const sigset_t *mask)
> +static int qemu_signalfd_compat(const sigset_t *mask, Error **errp)
>  {
>      struct sigfd_compat_info *info;
>      QemuThread thread;
> @@ -73,11 +74,13 @@ static int qemu_signalfd_compat(const sigset_t *mask)
>  
>      info = malloc(sizeof(*info));
>      if (info == NULL) {
> +        error_setg(errp, "Failed to malloc in %s", __func__);

I'd avoid using __func__ in error messages. Instead

   "Failed to allocate signalfd memory"

>          errno = ENOMEM;
>          return -1;
>      }
>  
>      if (pipe(fds) == -1) {
> +        error_setg(errp, "Failed to create a pipe in %s", __func__);

    "Failed to create signalfd pipe"

>          free(info);
>          return -1;
>      }
> @@ -94,17 +97,21 @@ static int qemu_signalfd_compat(const sigset_t *mask)
>      return fds[0];
>  }
>  
> -int qemu_signalfd(const sigset_t *mask)
> +int qemu_signalfd(const sigset_t *mask, Error **errp)
>  {
> -#if defined(CONFIG_SIGNALFD)
>      int ret;
> +    Error *local_err = NULL;
>  
> +#if defined(CONFIG_SIGNALFD)
>      ret = syscall(SYS_signalfd, -1, mask, _NSIG / 8);
>      if (ret != -1) {
>          qemu_set_cloexec(ret);
>          return ret;
>      }
>  #endif
> -
> -    return qemu_signalfd_compat(mask);
> +    ret = qemu_signalfd_compat(mask, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }

Using a local_err is not required - you can just pass errp stright
to qemu_signalfd_compat() and then check

   if (ret < 0)

> +    return ret;
>  }
> diff --git a/util/main-loop.c b/util/main-loop.c
> index affe0403c5..20f6ad3849 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -71,10 +71,11 @@ static void sigfd_handler(void *opaque)
>      }
>  }
>  
> -static int qemu_signal_init(void)
> +static int qemu_signal_init(Error **errp)
>  {
>      int sigfd;
>      sigset_t set;
> +    Error *local_err = NULL;
>  
>      /*
>       * SIG_IPI must be blocked in the main thread and must not be caught
> @@ -94,9 +95,10 @@ static int qemu_signal_init(void)
>      pthread_sigmask(SIG_BLOCK, &set, NULL);
>  
>      sigdelset(&set, SIG_IPI);
> -    sigfd = qemu_signalfd(&set);
> +    sigfd = qemu_signalfd(&set, &local_err);
>      if (sigfd == -1) {
>          fprintf(stderr, "failed to create signalfd\n");
> +        error_propagate(errp, local_err);
>          return -errno;
>      }

Again, no need for local_err - just pass errp stright in

>  
> @@ -109,7 +111,7 @@ static int qemu_signal_init(void)
>  
>  #else /* _WIN32 */
>  
> -static int qemu_signal_init(void)
> +static int qemu_signal_init(Error **errp)
>  {
>      return 0;
>  }
> @@ -148,8 +150,9 @@ int qemu_init_main_loop(Error **errp)
>  
>      init_clocks(qemu_timer_notify_cb);
>  
> -    ret = qemu_signal_init();
> +    ret = qemu_signal_init(&local_error);
>      if (ret) {
> +        error_propagate(errp, local_error);
>          return ret;
>      }

Again, no need for local_error.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
