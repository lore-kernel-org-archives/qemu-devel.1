Received: from eggs.gnu.org ([2001:4830:134:3::10]:55928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d2zlD-0001xG-CS
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d2zl9-0005eT-U2
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:40:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d2zl9-0005eF-NL
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:39:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99EA1C04BD2E
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 12:39:57 +0000 (UTC)
References: <20170425101758.3944-1-quintela@redhat.com>
	<20170425101758.3944-3-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <a338b667-31cf-8a49-7463-8efc8be7c009@redhat.com>
Date: Tue, 25 Apr 2017 14:39:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170425101758.3944-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 25/04/2017 12:17, Juan Quintela wrote:
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
> 

In migrate_fd_error(), we have "assert(s->to_dst_file == NULL);", so you
break the function with this change.

Laurent
