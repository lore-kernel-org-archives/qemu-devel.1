Received: from eggs.gnu.org ([2001:4830:134:3::10]:37186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXsSk-0004gR-2C
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXsSf-00034m-1S
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXsSe-00034F-RZ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:08:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8ACD010D4FA
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 17:08:31 +0000 (UTC)
Date: Wed, 19 Jul 2017 18:08:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170719170825.GI3500@work-vm>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-9-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 08/17] migration: Split
 migration_fd_process_incomming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We need that on posterior patches.

following/subsequent/later is probably a better word.

other than that;


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5a82c1c..b81c498 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -356,19 +356,31 @@ static void process_incoming_migration_co(void *opaque)
>      qemu_bh_schedule(mis->bh);
>  }
>  
> -void migration_fd_process_incoming(QEMUFile *f)
> +static void migration_incoming_setup(QEMUFile *f)
>  {
> -    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
> +    MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      if (multifd_load_setup() != 0) {
>          /* We haven't been able to create multifd threads
>             nothing better to do */
>          exit(EXIT_FAILURE);
>      }
> +    mis->from_src_file = f;
>      qemu_file_set_blocking(f, false);
> +}
> +
> +static void migration_incoming_process(void)
> +{
> +    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
>      qemu_coroutine_enter(co);
>  }
>  
> +void migration_fd_process_incoming(QEMUFile *f)
> +{
> +    migration_incoming_setup(f);
> +    migration_incoming_process();
> +}
> +
>  gboolean migration_ioc_process_incoming(QIOChannel *ioc)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
