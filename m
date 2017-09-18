Received: from eggs.gnu.org ([2001:4830:134:3::10]:33784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du4Vm-0001zE-3a
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du4Vk-0004pL-PD
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:27:30 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b016f0b6-c7bd-eef3-caee-47f7da7d8deb@redhat.com>
Date: Mon, 18 Sep 2017 17:27:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170918135935.255591-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q37wCm5Nw2XkvcMnC5JqwPm4PHWwdVk8D"
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/nbd-client: early fail
 nbd_read_reply_entry if s->quit is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q37wCm5Nw2XkvcMnC5JqwPm4PHWwdVk8D
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <b016f0b6-c7bd-eef3-caee-47f7da7d8deb@redhat.com>
Subject: Re: [PATCH v2 6/7] block/nbd-client: early fail nbd_read_reply_entry
 if s->quit is set
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> Do not continue any operation if s->quit is set in parallel.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 280147e6a7..f80a4c5564 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -81,7 +81,7 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)
>          if (ret < 0) {
>              error_report_err(local_err);
>          }
> -        if (ret <=3D 0) {
> +        if (ret <=3D 0 || s->quit) {
>              break;
>          }

I'm still not convinced this helps: either nbd_receive_reply() already
returned an error, or we got a successful reply header, at which point
either the command is done (no need to abort the command early - it
succeeded) or it is a read command (and we should detect at the point
where we try to populate the qiov that we don't want to read any more).
It depends on your 3/7 patch for the fact that we even try to read the
qiov directly in this while loop rather than in the coroutine handler,
where Paolo questioned whether we need that change.

> @@ -105,9 +105,8 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>              assert(qiov !=3D NULL);
>              assert(s->requests[i].request->len =3D=3D
>                     iov_size(qiov->iov, qiov->niov));
> -            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
> -                                      NULL) < 0)
> -            {
> +            ret =3D qio_channel_readv_all(s->ioc, qiov->iov, qiov->nio=
v, NULL);
> +            if (ret < 0 || s->quit) {
>                  s->requests[i].ret =3D -EIO;
>                  break;
>              }

The placement here looks odd. Either we should not attempt the read
because s->quit was already set (okay, your first addition makes sense
in that light), or we succeeded at the read (at which point, why do we
need to claim it failed?).

I'm trying to look forward to structured reads, where we will have to
deal with more than one server message in reply to a single client
request.  For read, we just piece together portions of the qiov until
the server has sent us all the pieces.  But for block query, I really do
think we'll want to defer to specialized handlers for doing further
reads (the amount of data to be read from the server is not known by the
client a priori, so it is a two-part read, one to get the length, and
another to read that remaining length); if we need some sort of callback
function rather than cramming all the logic here in the main read loop,
then the qio_channel_readv_all for read commands would belong in the
callback, and it is more a question of the main read loop checking
whether there is an early quit condition before calling into the callback=
=2E

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q37wCm5Nw2XkvcMnC5JqwPm4PHWwdVk8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnASEYACgkQp6FrSiUn
Q2qxKgf/WuHOO9kT+K1d4Xkf4k2NPEJuAUne86F/vb5JPv57WhZrICkHulnPtewg
KN54d5XLFmsCngeSexBsTuEyDQ2js8tLW7pa0Pn9uoa9XTLEnwgZ9J710i+UUEyF
r01j5xxVxvIzU1MCt6YXZ852g+n8LjCc9sJk+GUH8Vv8mNSiF7s/NqX5VpKIhi4U
o4xPWRID1aXDZzhJfD1mAwSHsYIWidn6RFZCFuHX29xo0sSQjQMP06A4V8J2i4XU
oZvdOAD55fWYLs4Y0HK2KJxbxpMNxjLiWwGRJbs6h3XJro7OXi+ndjv2VTkZB4pB
lq4Gb6GByAEP36TMk14eoHYE6GO7TA==
=odAt
-----END PGP SIGNATURE-----

--Q37wCm5Nw2XkvcMnC5JqwPm4PHWwdVk8D--
