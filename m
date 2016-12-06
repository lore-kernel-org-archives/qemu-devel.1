Received: from eggs.gnu.org ([2001:4830:134:3::10]:47064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cECX6-0001Nt-MP
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cECX5-0004Wo-Hh
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:59:32 -0500
Date: Tue, 6 Dec 2016 10:59:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161206095921.GB4990@noname.str.redhat.com>
References: <1480589964-29411-1-git-send-email-w.bumiller@proxmox.com>
	<f67785d9-7f7e-703d-b026-3e9adbb04c5a@redhat.com>
	<20161205082639.GA17546@olga.wb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161205082639.GA17546@olga.wb>
Subject: Re: [Qemu-devel] [RFC PATCH] glusterfs: allow partial reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 05.12.2016 um 09:26 hat Wolfgang Bumiller geschrieben:
> On Fri, Dec 02, 2016 at 01:13:28PM -0600, Eric Blake wrote:
> > On 12/01/2016 04:59 AM, Wolfgang Bumiller wrote:
> > > Fixes #1644754.
> > > 
> > > Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> > > ---
> > > I'm not sure what the original rationale was to treat both partial
> > > reads as well as well as writes as I/O error. (Seems to have happened
> > > from original glusterfs v1 to v2 series with a note but no reasoning
> > > for the read side as far as I could see.)
> > > The general direction lately seems to be to move away from sector
> > > based block APIs. Also eg. the NFS code allows partial reads. (It
> > > does, however, have an old patch (c2eb918e3) dedicated to aligning
> > > sizes to 512 byte boundaries for file creation for compatibility to
> > > other parts of qemu like qcow2. This already happens in glusterfs,
> > > though, but if you move a file from a different storage over to
> > > glusterfs you may end up with a qcow2 file with eg. the L1 table in
> > > the last 80 bytes of the file aligned to _begin_ at a 512 boundary,
> > > but not _end_ at one.)

Hm, does this really happen? I always thought that the file size of
qcow2 images is aligned to the cluster size. If it isn't, maybe we
should fix that.

> > >  block/gluster.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/block/gluster.c b/block/gluster.c
> > > index 891c13b..3db0bf8 100644
> > > --- a/block/gluster.c
> > > +++ b/block/gluster.c
> > > @@ -41,6 +41,7 @@ typedef struct GlusterAIOCB {
> > >      int ret;
> > >      Coroutine *coroutine;
> > >      AioContext *aio_context;
> > > +    bool is_write;
> > >  } GlusterAIOCB;
> > >  
> > >  typedef struct BDRVGlusterState {
> > > @@ -716,8 +717,10 @@ static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret, void *arg)
> > >          acb->ret = 0; /* Success */
> > >      } else if (ret < 0) {
> > >          acb->ret = -errno; /* Read/Write failed */
> > > +    } else if (acb->is_write) {
> > > +        acb->ret = -EIO; /* Partial write - fail it */
> > >      } else {
> > > -        acb->ret = -EIO; /* Partial read/write - fail it */
> > > +        acb->ret = 0; /* Success */
> > 
> > Does this properly guarantee that the portion beyond EOF reads as zero?
> 
> I'd argue this wasn't necessarily the case before either, considering
> the first check starts with `!ret`:
> 
>     if (!ret || ret == acb->size) {
>         acb->ret = 0; /* Success */
> 
> A read right at EOF would return 0 and be treated as success there, no?

Yes, this is a bug.

I guess this was the lazy way that "usually" works both for
reads/writes, which return a positive number of bytes, and for things
like flush which return 0 on success. But the callback really needs to
distinguish these cases and apply different checks.

> Iow. it wouldn't zero out the destination buffer as far as I can see.
> Come to think of it, I'm not too fond of this part of the check for the
> write case either.

raw-posix treats short reads as success, too, but it zeroes out the
missing part. Note that it also loops after a short read and only if it
reads 0 bytes then, it returns success. If an error is returned after
the short read, the whole function returns an error. Is this necessary
for gluster, too?

> > Would it be better to switch to byte-based interfaces rather than
> > continue to force gluster interaction in 512-byte sector chunks,
> > since gluster can obviously store files that are not 512-aligned?

The gluster I/O functions are byte-based anyway, and the driver already
implements .bdrv_co_readv, so going to .bdrv_co_preadv should be
trivial. Probably the best solution here indeed.

Kevin
