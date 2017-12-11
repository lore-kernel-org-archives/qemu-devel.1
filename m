Received: from eggs.gnu.org ([2001:4830:134:3::10]:53209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eOM6S-0001g9-Ex
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eOM6N-0001Z2-Fv
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:18:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eOM6N-0001XV-9u
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:18:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4541A84E
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 11:18:25 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BAE6560C13
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 11:18:25 +0000 (UTC)
Date: Mon, 11 Dec 2017 06:18:25 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1138111065.53748953.1512991105572.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171208133829.GA7600@stefanha-x1.localdomain>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
	<20171208005825.14587-13-marcandre.lureau@redhat.com>
	<20171208133829.GA7600@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

Hi

----- Original Message -----
> On Fri, Dec 08, 2017 at 01:58:25AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Not strictly necessary, but it may help ASAN and remove some false
> > positives.
> >=20
> > Sadly, this annotation produces an ASAN error:
> >=20
> > $ tests/test-coroutine -p /basic/lifecycle
> > /basic/lifecycle: =3D=3D27655=3D=3DWARNING: ASan doesn't fully support
> > makecontext/swapcontext functions and may produce false positives in so=
me
> > cases!
> > =3D=3D27655=3D=3DAddressSanitizer CHECK failed:
> > /builddir/build/BUILD/compiler-rt-4.0.1.src/lib/asan/asan_poisoning.cc:=
38
> > "((AddrIsAlignedByGranularity(addr + size))) !=3D (0)" (0x0, 0x0)
> >     #0 0x55d1e4e8a695 in __asan::AsanCheckFailed(char const*, int, char
> >     const*, unsigned long long, unsigned long long)
> >     (/home/elmarco/src/qq/build/tests/test-coroutine+0x1c0695)
> >     #1 0x55d1e4ea6235 in __sanitizer::CheckFailed(char const*, int, cha=
r
> >     const*, unsigned long long, unsigned long long)
> >     (/home/elmarco/src/qq/build/tests/test-coroutine+0x1dc235)
> >     #2 0x55d1e4e82ea4 in __asan::PoisonShadow(unsigned long, unsigned l=
ong,
> >     unsigned char)
> >     (/home/elmarco/src/qq/build/tests/test-coroutine+0x1b8ea4)
> >     #3 0x55d1e4dde1e7 in __asan::FakeStack::Destroy(int)
> >     (/home/elmarco/src/qq/build/tests/test-coroutine+0x1141e7)
> >     #4 0x55d1e528b775 in qemu_coroutine_switch
> >     /home/elmarco/src/qq/util/coroutine-ucontext.c:219:9
> >     #5 0x55d1e528b18d in coroutine_trampoline
> >     /home/elmarco/src/qq/util/coroutine-ucontext.c:114:9
> >     #6 0x7fb3e0087bef  (/lib64/libc.so.6+0x50bef)
>=20
> Looks like a step in the right direction.
>=20

Thanks Stefan, I suppose this is not irony ;)

I'll try to nail down the issue and make a small reproducer for ASAN.
