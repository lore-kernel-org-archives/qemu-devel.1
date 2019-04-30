Received: from eggs.gnu.org ([209.51.188.92]:51240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQzR-0005Fo-38
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQzP-00032e-Jo
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:32:01 -0400
Date: Tue, 30 Apr 2019 13:31:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190430113117.GH5607@linux.fritz.box>
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-11-kwolf@redhat.com>
	<03585bce-afb0-cd39-9732-7946fa1b03fc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <03585bce-afb0-cd39-9732-7946fa1b03fc@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 10/10] file-posix: Make
 auto-read-only dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.04.2019 um 22:16 hat Max Reitz geschrieben:
> On 11.03.19 17:50, Kevin Wolf wrote:
> > Until now, with auto-read-only=3Don we tried to open the file read-write
> > first and if that failed, read-only was tried. This is actually not good
> > enough for libvirt, which gives QEMU SELinux permissions for read-write
> > only as soon as it actually intends to write to the image. So we need to
> > be able to switch between read-only and read-write at runtime.
> >=20
> > This patch makes auto-read-only dynamic, i.e. the file is opened
> > read-only as long as no user of the node has requested write
> > permissions, but it is automatically reopened read-write as soon as the
> > first writer is attached. Conversely, if the last writer goes away, the
> > file is reopened read-only again.
> >=20
> > bs->read_only is no longer set for auto-read-only=3Don files even if the
> > file descriptor is opened read-only because it will be transparently
> > upgraded as soon as a writer is attached. This changes the output of
> > qemu-iotests 232.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/file-posix.c         | 36 +++++++++++++++++-------------------
> >  tests/qemu-iotests/232.out | 12 ++++++------
> >  2 files changed, 23 insertions(+), 25 deletions(-)
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1703793 seems to be caused
> by this patch: When the mirror job completes, it drops all permissions
> on its target BB with an &error_abort.  As of this patch, this may
> result in file-posix attempting to reopen the FD, which may fail.

Hm, yes. But we already agreed that dropping permissions should never
fail, so maybe we should just implement that now (in block.c).

> There are two problems I can see: First, the previous patch should have
> updated s->open_flags along with s->fd when the FD is switched.  As it
> is now, s->open_flags is not updated, so it stays on O_RDONLY and every
> time the permissions are checked, the FD is reconfigured and then switche=
d.
>=20
> That's simple to fix, just add BDRVRawState.perm_change_flags and set it
> to open_flags after raw_reconfigure_getfd() returned a ret !=3D s->fd
> (when s->perm_change_fd is set).

=2E..and actually do s->open_flags =3D s->perm_change_flags in
raw_set_perm(), otherwise it doesn't help much. :-)

> That fixes the problem of file-posix attempting to reopen the FD to
> O_RDWR all the time, which caused the crash.

Good.

> But that gives us another crash, because now dropping the permissions
> (correctly) reopens the FD to O_RDONLY, with the exact same implications
> as above: If the target becomes unavailable, opening the new FD will
> fail, and qemu will crash.
>=20
> I don't know what to do about this.  In the spirit of "dropping
> permissions should always work", I presume raw_reconfigure_getfd()
> should just return the old FD if it had more permissions than the new
> one would have.  But if the user issues an explicit reopen command, they
> probably want such an error to be reported.

Yes, I think file-posix should let the operation fail (because it
actually failed) and the permission functions in block.c should ignore
the error for dropping permissions. This way, reopen will still
correctly return the error because it has a different call chain.

Kevin

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcyDIFAAoJEH8JsnLIjy/WeNAQAK0jbe+ytjNBTD8CsW23J1kD
XE7ta7jevXSc59LtsOoFKvGjuspEiejKc3OaJr+Oh1r247xTWzn+GzO2yVs6kA8z
qOYdEvg12pgDlFLYzQkYs9npCIctq7RSHRBFGx0KRDleUq0Jdkp9Pttm0RZ7YtfG
Lm26CIup7f8BdRZDEtuXKb7HKSJjbMDH+KAB38zcesLSf/b7QSNN8h4lIoY+XQd9
bYWXSLp/dYwHUdpE6ZDaK/Eb8hpWrNxDghwRcJ4UAPfdzctReqM5vB/yAiQU+fnU
zCR74cPQLpOtQlbhfJ/HBExuL90UQySW8KEfMAfW65/QL2Clz8eI50gK0+CjfccE
I2Vm3ebMvXCQ/UvA17R81/avxf5/VOIjYxC/3qBxi1AhZmC/NRV5Faxn55CCTtXJ
bqy7fHopn2830dS/I7F+g56P41ZHosm0AWeZZAktAlXuI7BBfwdii2fHjvFkXr9M
hUJtjr2f1O3nAMa2o8nnxEm7YAWpuM/adpzmwp2zdm/Mj5FpWmr9wrbjqSdTtr1U
Gvg+ncSAcP6GcdXzfzhvRFiwaIU0i4819zYlFSmxBusfLxbY3T5+JzIpPy/Uj1JM
AA/1EMn6Kso61/t/QYS3cZOiyVJ2K0ugFAtvA8E71wC2287GiT5M8o09fsxvQaJY
YPqbOJ4TXcoMGmIMVIXv
=0wko
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
