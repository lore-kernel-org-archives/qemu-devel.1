Received: from eggs.gnu.org ([209.51.188.92]:59785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtF8m-0001yY-A0
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtEzI-0001zT-JQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:03:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtEzI-0001v6-AX
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:03:20 -0500
Date: Mon, 11 Feb 2019 17:03:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211170313.GK27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190207160617.1142-1-marcandre.lureau@redhat.com>
	<CAFEAcA9hWXR6ynuX8CvFA6AspAgruYiUsQYM0pJ0nNG4b1281w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9hWXR6ynuX8CvFA6AspAgruYiUsQYM0pJ0nNG4b1281w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] Chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Feb 08, 2019 at 11:44:42AM +0000, Peter Maydell wrote:
> On Thu, 7 Feb 2019 at 16:06, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > The following changes since commit 632351e0e1a861f2eaf709b053c53f96a1=
225825:
> >
> >   Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-reques=
t' into staging (2019-02-07 14:20:46 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/elmarco/qemu.git tags/chardev-pull-request
> >
> > for you to fetch changes up to df3afdedd23ade0c9de55cadeb1d8505568902=
3f:
> >
> >   tests/test-char: add muxed chardev testing for open/close (2019-02-=
07 16:18:25 +0100)
> >
> > ----------------------------------------------------------------
> > Various chardev fixes
> >
> > ----------------------------------------------------------------
>=20
> This seems to result in 'make check' failures on some platforms.
> I saw this on s390 and aarch32, I think.
>=20
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-char -m=3Dquick -k --tap < /dev/null |
> ./scripts/tap-driver.pl --test-name=3D"test-char
> "
> PASS 1 test-char /char/null
> PASS 2 test-char /char/invalid
> PASS 3 test-char /char/ringbuf
> PASS 4 test-char /char/mux
> PASS 5 test-char /char/stdio
> PASS 6 test-char /char/pipe
> PASS 7 test-char /char/file
> PASS 8 test-char /char/file-fifo
> PASS 9 test-char /char/udp
> PASS 10 test-char /char/serial
> PASS 11 test-char /char/hotswap
> PASS 12 test-char /char/websocket
> PASS 13 test-char /char/socket/server/mainloop/tcp
> PASS 14 test-char /char/socket/server/mainloop/unix
> PASS 15 test-char /char/socket/server/wait-conn/tcp
> PASS 16 test-char /char/socket/server/wait-conn/unix
> PASS 17 test-char /char/socket/server/mainloop-fdpass/tcp
> PASS 18 test-char /char/socket/server/mainloop-fdpass/unix
> PASS 19 test-char /char/socket/server/wait-conn-fdpass/tcp
> PASS 20 test-char /char/socket/server/wait-conn-fdpass/unix
> PASS 21 test-char /char/socket/client/mainloop/tcp
> PASS 22 test-char /char/socket/client/mainloop/unix
> qemu: qemu_mutex_destroy: Device or resource busy
> PASS 23 test-char /char/socket/client/wait-conn/tcp
> PASS 24 test-char /char/socket/client/wait-conn/unix
> Aborted (core dumped)
> ERROR - too few tests run (expected 32, got 24)
>=20
> Here's a backtrace from running tests/test-char under gdb.
> Looks like a race condition between a thread trying to
> destroy a mutex and a different thread that is still
> using it.

Thanks, that is very useful. I can see the race condition here
now between qio_task_thread_worker and qio_task_thread_result.
I need to acquire the mutex in qio_task_thread_result in order
to sycnhronize with completion of qio_task_thread_worker.

>=20
> On some other hosts I saw a similar
> "qemu: qemu_mutex_destroy: Device or resource busy" and core dump in th=
e
> migration tests, I think, which is probably the same underlying bug.

Yes, I expect it is the same problem


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
