Received: from eggs.gnu.org ([2001:4830:134:3::10]:41192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2XHq-0008QX-2k
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2XHp-0004DY-3A
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:15:50 -0400
Date: Mon, 24 Apr 2017 14:15:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170424061540.GD316@lemon.lan>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-8-famz@redhat.com>
	<20170421135105.GF4318@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421135105.GF4318@noname.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Fri, 04/21 15:51, Kevin Wolf wrote:
> Am 21.04.2017 um 05:55 hat Fam Zheng geschrieben:
> > qemu-img and qemu-io commands when guest is running need "-U" option,
> > add it.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/qemu-iotests/030 | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> > index 0d472d5..5f1dce8 100755
> > --- a/tests/qemu-iotests/030
> > +++ b/tests/qemu-iotests/030
> > @@ -63,8 +63,8 @@ class TestSingleDrive(iotests.QMPTestCase):
> >      def test_stream_intermediate(self):
> >          self.assert_no_active_block_jobs()
> >  
> > -        self.assertNotEqual(qemu_io('-f', 'raw', '-c', 'map', backing_img),
> > -                            qemu_io('-f', iotests.imgfmt, '-c', 'map', mid_img),
> > +        self.assertNotEqual(qemu_io('-f', 'raw', '-rU', '-c', 'map', backing_img),
> > +                            qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', mid_img),
> >                              'image file map matches backing file before streaming')
> >  
> >          result = self.vm.qmp('block-stream', device='mid', job_id='stream-mid')
> > @@ -114,7 +114,7 @@ class TestSingleDrive(iotests.QMPTestCase):
> >          self.assert_no_active_block_jobs()
> >  
> >          # The image map is empty before the operation
> > -        empty_map = qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img)
> > +        empty_map = qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', test_img)
> >  
> >          # This is a no-op: no data should ever be copied from the base image
> >          result = self.vm.qmp('block-stream', device='drive0', base=mid_img)
> > @@ -125,7 +125,7 @@ class TestSingleDrive(iotests.QMPTestCase):
> >          self.assert_no_active_block_jobs()
> >          self.vm.shutdown()
> >  
> > -        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img),
> > +        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', '-r', test_img),
> >                           empty_map, 'image file map changed after a no-op')
> 
> This one doesn't seem strictly necessary, as you're only adding -r
> without -U. I still think it's a good idea to use -r where we can, but
> if we decide to do this, there are more places in this test that could
> be updated.
> 
> Maybe a separate patch for adding -r without -U to the cases where
> qemu-io is run after shutting down the VM?

Yes, will split. (In a previous version -U is implied by -r, and the patch was
"add -r to all qemu-io invocations where writing is not needed.)

Fam
