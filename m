Received: from eggs.gnu.org ([2001:4830:134:3::10]:60874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAbIG-0004UC-ON
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAbI3-0001YB-Ui
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAbHt-0001R0-F1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:46:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-8-fli@suse.com>
Date: Thu, 11 Oct 2018 15:45:53 +0200
In-Reply-To: <20181010120841.13214-8-fli@suse.com> (Fei Li's message of "Wed,
	10 Oct 2018 20:08:41 +0800")
Message-ID: <87sh1c38by.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v5 7/7] qemu_thread_create: propagate
 the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, armbru@redhat.com, famz@redhat.com

Fei Li <fli@suse.com> writes:

> Make qemu_thread_create() return a Boolean to indicate if it succeeds
> rather than failing with an error. And add an Error parameter to hold
> the error message and let the callers handle it.
>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
[...]
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 289af4fab5..3a2a0cb3c1 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -15,6 +15,7 @@
>  #include "qemu/atomic.h"
>  #include "qemu/notify.h"
>  #include "qemu-thread-common.h"
> +#include "qapi/error.h"
>  
>  static bool name_threads;
>  
> @@ -504,9 +505,9 @@ static void *qemu_thread_start(void *args)
>      return start_routine(arg);
>  }
>  
> -void qemu_thread_create(QemuThread *thread, const char *name,
> -                       void *(*start_routine)(void*),
> -                       void *arg, int mode)
> +bool qemu_thread_create(QemuThread *thread, const char *name,
> +                        void *(*start_routine)(void *),
> +                        void *arg, int mode, Error **errp)
>  {
>      sigset_t set, oldset;
>      int err;
> @@ -515,7 +516,8 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>  
>      err = pthread_attr_init(&attr);
>      if (err) {
> -        error_exit(err, __func__);
> +        error_setg(errp, "pthread_attr_init failed: %s", strerror(err));
> +        return false;

The commit message claims this function was "failing with an error".
Not true; error_exit() abort()s.  It exit()ed until commit 53380ac37f2,
v1.0.  The name error_exit() became misleading then.  The bad name is
not this patch's problem, but its commit message needs to be corrected.

>      }
>  
>      if (mode == QEMU_THREAD_DETACHED) {
[...]

I think David Gilbert added the bite-sized task you took on.  David,
please review.
