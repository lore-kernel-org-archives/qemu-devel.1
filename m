Received: from eggs.gnu.org ([2001:4830:134:3::10]:53569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTUQx-00054j-WE
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTUQu-00035k-TU
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:40:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTUQu-00035U-JI
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:40:36 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b8174b0b-1782-48ae-6bef-3f2a6a08f025@redhat.com>
Date: Fri, 7 Jul 2017 09:40:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TFBOfjBje9tUQos03eF1E04nTFQnS7OCs"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd/server: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TFBOfjBje9tUQos03eF1E04nTFQnS7OCs
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <b8174b0b-1782-48ae-6bef-3f2a6a08f025@redhat.com>
Subject: Re: [PATCH v2 2/6] nbd/server: use errp instead of LOG
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move to modern errp scheme from just LOGging errors.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 268 +++++++++++++++++++++++++++++++++++----------------=
--------
>  1 file changed, 161 insertions(+), 107 deletions(-)

> -static coroutine_fn int nbd_negotiate(NBDClient *client)
> +static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)=

>  {
>      char buf[8 + 8 + 8 + 128];
>      int ret;

Now that you have this,

>     qio_channel_set_blocking(client->ioc, false, NULL);
>=20

you should probably pass errp through to qio_channel_set_blocking and
return early if that fails (either here or in one of the followup
patches) [hmm, I note that most callers of qio_channel_set_blocking()
ignore errors - outside of NBD, so that's a separate cleanup series]


> @@ -591,21 +617,23 @@ static coroutine_fn int nbd_negotiate(NBDClient *=
client)
> =20
>      if (oldStyle) {
>          if (client->tlscreds) {
> -            TRACE("TLS cannot be enabled with oldstyle protocol");
> +            error_setg(errp, "TLS cannot be enabled with oldstyle prot=
ocol");
>              return -EINVAL;

This code is unreachable, since earlier we have:

>     oldStyle =3D client->exp !=3D NULL && !client->tlscreds;

You could just as easily delete the conditional.  In fact, our code has:

if (oldStyle) {
    do stuff
} else {
    do stuff
}

if (oldStyle) {
    do stuff
} else {
    do stuff
}

and it would be simple to merge that into a single if statement.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TFBOfjBje9tUQos03eF1E04nTFQnS7OCs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX51eAAoJEKeha0olJ0Nqsb4H/j93n9iqS7J50R9Cny4kp5lE
PZF7dv3b1TPyvtcG6EXzCpbzP/1JAkXMvY+02EYccFdL8c3Dd3ECVQU9Fc2Ab2rY
wRYICBz7vAvCmu6/Sje8YQe/07JbE3DjFgq6gjiZyrx11AhJG15WAXN7MMaphC8c
2he6zuMyfaj+Te6XJxJ5bEX60TnRQliBYCKe7UFwW6hvFwGfa+1hj0pQUIjjvYpU
g77Jyh3vsnci+e3AuqDEUsN2zK3PZc6d5rPJaTFQOrwowzJmMCcxc1BPDUjbHYSe
n++CDnJNVvwypj2me4qRdeYZl1fMIPfCKGvY4Fy1/gj6lXbSKzf20u4Ab1B+fng=
=z3kn
-----END PGP SIGNATURE-----

--TFBOfjBje9tUQos03eF1E04nTFQnS7OCs--
