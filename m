Received: from eggs.gnu.org ([2001:4830:134:3::10]:46506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKNwP-0003I0-20
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKNwN-0005Iq-TX
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:27:45 -0500
Date: Thu, 30 Nov 2017 13:27:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171130122732.GB4039@localhost.localdomain>
References: <cover.1511978000.git.berto@igalia.com>
	<4011ffb0dd7f0a0a3e2cfe28223047c809761c90.1511978000.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4011ffb0dd7f0a0a3e2cfe28223047c809761c90.1511978000.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/1] blockjob: Make
 block_job_pause_all() keep a reference to the jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

Am 29.11.2017 um 18:56 hat Alberto Garcia geschrieben:
> Starting from commit 40840e419be31e6a32e6ea24511c74b389d5e0e4 we are
> pausing all block jobs during bdrv_reopen_multiple() to prevent any of
> them from finishing and removing nodes from the graph while they are
> being reopened.
> 
> It turns out that pausing a block job doesn't necessarily prevent it
> from finishing: a paused block job can still run its exit function
> from the main loop and call block_job_completed(). The mirror block
> job in particular always goes to the main loop while it is paused (by
> virtue of the bdrv_drained_begin() call in mirror_run()).
> 
> Destroying a paused block job during bdrv_reopen_multiple() has two
> consequences:
> 
>    1) The references to the nodes involved in the job are released,
>       possibly destroying some of them. If those nodes were in the
>       reopen queue this would trigger the problem originally described
>       in commit 40840e419be, crashing QEMU.

This specific problem could be avoided by making the BDS reference in
the reopen queue strong, i.e. bdrv_ref() in bdrv_reopen_queue_child()
and bdrv_unref() only at the end of bdrv_reopen_multiple().

>    2) At the end of bdrv_reopen_multiple(), bdrv_drain_all_end() would
>       not be doing all necessary bdrv_parent_drained_end() calls.

If I understand correctly, you don't have a reproducer here. I'm not
convinced that this one actually exists because the functions that do
the graph modifications (specficically bdrv_replace_child_noperm),
automatically drain and undrain nodes as necessary.

> I can reproduce problem 1) easily with iotest 030 by increasing
> STREAM_BUFFER_SIZE from 512KB to 8MB in block/stream.c, or by tweaking
> the iotest like in this example:
> 
>    https://lists.gnu.org/archive/html/qemu-block/2017-11/msg00934.html
> 
> This patch keeps an additional reference to all block jobs between
> block_job_pause_all() and block_job_resume_all(), guaranteeing that
> they are kept alive.

This might be okay as a stopgap solution if this is a real problem in
practice because we don't have a better solution right now. However,
I haven't seen any sign of there being an -rc4, so we're probably too
late for 2.11 anyway.

It's certainly not a full solution because keeping a reference to a
block job does not prevent it from completing, but only from being
freed. Most block jobs do graph modifications, including dropping the
references to nodes, already when they complete, not only when they are
freed.

Now, while the above might have sounded like we have an easy solution in
bdrv_reopen(), I see another problem that looks quite tough:

3) bdrv_reopen_queue() is a recursive operation that involves all
   children that inherited options. If the graph changes between the
   bdrv_reopen_queue() call and the end of bdrv_reopen_multiple(), the
   calculated options (and today possibly permissions) don't actually
   match the graph any more.

   The requirement we really have is that between bdrv_reopen_queue()
   and bdrv_reopen_multiple() no graph changes are made. Calling
   bdrv_drain_all_begin() in bdrv_reopen_multiple() is too late.

Maybe that actually gives us another relatively simple solution: We need
to push up the drain into the callers, and possibly just assert that the
nodes are drained in the reopen functions.

Kevin
