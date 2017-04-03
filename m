Received: from eggs.gnu.org ([2001:4830:134:3::10]:53851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1cv1Rm-0005Uk-IY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1cv1Ri-0003a4-JF
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:51:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1cv1Ri-0003ZS-96
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:50:58 -0400
Date: Mon, 3 Apr 2017 14:51:48 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20170403125148.GX26598@andariel.pipo.sk>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bEH3Ad9qdU9b/Xs9"
Content-Disposition: inline
In-Reply-To: <20170403081542.GA5036@noname.str.redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>


--bEH3Ad9qdU9b/Xs9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 10:15:42 +0200, Kevin Wolf wrote:
> Am 31.03.2017 um 19:43 hat Max Reitz geschrieben:
> > On 31.03.2017 18:03, Ciprian Barbu wrote:

[...]

> > So this doesn't work:
> >=20
> > $ x86_64-softmmu/qemu-system-x86_64 \
> >     -blockdev node-name=3Dimage,driver=3Dqcow2,\
> > file.driver=3Dfile,file.filename=3Dfoo.qcow2 \
> >     -device virtio-blk,drive=3Dimage \
> >     -qmp stdio
> > {"QMP": {"version": {"qemu": {"micro": 92, "minor": 8, "major": 2},
> > "package": " (v2.8.0-2038-g6604c893d0)"}, "capabilities": []}}
> > {'execute':'qmp_capabilities'}
> > {"return": {}}
> > {'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data'=
:{'host':'localhost','port':'10809'}}}}
> > {"return": {}}
> > {'execute':'nbd-server-add','arguments':{'device':'image','writable':tr=
ue}}
> > {"error": {"class": "GenericError", "desc": "Conflicts with use by
> > /machine/peripheral-anon/device[0]/virtio-backend as 'root', which does
> > not allow 'write' on image"}
> >=20
> > But this works:
> >=20
> > $ x86_64-softmmu/qemu-system-x86_64 \
> >     -blockdev node-name=3Dimage,driver=3Dqcow2,\
> > file.driver=3Dfile,file.filename=3Dfoo.qcow2 \
> >     -device virtio-blk,drive=3Dimage,share-rw=3Don \
> >     -qmp stdio
> > {"QMP": {"version": {"qemu": {"micro": 92, "minor": 8, "major": 2},
> > "package": " (v2.8.0-2038-g6604c893d0)"}, "capabilities": []}}
> > {'execute':'qmp_capabilities'}
> > {"return": {}}
> > {'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data'=
:{'host':'localhost','port':'10809'}}}}
> > {"return": {}}
> > {'execute':'nbd-server-add','arguments':{'device':'image','writable':tr=
ue}}
> > {"return": {}}
> >=20
> > (The difference is the share-rw=3Don in the -device parameter.)
> >=20
> > So in theory all that's necessary is to set share-rw=3Don for the device
> > in the management layer. But I'm not sure whether that's practical.
>=20
> Yes, libvirt needs to provide this option if the guest supports sharing.
> If it doesn't support sharing, rejecting a read-write NBD client seems
> correct to me.
>=20
> Peter, Eric, what is the status on the libvirt side here?

Libvirt currently uses the NBD server only for non-shared storage
migration. At that point the disk is not shared (while qemu may think
so) since the other side is not actually running until the mirror
reaches synchronized state.

The fix should be trivial.

> > As for just allowing the NBD server write access to the device... To me
> > that appears pretty difficult from an implementation perspective. We
> > assert that nobody can write without having requested write access and
> > we make sure that nobody can request write access without it being
> > allowed. Making an exception for NBD seems very difficult and would
> > probably mean we'd have to drop the assertion for write accesses altoge=
ther.
>=20
> Making an exception would simply be wrong.
>=20
> Kevin



--bEH3Ad9qdU9b/Xs9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAljiRWAACgkQHGwCByjY
1Gq1FhAAqoQg/02HlxmtVKqrr+iTtFjpljpzy6wRgtiFZivnyOSKBMv6rXeM+2KF
bE/EzzOqYxRkjJtoCzUAziG80YV1lFFP6RZTdhwk/NzrhPp/a/HLtCfLK42EaYOv
69h56IUPZlJXudLeBeqRyIJ+TkQzbrGdR1ygJSN+Lx2cqj1kksFSXcyCe7DH2FFq
aV24tyZ9yHpNGBhQeCwSsPV5aBVKaQGHo/sbruBa02WKTQzPSP7DA4gvZIXnUcEK
e20pDYHGNj/KMbMlz/7RvDRpmaJ3hZ+9fs6ZqM7ByJQmvOZ0c4jeaqqwQf/j+JfO
6dMWh0N0sPBhrs2mamVkNz53QNSiSS4/pYyxv6/ShBPxc316E4wcfrVPY6gIrNbY
OH6p7gVfm9KVA7u31xrhGSb3C5WPo+kv/tZ6L9a+wj3wjvHvo5a4PJnvvdd2O4Kt
qLtyQv+XttKaO/+4UC/VGjNheShUImDKRGSnKLE9hCI60UQFGySm6ELUviUW0bV4
4QKIK9JzVBkOJDE9c0rcD4m+/puj7TLS94pN9FrMx+JkY610ZniAKNuXQqxelftT
4dFfgfuBXTPfUOBFvyn/stoH1j5OL6Ox7OVOyp85cB6nTOrtW8BeyI+dAKXeL2zF
05GY4/R2a0khm24MGm27nUiRibt0R8jjrHsY8u06dxoKahuj0O4=
=8zWC
-----END PGP SIGNATURE-----

--bEH3Ad9qdU9b/Xs9--
