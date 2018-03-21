Received: from eggs.gnu.org ([2001:4830:134:3::10]:57426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eym1R-0003Xs-Mv
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 18:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eym1M-0006C5-JS
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 18:15:53 -0400
Date: Wed, 21 Mar 2018 22:15:31 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180321221531.GF2787@redhat.com>
References: <20180321124417.29242-1-ptoscano@redhat.com>
	<20180321125105.GJ19514@redhat.com>
	<65a7365f-89d5-a66c-4e7a-ce8ae1bcf595@redhat.com>
	<2075074.dXtERdIzXi@thyrus.usersys.redhat.com>
	<20180321204420.GL3898@localhost.localdomain>
	<386fe69d-f45b-704a-e936-0211935977ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <386fe69d-f45b-704a-e936-0211935977ce@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [Libguestfs] [PATCH] tests:
 regressions: make test-big-heap use a temporary empty file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Pino Toscano <ptoscano@redhat.com>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, libguestfs@redhat.com, mreitz@redhat.com

On Wed, Mar 21, 2018 at 03:58:05PM -0500, Eric Blake wrote:
> On 03/21/2018 03:44 PM, Kevin Wolf wrote:
> >>>
> >>>You're right that file locking on a character device like /dev/null =
is
> >>>not going to work as expected, but is it a case where fcntl() actual=
ly
> >>>fails, or is it worse where the fcntl() claiming the locks "succeeds=
"
> >>>but doesn't do what we want?  That is, what were the actual error
> >>>messages you ran into?
> >>
> >>$ qemu-img --version
> >>qemu-img version 2.10.1(qemu-2.10.1-2.fc27)
> >>Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project develope=
rs
> >>$ qemu-img info /dev/null
> >>qemu-img: Could not open '/dev/null': Failed to get "consistent read"=
 lock
> >>Is another process using the image?
> >
> >Not sure where the difference is, but I can't reproduce this on
> >upstream, neither git master nor the v2.10.1 tag:
>=20
> Is it a case where file locking actually works, and more than one
> process is trying to lock /dev/null at once?  (qemu-img info is
> short-lived, but could there be another longer-lived process also
> using /dev/null)?
>=20
> Does using -r help (if the only reason you're telling qemu-img to
> operate on /dev/null is to probe qemu-img features, can you probe
> those same features without needing to write, which in turn requests
> less locking)?

The original test (before Pino's patch) runs =E2=80=98qemu-img info /dev/=
null=E2=80=99
purely as a way to fork qemu-img.  It's a regression test for some
problem we had with the code that confines qemu-img using resource
limits.  So really nothing much to do with qemu-img at all.  The fix
is to create a temporary file and run qemu-img against that.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
