Received: from eggs.gnu.org ([2001:4830:134:3::10]:44306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gMv6M-0001y3-Ng
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gMv6J-0007ma-Ei
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:21:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gMv6H-0007f0-Dv
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:20:59 -0500
Date: Wed, 14 Nov 2018 13:20:43 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181114132043.GE27120@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<871s7nstle.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <871s7nstle.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, stefanha@redhat.com, renzo@cs.unibo.it

On Wed, Nov 14, 2018 at 01:59:25PM +0100, Markus Armbruster wrote:
> Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Hi,
> >
> > Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch
> >
> > This series goal is to allow building libslirp as an independent libr=
ary.
> >
> > While looking at making SLIRP a seperate running process, I thought
> > that having an independent library from QEMU would be a first step.
> >
> > There has been some attempts to make slirp a seperate project in the =
past.
> > (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
> > Unfortunately, they forked from QEMU and didn't provide enough
> > compatibility for QEMU to make use of it (in particular, vmstate
> > handling was removed, they lost git history etc). Furthermore, they
> > are not maintained as far as I can see.
> >
> > I would propose to make slirp a seperate project, that can initially
> > be used by QEMU as a submodule, keeping Makefile.objs until a proper
> > shared library with stability guarantees etc is ready..
> >
> > The subproject could created by preserving git tags, and cleaning up =
the code style, this way:
> >
> > git filter-branch --tree-filter "if ls * 1> /dev/null 2>&1; then clan=
g-format -i * /dev/null; fi " -f --subdirectory-filter "slirp" --prune-em=
pty --tag-name-filter cat -- --all
> > (my clang-format https://gist.github.com/elmarco/cb20c8d92007df0e2fb8=
a2404678ac73)
> >
> > What do you think?
>=20
> Has the slirp code been improved to be generally useful?  I still got i=
t
> filed under "friends don't let friends use that, except for testing"...

SLIRP may or may not be bad internally -- I don't know -- but it
provides an unbeatable feature that nothing else replaces: no setup,
no root network access.  We use it all over the place.

The idea of these patches is to move SLIRP into a separate project and
have it run as a separate process.  This solves IMHO two problems:
qemu maintainers don't seem to like it, as demonstrated above, and if
there are any security problems them we can nail down the SLIRP
external process so it has literally no access to the host except for
the handful of network socket system calls it needs.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
