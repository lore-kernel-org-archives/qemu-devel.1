Received: from eggs.gnu.org ([2001:4830:134:3::10]:45310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRz0w-0000pi-D6
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRz0t-0006RB-6v
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:27:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRz0s-0006P6-Uw
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:27:47 -0500
Date: Thu, 21 Dec 2017 19:27:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171221112738.GL10812@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-16-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-16-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 15/27] monitor: let suspend/resume work
 even with QMPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 12/19 16:45, Peter Xu wrote:
> One thing to mention is that for QMPs that are using IOThreads, we need
> an explicit kick for the IOThread in case it is sleeping.
> 
> Since at it, add traces for the operations.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c    | 26 +++++++++++++++++++++-----
>  trace-events |  1 +
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 844508d134..5f05f2e9da 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3992,19 +3992,35 @@ static void monitor_command_cb(void *opaque, const char *cmdline,
>  
>  int monitor_suspend(Monitor *mon)
>  {
> -    if (!mon->rs)
> -        return -ENOTTY;

Please add to the commit message why the mon->rs check is dropped, for this and
the other one.

Fam

>      atomic_inc(&mon->suspend_cnt);
> +    if (monitor_is_qmp(mon)) {
> +        /*
> +         * Kick iothread to make sure this takes effect.  It'll be
> +         * evaluated again in prepare() of the watch object.
> +         */
> +        aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
> +    }
> +    trace_monitor_suspend(mon, 1);
>      return 0;
>  }
>  
>  void monitor_resume(Monitor *mon)
>  {
> -    if (!mon->rs)
> -        return;
>      if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
> -        readline_show_prompt(mon->rs);
> +        if (monitor_is_qmp(mon)) {
> +            /*
> +             * For QMP monitors that are running in IOThread, let's
> +             * kick the thread in case it's sleeping.
> +             */
> +            if (mon->use_io_thr) {
> +                aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
> +            }
> +        } else {
> +            assert(mon->rs);
> +            readline_show_prompt(mon->rs);
> +        }
>      }
> +    trace_monitor_suspend(mon, -1);
>  }
>  
>  static QObject *get_qmp_greeting(Monitor *mon)
> diff --git a/trace-events b/trace-events
> index 1d2eb5d3e4..2646241a0f 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -47,6 +47,7 @@ monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
>  monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
>  handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
>  handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
> +monitor_suspend(void *ptr, int cnt) "mon %p: %d"
>  
>  # dma-helpers.c
>  dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
> -- 
> 2.14.3
> 
