Received: from eggs.gnu.org ([2001:4830:134:3::10]:50471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG2KQ-0007x9-Gy
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG2KL-0006Zx-IS
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:06:50 -0400
Date: Tue, 8 May 2018 14:06:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508130642.GP19710@stefanha-x1.localdomain>
References: <20180504155014.10311-1-stefanha@redhat.com>
	<20180504155014.10311-2-stefanha@redhat.com>
	<67aaa31e-c797-7b00-76da-8be6ca69517d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CKf/2jVYos1l2hij"
Content-Disposition: inline
In-Reply-To: <67aaa31e-c797-7b00-76da-8be6ca69517d@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] qemu-iotests: reduce
 chance of races in 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--CKf/2jVYos1l2hij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 08:43:43PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 04.05.2018 18:50, Stefan Hajnoczi wrote:
> > Commit 8565c3ab537e78f3e69977ec2c609dc9417a806e ("qemu-iotests: fix
> > 185") identified a race condition in a sub-test.
> >=20
> > Similar issues also affect the other sub-tests.  If disk I/O completes
> > quickly, it races with the QMP 'quit' command.  This causes spurious
> > test failures because QMP events are emitted in an unpredictable order.
> >=20
> > This test relies on QEMU internals and there is no QMP API for getting
> > deterministic behavior needed to make this test 100% reliable.  At the
> > same time, the test is useful and it would be a shame to remove it.
> >=20
> > Add sleep 0.5 to reduce the chance of races.  This is not a real fix but
> > appears to reduce spurious failures in practice.
> >=20
> > Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   tests/qemu-iotests/185     | 12 ++++++++++++
> >   tests/qemu-iotests/185.out |  4 ++--
> >   2 files changed, 14 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
> > index 298d88d04e..975404c99d 100755
> > --- a/tests/qemu-iotests/185
> > +++ b/tests/qemu-iotests/185
> > @@ -118,6 +118,9 @@ _send_qemu_cmd $h \
> >                         'speed': 65536 } }" \
> >       "return"
> > +# If we don't sleep here 'quit' command races with disk I/O
> > +sleep 0.5
> > +
> >   _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
> >   wait=3D1 _cleanup_qemu
> > @@ -137,6 +140,9 @@ _send_qemu_cmd $h \
> >                         'speed': 65536 } }" \
> >       "return"
> > +# If we don't sleep here 'quit' command races with disk I/O
> > +sleep 0.5
> > +
> >   _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
> >   wait=3D1 _cleanup_qemu
> > @@ -183,6 +189,9 @@ _send_qemu_cmd $h \
> >                         'speed': 65536 } }" \
> >       "return"
> > +# If we don't sleep here 'quit' command races with disk I/O
> > +sleep 0.5
> > +
> >   _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
> >   wait=3D1 _cleanup_qemu
> > @@ -201,6 +210,9 @@ _send_qemu_cmd $h \
> >                         'speed': 65536 } }" \
> >       "return"
> > +# If we don't sleep here 'quit' command races with disk I/O
> > +sleep 0.5
> > +
> >   _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
> >   wait=3D1 _cleanup_qemu
> > diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
> > index 2c4b04de73..1f21e79c13 100644
> > --- a/tests/qemu-iotests/185.out
> > +++ b/tests/qemu-iotests/185.out
> > @@ -26,9 +26,9 @@ Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D671=
08864 backing_file=3DTEST_DIR/t.q
> >   {"return": {}}
> >   {"return": {}}
> > -{"return": {}}
> > -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "SHUTDOWN", "data": {"guest": false}}
> >   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "e=
vent": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304, "offse=
t": 4194304, "speed": 65536, "type": "commit"}}
> > +{"return": {}}
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "SHUTDOWN", "data": {"guest": false}}
> >   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "e=
vent": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len": 4194304, "o=
ffset": 4194304, "speed": 65536, "type": "commit"}}
> >   =3D=3D=3D Start mirror job and exit qemu =3D=3D=3D
>=20
> Hm, it looks strange, that commit was done with such a small speed in 0.5
> seconds...

Rate-limiting is broken in the mirror job (qemu.git/master), so that's
why it completes within 0.5s.

A separate patch (already in Jeff's tree) fixes the rate-limiting issue.

I will rebase onto Jeff's tree and resend.  Thanks for pointing this
out!

Stefan

--CKf/2jVYos1l2hij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8aDiAAoJEJykq7OBq3PIuz4IAI/0xmiGI+ovPndHPv+K0nvY
Y7cdIbPxewRYVm90HnJp31hL+l85otEwKJpjOU0j+G6VEeAvqGyKyL31OQEGLNcm
pZxvUtHU5o8F7CDaM1Ru5BLvU5AMDcY5HKi9G6rVNPpnKDLyQkKBPGERqfLGeaTY
lLyc4osIOui/7SxRxkUFlSOM+52cmP2Gp59BvlcXaXsQdZ1RA3jU+z2ng/EtUPpb
UoKxu9mx/OiF96dSDEH1o1RprVlakscf45CJdWz4xJ/m/rIh/ZTzL6VdgZpf5/lJ
HyIGMpVwbGevZLXxbdXQo/gfYnuoZHhNI1f4QOXetpKoUnm5LnegpkuFCNne+6Q=
=XlmZ
-----END PGP SIGNATURE-----

--CKf/2jVYos1l2hij--
