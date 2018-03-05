Received: from eggs.gnu.org ([2001:4830:134:3::10]:35205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1estTC-0000Kb-Th
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1estT6-0005oW-U0
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:00:15 -0500
References: <20180302112050.26670-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3c829c67-f6b9-ad7e-ba1d-a0f7d25623bd@redhat.com>
Date: Mon, 5 Mar 2018 17:59:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180302112050.26670-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GfesAYqVgfHZ0c9WaveqRlKpJfos5jYjK"
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Tweak 030 in order to trigger
 a race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GfesAYqVgfHZ0c9WaveqRlKpJfos5jYjK
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3c829c67-f6b9-ad7e-ba1d-a0f7d25623bd@redhat.com>
Subject: Re: [PATCH v3] iotests: Tweak 030 in order to trigger a race
 condition with parallel jobs
References: <20180302112050.26670-1-berto@igalia.com>
In-Reply-To: <20180302112050.26670-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-02 12:20, Alberto Garcia wrote:
> This patch tweaks TestParallelOps in iotest 030 so it allocates data
> in smaller regions (256KB/512KB instead of 512KB/1MB) and the
> block-stream job in test_stream_commit() only needs to copy data that
> is at the very end of the image.
>=20
> This way when the block-stream job is awakened it will finish right
> away without any chance of being stopped by block_job_sleep_ns(). This
> triggers the bug that was fixed by 3d5d319e1221082974711af1d09d82f07
> and is therefore a more useful test case for parallel block jobs.
>=20
> After this patch the aforementiond bug can also be reproduced with the
> test_stream_parallel() test case.
>=20
> Since with this change the stream job in test_stream_commit() finishes
> early, this patch introduces a similar test case where both jobs are
> slowed down so they can actually run in parallel.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>=20
> This patch was sent already in December but it seems to have been
> forgotten. v3 is the same as v2 but with a typo fixed in the commit
> message.
>=20
> ---
>  tests/qemu-iotests/030     | 48 ++++++++++++++++++++++++++++++++++++++=
+-------
>  tests/qemu-iotests/030.out |  4 ++--
>  2 files changed, 43 insertions(+), 9 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index 457984b8e9..44ad1e311f 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -156,7 +156,7 @@ class TestSingleDrive(iotests.QMPTestCase):
>  class TestParallelOps(iotests.QMPTestCase):
>      num_ops =3D 4 # Number of parallel block-stream operations
>      num_imgs =3D num_ops * 2 + 1
> -    image_len =3D num_ops * 1024 * 1024
> +    image_len =3D num_ops * 512 * 1024
>      imgs =3D []
> =20
>      def setUp(self):
> @@ -177,12 +177,12 @@ class TestParallelOps(iotests.QMPTestCase):
> =20
>          # Put data into the images we are copying data from
>          for i in range(self.num_imgs / 2):
> -            img_index =3D i * 2 + 1
> -            # Alternate between 512k and 1M.
> +            img_index =3D self.num_imgs - i * 2 - 2

First of all, I don't like this very much because it's not clear that
img_index is going to be odd.

I'd prefer something like

  reverse_i =3D self.num_imgs / 2 - 1 - 1
  img_index =3D reverse_i * 2 + 1

Secondly, I've reverted 3d5d319e1221082 to test this, and I could
reproduce failure exactly once.  Since then, no luck (in like 20
attempts, I think)...

Max

> +            # Alternate between 256KB and 512KB.
>              # This way jobs will not finish in the same order they wer=
e created
> -            num_kb =3D 512 + 512 * (i % 2)
> +            num_kb =3D 256 + 256 * (i % 2)
>              qemu_io('-f', iotests.imgfmt,
> -                    '-c', 'write -P %d %d %d' % (i, i*1024*1024, num_k=
b * 1024),
> +                    '-c', 'write -P 0xFF %dk %dk' % (i * 512, num_kb),=

>                      self.imgs[img_index])
> =20
>          # Attach the drive to the VM
> @@ -318,12 +318,14 @@ class TestParallelOps(iotests.QMPTestCase):
>          self.wait_until_completed(drive=3D'commit-drive0')
> =20
>      # Test a block-stream and a block-commit job in parallel
> -    def test_stream_commit(self):
> +    # Here the stream job is supposed to finish quickly in order to re=
produce
> +    # the scenario that triggers the bug fixed in 3d5d319e122108297471=
1af1d09
> +    def test_stream_commit_1(self):
>          self.assertLessEqual(8, self.num_imgs)
>          self.assert_no_active_block_jobs()
> =20
>          # Stream from node0 into node2
> -        result =3D self.vm.qmp('block-stream', device=3D'node2', job_i=
d=3D'node2')
> +        result =3D self.vm.qmp('block-stream', device=3D'node2', base_=
node=3D'node0', job_id=3D'node2')
>          self.assert_qmp(result, 'return', {})
> =20
>          # Commit from the active layer into node3
> @@ -348,6 +350,38 @@ class TestParallelOps(iotests.QMPTestCase):
> =20
>          self.assert_no_active_block_jobs()
> =20
> +    # This is similar to test_stream_commit_1 but both jobs are slowed=

> +    # down so they can run in parallel for a little while.
> +    def test_stream_commit_2(self):
> +        self.assertLessEqual(8, self.num_imgs)
> +        self.assert_no_active_block_jobs()
> +
> +        # Stream from node0 into node4
> +        result =3D self.vm.qmp('block-stream', device=3D'node4', base_=
node=3D'node0', job_id=3D'node4', speed=3D1024*1024)
> +        self.assert_qmp(result, 'return', {})
> +
> +        # Commit from the active layer into node5
> +        result =3D self.vm.qmp('block-commit', device=3D'drive0', base=
=3Dself.imgs[5], speed=3D1024*1024)
> +        self.assert_qmp(result, 'return', {})
> +
> +        # Wait for all jobs to be finished.
> +        pending_jobs =3D ['node4', 'drive0']
> +        while len(pending_jobs) > 0:
> +            for event in self.vm.get_qmp_events(wait=3DTrue):
> +                if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
> +                    node_name =3D self.dictpath(event, 'data/device')
> +                    self.assertTrue(node_name in pending_jobs)
> +                    self.assert_qmp_absent(event, 'data/error')
> +                    pending_jobs.remove(node_name)
> +                if event['event'] =3D=3D 'BLOCK_JOB_READY':
> +                    self.assert_qmp(event, 'data/device', 'drive0')
> +                    self.assert_qmp(event, 'data/type', 'commit')
> +                    self.assert_qmp_absent(event, 'data/error')
> +                    self.assertTrue('drive0' in pending_jobs)
> +                    self.vm.qmp('block-job-complete', device=3D'drive0=
')
> +
> +        self.assert_no_active_block_jobs()
> +
>      # Test the base_node parameter
>      def test_stream_base_node_name(self):
>          self.assert_no_active_block_jobs()
> diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
> index 391c8573ca..42314e9c00 100644
> --- a/tests/qemu-iotests/030.out
> +++ b/tests/qemu-iotests/030.out
> @@ -1,5 +1,5 @@
> -.......................
> +........................
>  ----------------------------------------------------------------------=

> -Ran 23 tests
> +Ran 24 tests
> =20
>  OK
>=20



--GfesAYqVgfHZ0c9WaveqRlKpJfos5jYjK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqdd4MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8PYH/1yzdJ7OUtmclMbXWi0oD3yp4JkBS2ks
fWB6jIz7oj6jbWNZ3uxQqMeXjnLrvaFNq7DepYK2Knf1NVcRz5wr45S+H0Lboxjq
/sZO5uxHTX92AEjUbOZp9VEaI8gR+SjGsrcYou+tu0erf7l48xQxccobEFmMXVIk
2qTyYO5U9lGZYEnx0kKMjEQY+hvZ0lYG2qhDF5x4Gf4iIs6t8urctcrkB8Xhzprk
S6TtOTWiomcmu03gxYz7vugpFITjA7JeIF6WqTjX9yz0PkyGSvrSlzpeb7ASuO8U
5ouMHMdzrIy33PU13txNYDSkNq25CIgueYaePyBTvObJsenEM+TtgSQ=
=7Fjn
-----END PGP SIGNATURE-----

--GfesAYqVgfHZ0c9WaveqRlKpJfos5jYjK--
