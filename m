Received: from eggs.gnu.org ([2001:4830:134:3::10]:56598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eS0QA-0002Zk-Kq
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eS0Q7-00025W-ET
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:57:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eS0Q7-000258-7A
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:57:55 -0500
Date: Thu, 21 Dec 2017 20:57:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171221125745.GT10812@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-24-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-24-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 23/27] monitor: enable IO thread for (qmp
 & !mux) typed
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
> Start to use dedicate IO thread for QMP monitors that are not using
> MUXed chardev.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 0c6403bc65..7183061c2b 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -35,6 +35,7 @@
>  #include "net/net.h"
>  #include "net/slirp.h"
>  #include "chardev/char-fe.h"
> +#include "chardev/char-mux.h"
>  #include "ui/qemu-spice.h"
>  #include "sysemu/numa.h"
>  #include "monitor/monitor.h"
> @@ -4522,8 +4523,10 @@ void monitor_init(Chardev *chr, int flags)
>  {
>      Monitor *mon = g_malloc(sizeof(*mon));
>      GMainContext *context;
> +    /* Enable IOThread for QMPs that are not using MUX chardev backends. */
> +    bool use_io_thr = (!CHARDEV_IS_MUX(chr)) && (flags & MONITOR_USE_CONTROL);
>  
> -    monitor_data_init(mon, false, false);
> +    monitor_data_init(mon, false, use_io_thr);
>  
>      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
>      mon->flags = flags;
> -- 
> 2.14.3
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
