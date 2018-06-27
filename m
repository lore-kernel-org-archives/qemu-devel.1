Received: from eggs.gnu.org ([2001:4830:134:3::10]:42533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fY9Yd-0005zd-EQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fY9Yc-0004OG-Fb
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:28:23 -0400
Date: Wed, 27 Jun 2018 14:28:15 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180627122815.GD1933@paraplu>
References: <20180626222226.27620-1-jsnow@redhat.com>
	<20180626222226.27620-3-jsnow@redhat.com>
	<841140e6-0ea5-6ca0-f9e4-1f9224b313f5@redhat.com>
	<d77341f6-cb36-3317-e748-64a205e668c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d77341f6-cb36-3317-e748-64a205e668c1@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 2/2] iotests: add 222 to
 test basic fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Jun 27, 2018 at 01:51:59AM -0400, John Snow wrote:

[...]

FWIW, I would also add a little blurb in the commit message about what
"fleecing" exactly is.  Something along the lines of:=20

    "It provides an NBD export that serves you a (read-only?)
    point-in-time (PIT) snapshot of a disk." =20

I'm sure you can come up with better phrasing.

> > The test looks valid - you are definitely reading data over NBD from =
the
> > point in time that you started the blockdev-backup job, even while th=
e
> > source image continues to be modified.
> >=20
> >> +=A0=A0=A0 for p in overwrite:
> >> +=A0=A0=A0=A0=A0=A0=A0 cmd =3D "write -P%s %s %s" % p
> >> +=A0=A0=A0=A0=A0=A0=A0 log(cmd)
> >> +=A0=A0=A0=A0=A0=A0=A0 log(vm.hmp_qemu_io(srcNode, cmd))
> >> +
> >> +=A0=A0=A0 log('')
> >> +=A0=A0=A0 log('--- Verifying Data ---')
> >> +=A0=A0=A0 log('')
> >> +
> >> +=A0=A0=A0 for p in patterns:
> >> +=A0=A0=A0=A0=A0=A0=A0 cmd =3D "read -P%s %s %s" % p
> >> +=A0=A0=A0=A0=A0=A0=A0 log(cmd)
> >> +=A0=A0=A0=A0=A0=A0=A0 assert qemu_io_silent('-r', '-f', 'raw', '-c'=
, cmd, nbd_uri)
> >> =3D=3D 0
> >=20
> > Perhaps additional steps would be to then stop the NBD export, stop t=
he
> > block job, delete the tgtNode fleecing file, then stop qemu, and fina=
lly
> > check that the overwritten patterns correctly show up in the source
> > image (that is, also prove that we can tear down a job, and that the
> > overwrites worked).=A0 And we may want to enhance this test (or use i=
t as
> > a starting point to copy into a new test) to play with persistent dir=
ty
> > bitmaps thrown into the mix as well.=A0 But what you have is already =
a
> > great start to prevent regressions, so:
> >=20
>=20
> Good suggestions. I'm working toward throwing bitmaps in now, but
> actually cleaning up the VM properly and stopping the NBD server and
> testing some of the latter-half paths would be nice. This was just a bi=
t
> of an RFC to get the bits out there sooner rather than later.

Yeah, they can be added later on.  For this test, you can just get away
by cleaning up the VM and the NBD export: log(vm.qmp("nbd-server-stop").

With that:=20

    Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

--=20
/kashyap
