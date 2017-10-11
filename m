Received: from eggs.gnu.org ([2001:4830:134:3::10]:54495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e2Dch-0000QI-Io
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e2Dcd-0002Hr-KM
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:48:19 -0400
Date: Wed, 11 Oct 2017 11:48:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171011094801.GE4593@dhcp-200-186.str.redhat.com>
References: <20171010134205.6120-1-vsementsov@virtuozzo.com>
	<20171011092230.GC4593@dhcp-200-186.str.redhat.com>
	<479101f8-d6db-c90b-f1aa-05c26d7470cb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479101f8-d6db-c90b-f1aa-05c26d7470cb@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH RFC] file-posix: make lock_fd read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, berrange@redhat.com, eblake@redhat.com, famz@redhat.com

Am 11.10.2017 um 11:38 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 11.10.2017 12:22, Kevin Wolf wrote:
> > [ Cc: Fam ]
> > 
> > Am 10.10.2017 um 15:42 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > We do not reopen lock_fd on bdrv_reopen which leads to problems on
> > > reopen image RO. So, lets make lock_fd be always RO.
> > > This is correct, because qemu_lock_fd always called with exclusive=false
> > > on lock_fd.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > ---
> > > 
> > > Hi all!
> > > 
> > > We've faced the following problem with our shared-storage migration
> > > scheme. We make an external snapshot and need base image to be reopened
> > > RO. However, bdrv_reopen reopens only .fd of BDRVRawState but not
> > > .lock_fd. So, .lock_fd is left opened RW and this breaks the whole
> > > thing.
> > > 
> > > The simple fix is here: let's just open lock_fd as RO always. This
> > > looks fine for current code, as we never try to set write locks
> > > (qemu_lock_fd always called with exclusive=false).
> > > 
> > > However it will not work if we are going to use write locks.
> > I was sure that we had discussed this during review, so I just went back
> > and checked. Indeed, Fam originally had an unconditional O_RDONLY in
> > some version of the image locking patches, but I actually found a
> > potential problem with that back then:
> > 
> > > Note that with /dev/fdset there can be cases where we can open a file
> > > O_RDWR, but not O_RDONLY. Should we better just use the same flags as
> > > for the s->fd?
> > https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05107.html
> > 
> > However, I'm now wondering whether we really still need a separate
> > s->lock_fd or whether we can just use the normal image fd for this. If I
> > understood the old threads correctly, the original reason for it was
> > that during bdrv_reopen(), we couldn't safely migrate exclusive locks
> > from the old fd to the new one. But as we aren't using exclusive locks
> > any more, this shouldn't be a problem today.
> > 
> > Fam, are there more reasons why we need a separate lock_fd?
> > 
> > Kevin
> 
> If I understand correctly, posix lock will be lost on fd close anyway, so
> other app will have an opportunity of taking this lock, so it's unsafe.

With the OFD locks we're using, you just need to take the lock on the
new fd before you close the old fd, then it should be safe.

With normal POSIX locks, bdrv_reopen() is hopeless anyway, you will
always lose the lock, even with a separate lock_fd. This is why we only
make use of POSIX locks if OFD isn't available, if locking=on is
explicitly requested and only after printing a warning.

Kevin
