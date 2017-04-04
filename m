Received: from eggs.gnu.org ([2001:4830:134:3::10]:54700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvOMZ-0004t5-FL
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvOMV-0004Fo-GU
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:19:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cvOMV-0004Ff-8f
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:19:07 -0400
Date: Tue, 4 Apr 2017 15:19:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170404131902.GB4536@noname.str.redhat.com>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<20170403125148.GX26598@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20170403125148.GX26598@andariel.pipo.sk>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.04.2017 um 14:51 hat Peter Krempa geschrieben:
> On Mon, Apr 03, 2017 at 10:15:42 +0200, Kevin Wolf wrote:
> > Am 31.03.2017 um 19:43 hat Max Reitz geschrieben:
> > > On 31.03.2017 18:03, Ciprian Barbu wrote:
>=20
> [...]
>=20
> > > So this doesn't work:
> > >=20
> > > $ x86_64-softmmu/qemu-system-x86_64 \
> > >     -blockdev node-name=3Dimage,driver=3Dqcow2,\
> > > file.driver=3Dfile,file.filename=3Dfoo.qcow2 \
> > >     -device virtio-blk,drive=3Dimage \
> > >     -qmp stdio
> > > {"QMP": {"version": {"qemu": {"micro": 92, "minor": 8, "major": 2},
> > > "package": " (v2.8.0-2038-g6604c893d0)"}, "capabilities": []}}
> > > {'execute':'qmp_capabilities'}
> > > {"return": {}}
> > > {'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','dat=
a':{'host':'localhost','port':'10809'}}}}
> > > {"return": {}}
> > > {'execute':'nbd-server-add','arguments':{'device':'image','writable':=
true}}
> > > {"error": {"class": "GenericError", "desc": "Conflicts with use by
> > > /machine/peripheral-anon/device[0]/virtio-backend as 'root', which do=
es
> > > not allow 'write' on image"}
> > >=20
> > > But this works:
> > >=20
> > > $ x86_64-softmmu/qemu-system-x86_64 \
> > >     -blockdev node-name=3Dimage,driver=3Dqcow2,\
> > > file.driver=3Dfile,file.filename=3Dfoo.qcow2 \
> > >     -device virtio-blk,drive=3Dimage,share-rw=3Don \
> > >     -qmp stdio
> > > {"QMP": {"version": {"qemu": {"micro": 92, "minor": 8, "major": 2},
> > > "package": " (v2.8.0-2038-g6604c893d0)"}, "capabilities": []}}
> > > {'execute':'qmp_capabilities'}
> > > {"return": {}}
> > > {'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','dat=
a':{'host':'localhost','port':'10809'}}}}
> > > {"return": {}}
> > > {'execute':'nbd-server-add','arguments':{'device':'image','writable':=
true}}
> > > {"return": {}}
> > >=20
> > > (The difference is the share-rw=3Don in the -device parameter.)
> > >=20
> > > So in theory all that's necessary is to set share-rw=3Don for the dev=
ice
> > > in the management layer. But I'm not sure whether that's practical.
> >=20
> > Yes, libvirt needs to provide this option if the guest supports sharing.
> > If it doesn't support sharing, rejecting a read-write NBD client seems
> > correct to me.
> >=20
> > Peter, Eric, what is the status on the libvirt side here?
>=20
> Libvirt currently uses the NBD server only for non-shared storage
> migration. At that point the disk is not shared (while qemu may think
> so) since the other side is not actually running until the mirror
> reaches synchronized state.

Yes, I misunderstood the situation at first.

Anyway, is there already a libvirt patch for the cases where the image
is actually shared?

Kevin

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY451GAAoJEH8JsnLIjy/WF7kQALXQrA4denujnqCDZW2iz4Ms
XVd7zpGat566CYon61KFTZGBzJL78vZfyOfOCpqRRLtsY38EJ56kfysKhg4BDxIC
RXX3IkF2hyXxpytsWe66vELBehL2aFdVn/xiX8aqx7ZosVu7aCSnblo5SqUeHCEU
8qiYTL47zatwVo1ur181S9rHGI30ExclXDGI3luB7obM/IWYf+fTkehe1UAODUN+
13b13YQO9/7xqGg3TBLpk3Fj9wTd11lZVNldU64sEvkiHxRX57SmysmE9ucJjO/O
YHnED/tNOe1hpbfP+bpsM5fVNeCvm83stkNilu2sxpib1TBcqCTg0tAuMjTeoggE
ZfWnffPdbhGs56dHQSSCMkccLsDbnqC2ouTWMRwmSSWDra62NRhkrC7ffgcMAIpT
ZofLQwC/rsoSnJ98r1HO0Bs0NCV71ZmeGXD5LwhrW/6fmfxGBbtN0WaEVSjy/eZ/
TBU3XcCOlWXOX3Pj55zunQg/Qq4JWeZkvYoiqHPzxoqAfmkafVztRQmdlHVvamnT
/X9Uw6+FvEydpAL2LLs+nHO+fgL0sLmh+9tF6uU72JhzMFDZJLhbh/yWPKON7jEC
690pIOpDOkAVc3dqOi65Bzf9DT62Be52IcnUHrvKdasF3TIWJFZgBNsxL5kyJBC3
rheshmIjMSJAUc7bkjRw
=wKTa
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
