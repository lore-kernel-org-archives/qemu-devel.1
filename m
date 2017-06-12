Received: from eggs.gnu.org ([2001:4830:134:3::10]:49375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKMC6-0006Hv-7t
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKMC3-0004zQ-2w
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:03:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dKMC2-0004xG-QU
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:03:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4A793B71F
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 10:03:28 +0000 (UTC)
References: <20170601212921.30241-1-quintela@redhat.com>
	<20170601212921.30241-2-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d7fb3a8f-9aa2-6c09-5ee0-ebf41c8ce65d@redhat.com>
Date: Mon, 12 Jun 2017 12:03:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170601212921.30241-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/11] migration: Remove MigrationState
 from migration_channel_incomming()
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

On 01/06/2017 23:29, Juan Quintela wrote:
> All callers were calling migrate_get_current(), so do it inside the function.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  migration/channel.c | 5 +++--
>  migration/channel.h | 3 +--
>  migration/exec.c    | 2 +-
>  migration/fd.c      | 2 +-
>  migration/socket.c  | 3 +--
>  migration/tls.c     | 2 +-
>  6 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index eae1d9e..92f6f99 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -19,9 +19,10 @@
>  #include "qapi/error.h"
>  #include "io/channel-tls.h"
>  
> -void migration_channel_process_incoming(MigrationState *s,
> -                                        QIOChannel *ioc)
> +void migration_channel_process_incoming(QIOChannel *ioc)
>  {
> +    MigrationState *s = migrate_get_current();
> +
>      trace_migration_set_incoming_channel(
>          ioc, object_get_typename(OBJECT(ioc)));
>  
> diff --git a/migration/channel.h b/migration/channel.h
> index 2e0a7e3..e4b4057 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -18,8 +18,7 @@
>  
>  #include "io/channel.h"
>  
> -void migration_channel_process_incoming(MigrationState *s,
> -                                        QIOChannel *ioc);
> +void migration_channel_process_incoming(QIOChannel *ioc);
>  
>  void migration_channel_connect(MigrationState *s,
>                                 QIOChannel *ioc,
> diff --git a/migration/exec.c b/migration/exec.c
> index 9077024..fc78eeb 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -49,7 +49,7 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
>                                                 GIOCondition condition,
>                                                 gpointer opaque)
>  {
> -    migration_channel_process_incoming(migrate_get_current(), ioc);
> +    migration_channel_process_incoming(ioc);
>      object_unref(OBJECT(ioc));
>      return FALSE; /* unregister */
>  }
> diff --git a/migration/fd.c b/migration/fd.c
> index 0077a50..8a04dcd 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -49,7 +49,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
>                                               GIOCondition condition,
>                                               gpointer opaque)
>  {
> -    migration_channel_process_incoming(migrate_get_current(), ioc);
> +    migration_channel_process_incoming(ioc);
>      object_unref(OBJECT(ioc));
>      return FALSE; /* unregister */
>  }
> diff --git a/migration/socket.c b/migration/socket.c
> index 85bfdcc..50dc8d8 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -148,8 +148,7 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>      trace_migration_socket_incoming_accepted();
>  
>      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
> -    migration_channel_process_incoming(migrate_get_current(),
> -                                       QIO_CHANNEL(sioc));
> +    migration_channel_process_incoming(QIO_CHANNEL(sioc));
>      object_unref(OBJECT(sioc));
>  
>  out:
> diff --git a/migration/tls.c b/migration/tls.c
> index bae9aca..d3abd6e 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -74,7 +74,7 @@ static void migration_tls_incoming_handshake(QIOTask *task,
>          error_report_err(err);
>      } else {
>          trace_migration_tls_incoming_handshake_complete();
> -        migration_channel_process_incoming(migrate_get_current(), ioc);
> +        migration_channel_process_incoming(ioc);
>      }
>      object_unref(OBJECT(ioc));
>  }
> 
