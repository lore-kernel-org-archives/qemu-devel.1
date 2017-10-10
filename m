Received: from eggs.gnu.org ([2001:4830:134:3::10]:41462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1xoa-0003kf-07
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1xoW-0006eU-Uf
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1xoW-0006dx-KP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:55:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70AF67E440
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:55:27 +0000 (UTC)
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5622c2ab-caa8-3c46-0926-c46218a3d179@redhat.com>
Date: Tue, 10 Oct 2017 11:55:25 -0500
MIME-Version: 1.0
In-Reply-To: <20171010154328.8419-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SptGgNPBAiuI2BJUdrcvDKA1MLsubUUXm"
Subject: Re: [Qemu-devel] [PATCH v1 2/7] io: simplify websocket ping reply
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SptGgNPBAiuI2BJUdrcvDKA1MLsubUUXm
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5622c2ab-caa8-3c46-0926-c46218a3d179@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/7] io: simplify websocket ping reply
 handling
References: <20171010154328.8419-1-berrange@redhat.com>
 <20171010154328.8419-3-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> We must ensure we don't get flooded with ping replies if the outbound
> channel is slow. Currently we do this by keeping the ping reply in a
> separate temporary buffer and only writing it if the encoutput buffer
> is completely empty. This is overly pessimistic, as it is reasonable
> to add a ping reply to the encoutput buffer even if it has previous
> data in it, as long as that previous data doesn't include a ping
> reply.
>=20
> To track this better, put the ping reply directly into the encoutput
> buffer, and then record the size of encoutput at this time in
> ping_remain. As we write encoutput to the underlying channel, we
> can decrement the ping_remain counter. Once it hits zero, we can
> accept further ping replies for transmission.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/channel-websock.h |  2 +-
>  io/channel-websock.c         | 28 +++++++++++++++-------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
>=20

> +++ b/io/channel-websock.c
> @@ -825,11 +825,14 @@ static int qio_channel_websock_decode_payload(QIO=
ChannelWebsock *ioc,
>          }
>          return -1;
>      } else if (ioc->opcode =3D=3D QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
> -        /* ping frames produce an immediate reply */
> -        buffer_reset(&ioc->ping_reply);
> -        qio_channel_websock_encode_buffer(
> -            ioc, &ioc->ping_reply, QIO_CHANNEL_WEBSOCK_OPCODE_PONG,
> -            &ioc->encinput);
> +        /* ping frames produce an immediate reply, as long as we've no=
t still
> +         * got a previous ping queued, in which case we drop the new p=
ong */

Wouldn't that be a 'previous pong queued'?

> +        if (ioc->ping_remain =3D=3D 0) {
> +            qio_channel_websock_encode_buffer(
> +                ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_PONG,=

> +                &ioc->encinput);
> +            ioc->ping_remain =3D ioc->encoutput.offset;
> +        }

But if you change the comment, then naming the variable pong_remain may
make more sense.

But naming is a bikeshed issue, so either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SptGgNPBAiuI2BJUdrcvDKA1MLsubUUXm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnc+30ACgkQp6FrSiUn
Q2qtLQf/cedSay8bMR7PqrOBTxliKdr0OCMA2/pqvkDfnrlbIvW0gSUi09IAJWMS
WzqexnfUOeioozsPZbt1ZnM1dBY3GBinGYkz0AEOTTTosQ1ObhUZ5d7pMhk1DmrH
xhbuuEMxWwqhPAmAm2OW3kkPKiSZTZpIbPwNEuBvCp8vZUsw/pYD++aiNoFmbxBb
N53+ABg6GXjKg7MFpEE3+g5AgSdkUTQ4Ysb+Ng+dbtb6eYueISJ4PeSSbUOrwB/n
khnkbjS6R1oCJFUVE+rGGNilefXY7QiDmTEQXAFdHqubN6YaQAgRAzYRErRxRVZ0
VS02bnnKjQ7hxAyXHkb7eYHQb+x2xg==
=TuLM
-----END PGP SIGNATURE-----

--SptGgNPBAiuI2BJUdrcvDKA1MLsubUUXm--
