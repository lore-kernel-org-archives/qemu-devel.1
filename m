Received: from eggs.gnu.org ([2001:4830:134:3::10]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCjh3-0006Pk-0c
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCjgz-0002sa-Rd
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:04:17 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171109060526.GA30991@lemon>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
	<84b1b069-642e-2b33-7723-70edce3aea43@virtuozzo.com>
	<20171109060526.GA30991@lemon>
Date: Thu, 09 Nov 2017 11:03:33 +0100
Message-ID: <w51efp74vm2.fsf@maestria.local.igalia.com>
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
To: Fam Zheng <famz@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Thu 09 Nov 2017 07:05:26 AM CET, Fam Zheng wrote:

>> > I can fix the crash by adding block_job_pause_point(&s->common) at
>> > the end of stream_run() (where the 'out' label is).
>> > 
>> > I'm thinking that perhaps we should add the pause point directly to
>> > block_job_defer_to_main_loop(), to prevent any block job from
>> > running the exit function when it's paused.
>> > 
>> 
>> Is it possible that the exit function is already deferred when the
>> jobs are being paused? (even though it's at least less likely to
>> happen)
>> 
>> Then should we flush the bottom halves somehow in addition to putting
>> the jobs to sleep? And also then it all probably has to happen before
>> bdrv_reopen_queue()
>
> Or we can stash away the BH temporarily during pause period:
>
> ---
>
> diff --git a/blockjob.c b/blockjob.c
> index 3a0c49137e..7058ff7ae1 100644

Yeah, what you suggest sounds good. We would still need to add a pause
point in addition to this.

Does this sound good to everyone? If so I can prepare the patches.

Berto
