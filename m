Received: from eggs.gnu.org ([2001:4830:134:3::10]:51128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGiSH-0002JA-PH
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGiSG-0007oa-OS
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:05:45 -0400
Date: Thu, 10 May 2018 11:05:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510100537.GP1296@stefanha-x1.localdomain>
References: <20180508135436.30140-1-stefanha@redhat.com>
	<20180508135436.30140-2-stefanha@redhat.com>
	<aa220f7d-9aa1-f32d-14f0-35d6a8161032@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IYV9cRr2u6rjcP4B"
Content-Disposition: inline
In-Reply-To: <aa220f7d-9aa1-f32d-14f0-35d6a8161032@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qemu-iotests: reduce chance of
 races in 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>


--IYV9cRr2u6rjcP4B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 09:26:03AM -0500, Eric Blake wrote:
> On 05/08/2018 08:54 AM, Stefan Hajnoczi wrote:
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
> >   tests/qemu-iotests/185 | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
>=20
> I'm not opposed to this patch, but is there any way to write the test to
> take both events in either order, without logging the events as they arri=
ve,
> but instead summarizing in a deterministic order which events were receiv=
ed
> after the fact?  That way, no matter which way the race is won, we merely
> log that we got two expected events, and could avoid the extra sleep.

I don't think there is a practical way of doing that without big changes
to the test.  It could be rewritten in Python to make filtering the QMP
events easier.

Hiding the race doesn't solve the deeper problem though: the test case
doesn't exercise the same code path each time.  The test should really
cover all cancellation points in the block job lifecycle instead of just
one at random.  If we solve this problem then we don't need to filter
the QMP event sequence.

Maybe it can be done with blkdebug.  If not then maybe a blockjobdbg
interface is necessary to perform deterministic tests (eliminating the
need for the ratelimiting trick used by this test!).

Please share ideas, but I think this is a long-term item that shouldn't
block this series.

Stefan

--IYV9cRr2u6rjcP4B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9BlxAAoJEJykq7OBq3PIQT0H/3ETAaiUSm15NpE1I/11VQ0J
e/EKX2ag9HpRIAY+EKVeql3/AsdSOYKBXZkkZ8QyKHWeSdGs3XX0WK3rWYUgjrv2
tM6cF9f6QQNEWAcb/zkEgqjx8lD2MSBcuhVPtQaiKK16PiTTRBi5Olwlw4H4lHqq
YgJYUjWBcKZIlC/Ie9Xl1NAgcoykjohHnkAcs97tVaW1db+u4szMsLFMrrw/KoZz
wUvkbNvdoeAe8Pa7dkLANH1xLlHyf3jwesVww6EWjM4jdEXd0FOg+mftDOaUVcui
rk1LEuo6///kkzlFJCqJZrBHJWHgW/GgRecMv6z//GRqu2gDVr0GDjX7fWJ0U5Q=
=AGRE
-----END PGP SIGNATURE-----

--IYV9cRr2u6rjcP4B--
