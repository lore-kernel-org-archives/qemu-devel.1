Received: from eggs.gnu.org ([2001:4830:134:3::10]:39035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg1fN-0004Tq-Hj
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 00:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg1fK-00066L-S4
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 00:35:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dg1fK-000657-Iv
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 00:35:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 341AE29B5F2
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 04:35:17 +0000 (UTC)
Date: Fri, 11 Aug 2017 12:35:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170811043512.GH26015@pxdev.xzpeter.org>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-16-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-16-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 15/19] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Tue, Aug 08, 2017 at 06:26:25PM +0200, Juan Quintela wrote:
> We make the locking and the transfer of information specific, even if we
> are still receiving things through the main thread.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> We split when we create the main channel and where we start the main
> migration thread, so we wait for the creation of the other threads.
> 
> Use multifd_clear_group().
> ---
>  migration/migration.c |  7 ++++---
>  migration/migration.h |  1 +
>  migration/ram.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
>  migration/socket.c    |  2 +-
>  4 files changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8e9505a..b78dffc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -381,7 +381,7 @@ static void migration_incoming_setup(QEMUFile *f)
>      qemu_file_set_blocking(f, false);
>  }
>  
> -static void migration_incoming_process(void)
> +void migration_incoming_process(void)
>  {
>      Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
>      qemu_coroutine_enter(co);
> @@ -400,9 +400,10 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
>      if (!mis->from_src_file) {
>          QEMUFile *f = qemu_fopen_channel_input(ioc);
>          mis->from_src_file = f;
> -        migration_fd_process_incoming(f);
> +        migration_incoming_setup(f);

Here now we only setup the incoming channels, but not processing it
any more. Then would it be good we rename the function name as well?
The old "migration_ioc_process_incoming" has hints that it processed
something... And...

> +        return;
>      }
> -    /* We still only have a single channel.  Nothing to do here yet */
> +    multifd_new_channel(ioc);
>  }

[...]

> @@ -183,12 +183,12 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>  
>      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
>      migration_channel_process_incoming(QIO_CHANNEL(sioc));
> -    object_unref(OBJECT(sioc));
>  
>  out:
>      if (migration_has_all_channels()) {
>          /* Close listening socket as its no longer needed */
>          qio_channel_close(ioc, NULL);
> +        migration_incoming_process();

... here we only added migration_incoming_process() for sockets. Would
that break fd/exec migration?

Thanks,

>          return G_SOURCE_REMOVE;
>      } else {
>          return G_SOURCE_CONTINUE;

-- 
Peter Xu
