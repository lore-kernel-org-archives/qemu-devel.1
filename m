Received: from eggs.gnu.org ([2001:4830:134:3::10]:59469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7nx-0001YL-IA
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7nw-0002Lu-79
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:33:33 -0400
References: <cover.1504111803.git.jcody@redhat.com>
	<aba8a2b58f34b56281e63e5e9404eb0aab016836.1504111803.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1646044f-3c57-c415-f261-463c74ea45b8@redhat.com>
Date: Wed, 30 Aug 2017 13:33:19 -0500
MIME-Version: 1.0
In-Reply-To: <aba8a2b58f34b56281e63e5e9404eb0aab016836.1504111803.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ir754VkvMNOCfRA4h5Cw1rAsarVxTv4l8"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] qemu-iotests: make python tests
 attempt to leave intermediate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ir754VkvMNOCfRA4h5Cw1rAsarVxTv4l8
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, kwolf@redhat.com
Message-ID: <1646044f-3c57-c415-f261-463c74ea45b8@redhat.com>
Subject: Re: [PATCH v3 4/5] qemu-iotests: make python tests attempt to leave
 intermediate files
References: <cover.1504111803.git.jcody@redhat.com>
 <aba8a2b58f34b56281e63e5e9404eb0aab016836.1504111803.git.jcody@redhat.com>
In-Reply-To: <aba8a2b58f34b56281e63e5e9404eb0aab016836.1504111803.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:52 AM, Jeff Cody wrote:
> Now that 'check' will clean up after tests, try and make python
> tests leave intermediate files so that they might be inspectable
> on failure.
>=20
> This isn't perfect; the python unittest framework runs multiple
> tests, even if previous tests failed.  So we need to make sure that
> each test still begins with a "clean" slate, to prevent false
> positives or tainted test runs.
>=20
> Rather than delete images in the unittest tearDown, invert this
> and delete images to be used in that test at the beginning of the
> setUp.  This is to make sure that the test run is not inadvertently
> using file droppings from previous runs.  We must use 'blind_remove'
> then for these, as the files might not exist yet, but we don't want
> to throw an error for that.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---

> +++ b/tests/qemu-iotests/030
> @@ -21,7 +21,7 @@
>  import time
>  import os
>  import iotests
> -from iotests import qemu_img, qemu_io
> +from iotests import qemu_img, qemu_io, blind_remove
> =20
>  backing_img =3D os.path.join(iotests.test_dir, 'backing.img')
>  mid_img =3D os.path.join(iotests.test_dir, 'mid.img')
> @@ -31,6 +31,9 @@ class TestSingleDrive(iotests.QMPTestCase):
>      image_len =3D 1 * 1024 * 1024 # MB
> =20
>      def setUp(self):
> +        blind_remove(test_img)
> +        blind_remove(mid_img)
> +        blind_remove(backing_img)

Would it be any more pythonic to have support for:

blind_remove(test_img, mid_img, backing_img)

built into the previous patch?

>      def tearDown(self):
>          self.vm.shutdown()
> -        os.remove(self.test_img)
> -        os.remove(self.mid_img_abs)
> -        os.remove(self.backing_img_abs)
> -        try:
> -            os.rmdir(os.path.join(iotests.test_dir, self.dir1))
> -            os.rmdir(os.path.join(iotests.test_dir, self.dir3))
> -            os.rmdir(os.path.join(iotests.test_dir, self.dir2))
> -        except OSError as exception:
> -            if exception.errno !=3D errno.EEXIST and exception.errno !=
=3D errno.ENOTEMPTY:
> -                raise

The code removed here is using a syntax that differs from what you used
in 3/5 when defining blind_remove; does that matter for 3/5?

> +++ b/tests/qemu-iotests/041

> +        blind_remove(target_img)
>          iotests.create_image(backing_img, self.image_len)
>          qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D=
%s' % backing_img, test_img)
>          self.vm =3D iotests.VM().add_drive(test_img, "node-name=3Dtop,=
backing.node-name=3Dbase")
> @@ -49,12 +52,6 @@ class TestSingleDrive(iotests.QMPTestCase):
> =20
>      def tearDown(self):
>          self.vm.shutdown()
> -        os.remove(test_img)
> -        os.remove(backing_img)
> -        try:
> -            os.remove(target_img)
> -        except OSError:
> -            pass

You're changing failures other than ENOENT from ignored to explicit -
nice little bug-fix along the way :)  I notice this pattern in multiple
tests; is it worth mentioning in the commit message as intentional?

> @@ -797,6 +788,9 @@ class TestRepairQuorum(iotests.QMPTestCase):
>      IMAGES =3D [ quorum_img1, quorum_img2, quorum_img3 ]
> =20
>      def setUp(self):
> +        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_fi=
le ]:
> +            blind_remove(i)

Again, would it be more pythonic if blind_remove() could take a list and
automatically work on each element of the list, rather than having to
make the caller iterate?

> +++ b/tests/qemu-iotests/057
> @@ -23,7 +23,7 @@
>  import time
>  import os
>  import iotests
> -from iotests import qemu_img, qemu_io
> +from iotests import qemu_img, qemu_io, blind_remove
> =20
>  test_drv_base_name =3D 'drive'
> =20
> @@ -36,6 +36,8 @@ class ImageSnapshotTestCase(iotests.QMPTestCase):
> =20
>      def _setUp(self, test_img_base_name, image_num):
>          self.vm =3D iotests.VM()
> +        for dev_expect in self.expect:
> +            blind_remove(dev_expect['image'])

Another place where python magic could make the caller nicer?

> +++ b/tests/qemu-iotests/118

> @@ -411,16 +411,16 @@ class TestFloppyInitiallyEmpty(TestInitiallyEmpty=
):
> =20
>  class TestChangeReadOnly(ChangeBaseClass):
>      def setUp(self):
> -        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
> -        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
> -        self.vm =3D iotests.VM()
> -
> -    def tearDown(self):
> -        self.vm.shutdown()
>          os.chmod(old_img, 0666)
>          os.chmod(new_img, 0666)
> -        os.remove(old_img)
> -        os.remove(new_img)
> +        blind_remove(old_img)
> +        blind_remove(new_img)
> +        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
> +        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
> +        self.vm =3D iotests.VM()
> +
> +    def tearDown(self):
> +        self.vm.shutdown()

The script framework doesn't have any problem removing left-over
read-only files, correct?  (If it does, then earlier in the series you
may need to add 'chmod -R u+rwx scratch/$seq' prior to its removal?)

But overall, I didn't see any problems, so I'm okay with:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ir754VkvMNOCfRA4h5Cw1rAsarVxTv4l8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnBO8ACgkQp6FrSiUn
Q2pmPwf6AyVjbf44LEggWCcYrP1cW3/WO1XrAFToB+r2QAGuVX+RZcJ3VPVZ1vC3
QmncB54mYaUJezzaFAz7O3KtowerctyvUz2JGPUf1PrwyCDw/aPXMBdb1zQUJsg0
BtJrCduXyu6uw9AhsjKAlBworofLqDiSnOoJW0CSGr8IGlCytITKx7Y0seTxkpQZ
8ZxyKj9AAitkgE+mZVcx4+FPHot+re74QemMof4Q7Ox+XGECjACjKl5NDwPE1K0u
1b1X6jeZCHgPlOJvJ5WFRhtQuQjotARjOipjPQuAkO9aSbXt7jXq+2dJBqRCrtE3
GC7bX1+D2T0pvpBXSUd5+Inbya1bPg==
=+rfv
-----END PGP SIGNATURE-----

--Ir754VkvMNOCfRA4h5Cw1rAsarVxTv4l8--
