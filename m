Received: from eggs.gnu.org ([2001:4830:134:3::10]:41407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2GA0-00013u-7X
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2G9v-0007zn-LL
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:30:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e2G9v-0007zN-CQ
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:30:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D377C059B65
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 12:30:46 +0000 (UTC)
References: <20171011100959.29326-1-berrange@redhat.com>
	<20171011100959.29326-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <731291c2-90f9-e83a-73d7-ebe42da13d0c@redhat.com>
Date: Wed, 11 Oct 2017 07:30:45 -0500
MIME-Version: 1.0
In-Reply-To: <20171011100959.29326-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jOus2UjJwrxcUHmTpaeJF0RFqkbtopt7F"
Subject: Re: [Qemu-devel] [PATCH v2 4/7] io: pass a struct iovec into
 qio_channel_websock_encode
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
--jOus2UjJwrxcUHmTpaeJF0RFqkbtopt7F
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <731291c2-90f9-e83a-73d7-ebe42da13d0c@redhat.com>
Subject: Re: [PATCH v2 4/7] io: pass a struct iovec into
 qio_channel_websock_encode
References: <20171011100959.29326-1-berrange@redhat.com>
 <20171011100959.29326-5-berrange@redhat.com>
In-Reply-To: <20171011100959.29326-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/11/2017 05:09 AM, Daniel P. Berrange wrote:
> Instead of requiring use of another Buffer, pass a struct iovec
> into qio_channel_websock_encode, which gives callers more
> flexibility in how they process data.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

> +static void qio_channel_websock_encode(QIOChannelWebsock *ioc,
> +                                       uint8_t opcode,
> +                                       const struct iovec *iov,
> +                                       size_t niov,
> +                                       size_t size)
>  {
>      size_t header_size;
> +    size_t i;
>      union {
>          char buf[QIO_CHANNEL_WEBSOCK_HEADER_LEN_64_BIT];
>          QIOChannelWebsockHeader ws;

Is it worth adding assert(size <=3D iov_size(iov, niov)) near the top,

> +    trace_qio_channel_websock_encode(ioc, opcode, header_size, size);
> +    buffer_reserve(&ioc->encoutput, header_size + size);
> +    buffer_append(&ioc->encoutput, header.buf, header_size);
> +    for (i =3D 0; i < niov && size !=3D 0; i++) {
> +        size_t want =3D iov[i].iov_len;
> +        if (want > size) {
> +            want =3D size;
> +        }
> +        buffer_append(&ioc->encoutput, iov[i].iov_base, want);
> +        size -=3D want;
> +    }

so we don't have to worry about a huge size causing us to buffer_reserve
far too much space?

Doesn't affect my R-b, though.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jOus2UjJwrxcUHmTpaeJF0RFqkbtopt7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlneDvUACgkQp6FrSiUn
Q2rcWgf/STEdNxtIswdFyJ0KRnTCCsa4RBogUIqJ4AgiCxJSC0zUKbIF06EM67fJ
SZ5v+KXES146CQiwjWq/L9f+P0HS2Sb4693E1+AGftcGPN8Y/I0grB9hlzBUr4Pz
nFbOi6MxxD2jasscBMy2Dg0Va2+bUtNmqikUtSgfaEXDHBHEhUTx7KhnRkYRcdzi
TlPNsLoana4KV2xorqxPj+MysWoirKQ81vvKpDFChdIRD0W4ZkhkeIt76IpYfEBo
F36QC5cLf4xp477f2hByKZITm5aneQFd08s4+tdwiSPx7Tl+J0gpdlv+dM/jO0cg
tk0zOdh2VceQVAaWOC6XBYQ9dXcVAQ==
=SYc+
-----END PGP SIGNATURE-----

--jOus2UjJwrxcUHmTpaeJF0RFqkbtopt7F--
