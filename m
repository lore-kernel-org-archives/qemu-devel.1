Received: from eggs.gnu.org ([2001:4830:134:3::10]:46560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3LVy-0007oq-OD
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3LVv-0003qE-NR
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:53:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3LVv-0003pu-Gg
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:53:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C04885541
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 11:53:42 +0000 (UTC)
Date: Wed, 26 Apr 2017 19:53:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170426115331.GA26792@pxdev.xzpeter.org>
References: <20170425101758.3944-1-quintela@redhat.com>
	<20170425101758.3944-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170425101758.3944-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: to_dst_file at that point
 is NULL
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

On Tue, Apr 25, 2017 at 12:17:58PM +0200, Juan Quintela wrote:
> We have just arrived as:
> 
> migration.c: qemu_migrate()
>   ....
>   s = migrate_init() <- puts it to NULL
>   ....
>   {tcp,unix}_start_outgoing_migration ->
>      socket_outgoing_migration
>         migration_channel_connect()
> 	   sets to_dst_file
> 
> if tls is enabled, we do another round through
> migrate_channel_tls_connect(), but we only set it up if there is no
> error.  So we don't need the assignation.  I am removing it to remove
> in the follwing patches the knowledge about MigrationState in that two
> files.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/socket.c | 1 -
>  migration/tls.c    | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/migration/socket.c b/migration/socket.c
> index 13966f1..dc88812 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -79,7 +79,6 @@ static void socket_outgoing_migration(QIOTask *task,
>  
>      if (qio_task_propagate_error(task, &err)) {
>          trace_migration_socket_outgoing_error(error_get_pretty(err));
> -        data->s->to_dst_file = NULL;
>          migrate_fd_error(data->s, err);
>          error_free(err);
>      } else {
> diff --git a/migration/tls.c b/migration/tls.c
> index 45bec44..a33ecb7 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -116,7 +116,6 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>  
>      if (qio_task_propagate_error(task, &err)) {
>          trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
> -        s->to_dst_file = NULL;
>          migrate_fd_error(s, err);
>          error_free(err);
>      } else {
> -- 
> 2.9.3
> 

-- 
Peter Xu
