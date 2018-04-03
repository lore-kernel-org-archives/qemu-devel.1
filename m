Received: from eggs.gnu.org ([2001:4830:134:3::10]:44258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3LX2-0004XA-Hd
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3LWz-0007BD-BF
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:59:24 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3LWy-0007Ap-WB
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:59:21 -0400
Received: by mail-wr0-x242.google.com with SMTP id u11so18632092wri.12
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 05:59:20 -0700 (PDT)
Date: Tue, 3 Apr 2018 13:59:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180403125918.GF4467@stefanha-x1.localdomain>
References: <20180326061157.24865-1-peterx@redhat.com>
	<20180326104739.GC5267@localhost.localdomain>
	<20180327022155.GE17789@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <20180327022155.GE17789@xz-mi>
Subject: Re: [Qemu-devel] [PATCH] iotests: fix wait_until_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 10:21:55AM +0800, Peter Xu wrote:
> On Mon, Mar 26, 2018 at 12:47:39PM +0200, Kevin Wolf wrote:
> > Am 26.03.2018 um 08:11 hat Peter Xu geschrieben:
> > > If there are more than one events, wait_until_completed() might return
> > > the 2nd event even if the 1st event is JOB_COMPLETED, since the for l=
oop
> > > will continue to run even if completed is set to True.
> > >=20
> > > It never happened before, but it can be triggered when OOB is enabled
> > > due to the RESUME startup message. Fix that up by removing the boolean
> > > and make sure we return the correct event.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  tests/qemu-iotests/iotests.py | 20 ++++++++------------
> > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
> > > index b5d7945af8..11704e6583 100644
> > > --- a/tests/qemu-iotests/iotests.py
> > > +++ b/tests/qemu-iotests/iotests.py
> > > @@ -470,18 +470,14 @@ class QMPTestCase(unittest.TestCase):
> > > =20
> > >      def wait_until_completed(self, drive=3D'drive0', check_offset=3D=
True):
> > >          '''Wait for a block job to finish, returning the event'''
> > > -        completed =3D False
> > > -        while not completed:
> > > -            for event in self.vm.get_qmp_events(wait=3DTrue):
> > > -                if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
> > > -                    self.assert_qmp(event, 'data/device', drive)
> > > -                    self.assert_qmp_absent(event, 'data/error')
> > > -                    if check_offset:
> > > -                        self.assert_qmp(event, 'data/offset', event[=
'data']['len'])
> > > -                    completed =3D True
> > > -
> > > -        self.assert_no_active_block_jobs()
> > > -        return event
> > > +        for event in self.vm.get_qmp_events(wait=3DTrue):
> > > +            if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
> > > +                self.assert_qmp(event, 'data/device', drive)
> > > +                self.assert_qmp_absent(event, 'data/error')
> > > +                if check_offset:
> > > +                    self.assert_qmp(event, 'data/offset', event['dat=
a']['len'])
> > > +                self.assert_no_active_block_jobs()
> > > +                return event
> > > =20
> > >      def wait_ready(self, drive=3D'drive0'):
> > >          '''Wait until a block job BLOCK_JOB_READY event'''
> >=20
> > If an event is pending, but it's not the expected event, won't we return
> > None now instead of waiting for the BLOCK_JOB_COMPLETED event?
>=20
> If so, we'll return none.

Kevin is pointing out that this patch is broken.  Previously the
function waited for BLOCK_JOB_COMPLETED, even when other events were
pending when we entered the function.  Now it returns None and does not
wait for BLOCK_JOB_COMPLETED!

> The patch fixes the other case when there
> are two events: one JOB_COMPLETED plus another (e.g., RESUME) event.
> When that happens, logically we should return one JOB_COMPLETED event,
> but the old code will return the other event (e.g., RESUME).
>=20
> >=20
> > Wouldn't it be much easier to just add a 'break'?
>=20
> Yes, it's the same.  But IMHO those logics (e.g., the completed
> variable) are not really needed at all.  This one is simpler.

No, the outer loop is needed so that the function waits until
BLOCK_JOB_COMPLETED is received.  It's not possible to do it with a
single for loop.

Stefan

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaw3qmAAoJEJykq7OBq3PIsJMIAIv6jzLjYMj6yPTOXEY+Apjr
SSd7Cj+LCWTNpXICgEyqeCgeII4tH6rK/JbbJeLCeVyxd7JeAsKHxFtLdO3+UYPL
0/xDOVmjJskykKffGTOFbyZ6TlKfdPDSVjCcSJaypue4pqMqR6Gx4aSvGYJrJChw
GWYlz+5U6eAAohvMry7/k5dxAMYrQcUhkAGQYjCLtFYCiBOec1T7C+3vzyIs9s42
sMqyHGv1naAizsGXaRZ3cSaa1c+37OAjiWq9S/BY0FDk0bwPcOWdsjYANNV7n/yZ
LVLvvbkpD0Ypk96AX0ufGyeZlAgY8Kt9C1tinG1jpgGrDJEJ7YubL2yJaxVDpoI=
=+32o
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
