Received: from eggs.gnu.org ([2001:4830:134:3::10]:55879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du46B-0004GC-1A
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du46A-0001AL-4b
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:01:03 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3107b1aa-d708-0c3f-8bb7-be2e631dff1d@redhat.com>
Date: Mon, 18 Sep 2017 17:00:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170918135935.255591-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FxBHrsVTkBMElAiKQ7xwv1HEk8mw6jJhc"
Subject: Re: [Qemu-devel] [PATCH v2 4/7] block/nbd-client: drop reply field
 from NBDClientSession
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
--FxBHrsVTkBMElAiKQ7xwv1HEk8mw6jJhc
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <3107b1aa-d708-0c3f-8bb7-be2e631dff1d@redhat.com>
Subject: Re: [PATCH v2 4/7] block/nbd-client: drop reply field from
 NBDClientSession
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> Drop 'reply' from NBDClientSession. It's used to only deliver request
> return code to receiving coroutine. Instead introduce per-request ret
> variable to simplify the scheme and make further refactoring possible.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.h |  2 +-
>  block/nbd-client.c | 22 +++++++++-------------
>  2 files changed, 10 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index 3f97d31013..4bc8fe3993 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -22,6 +22,7 @@ typedef struct {
>      bool receiving;         /* waiting for read_reply_co? */
>      NBDRequest *request;
>      QEMUIOVector *qiov;
> +    int ret;
>  } NBDClientRequest;

I like this idea.  However, I note that:

> @@ -211,11 +211,7 @@ static int nbd_co_receive_reply(NBDClientSession *=
s, NBDRequest *request)
>      if (!s->ioc || s->quit) {
>          ret =3D -EIO;
>      } else {
> -        assert(s->reply.handle =3D=3D request->handle);
> -        ret =3D -s->reply.error;
> -
> -        /* Tell the read handler to read another header.  */
> -        s->reply.handle =3D 0;
> +        ret =3D s->requests[i].ret;

you are removing the assert you added in 2/7, where I questioned whether
we needed NBDClientRequest.request in the first place.  So there may be
some rebase churn, depending on how that conversation pans out.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FxBHrsVTkBMElAiKQ7xwv1HEk8mw6jJhc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnAQhQACgkQp6FrSiUn
Q2pSoQf/ehgJvqj+T2cO8sbymtrm2p60h8lwWN3s+pvUIWpDy75uD5Nuxhi4ERJw
T6bvHC1PqQgQmFThWrkbCC1E6n98AxByYkKfhJrU1DcVjyf688PLXvZw0EMGo7Gd
tzDDCKGxL633fuGOg7yVRidrT++fSE0+GjmVtwkaWm+LIH+J9DVpQPai5sRqRQbv
JAA9YWNLqCinkfq7x8QB3yelEEVPW7XFZv1CB/idyTgXb34s/A+YMAtNXkCa46qZ
OTY9oPbbEr32PVVEhNrDiysy06T/h8MEVQyqCwiasdVpOLwp63E3Qmidta7+12Y8
pn02894plfH92IKbGe2Efg+tgK1yyg==
=/V4l
-----END PGP SIGNATURE-----

--FxBHrsVTkBMElAiKQ7xwv1HEk8mw6jJhc--
