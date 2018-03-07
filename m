Received: from eggs.gnu.org ([2001:4830:134:3::10]:59471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etagm-0003Z3-J9
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etagi-0006yZ-NL
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:09:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1etagi-0006yM-IQ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:09:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40ABA8182D0C
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 15:09:04 +0000 (UTC)
Date: Wed, 7 Mar 2018 15:08:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180307150858.GG3089@work-vm>
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-11-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307110010.2205-11-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 10/24] migration: In case of error just
 end the migration
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>

It's probably worth keeping an eye on what happens in the case
of Peter's postcopy recovery where a new incoming connection
happens later.

Dave

> ---
>  migration/socket.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/socket.c b/migration/socket.c
> index 08606c665d..b12b0a462e 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -139,9 +139,8 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>      sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
>                                       &err);
>      if (!sioc) {
> -        error_report("could not accept migration connection (%s)",
> -                     error_get_pretty(err));
> -        goto out;
> +        migrate_set_error(migrate_get_current(), err);
> +        return G_SOURCE_REMOVE;
>      }
>  
>      trace_migration_socket_incoming_accepted();
> @@ -150,7 +149,6 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>      migration_channel_process_incoming(QIO_CHANNEL(sioc));
>      object_unref(OBJECT(sioc));
>  
> -out:
>      if (migration_has_all_channels()) {
>          /* Close listening socket as its no longer needed */
>          qio_channel_close(ioc, NULL);
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
