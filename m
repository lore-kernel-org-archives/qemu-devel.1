Received: from eggs.gnu.org ([2001:4830:134:3::10]:37781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFpp-0002Cr-Br
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFpk-000847-S6
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:44:25 -0400
Date: Fri, 8 Sep 2017 17:44:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908094408.GJ4511@lemon>
References: <20170811080939.22304-1-famz@redhat.com>
	<20170907150739.GH4461@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170907150739.GH4461@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2] file-posix: Clear out first
 sector in hdev_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, 09/07 17:07, Kevin Wolf wrote:
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index f4de022ae0..a63bbf2b90 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2703,6 +2703,16 @@ static int hdev_create(const char *filename, QemuOpts *opts,
> >          ret = -ENOSPC;
> >      }
> 
> So the error paths above only set ret, but don't actually return or jump
> to the end of the function.
> 
> > +    if (total_size) {
> > +        uint8_t buf[BDRV_SECTOR_SIZE] = { 0 };
> > +        int64_t zero_size = MIN(BDRV_SECTOR_SIZE, total_size);
> > +        if (lseek(fd, 0, SEEK_SET) == -1) {
> > +            ret = -errno;
> > +        } else {
> > +            ret = qemu_write_full(fd, buf, zero_size);
> > +            ret = ret == zero_size ? 0 : -errno;
> 
> Which means that an error above (like a too small block device or using
> a regular file) can be overwritten with a success value if clearing the
> first sector works. That's probably not quite right.

You're right, will fix.

Fam
