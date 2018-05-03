Received: from eggs.gnu.org ([2001:4830:134:3::10]:47106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fE80J-0004MF-OD
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fE80I-0007p6-Hm
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:46:11 -0400
Date: Thu, 3 May 2018 14:45:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180503064552.GJ15438@lemon.usersys.redhat.com>
References: <20180420220913.27000-1-mreitz@redhat.com>
	<20180420220913.27000-3-mreitz@redhat.com>
	<20180427062221.GD4217@lemon.usersys.redhat.com>
	<9801ca35-b050-d482-f482-f1364bf07e1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9801ca35-b050-d482-f482-f1364bf07e1c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] block/file-posix: File locking during
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Sat, 04/28 13:03, Max Reitz wrote:
> On 2018-04-27 08:22, Fam Zheng wrote:
> > On Sat, 04/21 00:09, Max Reitz wrote:
> >> When creating a file, we should take the WRITE and RESIZE permissions.
> >> We do not need either for the creation itself, but we do need them for
> >> clearing and resizing it.  So we can take the proper permissions by
> >> replacing O_TRUNC with an explicit truncation to 0, and by taking the
> >> appropriate file locks between those two steps.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/file-posix.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 39 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/file-posix.c b/block/file-posix.c
> >> index c98a4a1556..ed7932d6e8 100644
> >> --- a/block/file-posix.c
> >> +++ b/block/file-posix.c
> >> @@ -1992,6 +1992,7 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
> >>  {
> >>      BlockdevCreateOptionsFile *file_opts;
> >>      int fd;
> >> +    int perm, shared;
> >>      int result = 0;
> >>  
> >>      /* Validate options and set default values */
> >> @@ -2006,14 +2007,48 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
> >>      }
> >>  
> >>      /* Create file */
> >> -    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
> >> -                   0644);
> >> +    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
> >>      if (fd < 0) {
> >>          result = -errno;
> >>          error_setg_errno(errp, -result, "Could not create file");
> >>          goto out;
> >>      }
> >>  
> >> +    /* Take permissions: We want to discard everything, so we need
> >> +     * BLK_PERM_WRITE; and truncation to the desired size requires
> >> +     * BLK_PERM_RESIZE.
> >> +     * On the other hand, we cannot share the RESIZE permission
> >> +     * because we promise that after this function, the file has the
> >> +     * size given in the options.  If someone else were to resize it
> >> +     * concurrently, we could not guarantee that. */
> > 
> > Strictly speaking, we do close(fd) before this function returns so the lock is
> > lost and race can happen.
> 
> Right, but then creation from the perspective of file-posix is over.  We
> are going to reopen the file for formatting, but that is just a normal
> bdrv_open() so it will automatically be locked, no?

After this function close() but before the following bdrv_open(), another
process can sneak in and steal the lock. So we cannot guarantee the RESIZE lock
does what we really want.

Fam

> 
> >> +    perm = BLK_PERM_WRITE | BLK_PERM_RESIZE;
> >> +    shared = BLK_PERM_ALL & ~BLK_PERM_RESIZE;
> >> +
> >> +    /* Step one: Take locks in shared mode */
> >> +    result = raw_apply_lock_bytes(fd, perm, shared, false, errp);
> >> +    if (result < 0) {
> >> +        goto out_close;
> >> +    }
> >> +
> >> +    /* Step two: Try to get them exclusively */
> >> +    result = raw_check_lock_bytes(fd, perm, shared, errp);
> >> +    if (result < 0) {
> >> +        goto out_close;
> >> +    }
> >> +
> >> +    /* Step three: Downgrade them to shared again, and keep
> >> +     *             them that way until we are done */
> >> +    result = raw_apply_lock_bytes(fd, perm, shared, true, errp);
> > 
> > You comment it as "downgrade to shared" but what this actually does in addition
> > to step one is to "unlock" unneeded bytes which we haven't locked anyway. So I'm
> > confused why we need this stop. IIUC no downgrading is necessary after step one
> > and step two: only necessary shared locks are acquired in step one, and step two
> > is read-only op (F_OFD_GETLK).
> 
> Oops.  For some reason I thought raw_check_lock_bytes() would take the
> locks exclusively.  Yes, then we don't need this third step.
> 
> Thanks for reviewing!
> 
> Max
> 
> >> +    if (result < 0) {
> >> +        goto out_close;
> >> +    }
> >> +
> >> +    /* Clear the file by truncating it to 0 */
> >> +    result = raw_regular_truncate(fd, 0, PREALLOC_MODE_OFF, errp);
> >> +    if (result < 0) {
> >> +        goto out_close;
> >> +    }
> >> +
> >>      if (file_opts->nocow) {
> >>  #ifdef __linux__
> >>          /* Set NOCOW flag to solve performance issue on fs like btrfs.
> >> @@ -2029,6 +2064,8 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
> >>  #endif
> >>      }
> >>  
> >> +    /* Resize and potentially preallocate the file to the desired
> >> +     * final size */
> >>      result = raw_regular_truncate(fd, file_opts->size, file_opts->preallocation,
> >>                                    errp);
> >>      if (result < 0) {
> >> -- 
> >> 2.14.3
> >>
> >>
> > 
> > Fam
> > 
> 
> 
