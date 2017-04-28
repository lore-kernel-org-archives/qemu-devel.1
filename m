Received: from eggs.gnu.org ([2001:4830:134:3::10]:55239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Abv-0004o1-Ko
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Abu-00007A-Pz
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:27:19 -0400
Date: Fri, 28 Apr 2017 20:27:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170428182705.GE4714@noname.redhat.com>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-21-famz@redhat.com>
	<20170428134543.GD4714@noname.redhat.com>
	<20170428153056.GA31788@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428153056.GA31788@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v15 20/21] file-posix: Add image locking to
 perm operations
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

Am 28.04.2017 um 17:30 hat Fam Zheng geschrieben:
> On Fri, 04/28 15:45, Kevin Wolf wrote:
> > Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> > > This extends the permission bits of op blocker API to external using
> > > Linux OFD locks.
> > > 
> > > Each permission in @perm and @shared_perm is represented by a locked
> > > byte in the image file.  Requesting a permission in @perm is translated
> > > to a shared lock of the corresponding byte; rejecting to share the same
> > > permission is translated to a shared lock of a separate byte. With that,
> > > we use 2x number of bytes of distinct permission types.
> > > 
> > > virtlockd in libvirt locks the first byte, so we do locking from a
> > > higher offset.
> > > 
> > > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > 
> > >  BlockDriver bdrv_file = {
> > >      .format_name = "file",
> > >      .protocol_name = "file",
> > > @@ -1977,7 +2234,11 @@ BlockDriver bdrv_file = {
> > >      .bdrv_get_info = raw_get_info,
> > >      .bdrv_get_allocated_file_size
> > >                          = raw_get_allocated_file_size,
> > > -
> > > +    .bdrv_inactivate = raw_inactivate,
> > > +    .bdrv_invalidate_cache = raw_invalidate_cache,
> > > +    .bdrv_check_perm = raw_check_perm,
> > > +    .bdrv_set_perm   = raw_set_perm,
> > > +    .bdrv_abort_perm_update = raw_abort_perm_update,
> > >      .create_opts = &raw_create_opts,
> > >  };
> > 
> > By the way, is it intentional that we apply locking only to bdrv_file,
> > but not to bdrv_host_device or bdrv_host_cdrom?
> 
> Good question.
> 
> Though CDROM is not very interesting, I am not sure about bdrv_host_device:
> 
> 1) On the one hand, a host device can contain a qcow2 image so maybe locking is
> useful.  Another reason to lock is that they share the same QAPI option,
> BlockdevOptionsFile. That last reason is, it should be very easy to add it.
> 
> 2) On the other hand, unlike files, host devices get pretty high chances in
> being accesses by multiple readers/writers, outside of QEMU, such as partition
> detection, mount, fsck, etc.
> 
> What is your opinion?

I would add it, if nothing else to be consistent with regular files. You
don't even need qcow2 on a block device for it to be useful, even for
raw images the guest may not be able to tolerate a second writer (in
this case, share-rw of the qdev device will directly control the locking
mode).

As for 2), I don't think these other users are a problem because we're
only taking shared locks. We'll prevent other users from taking an
exclusive lock, but that's exactly right because it's true that we're
using the image.

Kevin
