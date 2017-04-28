Received: from eggs.gnu.org ([2001:4830:134:3::10]:52640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d47L4-0001DN-Ht
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d47Kz-0005gA-Vi
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:57:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d47Kz-0005fn-M9
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:57:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43666680E9
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 14:57:36 +0000 (UTC)
References: <20170428121553.22408-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f1ae51f-5336-7789-66b0-c4f984b5c0cc@redhat.com>
Date: Fri, 28 Apr 2017 09:57:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170428121553.22408-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5r05tAMcNcrOgF8rHqfolKa3WpDxFBXVC"
Subject: Re: [Qemu-devel] [PATCH] sockets: ensure we can bind to both ipv4 &
 ipv6 separately
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
--5r05tAMcNcrOgF8rHqfolKa3WpDxFBXVC
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <6f1ae51f-5336-7789-66b0-c4f984b5c0cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: ensure we can bind to both ipv4 &
 ipv6 separately
References: <20170428121553.22408-1-berrange@redhat.com>
In-Reply-To: <20170428121553.22408-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 07:15 AM, Daniel P. Berrange wrote:
> When binding to an IPv6 socket we currently force the
> IPV6_V6ONLY flag to off. This means that the IPv6 socket
> will accept both IPv4 & IPv6 sockets when QEMU is launched
> with something like
>=20
>   -vnc :::1

At first glance, I thought that was too many :.  But I guess it is
parsed as host:screen, with host of '::', and port offset of '1'...

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

=2E..and matches this being parsed as host of '' and port offset of '1'

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
>  util/qemu-sockets.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5r05tAMcNcrOgF8rHqfolKa3WpDxFBXVC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA1hUAAoJEKeha0olJ0Nqf2gIAI0gWHBKM/7c74fQK7Gr8Hcj
4KurTOZh5uEWv+RPcWjzlaXJ5fxxhCVI8xBryUuCL6xOn3/lnA9zjEnGhqHVaM8W
jz0RAwuQy2Mie7ut+OmSYePb51RF9K5TLj7usQXd1EHeFKFfSU52NxkQZe8F1dNc
FPEwF+w2GU2QisjwY8RFV45SzrkvHFXkn/6qCHpgjeMCe8/v27yQlH1tVm9dnVIy
cnne0s89ban8LjKhsS/SSxDCZJOg4gLfny6PdZ8T3DX6e6ojW/G6O2e2k+k7nTLk
uWVyJgWF+0rT+KC3WBckNU+BRO/08TQgPJhy7seFo/LBrhueVy59VzeZ3Zm30jI=
=BfrE
-----END PGP SIGNATURE-----

--5r05tAMcNcrOgF8rHqfolKa3WpDxFBXVC--
