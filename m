Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpE4-0004Kj-8W
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpE1-0007VM-4Y
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCpE0-0007UW-SL
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9FB861D1F
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:26:22 +0000 (UTC)
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <073211ce-d3df-da9f-8c70-cafc2dd1270e@redhat.com>
Date: Mon, 22 May 2017 10:26:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170519180342.19618-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="onDOG0mLXH0ibfNJ1qOW1b6TMP2evVjkK"
Subject: Re: [Qemu-devel] [PATCH v2 1/5] sockets: ensure we can bind to both
 ipv4 & ipv6 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--onDOG0mLXH0ibfNJ1qOW1b6TMP2evVjkK
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <073211ce-d3df-da9f-8c70-cafc2dd1270e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] sockets: ensure we can bind to both
 ipv4 & ipv6 separately
References: <20170519180342.19618-1-berrange@redhat.com>
 <20170519180342.19618-2-berrange@redhat.com>
In-Reply-To: <20170519180342.19618-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 01:03 PM, Daniel P. Berrange wrote:
> When binding to an IPv6 socket we currently force the
> IPV6_V6ONLY flag to off. This means that the IPv6 socket
> will accept both IPv4 & IPv6 sockets when QEMU is launched
> with something like
>=20
>   -vnc :::1
>=20
> While this is good for that case, it is bad for other
> cases. For example if an empty hostname is given,
> getaddrinfo resolves it to 2 addresses 0.0.0.0 and ::,
> in that order. We will thus bind to 0.0.0.0 first, and
> then fail to bind to :: on the same port. The same
> problem can happen if any other hostname lookup causes
> the IPv4 address to be reported before the IPv6 address.
>=20
> When we get an IPv6 bind failure, we should re-try the
> same port, but with IPV6_V6ONLY turned on again, to
> avoid clash with any IPv4 listener.
>=20
> This ensures that
>=20
>   -vnc :1
>=20
> will bind successfully to both 0.0.0.0 and ::, and also
> avoid
>=20
>   -vnc :1,to=3D2
>=20
> from mistakenly using a 2nd port for the :: listener.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>=20

>          for (p =3D port_min; p <=3D port_max; p++) {
> +#ifdef IPV6_V6ONLY
> +            /* listen on both ipv4 and ipv6 */
> +            int v6only =3D 0;
> +#endif
>              inet_setport(e, p);
> +#ifdef IPV6_V6ONLY
> +        rebind:
> +            if (e->ai_family =3D=3D PF_INET6) {

The rebind: label could go here with no change in semantics and one less
conditional when compiled without optimization. But hopefully the
compiler is smart enough to see that under -O2, so I don't see a reason
for you to change the code.

> +                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &v=
6only,
> +                                sizeof(v6only));
> +            }
> +#endif
>              if (bind(slisten, e->ai_addr, e->ai_addrlen) =3D=3D 0) {
>                  goto listen;
>              }
> +
> +#ifdef IPV6_V6ONLY
> +            /* If we got EADDRINUSE from an IPv6 bind & V6ONLY is unse=
t,
> +             * it could be that the IPv4 port is already claimed, so r=
etry
> +             * with V6ONLY set
> +             */
> +            if (e->ai_family =3D=3D PF_INET6 && errno =3D=3D EADDRINUS=
E && !v6only) {
> +                v6only =3D 1;
> +                goto rebind;
> +            }
> +#endif
> +

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--onDOG0mLXH0ibfNJ1qOW1b6TMP2evVjkK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIwMRAAoJEKeha0olJ0NqQeMIAIFZuK/YFexpkxSxYMXBsrwB
lLM9d7nE87mid58SQpNizGMf5M1c3feYU6f/THmCMHkO++tiUKUYWsZD8yjfRugr
A8w5PxkqSYxzsQt7zKN80KzbI1MRByMPNllQ0sheoNYAeuvgqO3bbhcyf80W56/z
ANnzn5BQy+0Jcwtjs1FSpGLrq7j65aIt4i2OTtjP9FnapTovsNCwz8b/uZRSXK0W
011eAV2hra3I8GWr1iVmXGxsytu6YyheBx6SzvfW5rHabtL4CuViKohccf+sMA89
6SqEm/3rveELr8mDvoZRfAuwTlfezs/eXVxn3SvvlF3670yBmiF5DWharsY+3hc=
=QKrI
-----END PGP SIGNATURE-----

--onDOG0mLXH0ibfNJ1qOW1b6TMP2evVjkK--
