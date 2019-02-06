Received: from eggs.gnu.org ([209.51.188.92]:35301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grNgv-0005zW-NK
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grNgu-00056u-CG
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:56:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grNgr-000517-Uh
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:56:39 -0500
Date: Wed, 6 Feb 2019 13:56:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190206135621.GN12331@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
	<CAMxuvayEOLrg4FOt2iwHwZrQZ6aY6OhQeU9YaTSG+YBadp-5kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvayEOLrg4FOt2iwHwZrQZ6aY6OhQeU9YaTSG+YBadp-5kQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/16] chardev: refactoring & many
 bugfixes related tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>

On Wed, Feb 06, 2019 at 02:45:22PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
> On Wed, Jan 23, 2019 at 6:27 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > This is a followup to
> >
> >   v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03344.=
html
> >
> > This series comes out of a discussion between myself & Yongji Xie in:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01881.html
> >
> > I eventually understood that the problem faced was that
> > tcp_chr_wait_connected was racing with the background connection atte=
mpt
> > previously started, causing two connections to be established. This
> > broke because some vhost user servers only allow a single connection.
> >
> > After messing around with the code alot the final solution was in fac=
t
> > very easy. We simply have to delay the first background connection
> > attempt until the main loop is running. It will then automatically
> > turn into a no-op if tcp_chr_wait_connected has been run. This is
> > dealt with in the last patch in this series
> >
> > I believe this should solve the problem Yongji Xie faced, and thus no=
t
> > require us to add support for "nowait" option with client sockets at
> > all. The reconnect=3D1 option effectively already implements nowait
> > semantics, and now plays nicely with tcp_chr_wait_connected.
> >
> > In investigating this I found various other bugs that needed fixing a=
nd
> > identified some useful refactoring to simplify / clarify the code, he=
nce
> > this very long series.
> >
> > This series passes make check-unit & check-qtest (for x86_64 target).
> >
> > I did a test with tests/vhost-user-bridge too, which was in fact alre=
ady
> > broken for the same reason Yongji Xie found - it only accepts a singl=
e
> > connection. This series fixes use of reconnect=3D1 with vhost-user-br=
idge.
> >
> > Changed in v2:
> >
> >  - Rewrite the way we synchronize in tcp_chr_wait_connected again
> >    to cope with chardev+device hotplug scenario
> >  - Add extensive unit test coverage
> >  - Resolve conflicts with git master
> >
> > Daniel P. Berrang=C3=A9 (16):
> >   io: store reference to thread information in the QIOTask struct
> >   io: add qio_task_wait_thread to join with a background thread
> >   chardev: fix validation of options for QMP created chardevs
> >   chardev: forbid 'reconnect' option with server sockets
> >   chardev: forbid 'wait' option with client sockets
> >   chardev: remove many local variables in qemu_chr_parse_socket
> >   chardev: ensure qemu_chr_parse_compat reports missing driver error
> >   chardev: remove unused 'sioc' variable & cleanup paths
> >   chardev: split tcp_chr_wait_connected into two methods
> >   chardev: split up qmp_chardev_open_socket connection code
> >   chardev: use a state machine for socket connection state
> >   chardev: honour the reconnect setting in tcp_chr_wait_connected
> >   chardev: disallow TLS/telnet/websocket with tcp_chr_wait_connected
> >   chardev: fix race with client connections in tcp_chr_wait_connected
> >   tests: expand coverage of socket chardev test
> >   chardev: ensure termios is fully initialized
> >
> >  chardev/char-serial.c          |   2 +-
> >  chardev/char-socket.c          | 487 ++++++++++++++++++-------
> >  chardev/char.c                 |   2 +
> >  include/io/task.h              |  29 +-
> >  io/task.c                      |  88 +++--
> >  io/trace-events                |   2 +
> >  tests/ivshmem-test.c           |   2 +-
> >  tests/libqtest.c               |   4 +-
> >  tests/test-char.c              | 643 ++++++++++++++++++++++++-------=
--
> >  tests/test-filter-redirector.c |   4 +-
> >  10 files changed, 928 insertions(+), 335 deletions(-)
> >
>=20
> With the fix squashed, I am queuing this series.
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

FYI in case you didn't notice, the fix i posted for patch 1, will
invalidate a small part of patch 2 where I had fixed the same
problem without realizing/remembering

I pushed my updated branch to if you want to compare:

  https://github.com/berrange/qemu/commits/chr-sock

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
