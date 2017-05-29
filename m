Received: from eggs.gnu.org ([2001:4830:134:3::10]:34779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFIlA-00043V-5Q
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFIl9-00047l-3E
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:22:52 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ceab079c-1d8e-368f-c51a-82e92a0b2852@redhat.com>
Date: Mon, 29 May 2017 13:22:41 +0200
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/29] qed: Convert to
 coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

On 26/05/2017 22:21, Kevin Wolf wrote:
> The qed block driver is one of the last remaining block drivers that use the
> AIO callback style interfaces. This series converts it to the coroutine model
> that other drivers are using and removes some AIO functions from the block
> layer API afterwards.
> 
> If this isn't compelling enough, the diffstat should speak for itself.
> 
> This series is relatively long, but it consists mostly of mechanical
> conversions of one function per patch, so it should be easy to review.

Looks great, just a few notes:

- There are a couple "Callback from qed_find_cluster()" comments that 
are obsolete.

- qed_acquire/qed_release can be removed as you inline stuff, but this
should not cause bugs so you can either do it as a final patch or let
me remove it later.

- coroutine_fn annotations are missing.  Also can be done as a final
patch.  It's a bit ugly that L1/L2 table access can happen both in a
coroutine (for regular I/O) and outside (for create/check).

- qed_is_allocated_cb can be inlined and QEDIsAllocatedCB removed.  Of
course a lot more cleanup could be done (I will do a couple more such
changes when adding a CoMutex to make the driver thread-safe) but this
one is pretty low-hanging fruit and seems to be in line with the rest
of the patches.

- qed_co_request doesn't need g_new for the QEDAIOCB.

Paolo

> Kevin Wolf (29):
>   qed: Use bottom half to resume waiting requests
>   qed: Make qed_read_table() synchronous
>   qed: Remove callback from qed_read_table()
>   qed: Remove callback from qed_read_l2_table()
>   qed: Remove callback from qed_find_cluster()
>   qed: Make qed_read_backing_file() synchronous
>   qed: Make qed_copy_from_backing_file() synchronous
>   qed: Remove callback from qed_copy_from_backing_file()
>   qed: Make qed_write_header() synchronous
>   qed: Remove callback from qed_write_header()
>   qed: Make qed_write_table() synchronous
>   qed: Remove GenericCB
>   qed: Remove callback from qed_write_table()
>   qed: Make qed_aio_read_data() synchronous
>   qed: Make qed_aio_write_main() synchronous
>   qed: Inline qed_commit_l2_update()
>   qed: Add return value to qed_aio_write_l1_update()
>   qed: Add return value to qed_aio_write_l2_update()
>   qed: Add return value to qed_aio_write_main()
>   qed: Add return value to qed_aio_write_cow()
>   qed: Add return value to qed_aio_write_inplace/alloc()
>   qed: Add return value to qed_aio_read/write_data()
>   qed: Remove ret argument from qed_aio_next_io()
>   qed: Remove recursion in qed_aio_next_io()
>   qed: Implement .bdrv_co_readv/writev
>   qed: Use CoQueue for serialising allocations
>   qed: Simplify request handling
>   qed: Use a coroutine for need_check_timer
>   block: Remove bdrv_aio_readv/writev_flush()
> 
>  block/Makefile.objs   |   2 +-
>  block/io.c            | 171 -----------
>  block/qed-cluster.c   | 123 ++++----
>  block/qed-gencb.c     |  33 ---
>  block/qed-table.c     | 261 ++++++-----------
>  block/qed.c           | 763 +++++++++++++++++++-------------------------------
>  block/qed.h           |  53 +---
>  include/block/block.h |   8 -
>  8 files changed, 432 insertions(+), 982 deletions(-)
>  delete mode 100644 block/qed-gencb.c
> 
