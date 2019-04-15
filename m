Received: from eggs.gnu.org ([209.51.188.92]:35358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hFwbv-0002mc-Fo
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hFwbu-0005TY-Dr
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:05:03 -0400
Date: Mon, 15 Apr 2019 10:04:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190415080452.GA6031@localhost.localdomain>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
	<20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
	<CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically
 the image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dillaman@redhat.com
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Am 14.04.2019 um 17:14 hat Jason Dillaman geschrieben:
> On Sun, Apr 14, 2019 at 9:20 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Thu, Apr 11, 2019 at 01:06:49PM -0400, Jason Dillaman wrote:
> > > On Thu, Apr 11, 2019 at 9:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >
> > > > On Thu, Apr 11, 2019 at 08:35:44AM -0400, Jason Dillaman wrote:
> > > > > On Thu, Apr 11, 2019 at 7:00 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > > >
> > > > > > RBD APIs don't allow us to write more than the size set with rbd_create()
> > > > > > or rbd_resize().
> > > > > > In order to support growing images (eg. qcow2), we resize the image
> > > > > > before RW operations that exceed the current size.
> > > > >
> > > > > What's the use-case for storing qcow2 images within a RBD image? RBD
> > > > > images are already thinly provisioned, they support snapshots, they
> > > > > can form a parent/child linked image hierarchy.
> > > > >
> > > >
> > > > Hi Jason,
> > > > I understand your point of view, maybe one use case could be if you have
> > > > a qcow2 image and you want to put it in the rdb pool without convert it.
> > > >
> > > > I'm going through this BZ [1] and I'll ask if they have other
> > > > use cases in mind.
> > >
> > > Assuming no good use-cases, perhaps it would just be better to make
> > > the qemu-img error messages more clear.
> > >
> >
> > Hi Jason,
> > I asked about use-cases and they want to use qcow2 on rbd in order to
> > take advantage of these qcow2 features [1]: external snapshots,
> > Copy-on-write, and optional compression and encryption.
> >
> > Maybe the more interesting are external snapshots and Copy-on-write,
> 
> Copy-on-write is natively supported by RBD. The concept of external
> snapshots seems similar to just automating the process of creating a
> new copy-on-write image. Compression is also supported by Ceph on the
> cluster side by recent releases.

I think a potential actual use case could be persistent dirty bitmaps
for incremental backup. Though maybe that would be better served by
using the rbd image just as a raw external data file and keeping the
qcow2 metadata on a filesystem.

How fast is rbd_resize()? Does automatically resizing for every write
request actually work reasonably well in practice? If it does, there is
probably little reason not to allow it, even if the use cases are rather
obscure.

Kevin
