Received: from eggs.gnu.org ([2001:4830:134:3::10]:45785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fFaUh-0003uP-0M
	for qemu-devel@nongnu.org; Mon, 07 May 2018 03:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fFaUf-0001tH-Mn
	for qemu-devel@nongnu.org; Mon, 07 May 2018 03:23:35 -0400
Date: Mon, 7 May 2018 15:23:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180507072315.GA22503@lemon.usersys.redhat.com>
References: <20180420220913.27000-1-mreitz@redhat.com>
	<20180420220913.27000-3-mreitz@redhat.com>
	<20180427062221.GD4217@lemon.usersys.redhat.com>
	<9801ca35-b050-d482-f482-f1364bf07e1c@redhat.com>
	<20180503064552.GJ15438@lemon.usersys.redhat.com>
	<829af997-251b-d0e9-fb76-4ada1c3dd340@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829af997-251b-d0e9-fb76-4ada1c3dd340@redhat.com>
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

On Fri, 05/04 15:45, Max Reitz wrote:
> On 2018-05-03 08:45, Fam Zheng wrote:
> > On Sat, 04/28 13:03, Max Reitz wrote:
> >> On 2018-04-27 08:22, Fam Zheng wrote:
> >>> On Sat, 04/21 00:09, Max Reitz wrote:
> >>>> When creating a file, we should take the WRITE and RESIZE permissions.
> >>>> We do not need either for the creation itself, but we do need them for
> >>>> clearing and resizing it.  So we can take the proper permissions by
> >>>> replacing O_TRUNC with an explicit truncation to 0, and by taking the
> >>>> appropriate file locks between those two steps.
> >>>>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> ---
> >>>>  block/file-posix.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >>>>  1 file changed, 39 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/block/file-posix.c b/block/file-posix.c
> >>>> index c98a4a1556..ed7932d6e8 100644
> >>>> --- a/block/file-posix.c
> >>>> +++ b/block/file-posix.c
> >>>> @@ -1992,6 +1992,7 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
> >>>>  {
> >>>>      BlockdevCreateOptionsFile *file_opts;
> >>>>      int fd;
> >>>> +    int perm, shared;
> >>>>      int result = 0;
> >>>>  
> >>>>      /* Validate options and set default values */
> >>>> @@ -2006,14 +2007,48 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
> >>>>      }
> >>>>  
> >>>>      /* Create file */
> >>>> -    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
> >>>> -                   0644);
> >>>> +    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
> >>>>      if (fd < 0) {
> >>>>          result = -errno;
> >>>>          error_setg_errno(errp, -result, "Could not create file");
> >>>>          goto out;
> >>>>      }
> >>>>  
> >>>> +    /* Take permissions: We want to discard everything, so we need
> >>>> +     * BLK_PERM_WRITE; and truncation to the desired size requires
> >>>> +     * BLK_PERM_RESIZE.
> >>>> +     * On the other hand, we cannot share the RESIZE permission
> >>>> +     * because we promise that after this function, the file has the
> >>>> +     * size given in the options.  If someone else were to resize it
> >>>> +     * concurrently, we could not guarantee that. */
> >>>
> >>> Strictly speaking, we do close(fd) before this function returns so the lock is
> >>> lost and race can happen.
> >>
> >> Right, but then creation from the perspective of file-posix is over.  We
> >> are going to reopen the file for formatting, but that is just a normal
> >> bdrv_open() so it will automatically be locked, no?
> > 
> > After this function close() but before the following bdrv_open(), another
> > process can sneak in and steal the lock. So we cannot guarantee the RESIZE lock
> > does what we really want.
> 
> Right, but I'd argue that is not the purpose of the lock.  If someone
> wants the file (or then rather the node) to be a certain size, they'd
> have to call bdrv_getlength() on it to check.
> 
> But indeed you're right in that not sharing the RESIZE is hypocritical
> considering it actually doesn't promise anything.
> 
> Anyway, let's consider the issues.  For formatting the file, this
> behavior is OK because since Kevin's x-blockdev-create series format
> drivers always truncate the file during formatting (that is, once they
> have opened the file), and not during creation, so that part is secured.
> 
> But we do have issues with e.g. drive-mirror, where we create an image
> and then open it.  The opened image may have a different size than what
> we wanted to create.  Now in this case I wouldn't consider this a big
> problem because drive-mirror is basically deprecated anyway, so there is
> no reason to waste resources here; and this applies to all of the QMP
> commands that create images and then open them automatically.
> 
> In the future, we want users to use blockdev-create and then
> blockdev-add in two separate steps.  Then it's up to the user to realize
> that the blockdev-add'ed node may have a different length then what they
> wanted to achieve in blockdev-create.  Actually, it may just differ
> altogether, I don't think qemu is going to make any promises on the
> state of the image in the interim.
> 
> So...  I suppose there aren't any real issues with not being able to
> promise that the image has the intended length immediately after
> creating it.  So I guess we can indeed share RESIZE.
> 
> But OTOH, it definitely does not feel right to me to share RESIZE.  We
> definitely do not want other parties to resize the image while we create it.
> 
> So I guess what I would like to do is keep RESIZE not shared and add a
> note after the comment:
> 
> > Note that after this function, we can no longer guarantee that the
> > file is not touched by a third party, so it may be resized then.
> 
> Ideally, we'd want the lock to stay active until blockdev-create or
> qemu-img create returns, but I don't think that is really worth it.  If
> there is a race condition between raw_co_create() returning and those
> commands returning (and we don't have a format layer to correct things),
> then I can't imagine that it couldn't bite you after those commands have
> returned.  (And after those commands, it isn't our problem anymore anyway.)

Yes, what you said makes total sense to me. Having a comment and _not_ sharing
RESIZE seems the most reasonable.

Technically we could extend the API to be able to hold the fd after
blockdev-create returns by introducing an explicit blockdev-create-cleanup
command, but like you said it is probably not worth it.

Fam
