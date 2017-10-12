Received: from eggs.gnu.org ([2001:4830:134:3::10]:37290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lwy-0004Ya-Op
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lwx-0001Sf-MJ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:27:32 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
Date: Thu, 12 Oct 2017 17:27:22 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AqoSprlhwb8XbHUNPuogTriAHWU37ptOS"
Subject: Re: [Qemu-devel] [PATCH v3 07/13] nbd-server: simplify reply
 transmission
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
--AqoSprlhwb8XbHUNPuogTriAHWU37ptOS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
Subject: Re: [PATCH v3 07/13] nbd-server: simplify reply transmission
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-8-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Send qiov via qio_channel_writev_all instead of calling nbd_write twice=

> with a cork.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 50 ++++++++++++++++++++++++--------------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
>=20

> @@ -1203,36 +1220,17 @@ static int nbd_co_send_simple_reply(NBDClient *=
client,
>                                      size_t len,
>                                      Error **errp)
>  {
> -    NBDSimpleReply simple_reply;
> -    int ret;
> -
> -    g_assert(qemu_in_coroutine());
> +    NBDSimpleReply reply;

Why the rename from simple_reply to reply?

> +    struct iovec iov[] =3D {
> +        {.iov_base =3D &reply, .iov_len =3D sizeof(reply)},

I guess it made this line shorter.  But we could reduce some churn by
naming it 'reply' in the first place, back in earlier patches.  At the
same time, I'm not going to bother if there's not a reason to respin the
series (or at least the first half).

> +        {.iov_base =3D data, .iov_len =3D len}
> +    };
> =20
>      trace_nbd_co_send_simple_reply(handle, error, len);
> =20
> -    set_be_simple_reply(&simple_reply, system_errno_to_nbd_errno(error=
),
> -                        handle);
> -
> -    qemu_co_mutex_lock(&client->send_lock);
> -    client->send_coroutine =3D qemu_coroutine_self();
> -
> -    if (!len) {
> -        ret =3D nbd_write(client->ioc, &simple_reply, sizeof(simple_re=
ply), NULL);
> -    } else {
> -        qio_channel_set_cork(client->ioc, true);
> -        ret =3D nbd_write(client->ioc, &simple_reply, sizeof(simple_re=
ply), NULL);
> -        if (ret =3D=3D 0) {
> -            ret =3D nbd_write(client->ioc, data, len, errp);
> -            if (ret < 0) {
> -                ret =3D -EIO;
> -            }
> -        }
> -        qio_channel_set_cork(client->ioc, false);
> -    }
> +    set_be_simple_reply(&reply, system_errno_to_nbd_errno(error), hand=
le);
> =20
> -    client->send_coroutine =3D NULL;
> -    qemu_co_mutex_unlock(&client->send_lock);
> -    return ret;
> +    return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);

This part is definitely nicer!  Thanks for splitting the v2 patch, it
made review a lot more pleasant.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AqoSprlhwb8XbHUNPuogTriAHWU37ptOS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf7EoACgkQp6FrSiUn
Q2rvWwf+PtpuGewWkMBq57S/Svohy5MXYtUDt586+eBOasbeN97PUg4I8Jk8X370
ypzOXvlc91OCgT6v5SgaTFFhz90kbVVHCKYtVsOC+wJsReCrEohrr6f2y/vLfiz9
fFXqmh3vn6BBLwpKgHX+Pyq5L10smcJ7QnwPRbj+FPiKF89EC2Iptwiv8f7Jy9iA
W3e0tkv3xBjTYUguZUCBvcWj/4pK3Gu/PNdhhuol3sA1JkGQEYR0mvrs5/+JjfY6
9h51D17+cDvsm8den1fh4oWi38aJnTDkoh8vl1D8iB7UcM6VRfDZZl61/nOnrQM+
LTsJ4SNmVTY5p6Dd1EWoDxw0qVdh4A==
=aUiH
-----END PGP SIGNATURE-----

--AqoSprlhwb8XbHUNPuogTriAHWU37ptOS--
