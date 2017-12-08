Received: from eggs.gnu.org ([2001:4830:134:3::10]:59146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNIrO-0004Gc-K9
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNIrN-0005DQ-Kl
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:38:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eNIrN-0005Ce-DP
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:38:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8796E3D97C
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 13:38:36 +0000 (UTC)
Date: Fri, 8 Dec 2017 13:38:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171208133829.GA7600@stefanha-x1.localdomain>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
	<20171208005825.14587-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20171208005825.14587-13-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/12] WIP ucontext: annotate coroutine
 stack for ASAN
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


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 01:58:25AM +0100, Marc-Andr=E9 Lureau wrote:
> Not strictly necessary, but it may help ASAN and remove some false
> positives.
>=20
> Sadly, this annotation produces an ASAN error:
>=20
> $ tests/test-coroutine -p /basic/lifecycle
> /basic/lifecycle: =3D=3D27655=3D=3DWARNING: ASan doesn't fully support ma=
kecontext/swapcontext functions and may produce false positives in some cas=
es!
> =3D=3D27655=3D=3DAddressSanitizer CHECK failed: /builddir/build/BUILD/com=
piler-rt-4.0.1.src/lib/asan/asan_poisoning.cc:38 "((AddrIsAlignedByGranular=
ity(addr + size))) !=3D (0)" (0x0, 0x0)
>     #0 0x55d1e4e8a695 in __asan::AsanCheckFailed(char const*, int, char c=
onst*, unsigned long long, unsigned long long) (/home/elmarco/src/qq/build/=
tests/test-coroutine+0x1c0695)
>     #1 0x55d1e4ea6235 in __sanitizer::CheckFailed(char const*, int, char =
const*, unsigned long long, unsigned long long) (/home/elmarco/src/qq/build=
/tests/test-coroutine+0x1dc235)
>     #2 0x55d1e4e82ea4 in __asan::PoisonShadow(unsigned long, unsigned lon=
g, unsigned char) (/home/elmarco/src/qq/build/tests/test-coroutine+0x1b8ea4)
>     #3 0x55d1e4dde1e7 in __asan::FakeStack::Destroy(int) (/home/elmarco/s=
rc/qq/build/tests/test-coroutine+0x1141e7)
>     #4 0x55d1e528b775 in qemu_coroutine_switch /home/elmarco/src/qq/util/=
coroutine-ucontext.c:219:9
>     #5 0x55d1e528b18d in coroutine_trampoline /home/elmarco/src/qq/util/c=
oroutine-ucontext.c:114:9
>     #6 0x7fb3e0087bef  (/lib64/libc.so.6+0x50bef)

Looks like a step in the right direction.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKpXVAAoJEJykq7OBq3PIG1gH/0GeIVCay4dWPj9xtQEsOiXs
EcPFgJJ5rnZb8P80fiwXm5CpeSnFKiaT2O39n71My29JFrWlKr2yJgo+SwdnrktZ
1e5cw+7IcbSjZMEpZJ5Ahb9LRLxsUwfJf52Fq/icnvQzlmRjJ70bB6MTfi4vJkhj
0mmMoQmkv1Dk2UfJEslVJggEbPv1qjkj8NT/L3D5i2rcg6nO/NnAVhVmjGj/r6VG
twRJLQ5N65uTQPqLaCxq14WfANCkvuiUGrcygIwti5A88KuSuphL+TqxKaBb1Dwb
iI51pW2RPqsPpAC3V0LY9dwvOQC+C2vuvEbpRr9qbfDUSL3gqEw7CCUFAkDXd0M=
=VJOl
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
