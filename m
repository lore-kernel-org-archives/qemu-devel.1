Received: from eggs.gnu.org ([2001:4830:134:3::10]:38603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtswj-0008Q9-0U
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtswf-0007YN-PW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:06:32 -0400
Date: Mon, 18 Sep 2017 11:06:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918100626.GE31063@stefanha-x1.localdomain>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-16-mreitz@redhat.com>
	<20170914155738.GE7370@stefanha-x1.localdomain>
	<2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 15/18] block/mirror: Add
 active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Sat, Sep 16, 2017 at 03:58:01PM +0200, Max Reitz wrote:
> On 2017-09-14 17:57, Stefan Hajnoczi wrote:
> > On Wed, Sep 13, 2017 at 08:19:07PM +0200, Max Reitz wrote:
> >> This patch implements active synchronous mirroring.  In active mode, the
> >> passive mechanism will still be in place and is used to copy all
> >> initially dirty clusters off the source disk; but every write request
> >> will write data both to the source and the target disk, so the source
> >> cannot be dirtied faster than data is mirrored to the target.  Also,
> >> once the block job has converged (BLOCK_JOB_READY sent), source and
> >> target are guaranteed to stay in sync (unless an error occurs).
> >>
> >> Optionally, dirty data can be copied to the target disk on read
> >> operations, too.
> >>
> >> Active mode is completely optional and currently disabled at runtime.  A
> >> later patch will add a way for users to enable it.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  qapi/block-core.json |  23 +++++++
> >>  block/mirror.c       | 187 +++++++++++++++++++++++++++++++++++++++++++++++++--
> >>  2 files changed, 205 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> index bb11815608..e072cfa67c 100644
> >> --- a/qapi/block-core.json
> >> +++ b/qapi/block-core.json
> >> @@ -938,6 +938,29 @@
> >>    'data': ['top', 'full', 'none', 'incremental'] }
> >>  
> >>  ##
> >> +# @MirrorCopyMode:
> >> +#
> >> +# An enumeration whose values tell the mirror block job when to
> >> +# trigger writes to the target.
> >> +#
> >> +# @passive: copy data in background only.
> >> +#
> >> +# @active-write: when data is written to the source, write it
> >> +#                (synchronously) to the target as well.  In addition,
> >> +#                data is copied in background just like in @passive
> >> +#                mode.
> >> +#
> >> +# @active-read-write: write data to the target (synchronously) both
> >> +#                     when it is read from and written to the source.
> >> +#                     In addition, data is copied in background just
> >> +#                     like in @passive mode.
> > 
> > I'm not sure the terms "active"/"passive" are helpful.  "Active commit"
> > means committing the top-most BDS while the guest is accessing it.  The
> > "passive" mirror block still works on the top-most BDS while the guest
> > is accessing it.
> > 
> > Calling it "asynchronous" and "synchronous" is clearer to me.  It's also
> > the terminology used in disk replication (e.g. DRBD).
> 
> I'd be OK with that, too, but I think I remember that in the past at
> least Kevin made a clear distinction between active/passive and
> sync/async when it comes to mirroring.
> 
> > Ideally the user wouldn't have to worry about async vs sync because QEMU
> > would switch modes as appropriate in order to converge.  That way
> > libvirt also doesn't have to worry about this.
> 
> So here you mean async/sync in the way I meant it, i.e., whether the
> mirror operations themselves are async/sync?

The meaning I had in mind is:

Sync mirroring means a guest write waits until the target write
completes.

Async mirroring means guest writes completes independently of target
writes.
