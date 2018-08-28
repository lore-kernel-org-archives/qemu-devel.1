Received: from eggs.gnu.org ([2001:4830:134:3::10]:36480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fufcO-0008DC-A4
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fufcK-0003PS-6i
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:09:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fufcI-0003LR-4j
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:09:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E234F7721B
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 15:09:12 +0000 (UTC)
Date: Tue, 28 Aug 2018 16:09:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828150905.GC31005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713130916.4153-10-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/29] qio: add
 qio_channel_command_new_spawn_with_pre_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, airlied@redhat.com, kraxel@redhat.com

On Fri, Jul 13, 2018 at 03:08:56PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Add a new function to let caller do some tuning thanks to a callback
> before exec().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/io/channel-command.h | 18 ++++++++++++++++++
>  io/channel-command.c         | 33 ++++++++++++++++++++++++++-------
>  2 files changed, 44 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/io/channel-command.h b/include/io/channel-command.=
h
> index 336d47fa5c..96c833daab 100644
> --- a/include/io/channel-command.h
> +++ b/include/io/channel-command.h
> @@ -71,6 +71,24 @@ qio_channel_command_new_pid(int writefd,
>                              int readfd,
>                              pid_t pid);
> =20
> +/**
> + * qio_channel_command_new_spawn_with_pre_exec:
> + * @argv: the NULL terminated list of command arguments
> + * @flags: the I/O mode, one of O_RDONLY, O_WRONLY, O_RDWR
> + * @errp: pointer to a NULL-initialized error object

Missing the new args

> + *
> + * Create a channel for performing I/O with the
> + * command to be spawned with arguments @argv.
> + *
> + * Returns: the command channel object, or NULL on error
> + */
> +QIOChannelCommand *
> +qio_channel_command_new_spawn_with_pre_exec(const char *const argv[],
> +                                            int flags,
> +                                            void (*pre_exec_cb)(void *=
),
> +                                            void *data,
> +                                            Error **errp);

I have a slight preference for using a typedef for the callback signature=
,
and providing API docs explaining the contract.

eg the callback should call _exit() if something happens that it can't
handle

> +
>  /**
>   * qio_channel_command_new_spawn:
>   * @argv: the NULL terminated list of command arguments
> diff --git a/io/channel-command.c b/io/channel-command.c
> index 3e7eb17eff..05903ff194 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -46,9 +46,12 @@ qio_channel_command_new_pid(int writefd,
> =20
>  #ifndef WIN32
>  QIOChannelCommand *
> -qio_channel_command_new_spawn(const char *const argv[],
> -                              int flags,
> -                              Error **errp)
> +qio_channel_command_new_spawn_with_pre_exec(const char *const argv[],
> +                                            int flags,
> +                                            void (*pre_exec_cb)(void *=
),
> +                                            void *data,
> +                                            Error **errp)
> +
>  {
>      pid_t pid =3D -1;
>      int stdinfd[2] =3D { -1, -1 };
> @@ -104,6 +107,10 @@ qio_channel_command_new_spawn(const char *const ar=
gv[],
>              close(devnull);
>          }
> =20
> +        if (pre_exec_cb) {
> +            pre_exec_cb(data);
> +        }
> +
>          execv(argv[0], (char * const *)argv);
>          _exit(1);
>      }
> @@ -139,12 +146,13 @@ qio_channel_command_new_spawn(const char *const a=
rgv[],
>      }
>      return NULL;
>  }
> -
>  #else /* WIN32 */
>  QIOChannelCommand *
> -qio_channel_command_new_spawn(const char *const argv[],
> -                              int flags,
> -                              Error **errp)
> +qio_channel_command_new_spawn_with_pre_exec(const char *const argv[],
> +                                            int flags,
> +                                            void (*pre_exec_cb)(void *=
),
> +                                            void *data,
> +                                            Error **errp)
>  {
>      error_setg_errno(errp, ENOSYS,
>                       "Command spawn not supported on this platform");
> @@ -152,6 +160,17 @@ qio_channel_command_new_spawn(const char *const ar=
gv[],
>  }
>  #endif /* WIN32 */
> =20
> +
> +QIOChannelCommand *
> +qio_channel_command_new_spawn(const char *const argv[],
> +                              int flags,
> +                              Error **errp)
> +{
> +    return qio_channel_command_new_spawn_with_pre_exec(argv, flags,
> +                                                       NULL, NULL, err=
p);
> +}
> +
> +
>  #ifndef WIN32
>  static int qio_channel_command_abort(QIOChannelCommand *ioc,
>                                       Error **errp)
> --=20
> 2.18.0.129.ge3331758f1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
