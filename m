Received: from eggs.gnu.org ([2001:4830:134:3::10]:52281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3jKd-0005UU-UF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3jKa-00011L-Pt
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:24:11 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3jKa-00010v-Ik
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:24:08 -0400
Received: by mail-wm0-x22b.google.com with SMTP id p9so41452363wmc.3
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 07:24:08 -0700 (PDT)
Date: Wed, 4 Apr 2018 15:24:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404142405.GU4467@stefanha-x1.localdomain>
References: <20180326061157.24865-1-peterx@redhat.com>
	<20180326104739.GC5267@localhost.localdomain>
	<20180327022155.GE17789@xz-mi>
	<20180403125918.GF4467@stefanha-x1.localdomain>
	<20180404014241.GG26441@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQqDiQVflaif2hna"
Content-Disposition: inline
In-Reply-To: <20180404014241.GG26441@xz-mi>
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


--NQqDiQVflaif2hna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 09:42:41AM +0800, Peter Xu wrote:
> On Tue, Apr 03, 2018 at 01:59:18PM +0100, Stefan Hajnoczi wrote:
> > On Tue, Mar 27, 2018 at 10:21:55AM +0800, Peter Xu wrote:
> > > On Mon, Mar 26, 2018 at 12:47:39PM +0200, Kevin Wolf wrote:
> > > > Am 26.03.2018 um 08:11 hat Peter Xu geschrieben:
> > > The patch fixes the other case when there
> > > are two events: one JOB_COMPLETED plus another (e.g., RESUME) event.
> > > When that happens, logically we should return one JOB_COMPLETED event,
> > > but the old code will return the other event (e.g., RESUME).
> > >=20
> > > >=20
> > > > Wouldn't it be much easier to just add a 'break'?
> > >=20
> > > Yes, it's the same.  But IMHO those logics (e.g., the completed
> > > variable) are not really needed at all.  This one is simpler.
> >=20
> > No, the outer loop is needed so that the function waits until
> > BLOCK_JOB_COMPLETED is received.  It's not possible to do it with a
> > single for loop.
>=20
> Indeed.  But then I would still slightly prefer removing the
> "completed" var:
>=20
>     def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue):
>         '''Wait for a block job to finish, returning the event'''
>         while True:
>             for event in self.vm.get_qmp_events(wait=3DTrue):
>                 if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
>                     self.assert_qmp(event, 'data/device', drive)
>                     self.assert_qmp_absent(event, 'data/error')
>                     if check_offset:
>                         self.assert_qmp(event, 'data/offset', event['data=
']['len'])
>                     self.assert_no_active_block_jobs()
>                     return event
>=20
> Or a single break would work too.  Do either of you have any
> preference?  I can repost in either way.  Thanks,

Looks good to me!

Stefan

--NQqDiQVflaif2hna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxOAFAAoJEJykq7OBq3PI7KsH/3ROgCBXScs0M6tRcUomBm9p
A9z5q5amrVk5YE4atqHmn9xJWde26BQ97mtaInUxktOaY6yuWCY/QbZ0US+5ZkBZ
7Cb2seZb/CN42K0Vv1mEZnI2z6S7aMUAmnyEkpUTBR1g1hJ86UMs0ncUnG1LJSrb
oitC8zpdrWJ1adyTyn/bBDoJP6CGFPpsuCJxsrd4BL3ppR/o7eqDt4WUYTpy1hxX
Q7+Ea88YgBjD+a1Xkgq79hZXmCTNd02DtCnqXidc65Yl3QZV7zgnWyCY4loH2cqK
ks3ujjm/ngCKrs+ONEzb4yFF4Ld/CSPhZOq+KftEpNvH/uFIe5gjAkynCI8sSls=
=QEX0
-----END PGP SIGNATURE-----

--NQqDiQVflaif2hna--
