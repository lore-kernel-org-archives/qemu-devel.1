Received: from eggs.gnu.org ([2001:4830:134:3::10]:35558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvPy-0003IU-3I
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvPv-0007dx-68
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:25:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQvPu-0007dd-W2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:25:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FE9B72D9E
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:25:14 +0000 (UTC)
Date: Mon, 18 Dec 2017 13:25:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218132509.GB16653@stefanha-x1.localdomain>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20171215150659.1811-14-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/13] tests: fix coroutine leak in
 /basic/entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 04:06:59PM +0100, Marc-Andr=E9 Lureau wrote:
> The coroutine is not finished by the time the test ends, resulting in
> ASAN warning:
>=20
> =3D=3D7005=3D=3DERROR: LeakSanitizer: detected memory leaks
>=20
> Direct leak of 312 byte(s) in 1 object(s) allocated from:
>     #0 0x7fd35290fa38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea3=
8)
>     #1 0x7fd3506c5f75 in g_malloc0 ../glib/gmem.c:124
>     #2 0x55994af03e47 in qemu_coroutine_new /home/elmarco/src/qemu/util/c=
oroutine-ucontext.c:144
>     #3 0x55994aefed99 in qemu_coroutine_create /home/elmarco/src/qemu/uti=
l/qemu-coroutine.c:76
>     #4 0x55994ac1eb50 in verify_entered_step_1 /home/elmarco/src/qemu/tes=
ts/test-coroutine.c:80
>     #5 0x55994af03c75 in coroutine_trampoline /home/elmarco/src/qemu/util=
/coroutine-ucontext.c:119
>     #6 0x7fd34ec02bef  (/lib64/libc.so.6+0x50bef)
>=20
> Do not yield() to let the coroutine terminate.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-coroutine.c | 1 -
>  1 file changed, 1 deletion(-)

Looks like a copy-paste mistake, the second yield shouldn't be there.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN8G1AAoJEJykq7OBq3PIsNMIAKwgZsjLqXfEUqNd36hK2Pbn
fjH6b4bfQxoZdzjPW341d6dBXP/37VtM7d0lHQaQz1umGidYdLzYZVgHBAkh2azU
0PxMlWqeSdlDjNZtsryyJavS67bScti9K5/L+u9mImAizAw7hvi2hc1Ags4klOs7
QQK8O+LXDN7xkErSq7K3hQ+EaF2CDS8PIEOlv7oR6aK/Eyn8l9Ac3M3XEzs5aPRV
uQCyPkXNDejdKgGvEhwaOn0Ib55aKsEya3lKuajCIiGoUJXKOGbd1De8rlISX9L3
/MqR5zKBIDy4tMcTR+xbNVd8a9cuFQx16DeA6PT4guu/wX92hWM1Qr0crF5cDYc=
=KDRJ
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
