Received: from eggs.gnu.org ([2001:4830:134:3::10]:43753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXcO-00080j-TN
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXcL-0003Zj-Qz
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:52:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etXcL-0003Za-M9
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:52:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AED9D143B
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:52:17 +0000 (UTC)
Date: Wed, 7 Mar 2018 11:52:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307115210.GN20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-11-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307110010.2205-11-quintela@redhat.com>
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Mar 07, 2018 at 11:59:56AM +0100, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/socket.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

> diff --git a/migration/socket.c b/migration/socket.c
> index 08606c665d..b12b0a462e 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -139,9 +139,8 @@ static gboolean socket_accept_incoming_migration(QI=
OChannel *ioc,
>      sioc =3D qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
>                                       &err);
>      if (!sioc) {
> -        error_report("could not accept migration connection (%s)",
> -                     error_get_pretty(err));
> -        goto out;
> +        migrate_set_error(migrate_get_current(), err);
> +        return G_SOURCE_REMOVE;

It will only return NULL if a client connected & then went away. This sho=
uld
not happen with a "normal" mgmt app usage. On the flip side this allows a
malicious network attacker to inflict a denial of service on the migratio=
n
by simply connecting to target QEMU & immediately exiting.

Our "authentication" for migration relies on being able to validate the T=
LS
certs during TLS handshake. So in general we ought to allow repeated inco=
ming
connections until we get a successful handshake.=20

So in fact, I think a better fix here is to simply remove the original
'error_report' line, and ensure we return G_SOURCE_CONTINUE to wait for
another incoming connection from the real mgmt app.

>      }
> =20
>      trace_migration_socket_incoming_accepted();
> @@ -150,7 +149,6 @@ static gboolean socket_accept_incoming_migration(QI=
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
