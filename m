Received: from eggs.gnu.org ([2001:4830:134:3::10]:44246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g00DZ-0004cz-0G
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzzzT-00057f-98
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:55:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fzzzT-000573-22
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:55:11 -0400
Date: Wed, 12 Sep 2018 15:55:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180912075508.GD2526@lemon.usersys.redhat.com>
References: <20180907133902.28462-1-fli@suse.com>
	<20180907133902.28462-2-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907133902.28462-2-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] Fix segmentation fault when
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
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, eblake@redhat.com

On Fri, 09/07 21:38, Fei Li wrote:
> Currently, when qemu_signal_init() fails it only returns a non-zero
> value but without propagating any Error. But its callers need a
> non-null err when runs error_report_err(err), or else 0->msg occurs.
> 
> To avoid such segmentation fault, add a new Error parameter to make
> the call trace to propagate the err to the final caller.
> 
> This patch also adds the omitted error handling when creating signalfd
> pipe fails in qemu_signalfd_compat().
> 
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  include/qemu/osdep.h |  2 +-
>  util/compatfd.c      |  9 ++++++---
>  util/main-loop.c     | 10 +++++-----
>  3 files changed, 12 insertions(+), 9 deletions(-)
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
> index 980bd33e52..d3ed890405 100644
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
> +        error_setg(errp, "Failed to allocate signalfd memory");
>          errno = ENOMEM;
>          return -1;
>      }
>  
>      if (pipe(fds) == -1) {
> +        error_setg(errp, "Failed to create signalfd pipe");
>          free(info);
>          return -1;
>      }
> @@ -94,7 +97,7 @@ static int qemu_signalfd_compat(const sigset_t *mask)
>      return fds[0];
>  }
>  
> -int qemu_signalfd(const sigset_t *mask)
> +int qemu_signalfd(const sigset_t *mask, Error **errp)
>  {
>  #if defined(CONFIG_SIGNALFD)
>      int ret;

Extend the context:

       ret = syscall(SYS_signalfd, -1, mask, _NSIG / 8);
       if (ret != -1) {
           qemu_set_cloexec(ret);
           return ret;
       }

This error path need error_setg() as well.

> @@ -106,5 +109,5 @@ int qemu_signalfd(const sigset_t *mask)
>      }
>  #endif
>  
> -    return qemu_signalfd_compat(mask);
> +    return qemu_signalfd_compat(mask, errp);
>  }
> diff --git a/util/main-loop.c b/util/main-loop.c
> index affe0403c5..22aa2b1007 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -71,7 +71,7 @@ static void sigfd_handler(void *opaque)
>      }
>  }
>  
> -static int qemu_signal_init(void)
> +static int qemu_signal_init(Error **errp)
>  {
>      int sigfd;
>      sigset_t set;
> @@ -94,10 +94,10 @@ static int qemu_signal_init(void)
>      pthread_sigmask(SIG_BLOCK, &set, NULL);
>  
>      sigdelset(&set, SIG_IPI);
> -    sigfd = qemu_signalfd(&set);
> +    sigfd = qemu_signalfd(&set, errp);
>      if (sigfd == -1) {
>          fprintf(stderr, "failed to create signalfd\n");

This fprintf is not needed any more.

> -        return -errno;
> +        return -1;
>      }
>  
>      fcntl_setfl(sigfd, O_NONBLOCK);
> @@ -109,7 +109,7 @@ static int qemu_signal_init(void)
>  
>  #else /* _WIN32 */
>  
> -static int qemu_signal_init(void)
> +static int qemu_signal_init(Error **errp)
>  {
>      return 0;
>  }
> @@ -148,7 +148,7 @@ int qemu_init_main_loop(Error **errp)
>  
>      init_clocks(qemu_timer_notify_cb);
>  
> -    ret = qemu_signal_init();
> +    ret = qemu_signal_init(errp);
>      if (ret) {
>          return ret;
>      }
> -- 
> 2.13.7
> 

Fam
