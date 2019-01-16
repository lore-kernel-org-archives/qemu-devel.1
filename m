Received: from eggs.gnu.org ([209.51.188.92]:45906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjocc-0003Zd-L4
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjoca-0002rG-PU
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:04:58 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-10-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8fff6a6e-1030-64d7-4c96-4704970b898c@redhat.com>
Date: Wed, 16 Jan 2019 11:04:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180731173033.75467-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ddjE7xD05tvWz11vqCBEhC5GH0zU6a3F7"
Subject: Re: [Qemu-devel] [PATCH v4 09/10] block/nbd-client: nbd reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ddjE7xD05tvWz11vqCBEhC5GH0zU6a3F7
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <8fff6a6e-1030-64d7-4c96-4704970b898c@redhat.com>
Subject: Re: [PATCH v4 09/10] block/nbd-client: nbd reconnect
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-10-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> Implement reconnect. To achieve this:
>=20
> 1. add new modes:
>    connecting-wait: means, that reconnecting is in progress, and there
>      were small number of reconnect attempts, so all requests are
>      waiting for the connection.
>    connecting-nowait: reconnecting is in progress, there were a lot of
>      attempts of reconnect, all requests will return errors.
>=20
>    two old modes are used too:
>    connected: normal state
>    quit: exiting after fatal error or on close

What makes an error fatal?  Without reconnect, life is simple - if the
server sends something we can't parse, we permanently turn the device
into an error condition - because we have no way to get back in sync
with the server for further commands.  Your patch allows reconnect
attempts where the connection is down (we failed to send to the server
or failed to receive the server's reply), but why can we not ALSO
attempt to reconnect after a parse error?  A reconnect would let us get
back in sync for attempting further commands.  You're right that the
current command should probably fail in that case (if the server sent us
garbage for a specific request, it will probably do so again on a repeat
of that request; which is different than when we don't even know what
the server would have sent because of a disconnect).

Or, put another way, we KNOW we have (corner) cases where a mis-aligned
image can currently cause the server to return BLOCK_STATUS replies that
aren't aligned to the advertised minimumm block size.  Attempting to
read the last sector of an image then causes the client to see the
misaligned reply and complain, which we are treating as fatal. But why
not instead just fail that particular read, but still attempt a
reconnect, in order to attempt further reads elsewhere in the image that
do not trip up the server's misaligned reply?

>=20
> Possible transitions are:
>=20
>    * -> quit
>    connecting-* -> connected
>    connecting-wait -> connecting-nowait (transition is done after
>                       reconnect-delay seconds in connecting-wait mode)
>    connected -> connecting-wait
>=20
> 2. Implement reconnect in connection_co. So, in connecting-* mode,
>     connection_co, tries to reconnect unlimited times.
>=20
> 3. Retry nbd queries on channel error, if we are in connecting-wait
>     state.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.h |   4 +
>  block/nbd-client.c | 304 +++++++++++++++++++++++++++++++++++++++++++--=
--------
>  2 files changed, 255 insertions(+), 53 deletions(-)
>=20

> @@ -781,16 +936,21 @@ static int nbd_co_request(BlockDriverState *bs, N=
BDRequest *request,
>      } else {
>          assert(request->type !=3D NBD_CMD_WRITE);
>      }
> -    ret =3D nbd_co_send_request(bs, request, write_qiov);
> -    if (ret < 0) {
> -        return ret;
> -    }
> =20
> -    ret =3D nbd_co_receive_return_code(client, request->handle,
> -                                     &request_ret, &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -    }
> +    do {
> +        ret =3D nbd_co_send_request(bs, request, write_qiov);
> +        if (ret < 0) {
> +            continue;
> +        }
> +
> +        ret =3D nbd_co_receive_return_code(client, request->handle,
> +                                         &request_ret, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            local_err =3D NULL;

Conflicts with the conversion to use trace points.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ddjE7xD05tvWz11vqCBEhC5GH0zU6a3F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/ZDAACgkQp6FrSiUn
Q2oEXgf/TJV+eH6PZbMu3V94+lmnca2lpCDf0kINn7NOFEP+t9+Ej+quDKtK95+z
txjAqdwH0HFUAD6GkN0RJeu5qUbDcBWDsEPuwpUNh1fpMIwbsTPagk1knrcRb+BI
6+K33F1ug6xNUMeufc9SRI6A0l+oCAQkjzqPcVG1cuCJbOI5AeN+luDtJuCF6aYi
NMYTQDO2xr8SJMw//ZiEwXzek1mxhPNMEFXqCYojQyOrnZ7/VdRNpH1R9Dn0cI9D
G8/SHL6zrppUjPEiVg0bF86j9LfD6ByTgO+PO0QXPO/YuygubifjeVfrN6q5J2RC
gXXkFuvhuuryCw/d6gS+jTrqc+a0bw==
=lsLu
-----END PGP SIGNATURE-----

--ddjE7xD05tvWz11vqCBEhC5GH0zU6a3F7--
