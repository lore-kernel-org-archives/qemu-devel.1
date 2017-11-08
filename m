Received: from eggs.gnu.org ([2001:4830:134:3::10]:47227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCRQb-00088z-MW
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCRQX-00044X-LF
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:34:05 -0500
Date: Wed, 8 Nov 2017 15:33:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171108143354.GF30890@localhost.localdomain>
References: <20171106145345.12038-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106145345.12038-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] block: Close a BlockDriverState completely
 even when bs->drv is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 06.11.2017 um 15:53 hat Alberto Garcia geschrieben:
> bdrv_close() skips much of its logic when bs->drv is NULL. This is
> fine when we're closing a BlockDriverState that has just been created
> (because e.g the initialization process failed), but it's not enough
> in other cases.
> 
> For example, when a valid qcow2 image is found to be corrupted then
> QEMU marks it as such in the file header and then sets bs->drv to
> NULL in order to make the BlockDriverState unusable. When that BDS is
> later closed then many of its data structures are not freed (leaking
> their memory) and none of its children are detached. This results in
> bdrv_close_all() failing to close all BDSs and making this assertion
> fail when QEMU is being shut down:
> 
>    bdrv_close_all: Assertion `QTAILQ_EMPTY(&all_bdrv_states)' failed.
> 
> This patch makes bdrv_close() do the full uninitialization process
> in all cases. This fixes the problem with corrupted images and still
> works fine with freshly created BDSs.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

This doesn't apply cleanly in the test case. Does it depend on your
qcow2 fixes?

Also, while I think the change makes sense, it's also clear that we're
trying to fix up an inconsistent state here. Maybe we could also improve
the state that block drivers leave behind when marking an image as
corrupt. Just setting bs->drv = NULL means that at least any internal
data structures will not get cleaned up.

On the other hand, we can't just call bdrv_close() from a failing
request because closing requires that we drain the request first. Maybe
it would be possible to call drv->bdrv_close() with a BH or something.

Kevin
