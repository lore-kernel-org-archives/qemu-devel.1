Received: from eggs.gnu.org ([2001:4830:134:3::10]:35994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdjE-0002Dp-9j
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdjC-0004P6-Vd
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:27:52 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-9-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8b64d45f-0e9c-107f-a55a-bb3880c60eb6@redhat.com>
Date: Tue, 29 May 2018 14:27:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bNnxCJsA1yxG2zRyhXpi02Ei9IEN6uGG3"
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
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bNnxCJsA1yxG2zRyhXpi02Ei9IEN6uGG3
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <8b64d45f-0e9c-107f-a55a-bb3880c60eb6@redhat.com>
Subject: Re: [PATCH 08/14] qemu-iotests: Rewrite 206 for blockdev-create job
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-9-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This rewrites the test case 206 to work with the new x-blockdev-create
> job rather than the old synchronous version of the command.
>=20
> All of the test cases stay the same as before, but in order to be able
> to implement proper job handling, the test case is rewritten in Python.=

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/206        | 705 +++++++++++++++++-----------------=
--------
>  tests/qemu-iotests/206.out    | 241 +++++++++------
>  tests/qemu-iotests/group      |   2 +-
>  tests/qemu-iotests/iotests.py |  15 +
>  4 files changed, 448 insertions(+), 515 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
> index 0a18b2b19a..9a305302d1 100755
> --- a/tests/qemu-iotests/206
> +++ b/tests/qemu-iotests/206

[...]

> +import iotests
> +from iotests import imgfmt
> +
> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
> +
> +def blockdev_create(vm, options):
> +    result =3D vm.qmp_log('x-blockdev-create', job_id=3D'job0', option=
s=3Doptions)
> +
> +    if 'return' in result:
> +        assert result['return'] =3D=3D {}
> +        vm.run_job('job0')
> +    iotests.log("")
> +
> +with iotests.FilePath('t.qcow2') as disk_path, \
> +     iotests.FilePath('t.qcow2.base') as backing_path, \
> +     iotests.VM() as vm:
> +
> +    vm.add_object('secret,id=3Dkeysec0,data=3D"foo"')

I don't know how subprocess.Popen() works, but are you sure you aren't
encrypting with '"foo"' now?  (i.e. literally that key, including quotes)=


> +
> +    #
> +    # Successful image creation (defaults)
> +    #
> +    iotests.log("=3D=3D=3D Successful image creation (defaults) =3D=3D=
=3D")

OK, the comment makes sense for visual separation.  But so would leaving
three empty lines.  *cough*

> +    iotests.log("")
> +
> +    size =3D 128 * 1024 * 1024
> +
> +    vm.launch()
> +    blockdev_create(vm, { 'driver': 'file',
> +                          'filename': disk_path,
> +                          'size': 0 })
> +
> +    vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
> +               node_name=3D'imgfile')
> +
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': 'imgfile',
> +                          'size': size })
> +    vm.shutdown()
> +
> +    iotests.img_info_log(disk_path)
> +

[...]

> +    #
> +    # Successful image creation (v2 non-default options)
> +    #
> +    iotests.log("=3D=3D=3D Successful image creation (v2 non-default o=
ptions) =3D=3D=3D")
> +    iotests.log("")
> +
> +    vm.launch()
> +    blockdev_create(vm, { 'driver': 'file',
> +                          'filename': disk_path,
> +                          'size': 0 })
> +
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': {
> +                              'driver': 'file',
> +                              'filename': disk_path,
> +                          },
> +                          'size': size,
> +                          'backing-file': backing_path,

Change from the bash version: backing_path does not exist here.  Not
sure if that was intentional.

> +                          'backing-fmt': 'qcow2',
> +                          'version': 'v2',
> +                          'cluster-size': 512 })
> +    vm.shutdown()
> +
> +    iotests.img_info_log(disk_path)

[...]

> +    #
> +    # Invalid sizes
> +    #
> +    iotests.log("=3D=3D=3D Invalid sizes =3D=3D=3D")
> +
> +    # TODO Negative image sizes aren't handled correctly, but this is =
a problem
> +    # with QAPI's implementation of the 'size' type and affects other =
commands
> +    # as well. Once this is fixed, we may want to add a test case here=
=2E
> +    #
> +    # 1. Misaligned image size
> +    # 2. 2^64 - 512
> +    # 3. 2^63 =3D 8 EB (qemu-img enforces image sizes less than this)
> +    # 4. 2^63 - 512 (generally valid, but qcow2 can't handle images th=
is size)
> +
> +    vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dnode0' % =
(disk_path))
> +
> +    vm.launch()
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': 'node0',
> +                          'size': 1234  })
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': 'node0',
> +                          'size': 18446744073709551104 })
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': 'node0',
> +                          'size': 9223372036854775808 })
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': 'node0',
> +                          'size': 9223372036854775296})

Missing space before the closing fancy bracket, critical!

[...]

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 20ce5a0cf0..f0f4ef32f0 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -416,6 +416,21 @@ class VM(qtest.QEMUQtestMachine):
>          log(result)
>          return result
> =20
> +    def run_job(self, job):

Is there any reason this function did not get its own patch?

Also, this is a function specifically for jobs that need a manual
dismiss but have auto-finalize.  That should be noted somewhere (ideally
in the function's name, but spontaneously I don't know how).

> +        while True:
> +            for ev in self.get_qmp_events_filtered(wait=3DTrue):
> +                if ev['event'] =3D=3D 'JOB_STATUS_CHANGE':
> +                    if ev['data']['status'] =3D=3D 'aborting':
> +                        result =3D self.qmp('query-jobs')
> +                        for j in result['return']:
> +                            log('Job failed: %s' % (j.get('error', Non=
e)))

I can understand that you didn't want to use just result['return'][0],
but if you do iterate, you should probably emit the job ID as well.

Max

> +                    elif ev['data']['status'] =3D=3D 'concluded':
> +                        self.qmp_log('job-dismiss', id=3Djob)
> +                    elif ev['data']['status'] =3D=3D 'null':
> +                        return
> +                else:
> +                    iotests.log(ev)
> +
> =20
>  index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')



--bNnxCJsA1yxG2zRyhXpi02Ei9IEN6uGG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNRzwACgkQ9AfbAGHV
z0AYCAgAix9Fatau9RD7a8CcIdsgGpBo/lM+YttPZ0Jk5eq2xqOhliSsY3RCACJP
ZeSIZLy8yfPZfQiBLC7Flmsxve2umef6+xCwqgtECs1+2lHB6/yTt6+e87zqYSfB
tqDTHHplmQf73mB4h+wtlhWBb/46IwJW4GivT0s+t33hvmd/iXZ8k/ngM++XBHUl
N872QlkaaQuIUZlR+cXbEz2x5/fZaSMp1QYINMrehapCSeE6UgaYM9/IPQeLZDky
TOuA4By0+T+XPwber4MsQuNwWTM3V+UMmRcPGT3kSeyfHpTwRTxCcPXB+nS529k9
MzomgdvXknOKKFm6UMd+cr3eLumL1A==
=p23a
-----END PGP SIGNATURE-----

--bNnxCJsA1yxG2zRyhXpi02Ei9IEN6uGG3--
