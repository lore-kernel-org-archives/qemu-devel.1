Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7m5u-0005qZ-D5
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7m5q-00036R-Dp
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:05:10 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d7m5q-00036H-9w
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:05:06 -0400
Received: by mail-qt0-x243.google.com with SMTP id j13so10379019qta.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 10:05:06 -0700 (PDT)
Date: Mon, 8 May 2017 13:05:03 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508170503.GH22428@stefanha-x1.localdomain>
References: <20170505162305.15763-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <20170505162305.15763-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Revert "Change net/socket.c to use
 socket_*() functions" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 05:23:05PM +0100, Daniel P. Berrange wrote:
> This reverts commit 883e4f7624e10b98d16d9adaffb8b1795664d899.
>=20
> This code changed net/socket.c from using socket()+connect(),
> to using socket_connect(). In theory this is great, but in
> practice this has completely broken the ability to connect
> the frontend and backend:
>=20
>   $ ./x86_64-softmmu/qemu-system-x86_64 \
>        -device e1000,id=3De0,netdev=3Dhn0,mac=3DDE:AD:BE:EF:AF:05 \
>        -netdev socket,id=3Dhn0,connect=3Dlocalhost:1234
>   qemu-system-x86_64: -device e1000,id=3De0,netdev=3Dhn0,mac=3DDE:AD:BE:E=
F:AF:05: Property 'e1000.netdev' can't find value 'hn0'
>=20
> The old code would call net_socket_fd_init() synchronously,
> while letting the connect() complete in the backgorund. The
> new code moved net_socket_fd_init() so that it is only called
> after connect() completes in the background.
>=20
> Thus at the time we initialize the NIC frontend, the backend
> does not exist.
>=20
> The socket_connect() conversion as done is a bad fit for the
> current code, since it did not try to change the way it deals
> with async connection completion. Rather than try to fix this,
> just revert the socket_connect() conversion entirely.
>=20
> The code is about to be converted to use QIOChannel which
> will let the problem be solved in a cleaner manner. This
> revert is more suitable for stable branches in the meantime.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  net/socket.c | 127 ++++++++++++++++++++++++++---------------------------=
------
>  1 file changed, 56 insertions(+), 71 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEKU/AAoJEJykq7OBq3PIbdcIAL6KRUPd+N87f7CPzncOnF3/
FPSAwzbA4dkuOBDNfBfKzLNUbJgIzTY++MwdHkqPyhtTto3QtmaQM69za2w5w2i6
3x54dU+5+D/jNXcS6dhFRf/+Ku2b3lA0EDrhUtUn93KTCs7W2qBR7I9n/EJoEyyb
lKTHgNdxtheS9WwPfU48uthhaHUw2JcHN6zpCSy9oWvqhVNp4xAZssvkQKuHFYha
p//Hb8IqnvZEDjbpUqs5Z9SSWHujMIrU7kSCw0qKa/2zqGlLkYTe8exhxanCf7Fc
nqDbm3VdQ0R+jq8lBpd69dcmlzRnHncIiJwMzgLA7FriuE6ZYO95Alb2/2EMUMA=
=jfz6
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
