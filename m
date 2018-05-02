Received: from eggs.gnu.org ([2001:4830:134:3::10]:52362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDqXW-0001JY-Fg
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDqXR-0001wg-Hz
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:07:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53880 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDqXR-0001wF-BI
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:07:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E1D3722E1
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 12:07:12 +0000 (UTC)
Date: Wed, 2 May 2018 13:07:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180502120705.GP3308@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180430185943.35714-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180430185943.35714-1-dgilbert@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Migration+TLS: Fix crash due to double
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, quintela@redhat.com, peterx@redhat.com

On Mon, Apr 30, 2018 at 07:59:43PM +0100, Dr. David Alan Gilbert (git) wr=
ote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> During a TLS connect we see:
>   migration_channel_connect calls
>   migration_tls_channel_connect
>   (calls after TLS setup)
>   migration_channel_connect
>=20
> My previous error handling fix made migration_channel_connect
> call migrate_fd_connect in all cases; unfortunately the above
> means it gets called twice and crashes doing double cleanup.
>=20
> Fixes: 688a3dcba98
>=20
> Reported-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/channel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I've satisfied myself that the double error reporting is not going to
cause any functional harm, so that's less urgent to fix.

>=20
> diff --git a/migration/channel.c b/migration/channel.c
> index c5eaf0fa0e..7a32b5aca4 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -71,6 +71,15 @@ void migration_channel_connect(MigrationState *s,
>              !object_dynamic_cast(OBJECT(ioc),
>                                   TYPE_QIO_CHANNEL_TLS)) {
>              migration_tls_channel_connect(s, ioc, hostname, &error);
> +
> +            if (!error) {
> +                /* tls_channel_connect will call back to this
> +                 * function after the TLS handshake,
> +                 * so we mustn't call migrate_fd_connect until then
> +                 */
> +
> +                return;
> +            }
>          } else {
>              QEMUFile *f =3D qemu_fopen_channel_output(ioc);
> =20
> --=20
> 2.17.0
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
