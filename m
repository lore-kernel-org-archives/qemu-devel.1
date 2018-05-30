Received: from eggs.gnu.org ([2001:4830:134:3::10]:42808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fO7dW-0003AG-BP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fO7dV-0005Zl-BO
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:23:58 -0400
Date: Wed, 30 May 2018 16:23:32 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180530202332.GA12428@localhost.localdomain>
References: <20180530194238.22774-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530194238.22774-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] main-loop: drop spin_counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, May 30, 2018 at 08:42:38PM +0100, Stefan Hajnoczi wrote:
> Commit d759c951f3287fad04210a52f2dc93f94cf58c7f ("replay: push
> replay_mutex_lock up the call tree") removed the !timeout lock
> optimization in the main loop.
> 
> The idea of the optimization was to avoid ping-pongs between threads by
> keeping the Big QEMU Lock held across non-blocking (!timeout) main loop
> iterations.
> 
> A warning is printed when the main loop spins without releasing BQL for
> long periods of time.  These warnings were supposed to aid debugging but
> in practice they just alarm users.  They are considered noise because
> the cause of spinning is not shown and is hard to find.
> 
> Now that the lock optimization has been removed, there is no danger of
> hogging the BQL.  Drop the spin counter and the infamous warning.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/main-loop.c                 | 25 -------------------------
>  tests/qemu-iotests/common.filter |  1 -
>  2 files changed, 26 deletions(-)
> 
> diff --git a/util/main-loop.c b/util/main-loop.c
> index 992f9b0f34..affe0403c5 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -222,36 +222,11 @@ static int os_host_main_loop_wait(int64_t timeout)
>  {
>      GMainContext *context = g_main_context_default();
>      int ret;
> -    static int spin_counter;
>  
>      g_main_context_acquire(context);
>  
>      glib_pollfds_fill(&timeout);
>  
> -    /* If the I/O thread is very busy or we are incorrectly busy waiting in
> -     * the I/O thread, this can lead to starvation of the BQL such that the
> -     * VCPU threads never run.  To make sure we can detect the later case,
> -     * print a message to the screen.  If we run into this condition, create
> -     * a fake timeout in order to give the VCPU threads a chance to run.
> -     */
> -    if (!timeout && (spin_counter > MAX_MAIN_LOOP_SPIN)) {
> -        static bool notified;
> -
> -        if (!notified && !qtest_enabled() && !qtest_driver()) {
> -            warn_report("I/O thread spun for %d iterations",
> -                        MAX_MAIN_LOOP_SPIN);
> -            notified = true;
> -        }
> -
> -        timeout = SCALE_MS;
> -    }
> -
> -
> -    if (timeout) {
> -        spin_counter = 0;
> -    } else {
> -        spin_counter++;
> -    }
>      qemu_mutex_unlock_iothread();
>      replay_mutex_unlock();
>  
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index f08ee55046..2031e353a5 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -77,7 +77,6 @@ _filter_qemu()
>  {
>      sed -e "s#\\(^\\|(qemu) \\)$(basename $QEMU_PROG):#\1QEMU_PROG:#" \
>          -e 's#^QEMU [0-9]\+\.[0-9]\+\.[0-9]\+ monitor#QEMU X.Y.Z monitor#' \
> -        -e '/main-loop: WARNING: I\/O thread spun for [0-9]\+ iterations/d' \
>          -e $'s#\r##' # QEMU monitor uses \r\n line endings
>  }
>  
> -- 
> 2.17.0
> 
> 

Happy to see this go!

Reviewed-by: Jeff Cody <jcody@redhat.com>
