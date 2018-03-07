Received: from eggs.gnu.org ([2001:4830:134:3::10]:44255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXgA-00011t-5Q
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXg7-0004SO-3a
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:56:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etXg6-0004SI-VS
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:56:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C5FE80AD211
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:56:14 +0000 (UTC)
Date: Wed, 7 Mar 2018 11:56:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307115611.GO20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307110010.2205-13-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 12/24] migration: Reference counting
 recv channels correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Mar 07, 2018 at 11:59:58AM +0100, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/socket.c | 11 +++++++++++
>  migration/socket.h |  7 +++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/migration/socket.c b/migration/socket.c
> index b12b0a462e..26110739cf 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -27,6 +27,17 @@
>  #include "io/channel-socket.h"
>  #include "trace.h"
>  
> +int socket_recv_channel_ref(QIOChannel *recv)
> +{
> +    object_ref(OBJECT(recv));
> +    return 0;
> +}
> +
> +int socket_recv_channel_unref(QIOChannel *recv)
> +{
> +    object_unref(OBJECT(recv));
> +    return 0;
> +}

These helpers don't really add any value IMHO  - just call object_ref/unref
directly where needed. We don't provide explicit qio_channel_ref() wrappers
around object_ref because they add no value.

>  
>  static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
>  {
> diff --git a/migration/socket.h b/migration/socket.h
> index 6b91e9db38..638a85255a 100644
> --- a/migration/socket.h
> +++ b/migration/socket.h
> @@ -16,6 +16,13 @@
>  
>  #ifndef QEMU_MIGRATION_SOCKET_H
>  #define QEMU_MIGRATION_SOCKET_H
> +
> +#include "io/channel.h"
> +#include "io/task.h"
> +
> +int socket_recv_channel_ref(QIOChannel *recv);
> +int socket_recv_channel_unref(QIOChannel *recv);
> +
>  void tcp_start_incoming_migration(const char *host_port, Error **errp);
>  
>  void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
> -- 
> 2.14.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
