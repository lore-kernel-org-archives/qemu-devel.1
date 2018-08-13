Received: from eggs.gnu.org ([2001:4830:134:3::10]:54343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fp8aY-0003Vx-2v
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fp8aX-0001xE-47
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:52:34 -0400
Date: Mon, 13 Aug 2018 10:52:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813085222.GB4323@localhost.localdomain>
References: <20180718084318.7540-1-famz@redhat.com>
	<20180810121455.GF4367@localhost.localdomain>
	<20180813014559.GA7549@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813014559.GA7549@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Skip effectiveless OFD lock
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 13.08.2018 um 03:45 hat Fam Zheng geschrieben:
> On Fri, 08/10 14:14, Kevin Wolf wrote:
> > Am 18.07.2018 um 10:43 hat Fam Zheng geschrieben:
> > > If we know we've already locked the bytes, don't do it again; similarly
> > > don't unlock a byte if we haven't locked it. This doesn't change the
> > > behavior, but fixes a corner case explained below.
> > > 
> > > Libvirt had an error handling bug that an image can get its (ownership,
> > > file mode, SELinux) permissions changed (RHBZ 1584982) by mistake behind
> > > QEMU. Specifically, an image in use by Libvirt VM has:
> > > 
> > >     $ ls -lhZ b.img
> > >     -rw-r--r--. qemu qemu system_u:object_r:svirt_image_t:s0:c600,c690 b.img
> > > 
> > > Trying to attach it a second time won't work because of image locking.
> > > And after the error, it becomes:
> > > 
> > >     $ ls -lhZ b.img
> > >     -rw-r--r--. root root system_u:object_r:virt_image_t:s0 b.img
> > > 
> > > Then, we won't be able to do OFD lock operations with the existing fd.
> > > In other words, the code such as in blk_detach_dev:
> > > 
> > >     blk_set_perm(blk, 0, BLK_PERM_ALL, &error_abort);
> > > 
> > > can abort() QEMU, out of environmental changes.
> > > 
> > > This patch is an easy fix to this and the change is regardlessly
> > > reasonable, so do it.
> > > 
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > ---
> > >  block/file-posix.c | 27 +++++++++++++++++----------
> > >  1 file changed, 17 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > index 60af4b3d51..45d44c9947 100644
> > > --- a/block/file-posix.c
> > > +++ b/block/file-posix.c
> > > @@ -680,23 +680,28 @@ typedef enum {
> > >   * file; if @unlock == true, also unlock the unneeded bytes.
> > >   * @shared_perm_lock_bits is the mask of all permissions that are NOT shared.
> > >   */
> > > -static int raw_apply_lock_bytes(int fd,
> > > +static int raw_apply_lock_bytes(BDRVRawState *s, int fd,
> > >                                  uint64_t perm_lock_bits,
> > >                                  uint64_t shared_perm_lock_bits,
> > >                                  bool unlock, Error **errp)
> > >  {
> > >      int ret;
> > >      int i;
> > > +    uint64_t locked_perm, locked_shared_perm;
> > > +
> > > +    locked_perm = s ? s->perm : 0;
> > > +    locked_shared_perm = s ? ~s->shared_perm & BLK_PERM_ALL : 0;
> > 
> > For the s == NULL case, using 0 is okay for locking because we will
> > always consider the bit as previously unlocked, so we will lock it.
> > 
> > For unlocking, however, we'll also see it as previously unlocked, so we
> > will never actually unlock anything any more.
> > 
> > Am I missing something?
> 
> You are right. Though s == NULL only happens in raw_co_create and the fd will be
> closed before the function returns, I agree for the correctness of this function
> it's better to do a blanket unlock when unlocking. Will respin.

At least one reason why you can't rely on file descriptors being closed
and releasing the locks is fdsets, where there are still more file
descriptors for the same OFD.

Kevin
