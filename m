Received: from eggs.gnu.org ([2001:4830:134:3::10]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1Yy1-0000AY-I6
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1Yxw-0003MO-0x
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:51:21 -0400
Date: Fri, 21 Apr 2017 15:51:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170421135105.GF4318@noname.redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-8-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421035606.448-8-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 07/20] iotests: 030: Prepare for image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 21.04.2017 um 05:55 hat Fam Zheng geschrieben:
> qemu-img and qemu-io commands when guest is running need "-U" option,
> add it.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/030 | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index 0d472d5..5f1dce8 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -63,8 +63,8 @@ class TestSingleDrive(iotests.QMPTestCase):
>      def test_stream_intermediate(self):
>          self.assert_no_active_block_jobs()
>  
> -        self.assertNotEqual(qemu_io('-f', 'raw', '-c', 'map', backing_img),
> -                            qemu_io('-f', iotests.imgfmt, '-c', 'map', mid_img),
> +        self.assertNotEqual(qemu_io('-f', 'raw', '-rU', '-c', 'map', backing_img),
> +                            qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', mid_img),
>                              'image file map matches backing file before streaming')
>  
>          result = self.vm.qmp('block-stream', device='mid', job_id='stream-mid')
> @@ -114,7 +114,7 @@ class TestSingleDrive(iotests.QMPTestCase):
>          self.assert_no_active_block_jobs()
>  
>          # The image map is empty before the operation
> -        empty_map = qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img)
> +        empty_map = qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', test_img)
>  
>          # This is a no-op: no data should ever be copied from the base image
>          result = self.vm.qmp('block-stream', device='drive0', base=mid_img)
> @@ -125,7 +125,7 @@ class TestSingleDrive(iotests.QMPTestCase):
>          self.assert_no_active_block_jobs()
>          self.vm.shutdown()
>  
> -        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img),
> +        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', '-r', test_img),
>                           empty_map, 'image file map changed after a no-op')

This one doesn't seem strictly necessary, as you're only adding -r
without -U. I still think it's a good idea to use -r where we can, but
if we decide to do this, there are more places in this test that could
be updated.

Maybe a separate patch for adding -r without -U to the cases where
qemu-io is run after shutting down the VM?

>      def test_stream_partial(self):
> @@ -197,8 +197,8 @@ class TestParallelOps(iotests.QMPTestCase):
>  
>          # Check that the maps don't match before the streaming operations
>          for i in range(2, self.num_imgs, 2):
> -            self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i]),
> -                                qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i-1]),
> +            self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-U', '-c', 'map', self.imgs[i]),
> +                                qemu_io('-f', iotests.imgfmt, '-U', '-c', 'map', self.imgs[i-1]),
>                                  'image file map matches backing file before streaming')
>  
>          # Create all streaming jobs
> @@ -351,8 +351,8 @@ class TestParallelOps(iotests.QMPTestCase):
>      def test_stream_base_node_name(self):
>          self.assert_no_active_block_jobs()
>  
> -        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[4]),
> -                            qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[3]),
> +        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-U', '-c', 'map', self.imgs[4]),
> +                            qemu_io('-f', iotests.imgfmt, '-U', '-c', 'map', self.imgs[3]),
>                              'image file map matches backing file before streaming')
>  
>          # Error: the base node does not exist
> @@ -422,8 +422,8 @@ class TestQuorum(iotests.QMPTestCase):
>          if not iotests.supports_quorum():
>              return
>  
> -        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.children[0]),
> -                            qemu_io('-f', iotests.imgfmt, '-c', 'map', self.backing[0]),
> +        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-U', '-c', 'map', self.children[0]),
> +                            qemu_io('-f', iotests.imgfmt, '-U', '-c', 'map', self.backing[0]),
>                              'image file map matches backing file before streaming')
>  
>          self.assert_no_active_block_jobs()
> @@ -436,8 +436,8 @@ class TestQuorum(iotests.QMPTestCase):
>          self.assert_no_active_block_jobs()
>          self.vm.shutdown()
>  
> -        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.children[0]),
> -                         qemu_io('-f', iotests.imgfmt, '-c', 'map', self.backing[0]),
> +        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-U', '-c', 'map', self.children[0]),
> +                         qemu_io('-f', iotests.imgfmt, '-U', '-c', 'map', self.backing[0]),
>                           'image file map does not match backing file after streaming')

These hunks all have -U without -r, which I think we wanted to make an
error.

Kevin
