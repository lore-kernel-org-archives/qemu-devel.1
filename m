Received: from eggs.gnu.org ([2001:4830:134:3::10]:33378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqMzn-00073o-J5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqMzi-0007i2-Kz
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:23:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dqMzi-0007h9-EZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:23:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31A674A6E7
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 17:23:05 +0000 (UTC)
Date: Fri, 8 Sep 2017 18:22:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170908172258.GE2836@work-vm>
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-14-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906115143.27451-14-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 13/22] migration: Split
 migration_fd_process_incoming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We need that on later patches.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

I think this could also go into current qemu?

Dave

> ---
>  migration/migration.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 9fec880a58..18bd24a14c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -372,9 +372,8 @@ static void process_incoming_migration_co(void *opaque)
>      qemu_bh_schedule(mis->bh);
>  }
>  
> -void migration_fd_process_incoming(QEMUFile *f)
> +static void migration_incoming_setup(QEMUFile *f)
>  {
> -    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      if (multifd_load_setup() != 0) {
> @@ -387,9 +386,20 @@ void migration_fd_process_incoming(QEMUFile *f)
>          mis->from_src_file = f;
>      }
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
>  void migration_ioc_process_incoming(QIOChannel *ioc)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -- 
> 2.13.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
