Received: from eggs.gnu.org ([2001:4830:134:3::10]:36125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtr9A-0001ze-OV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtr99-00044g-Ob
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:11:16 -0400
Date: Mon, 18 Sep 2017 10:11:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170918081103.GD31915@localhost.localdomain>
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170918075107.GK15551@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918075107.GK15551@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH 0/6] block: Fix permissions after ro/rw
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

Am 18.09.2017 um 09:51 hat Fam Zheng geschrieben:
> On Fri, 09/15 12:10, Kevin Wolf wrote:
> > bdrv_reopen() can switch nodes between read-only and read-write modes.
> > This has implications for the required permissions on their child nodes.
> > For example, a qcow2 node requests write permissions on bs->file only if
> > it is writable itself.
> > 
> > This means that during bdrv_reopen(), the permissions need to be
> > recalculated in order to prevent failures where the bs->file
> > permissions don't match its actual read-only state (e.g. bs->file is a
> > read-write node, but the permission still enforces read-only access).
> 
> Passing reopen_queue around makes the interface and implementations
> complicated.

Yes. I don't like it, but I couldn't find any easier way.

> I wonder if any of the alternatives make sense:
> 
> 1) Don't pass reopen_queue as a parameter, just pass the one
> interesting BDRVReopenState pointer. So that callees don't need to
> call bdrv_reopen_get_flags().

There isn't a single interesting BDRVReopenState. The subset that a
single BDS needs to determine its new state is the the BDRVReopenState
of all of its parents. This can be an arbitrary number.

> 2) Don't change the prototypes at all, just change .bdrv_reopen_prepare contract
> so that after it returns, .bdrv_child_perm/.bdrv_check_perm should comply to the
> new state that would be commited once .bdrv_reopen_commit() is called, or
> reverted if .bdrv_reopen_abort().

Hm, .bdrv_reopen_prepare already gets the whole queue passed, so I guess
this could technically work. I'm not sure if it is a good idea, though.

Such a change would still make .bdrv_child_perm depend on the reopen
queue, just without actually passing it as a parameter. I like such
hidden data flows even less than adding an explicit one.

It would also mean that each block driver would have to save the queue
in its local bs->opaque structure so that .bdrv_child_perm can access it
later. Alternatively, bdrv_reopen_prepare could already store the new
cumulative parent permissions, but it would still involve two new fields
in bs->opaque for storing something of a rather temporary nature.

Though maybe I'm just missing another way to implement this that you had
in mind?

> 3) Don't change the prototypes at all, track the reopen progress in block.c
> generically, (e.g. ignore conflicts and voilations) and update the permissions
> only after bdrv_reopen_commit().

Both permission updates and reopen are transactional. You need to do
both prepare stages first before you can do commits. If you only start
doing the prepare stage of permissions during the commit stage of
reopen, you break the error cases.

Kevin
