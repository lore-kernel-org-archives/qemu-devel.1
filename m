Received: from eggs.gnu.org ([2001:4830:134:3::10]:49786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY9MP-0007cC-Tk
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY9MK-0002P1-TL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:11:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dY9MK-0002Ol-JV
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:11:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4627A2FFC56
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 11:11:07 +0000 (UTC)
Date: Thu, 20 Jul 2017 19:10:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170720111059.GA878@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-15-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-15-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 14/17] migration: Delay the start of
 reception on main channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, berrange@redhat.com

On Mon, Jul 17, 2017 at 03:42:35PM +0200, Juan Quintela wrote:
> When we start multifd, we will want to delay the main channel until
> the others are created.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index d9d5415..e122684 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -358,14 +358,11 @@ static void process_incoming_migration_co(void *opaque)
>  
>  static void migration_incoming_setup(QEMUFile *f)
>  {
> -    MigrationIncomingState *mis = migration_incoming_get_current();
> -
>      if (multifd_load_setup() != 0) {
>          /* We haven't been able to create multifd threads
>             nothing better to do */
>          exit(EXIT_FAILURE);
>      }
> -    mis->from_src_file = f;

Shall we keep this, and ...

>      qemu_file_set_blocking(f, false);
>  }
>  
> @@ -384,18 +381,26 @@ void migration_fd_process_incoming(QEMUFile *f)
>  gboolean migration_ioc_process_incoming(QIOChannel *ioc)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> +    gboolean result = FALSE;
>  
>      if (!mis->from_src_file) {
>          QEMUFile *f = qemu_fopen_channel_input(ioc);
>          mis->from_src_file = f;

... remove this instead?  I am not sure, but looks like RDMA is still
using migration_fd_process_incoming():

rdma_accept_incoming_migration
  migration_fd_process_incoming
    migration_incoming_setup
    migration_incoming_process
      process_incoming_migration_co <-- here we'll use from_src_file
                                        while it's not inited?

> -        migration_fd_process_incoming(f);
> -        if (!migrate_use_multifd()) {
> -            return FALSE;
> -        } else {
> -            return TRUE;
> +        migration_incoming_setup(f);
> +        if (migrate_use_multifd()) {
> +            result = TRUE;
>          }
> +    } else {
> +        /* we can only arrive here if multifd is on
> +           and this is a new channel */
> +        result = multifd_new_channel(ioc);
>      }
> -    return multifd_new_channel(ioc);
> +    if (result == FALSE) {
> +        /* called when !multifd and for last multifd channel */
> +        migration_incoming_process();
> +    }
> +
> +    return result;

-- 
Peter Xu
