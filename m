Received: from eggs.gnu.org ([2001:4830:134:3::10]:45587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtuby-0007BX-4p
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtubx-0004KR-50
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:53:14 -0400
Date: Mon, 18 Sep 2017 19:53:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918115303.GL15551@lemon.lan>
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170918075107.GK15551@lemon.lan>
	<20170918081103.GD31915@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918081103.GD31915@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Mon, 09/18 10:11, Kevin Wolf wrote:
> > 2) Don't change the prototypes at all, just change .bdrv_reopen_prepare contract
> > so that after it returns, .bdrv_child_perm/.bdrv_check_perm should comply to the
> > new state that would be commited once .bdrv_reopen_commit() is called, or
> > reverted if .bdrv_reopen_abort().
> 
> Hm, .bdrv_reopen_prepare already gets the whole queue passed, so I guess
> this could technically work. I'm not sure if it is a good idea, though.
> 
> Such a change would still make .bdrv_child_perm depend on the reopen
> queue, just without actually passing it as a parameter. I like such
> hidden data flows even less than adding an explicit one.
> 
> It would also mean that each block driver would have to save the queue
> in its local bs->opaque structure so that .bdrv_child_perm can access it
> later. Alternatively, bdrv_reopen_prepare could already store the new
> cumulative parent permissions, but it would still involve two new fields
> in bs->opaque for storing something of a rather temporary nature.

What about this?

1) drv->bdrv_reopen_prepare() saves the desired new perms in BDRVReopenState.
2) bdrv_reopen_prepare() checks the new perms after drv->bdrv_reopen_prepare()
   returns.
3) bdrv_reopen_commit() updates the bs to new perms.

Fam
