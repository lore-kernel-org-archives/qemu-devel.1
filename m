Received: from eggs.gnu.org ([2001:4830:134:3::10]:49722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUORV-0000gJ-4T
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 20:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUORU-00015w-6b
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 20:56:41 -0500
Date: Fri, 20 Jan 2017 09:56:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170120015628.GA29561@lemon>
References: <20170119143816.21972-1-famz@redhat.com>
	<20170119143816.21972-15-famz@redhat.com>
	<20170119154900.GB16641@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119154900.GB16641@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 14/16] file-posix: Implement image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

On Thu, 01/19 15:49, Daniel P. Berrange wrote:
> On Thu, Jan 19, 2017 at 10:38:14PM +0800, Fam Zheng wrote:
> > This implements open flag sensible image locking for local file
> > and host device protocol.
> > 
> > virtlockd in libvirt locks the first byte, so we start looking at the
> > file bytes from 1.
> > 
> > Quoting what was proposed by Kevin Wolf <kwolf@redhat.com>, there are
> > four locking modes by combining two bits (BDRV_O_RDWR and
> > BDRV_O_SHARE_RW), and implemented by taking two locks:
> > 
> > Lock bytes:
> > 
> > * byte 1: I can't allow other processes to write to the image
> > * byte 2: I am writing to the image
> > 
> > Lock modes:
> > 
> > * shared writer (BDRV_O_RDWR | BDRV_O_SHARE_RW): Take shared lock on
> >   byte 2. Test whether byte 1 is locked using an exclusive lock, and
> >   fail if so.
> > 
> > * exclusive writer (BDRV_O_RDWR only): Take shared lock on byte 2. Test
> >   whether byte 1 is locked using an exclusive lock, and fail if so. Then
> >   take shared lock on byte 1. I suppose this is racy, but we can
> >   probably tolerate that.
> > 
> > * reader that can tolerate writers (BDRV_O_SHARE_RW only): Don't do anything
> > 
> > * reader that can't tolerate writers (neither bit is set): Take shared
> >   lock on byte 1. Test whether byte 2 is locked, and fail if so.
> 
> Ahh, using two bytes is an interesting technique for mapping the four
> different access methods onto the more limit fcntl lock semantics. We
> might want to copy this approach in libvirt too....
> 
> > +/* Posix file locking bytes. Libvirt takes byte 0, so start from byte 1. */
> > +#define RAW_LOCK_BYTE_MIN             1
> > +#define RAW_LOCK_BYTE_NO_OTHER_WRITER 1
> > +#define RAW_LOCK_BYTE_WRITE           2
> 
> ...would you mind if QEMU started from say byte 10, leaving the first 10
> reserved for libvirt uses. This lets libvirt have a continuous space for
> its own usage if we want to use more bytes

That's easy, will do it. (Actually the descriptions above are a bit stale
because exclusive writers now take two bytes exclusively and the lock testings
are done with F_OFD_GETLK so that RO readers can test against shared locks
without acquiring a write lock, which requires O_RDWR).

Fam
