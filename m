Received: from eggs.gnu.org ([2001:4830:134:3::10]:41866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fY9WD-0004Xp-IS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fY9WA-00024g-EB
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:25:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44350 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fY9WA-00023t-95
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:25:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E154C77888
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:25:49 +0000 (UTC)
Date: Wed, 27 Jun 2018 13:25:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180627122544.GG2423@work-vm>
References: <20180627105112.31401-1-peterx@redhat.com>
	<20180627105112.31401-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627105112.31401-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration: do explicit incoming
 setup for rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> RDMA does not support postcopy recovery, so no need to go into such
> logic.  Instead of calling migration_fd_process_incoming(), let's call
> the two functions that setup the incoming migration.  There should have
> no functional change at all.

Can you explain why we need to though?  The reason I ask is that there
is Lidong Chen's work that gets postcopy partially working with RDMA, so
then the next question is bound to be recovery.

Dave

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 8bd7159059..217cdd7dd8 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3687,7 +3687,8 @@ static void rdma_accept_incoming_migration(void *opaque)
>      }
>  
>      rdma->migration_started_on_destination = 1;
> -    migration_fd_process_incoming(f);
> +    migration_incoming_setup(f);
> +    migration_incoming_process();
>  }
>  
>  void rdma_start_incoming_migration(const char *host_port, Error **errp)
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
