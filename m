Received: from eggs.gnu.org ([209.51.188.92]:39851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn7HR-0002S1-Pc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn7HQ-0002bx-TO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:36:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gn7HQ-0002aE-KN
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:36:44 -0500
Date: Fri, 25 Jan 2019 14:36:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190125143247-mutt-send-email-mst@kernel.org>
References: <20190115200252.25911-1-mst@redhat.com>
	<20190115200252.25911-8-mst@redhat.com>
	<690e996c-2ece-5b4b-956b-e5a50f22f975@redhat.com>
	<b5a2251d-d992-47b8-012f-1257476752c8@comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b5a2251d-d992-47b8-012f-1257476752c8@comstyle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 07/49] util: check the return value of
 fcntl in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <n54@gmx.com>

On Fri, Jan 25, 2019 at 02:04:15PM -0500, Brad Smith wrote:
> On 1/25/2019 1:53 PM, Philippe Mathieu-Daud=E9 wrote:
>=20
> > Hi,
> >=20
> > On 1/15/19 9:04 PM, Michael S. Tsirkin wrote:
> > > From: Li Qiang <liq3ea@163.com>
> > >=20
> > > Assert that the return value is not an error. This is like commit
> > > 7e6478e7d4f for qemu_set_cloexec.
> > >=20
> > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >   util/oslib-posix.c | 8 ++++++--
> > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > index c1bee2a581..4ce1ba9ca4 100644
> > > --- a/util/oslib-posix.c
> > > +++ b/util/oslib-posix.c
> > > @@ -233,14 +233,18 @@ void qemu_set_block(int fd)
> > >   {
> > >       int f;
> > >       f =3D fcntl(fd, F_GETFL);
> > > -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> > > +    assert(f !=3D -1);
> > > +    f =3D fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> > > +    assert(f !=3D -1);
> > >   }
> > >   void qemu_set_nonblock(int fd)
> > >   {
> > >       int f;
> > >       f =3D fcntl(fd, F_GETFL);
> > > -    fcntl(fd, F_SETFL, f | O_NONBLOCK);
> > > +    assert(f !=3D -1);
> > > +    f =3D fcntl(fd, F_SETFL, f | O_NONBLOCK);
> > > +    assert(f !=3D -1);
> > This commit breaks OpenBSD, when trying to start QEMU I get:
> > assertion "f !=3D -1" failed: file "util/oslib-posix.c", line 247,
> > function "qemu_set_nonblock"
> >=20
> > Having a quick look at gdb, the last device opened is /dev/null, and
> > when fcntl() fails we have errno =3D ENODEV.
> >=20
> >      19 ENODEV Operation not supported by device.
> >      An attempt was made to apply an inappropriate function to a devi=
ce,
> >      for example, trying to read a write-only device such as a printe=
r.
> >=20
> > Digging further I found a recent commit which could fix this problem:
> > https://github.com/openbsd/src/commit/c2a35b387f9d3c
> > "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, s=
o
> > the memory devices (/dev/null, /dev/zero, etc) need to permit them."
> >=20
> > Brad: Do you think this might be the fix? If so, any idea what is the
> > first release to contain this fix? I don't know OpenBSD and can't fig=
ure
> > this out... Also, what would be the cleaner QEMU fix?
>=20
> I don't know. But that commit was included with 6.3 or newer.

I'm quite prepared to revert that - the value of spreading
asserts around is marginal and if we don't set fd
even on a real file to non-blocking qemu doesn't explode -
it just hangs which isn't much worse than an assert.

Let me know.

--=20
MST
