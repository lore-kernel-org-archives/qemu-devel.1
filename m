Received: from eggs.gnu.org ([2001:4830:134:3::10]:34678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVz1O-00044I-8z
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVz1K-0003Ih-9I
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:12:18 -0500
Date: Tue, 24 Jan 2017 19:12:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170124111207.GA13714@lemon.Home>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-9-git-send-email-vsementsov@virtuozzo.com>
	<20170124075949.GD27126@lemon.Home>
	<22f99aae-0968-286f-186c-0eaefadbe649@virtuozzo.com>
	<20170124093643.GA14811@lemon.Home>
	<f38c92ff-9f18-e03f-a756-e44f6ca22dde@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38c92ff-9f18-e03f-a756-e44f6ca22dde@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 08/21] backup: skip unallocated clusters
 for full mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com, jcody@redhat.com

On Tue, 01/24 13:13, Vladimir Sementsov-Ogievskiy wrote:
> 24.01.2017 12:36, Fam Zheng wrote:
> > On Tue, 01/24 12:18, Vladimir Sementsov-Ogievskiy wrote:
> > > 24.01.2017 10:59, Fam Zheng wrote:
> > > > On Fri, 12/23 17:28, Vladimir Sementsov-Ogievskiy wrote:
> > > > > diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
> > > > > index 1d3fd04..388b7b2 100755
> > > > > --- a/tests/qemu-iotests/055
> > > > > +++ b/tests/qemu-iotests/055
> > > > > @@ -30,6 +30,7 @@ target_img = os.path.join(iotests.test_dir, 'target.img')
> > > > >    blockdev_target_img = os.path.join(iotests.test_dir, 'blockdev-target.img')
> > > > >    image_len = 64 * 1024 * 1024 # MB
> > > > > +pause_write = '3M'
> > > > >    def setUpModule():
> > > > >        qemu_img('create', '-f', iotests.imgfmt, test_img, str(image_len))
> > > > > @@ -39,6 +40,7 @@ def setUpModule():
> > > > >        qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xd5 1M 32k', test_img)
> > > > >        qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 32M 124k', test_img)
> > > > >        qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x33 67043328 64k', test_img)
> > > > > +    qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 40M ' + pause_write, test_img)
> > > > What does this iotest change do?
> > > Without this backup block-job finishes before the next query to it from test
> > > and test fails. This is a wide problem I suffer of on the way of backup
> > > improvement and it should have better solution then adjusting amount of data
> > > being copied...
> > You can use blkdebug to pause I/O before querying the block job, or simply
> > throttle it down.
> > 
> > Fam
> 
> throttling down is not better I thing then just copying additional 3M, it is
> environment-dependent hack too. And we can't use throttling in all tests -
> throttling should be itself tested separately.

Then maybe opt to blkdebug?

I didn't mean the speed parameter of block jobs, but the block_set_io_throttle.
It is not perfect, but still better than simply enlarging the data size, and
is slightly simpler than blkdebug pause/resume.

Fam
