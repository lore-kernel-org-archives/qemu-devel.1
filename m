Received: from eggs.gnu.org ([2001:4830:134:3::10]:42761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtUT-0005wf-7X
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtUS-0007VH-9r
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:50:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewtUS-0007Uc-4f
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:50:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0CE6EBFEA
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:50:03 +0000 (UTC)
Date: Fri, 16 Mar 2018 17:49:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316174959.GA3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
	<20180316115403.4148-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316115403.4148-3-quintela@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 02/15] migration: In case of error just
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Fri, Mar 16, 2018 at 12:53:50PM +0100, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> --
>=20
> As requested, just continue connection in case of error.

Just need to touch up the $subject to match the behaviour now. eg

   migration: continue listening for clients if accept fails

> ---
>  migration/socket.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/migration/socket.c b/migration/socket.c
> index 52db0c0c09..8dda1d9a98 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -140,9 +140,7 @@ static gboolean socket_accept_incoming_migration(QI=
OChannel *ioc,
>      sioc =3D qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
>                                       &err);
>      if (!sioc) {
> -        error_report("could not accept migration connection (%s)",
> -                     error_get_pretty(err));
> -        goto out;
> +        return G_SOURCE_CONTINUE;
>      }
> =20
>      trace_migration_socket_incoming_accepted();
> @@ -151,7 +149,6 @@ static gboolean socket_accept_incoming_migration(QI=
OChannel *ioc,
>      migration_channel_process_incoming(QIO_CHANNEL(sioc));
>      object_unref(OBJECT(sioc));
> =20
> -out:
>      if (migration_has_all_channels()) {
>          /* Close listening socket as its no longer needed */
>          qio_channel_close(ioc, NULL);
> --=20
> 2.14.3
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
