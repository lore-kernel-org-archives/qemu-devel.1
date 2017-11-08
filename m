Received: from eggs.gnu.org ([2001:4830:134:3::10]:39192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eCScP-00086f-ML
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eCScO-0003Gu-R2
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:50:21 -0500
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <84b1b069-642e-2b33-7723-70edce3aea43@virtuozzo.com>
Date: Wed, 8 Nov 2017 18:50:05 +0300
MIME-Version: 1.0
In-Reply-To: <w51inekzv59.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com



On 8/11/2017 5:45 PM, Alberto Garcia wrote:
> On Tue 07 Nov 2017 05:19:41 PM CET, Anton Nefedov wrote:
>> BlockBackend gets deleted by another job's stream_complete(), deferred
>> to the main loop, so the fact that the job is put to sleep by
>> bdrv_drain_all_begin() doesn't really stop it from execution.
> 
> I was debugging this a bit, and the block_job_defer_to_main_loop() call
> happens _after_ all jobs have been paused, so I think that when the BDS
> is drained then stream_run() finishes the last iteration without
> checking if it's paused.
> 
> Without your patch (i.e. with a smaller STREAM_BUFFER_SIZE) then I
> assume that the function would have to continue looping and
> block_job_sleep_ns() would make the job coroutine yield, effectively
> pausing the job and preventing the crash.
> 
> I can fix the crash by adding block_job_pause_point(&s->common) at the
> end of stream_run() (where the 'out' label is).
> 
> I'm thinking that perhaps we should add the pause point directly to
> block_job_defer_to_main_loop(), to prevent any block job from running
> the exit function when it's paused.
> 

Is it possible that the exit function is already deferred when the jobs
are being paused? (even though it's at least less likely to happen)

Then should we flush the bottom halves somehow in addition to putting
the jobs to sleep? And also then it all probably has to happen before
bdrv_reopen_queue()

/Anton

> Somehow I had the impression that we discussed this already in the past
> (?) because I remember thinking about this very scenario.
> 
> Berto
> 
