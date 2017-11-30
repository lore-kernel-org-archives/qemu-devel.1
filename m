Received: from eggs.gnu.org ([2001:4830:134:3::10]:54555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eKPvq-0007Oy-T3
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eKPvm-0005sh-Es
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:35:18 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171130122732.GB4039@localhost.localdomain>
References: <cover.1511978000.git.berto@igalia.com>
	<4011ffb0dd7f0a0a3e2cfe28223047c809761c90.1511978000.git.berto@igalia.com>
	<20171130122732.GB4039@localhost.localdomain>
Date: Thu, 30 Nov 2017 15:35:11 +0100
Message-ID: <w514lpbj0m8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

On Thu 30 Nov 2017 01:27:32 PM CET, Kevin Wolf wrote:

>> Destroying a paused block job during bdrv_reopen_multiple() has two
>> consequences:
>> 
>>    1) The references to the nodes involved in the job are released,
>>       possibly destroying some of them. If those nodes were in the
>>       reopen queue this would trigger the problem originally described
>>       in commit 40840e419be, crashing QEMU.
>
> This specific problem could be avoided by making the BDS reference in
> the reopen queue strong, i.e. bdrv_ref() in bdrv_reopen_queue_child()
> and bdrv_unref() only at the end of bdrv_reopen_multiple().

That is correct.

>>    2) At the end of bdrv_reopen_multiple(), bdrv_drain_all_end() would
>>       not be doing all necessary bdrv_parent_drained_end() calls.
>
> If I understand correctly, you don't have a reproducer here.

That's unfortunately not correct.

You can use the very test case that I mentioned in the commit message:

   https://lists.gnu.org/archive/html/qemu-block/2017-11/msg00934.html

With that one, QEMU master crashes easily because of problem (1). If I
hold strong references in the reopen queue as you mentioned, the test
case hangs because of problem (2).

> It's certainly not a full solution because keeping a reference to a
> block job does not prevent it from completing, but only from being
> freed. Most block jobs do graph modifications, including dropping the
> references to nodes, already when they complete, not only when they
> are freed.

Yes but the block job itself holds additional references (thanks to
block_job_add_bdrv()).

> Now, while the above might have sounded like we have an easy solution
> in bdrv_reopen(), I see another problem that looks quite tough:
>
> 3) bdrv_reopen_queue() is a recursive operation that involves all
>    children that inherited options. If the graph changes between the
>    bdrv_reopen_queue() call and the end of bdrv_reopen_multiple(), the
>    calculated options (and today possibly permissions) don't actually
>    match the graph any more.
>
>    The requirement we really have is that between bdrv_reopen_queue()
>    and bdrv_reopen_multiple() no graph changes are made. Calling
>    bdrv_drain_all_begin() in bdrv_reopen_multiple() is too late.

Yes I agree that that should be the requirement.

Berto
