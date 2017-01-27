Received: from eggs.gnu.org ([2001:4830:134:3::10]:34458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cXAah-0000cI-Vu
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cXAae-0008MK-IY
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:45:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cXAad-0008M0-TS
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:45:36 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A305DC04BD5F
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 17:45:35 +0000 (UTC)
Date: Fri, 27 Jan 2017 17:45:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170127174530.GH3323@work-vm>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-10-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1485207141-1941-10-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/17] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We create new channels for each new thread created. We only send through
> them a character to be sure that we are creating the channels in the
> right order.
>=20
> Note: Reference count/freeing of channels is not done
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h |  6 +++++
>  migration/ram.c               | 45 +++++++++++++++++++++++++++++++++-
>  migration/socket.c            | 56 +++++++++++++++++++++++++++++++++++++=
++++--
>  3 files changed, 104 insertions(+), 3 deletions(-)

One thing not direclt in here, you should probably look at the migration ca=
ncel
code to get it to call shutdown() on all your extra sockets, it stops things
blocking in any one of them.

>=20
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index f119ba0..3989bd6 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -22,6 +22,7 @@
>  #include "qapi-types.h"
>  #include "exec/cpu-common.h"
>  #include "qemu/coroutine_int.h"
> +#include "io/channel.h"
>=20
>  #define QEMU_VM_FILE_MAGIC           0x5145564d
>  #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
> @@ -218,6 +219,11 @@ void tcp_start_incoming_migration(const char *host_p=
ort, Error **errp);
>=20
>  void tcp_start_outgoing_migration(MigrationState *s, const char *host_po=
rt, Error **errp);
>=20
> +QIOChannel *socket_recv_channel_create(void);
> +int socket_recv_channel_destroy(QIOChannel *recv);
> +QIOChannel *socket_send_channel_create(void);
> +int socket_send_channel_destroy(QIOChannel *send);
> +
>  void unix_start_incoming_migration(const char *path, Error **errp);
>=20
>  void unix_start_outgoing_migration(MigrationState *s, const char *path, =
Error **errp);
> diff --git a/migration/ram.c b/migration/ram.c
> index 939f364..5ad7cb3 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -386,9 +386,11 @@ void migrate_compress_threads_create(void)
>=20
>  struct MultiFDSendParams {
>      QemuThread thread;
> +    QIOChannel *c;
>      QemuCond cond;
>      QemuMutex mutex;
>      bool quit;
> +    bool started;
>  };
>  typedef struct MultiFDSendParams MultiFDSendParams;
>=20
> @@ -397,6 +399,13 @@ static MultiFDSendParams *multifd_send;
>  static void *multifd_send_thread(void *opaque)
>  {
>      MultiFDSendParams *params =3D opaque;
> +    char start =3D 's';
> +
> +    qio_channel_write(params->c, &start, 1, &error_abort);

I'd be tempted to send something stronger as a guarantee
that you're connecting the right thing to the right place;
maybe something like a QEMU + UUID + fd index?
I guarantee someone is going to mess up the fd's in the wrong
order or connect some random other process to one of them.

> +    qemu_mutex_lock(&params->mutex);
> +    params->started =3D true;
> +    qemu_cond_signal(&params->cond);
> +    qemu_mutex_unlock(&params->mutex);
>=20
>      qemu_mutex_lock(&params->mutex);

That unlock/lock pair is odd.

>      while (!params->quit){
> @@ -433,6 +442,7 @@ void migrate_multifd_send_threads_join(void)
>          qemu_thread_join(&multifd_send[i].thread);
>          qemu_mutex_destroy(&multifd_send[i].mutex);
>          qemu_cond_destroy(&multifd_send[i].cond);
> +        socket_send_channel_destroy(multifd_send[i].c);
>      }
>      g_free(multifd_send);
>      multifd_send =3D NULL;
> @@ -452,18 +462,31 @@ void migrate_multifd_send_threads_create(void)
>          qemu_mutex_init(&multifd_send[i].mutex);
>          qemu_cond_init(&multifd_send[i].cond);
>          multifd_send[i].quit =3D false;
> +        multifd_send[i].started =3D false;
> +        multifd_send[i].c =3D socket_send_channel_create();
> +        if(!multifd_send[i].c) {
> +            error_report("Error creating a send channel");
> +            exit(0);

Hmm no exit!

> +        }
>          snprintf(thread_name, 15, "multifd_send_%d", i);
>          qemu_thread_create(&multifd_send[i].thread, thread_name,
>                             multifd_send_thread, &multifd_send[i],
>                             QEMU_THREAD_JOINABLE);
> +        qemu_mutex_lock(&multifd_send[i].mutex);
> +        while (!multifd_send[i].started) {
> +            qemu_cond_wait(&multifd_send[i].cond, &multifd_send[i].mutex=
);
> +        }
> +        qemu_mutex_unlock(&multifd_send[i].mutex);
>      }
>  }
>=20
>  struct MultiFDRecvParams {
>      QemuThread thread;
> +    QIOChannel *c;
>      QemuCond cond;
>      QemuMutex mutex;
>      bool quit;
> +    bool started;
>  };
>  typedef struct MultiFDRecvParams MultiFDRecvParams;
>=20
> @@ -472,7 +495,14 @@ static MultiFDRecvParams *multifd_recv;
>  static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *params =3D opaque;
> -=20
> +    char start;
> +
> +    qio_channel_read(params->c, &start, 1, &error_abort);
> +    qemu_mutex_lock(&params->mutex);
> +    params->started =3D true;
> +    qemu_cond_signal(&params->cond);
> +    qemu_mutex_unlock(&params->mutex);
> +
>      qemu_mutex_lock(&params->mutex);
>      while (!params->quit){
>          qemu_cond_wait(&params->cond, &params->mutex);
> @@ -508,6 +538,7 @@ void migrate_multifd_recv_threads_join(void)
>          qemu_thread_join(&multifd_recv[i].thread);
>          qemu_mutex_destroy(&multifd_recv[i].mutex);
>          qemu_cond_destroy(&multifd_recv[i].cond);
> +        socket_send_channel_destroy(multifd_recv[i].c);
>      }
>      g_free(multifd_recv);
>      multifd_recv =3D NULL;
> @@ -526,9 +557,21 @@ void migrate_multifd_recv_threads_create(void)
>          qemu_mutex_init(&multifd_recv[i].mutex);
>          qemu_cond_init(&multifd_recv[i].cond);
>          multifd_recv[i].quit =3D false;
> +        multifd_recv[i].started =3D false;
> +        multifd_recv[i].c =3D socket_recv_channel_create();
> +
> +        if(!multifd_recv[i].c) {
> +            error_report("Error creating a recv channel");
> +            exit(0);
> +        }
>          qemu_thread_create(&multifd_recv[i].thread, "multifd_recv",
>                             multifd_recv_thread, &multifd_recv[i],
>                             QEMU_THREAD_JOINABLE);
> +        qemu_mutex_lock(&multifd_recv[i].mutex);
> +        while (!multifd_recv[i].started) {
> +            qemu_cond_wait(&multifd_recv[i].cond, &multifd_recv[i].mutex=
);
> +        }
> +        qemu_mutex_unlock(&multifd_recv[i].mutex);
>      }
>  }
>=20
> diff --git a/migration/socket.c b/migration/socket.c
> index 11f80b1..7cd9213 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -24,6 +24,54 @@
>  #include "io/channel-socket.h"
>  #include "trace.h"
>=20
> +struct SocketArgs {
> +    QIOChannelSocket *ioc;
> +    SocketAddress *saddr;
> +    Error **errp;
> +} socket_args;
> +
> +QIOChannel *socket_recv_channel_create(void)
> +{
> +    QIOChannelSocket *sioc;
> +    Error *err =3D NULL;
> +
> +    sioc =3D qio_channel_socket_accept(QIO_CHANNEL_SOCKET(socket_args.io=
c),
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
> +    // Remove channel
> +    object_unref(OBJECT(send));
> +    return 0;
> +}
> +
> +QIOChannel *socket_send_channel_create(void)
> +{
> +    QIOChannelSocket *sioc =3D qio_channel_socket_new();
> +
> +    qio_channel_socket_connect_sync(sioc, socket_args.saddr,
> +                                    socket_args.errp);

We need to be careful there since that's a sync; it depends what
calls this, if I'm reading the code above correctly then it gets called
=66rom the main thread and that would be bad if it blocked; it's ok if it
was the fd threads or the migration thread though.

> +    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
> +    return QIO_CHANNEL(sioc);
> +}
> +
> +int socket_send_channel_destroy(QIOChannel *send)
> +{
> +    // Remove channel
> +    object_unref(OBJECT(send));
> +    if (socket_args.saddr) {
> +        qapi_free_SocketAddress(socket_args.saddr);
> +        socket_args.saddr =3D NULL;
> +    }
> +    return 0;
> +}
>=20
>  static SocketAddress *tcp_build_address(const char *host_port, Error **e=
rrp)
>  {
> @@ -96,6 +144,10 @@ static void socket_start_outgoing_migration(Migration=
State *s,
>      struct SocketConnectData *data =3D g_new0(struct SocketConnectData, =
1);
>=20
>      data->s =3D s;
> +
> +    socket_args.saddr =3D saddr;
> +    socket_args.errp =3D errp;
> +
>      if (saddr->type =3D=3D SOCKET_ADDRESS_KIND_INET) {
>          data->hostname =3D g_strdup(saddr->u.inet.data->host);
>      }
> @@ -106,7 +158,6 @@ static void socket_start_outgoing_migration(Migration=
State *s,
>                                       socket_outgoing_migration,
>                                       data,
>                                       socket_connect_data_free);
> -    qapi_free_SocketAddress(saddr);
>  }
>=20
>  void tcp_start_outgoing_migration(MigrationState *s,
> @@ -154,7 +205,7 @@ static gboolean socket_accept_incoming_migration(QIOC=
hannel *ioc,
>=20
>  out:
>      /* Close listening socket as its no longer needed */
> -    qio_channel_close(ioc, NULL);
> +//    qio_channel_close(ioc, NULL);
>      return FALSE; /* unregister */
>  }
>=20
> @@ -163,6 +214,7 @@ static void socket_start_incoming_migration(SocketAdd=
ress *saddr,
>                                              Error **errp)
>  {
>      QIOChannelSocket *listen_ioc =3D qio_channel_socket_new();
> +    socket_args.ioc =3D listen_ioc;
>=20
>      qio_channel_set_name(QIO_CHANNEL(listen_ioc),
>                           "migration-socket-listener");
> --=20
> 2.9.3
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
