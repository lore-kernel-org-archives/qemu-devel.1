Received: from eggs.gnu.org ([2001:4830:134:3::10]:41093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4jG9-0006Dd-Oo
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4jG8-0002M5-Mn
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:59:25 -0400
Date: Wed, 18 Oct 2017 15:59:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171018075915.GB9443@lemon>
References: <20171010134205.6120-1-vsementsov@virtuozzo.com>
	<20171011092230.GC4593@dhcp-200-186.str.redhat.com>
	<479101f8-d6db-c90b-f1aa-05c26d7470cb@virtuozzo.com>
	<20171011094801.GE4593@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011094801.GE4593@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] file-posix: make lock_fd read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, berrange@redhat.com, eblake@redhat.com

On Wed, 10/11 11:48, Kevin Wolf wrote:
> Am 11.10.2017 um 11:38 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > 11.10.2017 12:22, Kevin Wolf wrote:
> > > [ Cc: Fam ]

Sorry for being slow, now finally getting my hands on email backlog after
holiday and preparing for KVM Forum presentation.

> > > 
> > > Am 10.10.2017 um 15:42 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > > We do not reopen lock_fd on bdrv_reopen which leads to problems on
> > > > reopen image RO. So, lets make lock_fd be always RO.
> > > > This is correct, because qemu_lock_fd always called with exclusive=false
> > > > on lock_fd.
> > > > 
> > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > > ---
> > > > 
> > > > Hi all!
> > > > 
> > > > We've faced the following problem with our shared-storage migration
> > > > scheme. We make an external snapshot and need base image to be reopened
> > > > RO. However, bdrv_reopen reopens only .fd of BDRVRawState but not
> > > > .lock_fd. So, .lock_fd is left opened RW and this breaks the whole
> > > > thing.
> > > > 
> > > > The simple fix is here: let's just open lock_fd as RO always. This
> > > > looks fine for current code, as we never try to set write locks
> > > > (qemu_lock_fd always called with exclusive=false).
> > > > 
> > > > However it will not work if we are going to use write locks.
> > > I was sure that we had discussed this during review, so I just went back
> > > and checked. Indeed, Fam originally had an unconditional O_RDONLY in
> > > some version of the image locking patches, but I actually found a
> > > potential problem with that back then:
> > > 
> > > > Note that with /dev/fdset there can be cases where we can open a file
> > > > O_RDWR, but not O_RDONLY. Should we better just use the same flags as
> > > > for the s->fd?
> > > https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05107.html
> > > 
> > > However, I'm now wondering whether we really still need a separate
> > > s->lock_fd or whether we can just use the normal image fd for this. If I
> > > understood the old threads correctly, the original reason for it was
> > > that during bdrv_reopen(), we couldn't safely migrate exclusive locks
> > > from the old fd to the new one. But as we aren't using exclusive locks
> > > any more, this shouldn't be a problem today.
> > > 
> > > Fam, are there more reasons why we need a separate lock_fd?

I think your reasoning is right. We needed lock_fd in earlier revisions of the
image locking patch because we cannot move exclusive lock from one fd to another
transactionally. We don't need that now.

Fam
