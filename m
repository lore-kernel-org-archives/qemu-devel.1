Received: from eggs.gnu.org ([2001:4830:134:3::10]:33215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d47rQ-0000p5-MI
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d47rP-000879-Nt
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:31:08 -0400
Date: Fri, 28 Apr 2017 23:30:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170428153056.GA31788@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-21-famz@redhat.com>
	<20170428134543.GD4714@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428134543.GD4714@noname.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Fri, 04/28 15:45, Kevin Wolf wrote:
> Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> > This extends the permission bits of op blocker API to external using
> > Linux OFD locks.
> > 
> > Each permission in @perm and @shared_perm is represented by a locked
> > byte in the image file.  Requesting a permission in @perm is translated
> > to a shared lock of the corresponding byte; rejecting to share the same
> > permission is translated to a shared lock of a separate byte. With that,
> > we use 2x number of bytes of distinct permission types.
> > 
> > virtlockd in libvirt locks the first byte, so we do locking from a
> > higher offset.
> > 
> > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> >  BlockDriver bdrv_file = {
> >      .format_name = "file",
> >      .protocol_name = "file",
> > @@ -1977,7 +2234,11 @@ BlockDriver bdrv_file = {
> >      .bdrv_get_info = raw_get_info,
> >      .bdrv_get_allocated_file_size
> >                          = raw_get_allocated_file_size,
> > -
> > +    .bdrv_inactivate = raw_inactivate,
> > +    .bdrv_invalidate_cache = raw_invalidate_cache,
> > +    .bdrv_check_perm = raw_check_perm,
> > +    .bdrv_set_perm   = raw_set_perm,
> > +    .bdrv_abort_perm_update = raw_abort_perm_update,
> >      .create_opts = &raw_create_opts,
> >  };
> 
> By the way, is it intentional that we apply locking only to bdrv_file,
> but not to bdrv_host_device or bdrv_host_cdrom?

Good question.

Though CDROM is not very interesting, I am not sure about bdrv_host_device:

1) On the one hand, a host device can contain a qcow2 image so maybe locking is
useful.  Another reason to lock is that they share the same QAPI option,
BlockdevOptionsFile. That last reason is, it should be very easy to add it.

2) On the other hand, unlike files, host devices get pretty high chances in
being accesses by multiple readers/writers, outside of QEMU, such as partition
detection, mount, fsck, etc.

What is your opinion?

Fam
