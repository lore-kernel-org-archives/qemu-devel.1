Received: from eggs.gnu.org ([2001:4830:134:3::10]:40035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdRO9-0006pd-HD
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 19:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdRO8-0004Uk-Ft
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 19:54:37 -0500
Date: Tue, 14 Feb 2017 08:54:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214005427.GA6428@lemon.lan>
References: <20170207132723.13934-1-famz@redhat.com>
	<20170207132723.13934-3-famz@redhat.com>
	<25ac6a9f-c393-1a9a-e7f1-f8e3374135ee@redhat.com>
	<20170213142814.GK10361@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213142814.GK10361@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-blk: Inline request init,
 complete and free functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, 02/13 14:28, Stefan Hajnoczi wrote:
> On Tue, Feb 07, 2017 at 02:52:38PM +0100, Laszlo Ersek wrote:
> > On 02/07/17 14:27, Fam Zheng wrote:
> > > These are used in each request handling, inline them.
> > > 
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > ---
> > >  hw/block/virtio-blk.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > index 2858c31..1da9570 100644
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -29,8 +29,8 @@
> > >  #include "hw/virtio/virtio-bus.h"
> > >  #include "hw/virtio/virtio-access.h"
> > >  
> > > -static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
> > > -                                    VirtIOBlockReq *req)
> > > +static inline void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
> > > +                                           VirtIOBlockReq *req)
> > >  {
> > >      req->dev = s;
> > >      req->vq = vq;
> > > @@ -40,12 +40,13 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
> > >      req->mr_next = NULL;
> > >  }
> > >  
> > > -static void virtio_blk_free_request(VirtIOBlockReq *req)
> > > +static inline void virtio_blk_free_request(VirtIOBlockReq *req)
> > >  {
> > >      g_free(req);
> > >  }
> > >  
> > > -static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
> > > +static inline void virtio_blk_req_complete(VirtIOBlockReq *req,
> > > +                                           unsigned char status)
> > >  {
> > >      VirtIOBlock *s = req->dev;
> > >      VirtIODevice *vdev = VIRTIO_DEVICE(s);
> > > 
> > 
> > Hm, virtio_blk_req_complete() looks a bit too "meaty" and seems to be
> > called from a little too many places for me to feel convenient about
> > inlining it. I guess I'd leave it to the compiler to optimize the
> > function call. Does the explicit hint offer a noticeable perf improvement?
> > 
> > Inlining virtio_blk_free_request() looks reasonable.
> > 
> > virtio_blk_init_request() looks okay too.
> > 
> > Other reviewers should feel free to override my concerns :) My view on
> > this is distant.
> 
> I'm not a big fan of manually inlining functions.  Let the compiler
> decide whether these static functions should be inlined.
> 

Fair enough, let's drop this one.

Fam
