Received: from eggs.gnu.org ([2001:4830:134:3::10]:37760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eIBkI-0002gK-5v
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eIBkD-00017t-Jq
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:02:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eIBkD-00013m-DA
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:02:05 -0500
Date: Fri, 24 Nov 2017 11:01:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171124110149.GC2302@work-vm>
References: <20171116130610.23582-1-peterx@redhat.com>
	<20171116130610.23582-24-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171116130610.23582-24-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 23/27] monitor: enable IO thread for (qmp
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> Start to use dedicate IO thread for QMP monitors that are not using
> MUXed chardev.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I guess another way to do this would be to have a property on the
Chardev something like 'can use iothread' and clear that for Mux.

Dave

> ---
>  monitor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor.c b/monitor.c
> index b18d9d696c..5e0b8ed9c5 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -36,6 +36,7 @@
>  #include "net/net.h"
>  #include "net/slirp.h"
>  #include "chardev/char-fe.h"
> +#include "chardev/char-mux.h"
>  #include "ui/qemu-spice.h"
>  #include "sysemu/numa.h"
>  #include "monitor/monitor.h"
> @@ -4456,7 +4457,7 @@ void monitor_init(Chardev *chr, int flags)
>      Monitor *mon = g_malloc(sizeof(*mon));
>      GMainContext *context;
>  
> -    monitor_data_init(mon, false, false);
> +    monitor_data_init(mon, false, !CHARDEV_IS_MUX(chr));
>  
>      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
>      mon->flags = flags;
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
