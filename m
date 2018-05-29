Received: from eggs.gnu.org ([2001:4830:134:3::10]:53818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNjgI-0001nY-NE
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNjgH-0003Zl-Ir
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:49:14 -0400
Date: Tue, 29 May 2018 20:49:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180529184904.GJ4756@localhost.localdomain>
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-9-kwolf@redhat.com>
	<8b64d45f-0e9c-107f-a55a-bb3880c60eb6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
In-Reply-To: <8b64d45f-0e9c-107f-a55a-bb3880c60eb6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/14] qemu-iotests: Rewrite 206 for
 blockdev-create job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.05.2018 um 14:27 hat Max Reitz geschrieben:
> On 2018-05-25 18:33, Kevin Wolf wrote:
> > This rewrites the test case 206 to work with the new x-blockdev-create
> > job rather than the old synchronous version of the command.
> >=20
> > All of the test cases stay the same as before, but in order to be able
> > to implement proper job handling, the test case is rewritten in Python.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/206        | 705 +++++++++++++++++-----------------=
--------
> >  tests/qemu-iotests/206.out    | 241 +++++++++------
> >  tests/qemu-iotests/group      |   2 +-
> >  tests/qemu-iotests/iotests.py |  15 +
> >  4 files changed, 448 insertions(+), 515 deletions(-)
> >=20
> > diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
> > index 0a18b2b19a..9a305302d1 100755
> > --- a/tests/qemu-iotests/206
> > +++ b/tests/qemu-iotests/206
>=20
> [...]
>=20
> > +import iotests
> > +from iotests import imgfmt
> > +
> > +iotests.verify_image_format(supported_fmts=3D['qcow2'])
> > +
> > +def blockdev_create(vm, options):
> > +    result =3D vm.qmp_log('x-blockdev-create', job_id=3D'job0', option=
s=3Doptions)
> > +
> > +    if 'return' in result:
> > +        assert result['return'] =3D=3D {}
> > +        vm.run_job('job0')
> > +    iotests.log("")
> > +
> > +with iotests.FilePath('t.qcow2') as disk_path, \
> > +     iotests.FilePath('t.qcow2.base') as backing_path, \
> > +     iotests.VM() as vm:
> > +
> > +    vm.add_object('secret,id=3Dkeysec0,data=3D"foo"')
>=20
> I don't know how subprocess.Popen() works, but are you sure you aren't
> encrypting with '"foo"' now?  (i.e. literally that key, including quotes)

That's correct. Anything wrong with it?

(Okay, you're right. I did fix it in 210, but forgot it here...)

> > +
> > +    #
> > +    # Successful image creation (defaults)
> > +    #
> > +    iotests.log("=3D=3D=3D Successful image creation (defaults) =3D=3D=
=3D")
>=20
> OK, the comment makes sense for visual separation.  But so would leaving
> three empty lines.  *cough*

I tried vertical spacing first, but it didn't work well for me. What
made the difference is the syntax highlighting of comments vs. code.
YMMV.

> > +    iotests.log("")
> > +
> > +    size =3D 128 * 1024 * 1024
> > +
> > +    vm.launch()
> > +    blockdev_create(vm, { 'driver': 'file',
> > +                          'filename': disk_path,
> > +                          'size': 0 })
> > +
> > +    vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
> > +               node_name=3D'imgfile')
> > +
> > +    blockdev_create(vm, { 'driver': imgfmt,
> > +                          'file': 'imgfile',
> > +                          'size': size })
> > +    vm.shutdown()
> > +
> > +    iotests.img_info_log(disk_path)
> > +
>=20
> [...]
>=20
> > +    #
> > +    # Successful image creation (v2 non-default options)
> > +    #
> > +    iotests.log("=3D=3D=3D Successful image creation (v2 non-default o=
ptions) =3D=3D=3D")
> > +    iotests.log("")
> > +
> > +    vm.launch()
> > +    blockdev_create(vm, { 'driver': 'file',
> > +                          'filename': disk_path,
> > +                          'size': 0 })
> > +
> > +    blockdev_create(vm, { 'driver': imgfmt,
> > +                          'file': {
> > +                              'driver': 'file',
> > +                              'filename': disk_path,
> > +                          },
> > +                          'size': size,
> > +                          'backing-file': backing_path,
>=20
> Change from the bash version: backing_path does not exist here.  Not
> sure if that was intentional.

No, it was not. It's actually a good test case, though. Creating an
image at backing_path would be easy enough, but maybe we should just
leave it?

> > +                          'backing-fmt': 'qcow2',
> > +                          'version': 'v2',
> > +                          'cluster-size': 512 })
> > +    vm.shutdown()
> > +
> > +    iotests.img_info_log(disk_path)
>=20
> [...]
>=20
> > +    #
> > +    # Invalid sizes
> > +    #
> > +    iotests.log("=3D=3D=3D Invalid sizes =3D=3D=3D")
> > +
> > +    # TODO Negative image sizes aren't handled correctly, but this is =
a problem
> > +    # with QAPI's implementation of the 'size' type and affects other =
commands
> > +    # as well. Once this is fixed, we may want to add a test case here.
> > +    #
> > +    # 1. Misaligned image size
> > +    # 2. 2^64 - 512
> > +    # 3. 2^63 =3D 8 EB (qemu-img enforces image sizes less than this)
> > +    # 4. 2^63 - 512 (generally valid, but qcow2 can't handle images th=
is size)
> > +
> > +    vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dnode0' % =
(disk_path))
> > +
> > +    vm.launch()
> > +    blockdev_create(vm, { 'driver': imgfmt,
> > +                          'file': 'node0',
> > +                          'size': 1234  })
> > +    blockdev_create(vm, { 'driver': imgfmt,
> > +                          'file': 'node0',
> > +                          'size': 18446744073709551104 })
> > +    blockdev_create(vm, { 'driver': imgfmt,
> > +                          'file': 'node0',
> > +                          'size': 9223372036854775808 })
> > +    blockdev_create(vm, { 'driver': imgfmt,
> > +                          'file': 'node0',
> > +                          'size': 9223372036854775296})
>=20
> Missing space before the closing fancy bracket, critical!
>=20
> [...]
>=20
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> > index 20ce5a0cf0..f0f4ef32f0 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -416,6 +416,21 @@ class VM(qtest.QEMUQtestMachine):
> >          log(result)
> >          return result
> > =20
> > +    def run_job(self, job):
>=20
> Is there any reason this function did not get its own patch?
>=20
> Also, this is a function specifically for jobs that need a manual
> dismiss but have auto-finalize.  That should be noted somewhere (ideally
> in the function's name, but spontaneously I don't know how).

If you want me to move it into a separate patch, maybe just make it more
reusable with parameters auto_finalize=3DTrue, auto_dismiss=3Dfalse.

> > +        while True:
> > +            for ev in self.get_qmp_events_filtered(wait=3DTrue):
> > +                if ev['event'] =3D=3D 'JOB_STATUS_CHANGE':
> > +                    if ev['data']['status'] =3D=3D 'aborting':
> > +                        result =3D self.qmp('query-jobs')
> > +                        for j in result['return']:
> > +                            log('Job failed: %s' % (j.get('error', Non=
e)))
>=20
> I can understand that you didn't want to use just result['return'][0],
> but if you do iterate, you should probably emit the job ID as well.

If you have multiple jobs running, it doesn't work correctly anyway. :-)

Kevin

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbDaCgAAoJEH8JsnLIjy/WWjAQAIbliu46aBiORVzHs+8qq4aL
/2f4QotH/9Uy5A5nnJsZStuh5ezwLOmMltaPwkUGajPKYx0AxsIJRHBOMKz6KO6D
G/vL5rtiVwDX8WrxojfuqKGLP72XmXwCICnNuQOBC7A4iPc/iTsE+hYkHn87sG6i
chZLyWYDX37w1guu6vXmlB/FOFZJXFRo0kbQKDAPRPABWK0QGj1SisjmBQVP93/0
mg0QiNNSThKx5+BdUiwIpLNIS7fwgsvWonsrZAL6AtV6gA8E5Cl9vmBp536lFSlo
SSh0twDTT4qdfmROw/Gvao/dTFPkZmsrQHTfvxC+mFxA5vDJDnNu8JCQX/yNWf4f
KxzKGn1pUu1HN6T3ik+CZJcljK3umyEveSGeALRWnhLH0xVoIW1MFGA7Qt4/lMNi
Iw2eDrMdPuOvY/zmSh+AUoAzNFXvM9JVI1TcEgjgTPUdMozwGCOAxmX7b+OwDWp7
uGXP63wOvbRpcGgrs4yAXcGqDVRTZpQG4n0D+DB3v6rSPGixcAbiAb9dsk6UDEnD
wR73akmqzvyzR4G4EtJlltWwgiIQiK5wudYQmIkTKiR9zCA51IdhN7L3oX/9lCp9
IX4ap50QIVWiD0ca8FkTdyfSV2+RkUZhlCccDfEyRx0WIiK7JcguBt8aNOAIOLra
rNOygv2lYauUEZBVHFkd
=SwT/
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
