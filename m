Received: from eggs.gnu.org ([2001:4830:134:3::10]:54079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpIf-0005Vv-J6
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpIc-00016Y-FU
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:31:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCpIc-000161-6j
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:31:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BBDC72497
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:31:09 +0000 (UTC)
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cfb86d90-8a74-ed2c-ae15-feb7d628f197@redhat.com>
Date: Mon, 22 May 2017 10:30:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170519180342.19618-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qrMnPV52vxIwCwHBb7FbU2XtIvjH55mh3"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] sockets: don't block IPv4 clients
 when listening on "::"
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
--qrMnPV52vxIwCwHBb7FbU2XtIvjH55mh3
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <cfb86d90-8a74-ed2c-ae15-feb7d628f197@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] sockets: don't block IPv4 clients
 when listening on "::"
References: <20170519180342.19618-1-berrange@redhat.com>
 <20170519180342.19618-3-berrange@redhat.com>
In-Reply-To: <20170519180342.19618-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 01:03 PM, Daniel P. Berrange wrote:
> When inet_parse() parses the hostname, it is forcing the
> has_ipv6 && ipv6 flags if the address contains a ":". This
> means that if the user had set the ipv4=3Don flag, to try to
> restrict the listener to just ipv4, an error would not have
> been raised.  eg
>=20
>    -incoming tcp:[::]:9000,ipv4
>=20
> should have raised an error because listening for IPv4
> on "::" is a non-sensical combination.

If I understand correctly, the correct response (and post-patch
behavior) is an error (mismatch between requesting IPv4-only usage while
giving an IPv6 address), but the buggy response (pre-patch behavior) is
that we ended up setting ipv6 in addition to the user-set ipv4 (because
we found a ':'), and then end up listening on IPv6 after all contrary to
the user's request.


> With this removed,
> we now call getaddrinfo() on "::" passing PF_INET and
> so getaddrinfo reports an error about the hostname being
> incompatible with the requested protocol.
>=20
> Likewise it is explicitly setting the has_ipv4 & ipv4
> flags when the address contains only digits + '.'. This
> has no ill-effect, but also has no benefit, so is removed.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qrMnPV52vxIwCwHBb7FbU2XtIvjH55mh3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIwQwAAoJEKeha0olJ0NqzMwH/Rf/vIA35yn/qsftEPzaXIFZ
W9FowcArLxcB21gdo+qClF+JvIiV9e6c79hRIsZ0qS8/tGLj79ingZ1nZa0K3O+v
iqQe3sCdeUJQH+mqknUCOtkhBALLCY/bYWC/glplnO7VYR9HtGm0Gj2m3R/zVf/k
efyQRq4w4wpzFARZKqoYDawQLhnmmk+lMLfUHPCqZsoA3Ua03nnz34R9Z051QpPv
cZ8ViNM/KVfOOeOOihA+CNZIwz/JPiShqH9F7TVGO6sEmnJDtpRD1I1HRfLzInof
knMgF7hOpw2ubBahnZHRY0WmuYTtyd1KGT7BgGBxwZ6Wej2WLUP5NHN6QK2m1+c=
=zgMg
-----END PGP SIGNATURE-----

--qrMnPV52vxIwCwHBb7FbU2XtIvjH55mh3--
