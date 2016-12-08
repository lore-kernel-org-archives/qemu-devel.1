Received: from eggs.gnu.org ([2001:4830:134:3::10]:33716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cEtQK-0005uV-B1
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cEtQH-0003bN-8b
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:47:24 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:59933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cEtQH-0003ZS-0c
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:47:21 -0500
Date: Thu, 8 Dec 2016 02:47:16 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <414279889.3011871.1481183236280.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA8y2q1HDg0fL0kPLyySfNmPUpR2jCk1rzMhm1kcbzcBhQ@mail.gmail.com>
References: <65fce607-1674-d208-965b-0e2f667664dd@redhat.com>
	<2082277889.2697853.1467841252544.JavaMail.zimbra@redhat.com>
	<20160706222026.9860.13979@loki>
	<d7998329-3a73-197d-9afd-915052e1f454@redhat.com>
	<20160706230204.9860.27543@loki>
	<CAFEAcA8y2q1HDg0fL0kPLyySfNmPUpR2jCk1rzMhm1kcbzcBhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] test-qga failures on Fedora 24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi

----- Original Message -----
> On 7 July 2016 at 00:02, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > Quoting John Snow (2016-07-06 17:41:32)
> >>
> >>
> >> On 07/06/2016 06:20 PM, Michael Roth wrote:
> >> > Quoting Marc-Andr=C3=A9 Lureau (2016-07-06 16:40:52)
> >> >>> Here's the meat of it:
> >> >>>
> >> >>>   LINK  tests/test-qga
> >> >>> GTESTER tests/test-qga
> >> >>> **
> >> >>> ERROR:/home/bos/jhuston/src/qemu/tests/test-qga.c:266:test_qga_get=
_fsinfo:
> >> >>> assertion failed ret: GenericError realpath("/sys/dev/block/8:17")=
: No
> >> >>> such file or directory
> >> >>> GTester: last random seed: R02S9d55aa8939b9bd797279bd3f69d33466
> >> >>> **
> >> >>> ERROR:/home/bos/jhuston/src/qemu/tests/test-qga.c:685:test_qga_bla=
cklist:
> >> >>> assertion failed ret: GenericError realpath("/sys/dev/block/8:17")=
: No
> >> >>> such file or directory
> >> >>> GTester: last random seed: R02Sb9bc461c2129c284f83033dca27827c6
> >> >>> /home/bos/jhuston/src/qemu/tests/Makefile.include:684: recipe for
> >> >>> target
> >> >>> 'check-tests/test-qga' failed
> >> >>> make: *** [check-tests/test-qga] Error 1
> >> >>>
> >> >>>
> >> >>> Any clues as to what's gone awry?
>=20
> >> Good news: The problem went away.
> >>
> >> It was likely due to an external XFS drive I have that perhaps didn't
> >> properly register as ejected. I unmounted it and re-mounted it and now
> >> everything's fine.
> >>
> >> I'm not sure where it got 8:17, though. I guess mtab was stale?
> >
> > Yah, that would explain it. The values are pulled from mtab via
> > getmntent()
>=20
> I just ran into this today too (in my case due to an external
> USB mass storage device that was powered-down without being
> unmounted). It's kind of annoying that the test fails: why should
> it care at all about what block devices you happen to have
> on your system, whether they're mounted or busted or otherwise ?
>=20

Since guest-get-fsinfo isn't always succeeding, I propose to either handle =
errors gracefully and/or to move it with other tests under QGA_TEST_SIDE_EF=
FECTING.

QGA_TEST_SIDE_EFFECTING is supposed to succeed under a test VM/container, i=
t's probably best to just move the test there.
