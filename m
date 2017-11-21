Received: from eggs.gnu.org ([2001:4830:134:3::10]:44157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eH81e-0001Db-9j
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eH81b-000119-6k
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:51:42 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <41e905e4-0c2a-fad3-09a6-4959f04fe546@virtuozzo.com>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
	<w518tff4dvi.fsf@maestria.local.igalia.com>
	<20171110030223.GA7303@lemon>
	<w518tf7k0ov.fsf@maestria.local.igalia.com>
	<14461b9b-d62d-3723-d2bb-c2fe873207c5@virtuozzo.com>
	<w51bmk2qkvv.fsf@maestria.local.igalia.com>
	<41e905e4-0c2a-fad3-09a6-4959f04fe546@virtuozzo.com>
Date: Tue, 21 Nov 2017 13:51:34 +0100
Message-ID: <w51zi7fbxrd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] segfault in parallel blockjobs
 (iotest 30)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

On Thu 16 Nov 2017 05:09:59 PM CET, Anton Nefedov wrote:
>>>> I have the impression that one major source of headaches is the
>>>> fact that the reopen queue contains nodes that don't need to be
>>>> reopened at all. Ideally this should be detected early on in
>>>> bdrv_reopen_queue(), so there's no chance that the queue contains
>>>> nodes used by a different block job. If we had that then op
>>>> blockers should be enough to prevent these things. Or am I missing
>>>> something?
>>>>
>>> After applying Max's patch I tried the similar approach; that is
>>> keep BDSes referenced while they are in the reopen queue.  Now I get
>>> the stream job hanging. Somehow one blk_root_drained_begin() is not
>>> paired with blk_root_drained_end(). So the job stays paused.
>> 
>> I can see this if I apply Max's patch and keep refs to BDSs in the
>> reopen queue:
>> 
>> #0  block_job_pause (...) at blockjob.c:130
>> #1  0x000055c143cb586d in block_job_drained_begin (...) at blockjob.c:227
>> #2  0x000055c143d08067 in blk_set_dev_ops (...) at block/block-backend.c:887
>> #3  0x000055c143cb69db in block_job_create (...) at blockjob.c:678
>> #4  0x000055c143d17c0c in mirror_start_job (...) at block/mirror.c:1177
>> 
>> There's a ops->drained_begin(opaque) call in blk_set_dev_ops() that
>> doesn't seem to be paired. 
>
> My understanding for now is
>
>    1. in bdrv_drain_all_begin(), BDS gets drained with
>       bdrv_parent_drained_begin(), all the parents get
>       blk_root_drained_begin(), pause their jobs.
>    2. one of the jobs finishes and deletes BB.
>    3. in bdrv_drain_all_end(), bdrv_parent_drained_end() is never
>       called because even though BDS still exists (referenced in the
>       queue), it cannot be accessed as bdrv_next() takes BDS from the
>       global BB list (and the corresponding BB is deleted).

Yes, I was debugging this and I got to a similar conclusion. With
test_stream_commit from iotest 030 I can see that

   1. the block-stream job is created first, then stream_run begins and
      starts copying the data.
   2. block-commit starts and tries to reopen the top image in
      read-write mode. This pauses the stream block job and drains all
      BDSs.
   3. The draining causes the stream job to finish, it is deferred to
      the main loop, then stream_complete finishes and unrefs the block
      job, deleting it. At the point of deletion the pause count was
      still > 0 (because of step (2))

> Max's patch v1 could have helped:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg01835.html

This doesn't solve the problem.

> Or, perhaps another approach, keep BlockJob referenced while it is
> paused (by block_job_pause/resume_all()). That should prevent it from
> deleting the BB.

Yes, I tried this and it actually solves the issue. But I still think
that the problem is that block jobs are allowed to finish when they are
paused.

Adding block_job_pause_point(&s->common) at the end of stream_run()
fixes the problem too.

Berto
