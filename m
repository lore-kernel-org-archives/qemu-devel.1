Received: from eggs.gnu.org ([2001:4830:134:3::10]:35383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg4cf-0008KU-Uh
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg4cf-0001kg-0v
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:44:45 -0400
Date: Fri, 11 Aug 2017 15:44:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170811074435.GB27391@lemon.lan>
References: <20170810080108.31047-1-famz@redhat.com>
	<f587d8ac-476d-e285-6579-3a8188de1790@redhat.com>
	<20170811072806.GA27391@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811072806.GA27391@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.10?] file-posix: Clear out first
 sector in hdev_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 08/11 15:28, Fam Zheng wrote:
> On Thu, 08/10 08:58, Eric Blake wrote:
> > On 08/10/2017 03:01 AM, Fam Zheng wrote:
> > > +    if (total_size) {
> > > +        int64_t zero_size = MIN(BDRV_SECTOR_SIZE, total_size);
> > > +        uint8_t *buf;
> > 
> > Since BDRV_SECTOR_SIZE is small enough to stack-allocate, you could skip
> > the malloc by doing:
> > 
> > uint8_t buf[BDRV_SECTOR_SIZE] = "";
> > 
> > > +        if (lseek(fd, 0, SEEK_SET) == -1) {
> > > +            ret = -errno;
> > > +        } else {
> > > +            buf = g_malloc0(zero_size);
> > > +            ret = qemu_write_full(fd, buf, zero_size);
> > 
> > Instead of doing lseek + qemu_write_full, can we just use
> > qemu_pwritev(fd, &iov, 1, 0) with an iov set up to point to the
> > appropriate amount of buf?
> 
> Neat, will update.

For stack-allocation yes, but qemu_write_full turns out to be better because of
short write handling.  So I'll keep it in v2.

Fam
