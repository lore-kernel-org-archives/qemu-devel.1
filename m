Received: from eggs.gnu.org ([2001:4830:134:3::10]:55469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fB1YV-0004iL-F5
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fB1YU-0001PB-1F
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:16:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fB1YT-0001Oo-SW
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:16:37 -0400
Date: Tue, 24 Apr 2018 18:16:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180424171631.GF2521@work-vm>
References: <1524295325-18136-1-git-send-email-wangxinxin.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524295325-18136-1-git-send-email-wangxinxin.wang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] migration/fd: abort migration if receive
 POLLHUP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang Xin <wangxinxin.wang@huawei.com>, berrange@redhat.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, arei.gonglei@huawei.com, peterx@redhat.com

* Wang Xin (wangxinxin.wang@huawei.com) wrote:
> If the fd socket peer closed shortly, ppoll may receive a POLLHUP
> event before the expected POLLIN event, and qemu will do nothing
> but goes into an infinite loop of the POLLHUP event.
> 
> So, abort the migration if we receive a POLLHUP event.

Hi Wang Xin,
  Can you explain how you manage to trigger this case; I've not hit it.

> Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>
> 
> diff --git a/migration/fd.c b/migration/fd.c
> index cd06182..5932c87 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "channel.h"
>  #include "fd.h"
>  #include "monitor/monitor.h"
> @@ -46,6 +47,11 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
>                                               GIOCondition condition,
>                                               gpointer opaque)
>  {
> +    if (condition & G_IO_HUP) {
> +        error_report("The migration peer closed, job abort");
> +        exit(EXIT_FAILURE);
> +    }
> +

OK,  I wish we had a nicer way for failing;  especially for the
multifd/postcopy recovery worlds where one failed connection might not
be fatal; but I don't see how to do that here.

>      migration_channel_process_incoming(ioc);
>      object_unref(OBJECT(ioc));
>      return G_SOURCE_REMOVE;
> @@ -67,7 +73,7 @@ void fd_start_incoming_migration(const char *infd, Error **errp)
>  
>      qio_channel_set_name(QIO_CHANNEL(ioc), "migration-fd-incoming");
>      qio_channel_add_watch(ioc,
> -                          G_IO_IN,
> +                          G_IO_IN | G_IO_HUP,
>                            fd_accept_incoming_migration,
>                            NULL,
>                            NULL);

Dave

> -- 
> 2.8.1.windows.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
