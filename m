Received: from eggs.gnu.org ([2001:4830:134:3::10]:33651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzLeM-0001v3-A4
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 08:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzLW2-00052O-3f
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 08:42:07 -0400
Date: Mon, 10 Sep 2018 14:41:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180910124136.GF4901@dhcp-200-186.str.redhat.com>
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
	<20180629124052.331406-3-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629124052.331406-3-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v0 2/2] block: postpone the coroutine
 executing if the BDS's is drained
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 29.06.2018 um 14:40 hat Denis Plotnikov geschrieben:
> Fixes the problem of ide request appearing when the BDS is in
> the "drained section".
> 
> Without the patch the request can come and be processed by the main
> event loop, as the ide requests are processed by the main event loop
> and the main event loop doesn't stop when its context is in the
> "drained section".
> The request execution is postponed until the end of "drained section".
> 
> The patch doesn't modify ide specific code, as well as any other
> device code. Instead, it modifies the infrastructure of asynchronous
> Block Backend requests, in favor of postponing the requests arisen
> when in "drained section" to remove the possibility of request appearing
> for all the infrastructure clients.
> 
> This approach doesn't make vCPU processing the request wait untill
> the end of request processing.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

I generally agree with the idea that requests should be queued during a
drained section. However, I think there are a few fundamental problems
with the implementation in this series:

1) aio_disable_external() is already a layering violation and we'd like
   to get rid of it (by replacing it with a BlockDevOps callback from
   BlockBackend to the devices), so adding more functionality there
   feels like a step in the wrong direction.

2) Only blk_aio_* are fixed, while we also have synchronous public
   interfaces (blk_pread/pwrite) as well as coroutine-based ones
   (blk_co_*). They need to be postponed as well.

   blk_co_preadv/pwritev() are the common point in the call chain for
   all of these variants, so this is where the fix needs to live.

3) Within a drained section, you want requests from other users to be
   blocked, but not your own ones (essentially you want exclusive
   access). We don't have blk_drained_begin/end() yet, so this is not
   something to implement right now, but let's keep this requirement in
   mind and choose a design that allows this.

I believe the whole logic should be kept local to BlockBackend, and
blk_root_drained_begin/end() should be the functions that start queuing
requests or let queued requests resume.

As we are already in coroutine context in blk_co_preadv/pwritev(), after
checking that blk->quiesce_counter > 0, we can enter the coroutine
object into a list and yield. blk_root_drained_end() calls aio_co_wake()
for each of the queued coroutines. This should be all that we need to
manage.

Kevin
