Received: from eggs.gnu.org ([2001:4830:134:3::10]:38808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fl6W0-0004ld-Ey
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 01:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fl6Vx-0007as-CA
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 01:51:12 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52060)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fl6Vw-0007ZG-TY
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 01:51:09 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121701.12867.49392.stgit@pasha-VirtualBox>
	<87zhyerotn.fsf@linaro.org> <000301d42565$aeeb2e40$0cc18ac0$@ru>
	<87sh44sk5j.fsf@linaro.org>
In-Reply-To: <87sh44sk5j.fsf@linaro.org>
Date: Thu, 2 Aug 2018 08:50:59 +0300
Message-ID: <000001d42a24$ca6df4e0$5f49dea0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v5 23/24] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net


> -----Original Message-----
> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Sent: Friday, July 27, 2018 7:45 PM
> To: Pavel Dovgalyuk
> Cc: 'Pavel Dovgalyuk'; qemu-devel@nongnu.org; kwolf@redhat.com; =
peter.maydell@linaro.org;
> war2jordan@live.com; crosthwaite.peter@gmail.com; =
boost.lists@gmail.com; quintela@redhat.com;
> ciro.santilli@gmail.com; jasowang@redhat.com; mst@redhat.com; =
zuban32s@gmail.com;
> armbru@redhat.com; maria.klimushenkova@ispras.ru; kraxel@redhat.com;
> thomas.dullien@googlemail.com; pbonzini@redhat.com; mreitz@redhat.com; =
dgilbert@redhat.com;
> rth@twiddle.net
> Subject: Re: [PATCH v5 23/24] replay: add BH oneshot event for block =
layer
>=20
>=20
> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>=20
> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> > Replay is capable of recording normal BH events, but sometimes
> >> > there are single use callbacks scheduled with =
aio_bh_schedule_oneshot
> >> > function. This patch enables recording and replaying such =
callbacks.
> >> > Block layer uses these events for calling the completion =
function.
> >> > Replaying these calls makes the execution deterministic.
> >> >
> >> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >>
> >> I'm not sure what about this commit causes the compile breakage I'm
> >> seeing:
> >>
> >>   LINK    aarch64-linux-user/qemu-aarch64
> >> ../libqemuutil.a(cpu-get-icount.o):(.bss+0x0): multiple definition =
of `use_icount'
> >> exec.o:(.bss+0x58): first defined here
> >> collect2: error: ld returned 1 exit status
> >> Makefile:199: recipe for target 'qemu-aarch64' failed
> >> make[1]: *** [qemu-aarch64] Error 1
> >> Makefile:481: recipe for target 'subdir-aarch64-linux-user' failed
> >> make: *** [subdir-aarch64-linux-user] Error 2
> >>
> >> It only occurs on a make clean && make -j on that commit though. =
It's
> >> hidden if you do incremental builds.
> >
> > make distclean works for me in such cases.
>=20
> Hmmm
>=20
> make distclean
> ./configure
> make
>=20
> And I get:
>=20
> LINK    aarch64-linux-user/qemu-aarch64
> ../libqemuutil.a(cpu-get-icount.o):(.bss+0x0): multiple definition of =
`use_icount'
> exec.o:(.bss+0x58): first defined here
> collect2: error: ld returned 1 exit status
> Makefile:199: recipe for target 'qemu-aarch64' failed
> make[1]: *** [qemu-aarch64] Error 1
> Makefile:481: recipe for target 'subdir-aarch64-linux-user' failed
> make: *** [subdir-aarch64-linux-user] Error 2

That's strange. As I understand, linux-user emulators does not include =
block layer.
They also don't include record/replay.
Why then block- and record-related stub affects the build?

Pavel Dovgalyuk
