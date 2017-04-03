Received: from eggs.gnu.org ([2001:4830:134:3::10]:46771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cux9g-0003is-CX
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cux9d-0004dD-6n
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:16:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cux9c-0004aN-UA
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:16:01 -0400
Date: Mon, 3 Apr 2017 10:15:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170403081542.GA5036@noname.str.redhat.com>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, pkrempa@redhat.com, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.03.2017 um 19:43 hat Max Reitz geschrieben:
> On 31.03.2017 18:03, Ciprian Barbu wrote:
> > Hello,
> >=20
> > Similar to the other thread about possible regression with rbd, there m=
ight be a regression with nbd.
> > This time we are launching an instance from an image (not volume) and t=
ry to live migrate it:
> >=20
> > nova live-migration <test_instance>
> >=20
> > The nova-compute service complains with:
> >=20
> > 2017-03-31 15:32:56.179 7806 INFO nova.virt.libvirt.driver [req-15d79cb=
e-5956-4738-92df-3624e6b993ee d795de59fb9a4ea38776a11d20ae8469 cee03e74881f=
4ccba3b83345fb652b2c - - -] [instance: 6a04508f-5d79-4582-8e2c-4cc368753f6c=
] Migration running for 0 secs, memory 100% remaining; (bytes processed=3D0=
, remaining=3D0, total=3D0)
> > 2017-03-31 15:32:58.029 7806 WARNING stevedore.named [req-73bc0113-5555=
-4dd8-8903-d3540cc61b47 b9fbceeadd2d4d1bab9c90ae104db1f7 7e7db99b32c6467184=
701e9a0c2f1de7 - - -] Could not load instance_network_info
> > 2017-03-31 15:32:59.038 7806 ERROR nova.virt.libvirt.driver [req-15d79c=
be-5956-4738-92df-3624e6b993ee d795de59fb9a4ea38776a11d20ae8469 cee03e74881=
f4ccba3b83345fb652b2c - - -] [instance: 6a04508f-5d79-4582-8e2c-4cc368753f6=
c] Live Migration failure: internal error: unable to execute QEMU command '=
nbd-server-add': Conflicts with use by drive-virtio-disk0 as 'root', which =
does not allow 'write' on #block143
> > 2017-03-31 15:32:59.190 7806 ERROR nova.virt.libvirt.driver [req-15d79c=
be-5956-4738-92df-3624e6b993ee d795de59fb9a4ea38776a11d20ae8469 cee03e74881=
f4ccba3b83345fb652b2c - - -] [instance: 6a04508f-5d79-4582-8e2c-4cc368753f6=
c] Migration operation has aborted
> >=20
> > I will try and bisect it myself, but I thought I would paste this here =
first, just so you know there is this issue too.
>=20
> Well, I already know the commit in question. It's
> 8a7ce4f9338c475df1afc12502af704e4300a3e0 ("nbd/server: Use real
> permissions for NBD exports").
>=20
> Whether this is a bug depends on the standpoint. I would very much
> consider it a bug fix because as of this commit you can no longer create
> a writable NBD server on a block device that is in use by a guest device
> without the guest device being aware of this.
>=20
> The problem is that the functionality to "make" the guest device "aware"
> of it was introduced only a couple of commits before, and it's called
> "share-rw".
>=20
> So this doesn't work:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 \
>     -blockdev node-name=3Dimage,driver=3Dqcow2,\
> file.driver=3Dfile,file.filename=3Dfoo.qcow2 \
>     -device virtio-blk,drive=3Dimage \
>     -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 92, "minor": 8, "major": 2},
> "package": " (v2.8.0-2038-g6604c893d0)"}, "capabilities": []}}
> {'execute':'qmp_capabilities'}
> {"return": {}}
> {'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data':{=
'host':'localhost','port':'10809'}}}}
> {"return": {}}
> {'execute':'nbd-server-add','arguments':{'device':'image','writable':true=
}}
> {"error": {"class": "GenericError", "desc": "Conflicts with use by
> /machine/peripheral-anon/device[0]/virtio-backend as 'root', which does
> not allow 'write' on image"}
>=20
> But this works:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 \
>     -blockdev node-name=3Dimage,driver=3Dqcow2,\
> file.driver=3Dfile,file.filename=3Dfoo.qcow2 \
>     -device virtio-blk,drive=3Dimage,share-rw=3Don \
>     -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 92, "minor": 8, "major": 2},
> "package": " (v2.8.0-2038-g6604c893d0)"}, "capabilities": []}}
> {'execute':'qmp_capabilities'}
> {"return": {}}
> {'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data':{=
'host':'localhost','port':'10809'}}}}
> {"return": {}}
> {'execute':'nbd-server-add','arguments':{'device':'image','writable':true=
}}
> {"return": {}}
>=20
> (The difference is the share-rw=3Don in the -device parameter.)
>=20
> So in theory all that's necessary is to set share-rw=3Don for the device
> in the management layer. But I'm not sure whether that's practical.

Yes, libvirt needs to provide this option if the guest supports sharing.
If it doesn't support sharing, rejecting a read-write NBD client seems
correct to me.

Peter, Eric, what is the status on the libvirt side here?

> As for just allowing the NBD server write access to the device... To me
> that appears pretty difficult from an implementation perspective. We
> assert that nobody can write without having requested write access and
> we make sure that nobody can request write access without it being
> allowed. Making an exception for NBD seems very difficult and would
> probably mean we'd have to drop the assertion for write accesses altogeth=
er.

Making an exception would simply be wrong.

Kevin

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY4gSuAAoJEH8JsnLIjy/W/KEQAKzXwNkY++XtKmM/L0D2zdSa
JyCHHCzwak2xrs1+C938O+XqrcpJhrCgOlhmbRUwagwpts/DAG1e+OPM8H17DfH3
oT4OUprfnAtGrbFIGkBk4M181Pr5EYYF+L2UGeanifz27igRu+ZGb+H7FRK1QKwg
mu7p+tRYcGSVk9FS5XS1uamdL64D+WeEs3lUWOlY/4q3CK8jBiPBWcTv/pN0w1mk
b2z/gTP+MAumgAd2wMxVUhJyNwxfDPQhgiPWpH1PARousgSWTaVURUKFlEveqHG3
sEXV1Vn02nZfMC3BI/ro1iV6Yk4bD6QqOJUhIRkxhpBqdAK1dAFdDYFxv+X2822N
eFleqz+cjJA/Gfijbz9hRZ+UVzLRHKMtqoa03krDRdNLyOjTRhE7vSlYEsLWJEFr
viZF++AJVjm6wDkWKHbgXGcwlSesPhzLRS/cbBb+7Cx0pkun+Cx4o8tPOCCLq2bu
Rc4MQH5E3X0W6ZxFUwbDdfgMKBKFA/HkJLhLs9D5nbF+mGTCp6L2kJZMkznV/IE0
ZISu3eBkMHzVTNh6owzP0Q1eYyYzgTpPUVzDNnLSGwi0ZmL6lR3yiojH2BnM2yjq
317hlSCUpXayqoyxGVyElo9OAenhdGAiFfs42aOwcPHjDj9uIarGxaoJUmkJCvYm
lQqVijGorceS2kso02DH
=Vt83
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
