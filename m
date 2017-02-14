Received: from eggs.gnu.org ([2001:4830:134:3::10]:34440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdb7D-0007Qf-Pk
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdb79-0005vf-Tz
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cdb79-0005uq-L5
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:17:43 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEFF1C054908
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 11:17:43 +0000 (UTC)
Date: Tue, 14 Feb 2017 11:17:37 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170214111737.GC467@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-8-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1487006388-7966-8-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PULL 07/12] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

On Mon, Feb 13, 2017 at 06:19:43PM +0100, Juan Quintela wrote:
> We create new channels for each new thread created. We only send through
> them a character to be sure that we are creating the channels in the
> right order.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h |  7 +++++
>  migration/ram.c               | 33 ++++++++++++++++++++++
>  migration/socket.c            | 64 +++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 101 insertions(+), 3 deletions(-)

[snip]

> diff --git a/migration/socket.c b/migration/socket.c
> index 13966f1..1c764f1 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -24,6 +24,62 @@
>  #include "io/channel-socket.h"
>  #include "trace.h"
> 
> +struct SocketArgs {
> +    QIOChannelSocket *ioc;
> +    SocketAddress *saddr;
> +    Error **errp;
> +} socket_args;
> +
> +QIOChannel *socket_recv_channel_create(void)
> +{
> +    QIOChannelSocket *sioc;
> +    Error *err = NULL;
> +
> +    sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(socket_args.ioc),
> +                                     &err);
> +    if (!sioc) {
> +        error_report("could not accept migration connection (%s)",
> +                     error_get_pretty(err));
> +        return NULL;
> +    }
> +    return QIO_CHANNEL(sioc);
> +}
> +
> +int socket_recv_channel_destroy(QIOChannel *recv)
> +{
> +    /* Remove channel */
> +    object_unref(OBJECT(send));
> +    return 0;
> +}
> +
> +/* we have created all the recv channels, we can close the main one */
> +int socket_recv_channel_close_listening(void)
> +{
> +    /* Close listening socket as its no longer needed */
> +    qio_channel_close(QIO_CHANNEL(socket_args.ioc), NULL);
> +    return 0;
> +}
> +
> +QIOChannel *socket_send_channel_create(void)
> +{
> +    QIOChannelSocket *sioc = qio_channel_socket_new();
> +
> +    qio_channel_socket_connect_sync(sioc, socket_args.saddr,
> +                                    socket_args.errp);
> +    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
> +    return QIO_CHANNEL(sioc);
> +}
> +
> +int socket_send_channel_destroy(QIOChannel *send)
> +{
> +    /* Remove channel */
> +    object_unref(OBJECT(send));
> +    if (socket_args.saddr) {
> +        qapi_free_SocketAddress(socket_args.saddr);
> +        socket_args.saddr = NULL;
> +    }
> +    return 0;
> +}
> 
>  static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
>  {
> @@ -97,6 +153,10 @@ static void socket_start_outgoing_migration(MigrationState *s,
>      struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
> 
>      data->s = s;
> +
> +    socket_args.saddr = saddr;
> +    socket_args.errp = errp;
> +
>      if (saddr->type == SOCKET_ADDRESS_KIND_INET) {
>          data->hostname = g_strdup(saddr->u.inet.data->host);
>      }
> @@ -107,7 +167,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
>                                       socket_outgoing_migration,
>                                       data,
>                                       socket_connect_data_free);
> -    qapi_free_SocketAddress(saddr);
>  }
> 
>  void tcp_start_outgoing_migration(MigrationState *s,
> @@ -154,8 +213,6 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>      object_unref(OBJECT(sioc));
> 
>  out:
> -    /* Close listening socket as its no longer needed */
> -    qio_channel_close(ioc, NULL);
>      return FALSE; /* unregister */
>  }
> 
> @@ -164,6 +221,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>                                              Error **errp)
>  {
>      QIOChannelSocket *listen_ioc = qio_channel_socket_new();
> +    socket_args.ioc = listen_ioc;
> 
>      qio_channel_set_name(QIO_CHANNEL(listen_ioc),
>                           "migration-socket-listener");

FYI I put some comments against v3 on this patch just as you sent this v4,
as I don't think the changes here are desirable in this format.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
