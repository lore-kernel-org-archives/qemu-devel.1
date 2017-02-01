Received: from eggs.gnu.org ([2001:4830:134:3::10]:39985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ4Da-0001F7-US
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ4DZ-0006d4-St
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:21:38 -0500
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-18-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fe86c7ae-406f-2767-f03f-2f46bdcb140b@redhat.com>
Date: Thu, 2 Feb 2017 00:21:25 +0100
MIME-Version: 1.0
In-Reply-To: <1479837270-79005-18-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d7a2gTAVSlCl911fdhFqXCjUS3bE3XxTP"
Subject: Re: [Qemu-devel] [PATCH 17/17] iotests: add dirty bitmap postcopy
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d7a2gTAVSlCl911fdhFqXCjUS3bE3XxTP
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com,
 quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org,
 dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com
Message-ID: <fe86c7ae-406f-2767-f03f-2f46bdcb140b@redhat.com>
Subject: Re: [PATCH 17/17] iotests: add dirty bitmap postcopy test
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
 <1479837270-79005-18-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479837270-79005-18-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:54, Vladimir Sementsov-Ogievskiy wrote:
> Test
> - start two vms (vm_a, vm_b)
>=20
> - in a
>     - do writes from set A
>     - do writes from set B
>     - fix bitmap md5

*sha256

>     - clear bitmap
>     - do writes from set A
>     - start migration
> - than, in b
>     - wait vm start (postcopy should start)
>     - do writes from set B
>     - check btimap md5

*bitmap and *sha256

>=20
> The test should verify postcopy migration and than merging with delta

*then

> (changes in target, during postcopy process).
>=20
> Reduce supported cache modes to only 'none', because with cache on time=

> from source.STOP to target.RESUME is unpredictable and we can fail with=

> timout while waiting for target.RESUME.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/169        | 74 +++++++++++++++++++++++++++++++++++=
++------
>  tests/qemu-iotests/169.out    |  4 +--
>  tests/qemu-iotests/iotests.py |  7 +++-
>  3 files changed, 72 insertions(+), 13 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
> index 58b1ab1..d438d12 100755
> --- a/tests/qemu-iotests/169
> +++ b/tests/qemu-iotests/169
> @@ -29,8 +29,14 @@ fifo =3D os.path.join(iotests.test_dir, 'mig_fifo')
> =20
>  class TestDirtyBitmapMigration(iotests.QMPTestCase):
> =20
> -    def setUp(self):
> -        size =3D 0x400000000 # 1G
> +    def tearDown(self):
> +        self.vm_a.shutdown()
> +        self.vm_b.shutdown()
> +        os.remove(disk_a)
> +        os.remove(disk_b)
> +        os.remove(fifo)
> +
> +    def init(self, size):
>          os.mkfifo(fifo)
>          qemu_img('create', '-f', iotests.imgfmt, disk_a, str(size))
>          qemu_img('create', '-f', iotests.imgfmt, disk_b, str(size))
> @@ -40,14 +46,8 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):=

>          self.vm_a.launch()
>          self.vm_b.launch()
> =20
> -    def tearDown(self):
> -        self.vm_a.shutdown()
> -        self.vm_b.shutdown()
> -        os.remove(disk_a)
> -        os.remove(disk_b)
> -        os.remove(fifo)
> -
>      def test_migration(self):
> +        self.init(0x400000000) # 1G
>          granularity =3D 512
>          regions =3D [
>              { 'start': 0,           'count': 0x100000 },
> @@ -81,6 +81,60 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):=

>                                 node=3D'drive0', name=3D'bitmap')
>          self.assert_qmp(result, 'return/sha256', sha256);
> =20
> +    def test_postcopy(self):
> +        self.init(0x4000000000) # 128G

I think it's rather 256 GB.

With that and the commit message fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--d7a2gTAVSlCl911fdhFqXCjUS3bE3XxTP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSbXUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AwcQIAIB7lm8oR1fH5tPFVH2hfKpQOhtFaySn
V2rkLGLQfdGfyEk2PTnTQBLxYQhKNg8WCE/vz03/R2Ww5blHZcf8uFv8XcWRGobD
GEdhsZ8q0HgoogZQeYeqDAHIGKcsDwchClR0J17octz2HFVtd8cuo+hHOSdWKMQT
id0r+LWXohZIImLV+kXWJW+A1eRFjUvPoUqxIGAXk/2qcN/YJIB9iHoGyP22RyAN
a8CBohUO1ksDnpjS+BsGRxiQzB6blhnDusHCN9zbs1Fm+vVI659IBP1GQySFIoIG
Zq+JYuJK3O6I/fi7y6WiIyEnElUOGfO8A/dyR36tkR5SpuTW+5rxtxc=
=6wNq
-----END PGP SIGNATURE-----

--d7a2gTAVSlCl911fdhFqXCjUS3bE3XxTP--
