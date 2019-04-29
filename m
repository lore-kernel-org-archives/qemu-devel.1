Received: from eggs.gnu.org ([209.51.188.92]:45728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hLChj-0008Ud-Fx
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hLChi-0001iK-CB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:16:47 -0400
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-11-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <03585bce-afb0-cd39-9732-7946fa1b03fc@redhat.com>
Date: Mon, 29 Apr 2019 22:16:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190311165017.32247-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UwYAwpf3FIGPA23cfN0gdzurn9fdoRaNS"
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
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UwYAwpf3FIGPA23cfN0gdzurn9fdoRaNS
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <03585bce-afb0-cd39-9732-7946fa1b03fc@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 10/10] file-posix: Make auto-read-only
 dynamic
References: <20190311165017.32247-1-kwolf@redhat.com>
 <20190311165017.32247-11-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.03.19 17:50, Kevin Wolf wrote:
> Until now, with auto-read-only=3Don we tried to open the file read-writ=
e
> first and if that failed, read-only was tried. This is actually not goo=
d
> enough for libvirt, which gives QEMU SELinux permissions for read-write=

> only as soon as it actually intends to write to the image. So we need t=
o
> be able to switch between read-only and read-write at runtime.
>=20
> This patch makes auto-read-only dynamic, i.e. the file is opened
> read-only as long as no user of the node has requested write
> permissions, but it is automatically reopened read-write as soon as the=

> first writer is attached. Conversely, if the last writer goes away, the=

> file is reopened read-only again.
>=20
> bs->read_only is no longer set for auto-read-only=3Don files even if th=
e
> file descriptor is opened read-only because it will be transparently
> upgraded as soon as a writer is attached. This changes the output of
> qemu-iotests 232.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c         | 36 +++++++++++++++++-------------------
>  tests/qemu-iotests/232.out | 12 ++++++------
>  2 files changed, 23 insertions(+), 25 deletions(-)

https://bugzilla.redhat.com/show_bug.cgi?id=3D1703793 seems to be caused
by this patch: When the mirror job completes, it drops all permissions
on its target BB with an &error_abort.  As of this patch, this may
result in file-posix attempting to reopen the FD, which may fail.

There are two problems I can see: First, the previous patch should have
updated s->open_flags along with s->fd when the FD is switched.  As it
is now, s->open_flags is not updated, so it stays on O_RDONLY and every
time the permissions are checked, the FD is reconfigured and then switche=
d.

That's simple to fix, just add BDRVRawState.perm_change_flags and set it
to open_flags after raw_reconfigure_getfd() returned a ret !=3D s->fd
(when s->perm_change_fd is set).

That fixes the problem of file-posix attempting to reopen the FD to
O_RDWR all the time, which caused the crash.

But that gives us another crash, because now dropping the permissions
(correctly) reopens the FD to O_RDONLY, with the exact same implications
as above: If the target becomes unavailable, opening the new FD will
fail, and qemu will crash.

I don't know what to do about this.  In the spirit of "dropping
permissions should always work", I presume raw_reconfigure_getfd()
should just return the old FD if it had more permissions than the new
one would have.  But if the user issues an explicit reopen command, they
probably want such an error to be reported.

Max


--UwYAwpf3FIGPA23cfN0gdzurn9fdoRaNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzHW6cACgkQ9AfbAGHV
z0AYnAf/e31fEFmLPwebhQ54XUV7sQY3UbPuQZmRgkRhybqBZlkS9wLuVcSxs6Kx
AXk9yibnxgKkEveYM/DVC//xkuoF6Vw43Auh23G6+mIhtg/i5Yd1lH4PiLVP3LKl
KHeg3JOrd/i2bU2GEIZ+NbMNNHpRlkTL4Kci7wtIS3CLqircxsG3Io2QkwnCFx8a
ARJrLDavh6AFSInSbAxliMPCDyVmBopgrmcCkb2dhlg2IBNcVLadVvR+k2OLINzh
1N2e73blfDbz1x5jluSOkIXbbjbvLr8JaYxH2FNwDb4mW7MUt1XnkUy/0LI/a+nr
vAtFFCq2V3QAF7PJL8Z6rvjFEIBJMQ==
=j151
-----END PGP SIGNATURE-----

--UwYAwpf3FIGPA23cfN0gdzurn9fdoRaNS--
