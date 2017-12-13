Received: from eggs.gnu.org ([2001:4830:134:3::10]:39779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP9Ar-0001hJ-Qu
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP9Am-000058-VW
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:42:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP9Am-0008WO-Oe
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:42:16 -0500
Date: Wed, 13 Dec 2017 15:41:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213154149.GG7173@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-7-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 06/26] monitor: move the cur_mon hack
 deeper for QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:40PM +0800, Peter Xu wrote:
> In monitor_qmp_read(), we have the hack to temporarily replace the
> cur_mon pointer.  Now we move this hack deeper inside the QMP dispatcher
> routine since the Monitor pointer can be passed in to that using the new
> JSON Parser opaque field now.
>=20
> This does not make much sense as a single patch.  However, this will be
> a big step for the next patch, when the QMP dispatcher routine will be
> split from the QMP parser.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index ab80d32c70..322dfb5f31 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3813,7 +3813,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens,
>  {
>      QObject *req, *rsp =3D NULL, *id =3D NULL;
>      QDict *qdict =3D NULL;
> -    Monitor *mon =3D cur_mon;
> +    Monitor *mon =3D opaque, *old_mon;

Or without the new opaque argument:

MonitorQMP *mon_qmp =3D container_of(parser, MonitorQMP, parser);
Monitor *mon =3D container_of(mon_qmp, Monitor, qmp);

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMUo9AAoJEJykq7OBq3PI8RkIAJteJ38+42jDVqyVIAaLN7fY
q7Jp+CZwhaRBjqBYQG9XSG4f93KgztyKPd6xkPL1pwPimMrXyo/vWmVvW7V79M4L
TC4IJAkDBhUtNa7QlnYcxLqMfyGTgBAHkjkb6Pizy+AA3ssjGDSrx6PV6x0OuywH
DRG+gt9A/T9VBvyyEcRgQd5ktn6YnfMyRonoYRhbg4tErCzY1Y/RHMQZpfEZnfNI
r7XqPIDQ5Le349JGNqhNknKFQc+y/A533zbJxE4HB4VnKcvj7jGIveMhc0h9mh+J
WYPO26sm9ApkYHXbJCnk44J3DNOsTqy5wKjn7BnHQEpflyu9M7o9lFasO2L/oHE=
=2S3T
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
