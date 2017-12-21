Received: from eggs.gnu.org ([2001:4830:134:3::10]:38427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRuCF-0006D4-LM
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 01:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRuCA-0002Ny-Q9
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 01:19:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRuCA-0002MZ-HP
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 01:19:06 -0500
Date: Thu, 21 Dec 2017 14:18:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171221061859.GH10812@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-10-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 09/27] monitor: create monitor dedicate
 iothread
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
> Create one IOThread for the monitors, prepared to handle all the
> input/output IOs using existing iothread framework.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/monitor.c b/monitor.c
> index 95fc54d97f..4ebd83fd94 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -75,6 +75,7 @@
>  #include "qmp-introspect.h"
>  #include "sysemu/qtest.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/iothread.h"
>  #include "qemu/cutils.h"
>  #include "qapi/qmp/dispatch.h"
>  
> @@ -207,6 +208,11 @@ struct Monitor {
>      QTAILQ_ENTRY(Monitor) entry;
>  };
>  
> +/* Let's add monitor global variables to this struct. */
> +static struct {
> +    IOThread *mon_iothread;
> +} mon_global;
> +
>  /* QMP checker flags */
>  #define QMP_ACCEPT_UNKNOWNS 1
>  
> @@ -4034,12 +4040,24 @@ static void sortcmdlist(void)
>      qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
>  }
>  
> +static GMainContext *monitor_io_context_get(void)
> +{
> +    return iothread_get_g_main_context(mon_global.mon_iothread);
> +}
> +
> +static void monitor_iothread_init(void)
> +{
> +    mon_global.mon_iothread = iothread_create("mon_iothread",
> +                                              &error_abort);
> +}
> +
>  void monitor_init_globals(void)
>  {
>      monitor_init_qmp_commands();
>      monitor_qapi_event_init();
>      sortcmdlist();
>      qemu_mutex_init(&monitor_lock);
> +    monitor_iothread_init();
>  }
>  
>  /* These functions just adapt the readline interface in a typesafe way.  We
> @@ -4117,6 +4135,14 @@ void monitor_cleanup(void)
>  {
>      Monitor *mon, *next;
>  
> +    /*
> +     * We need to explicitly stop the iothread (but not destroy it),
> +     * cleanup the monitor resources, then destroy the iothread since
> +     * we need to unregister from chardev below in
> +     * monitor_data_destroy(), and chardev is not thread-safe yet
> +     */
> +    iothread_stop(mon_global.mon_iothread);
> +
>      qemu_mutex_lock(&monitor_lock);
>      QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
>          QTAILQ_REMOVE(&mon_list, mon, entry);
> @@ -4124,6 +4150,9 @@ void monitor_cleanup(void)
>          g_free(mon);
>      }
>      qemu_mutex_unlock(&monitor_lock);
> +
> +    iothread_destroy(mon_global.mon_iothread);
> +    mon_global.mon_iothread = NULL;
>  }
>  
>  QemuOptsList qemu_mon_opts = {
> -- 
> 2.14.3
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
