Received: from eggs.gnu.org ([2001:4830:134:3::10]:33801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEzqm-0008Cz-3c
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEzqi-0002cH-6y
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:43:40 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171110030223.GA7303@lemon>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
	<w518tff4dvi.fsf@maestria.local.igalia.com>
	<20171110030223.GA7303@lemon>
Date: Wed, 15 Nov 2017 16:42:56 +0100
Message-ID: <w518tf7k0ov.fsf@maestria.local.igalia.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Fri 10 Nov 2017 04:02:23 AM CET, Fam Zheng wrote:
>> > I'm thinking that perhaps we should add the pause point directly to
>> > block_job_defer_to_main_loop(), to prevent any block job from
>> > running the exit function when it's paused.
>> 
>> I was trying this and unfortunately this breaks the mirror job at
>> least (reproduced with a simple block-commit on the topmost node,
>> which uses commit_active_start() -> mirror_start_job()).
>> 
>> So what happens is that mirror_run() always calls
>> bdrv_drained_begin() before returning, pausing the block job. The
>> closing bdrv_drained_end() call is at the end of mirror_exit(),
>> already in the main loop.
>> 
>> So the mirror job is always calling block_job_defer_to_main_loop()
>> and mirror_exit() when the job is paused.
>
> FWIW, I think Max's report on 194 failures is related:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01822.html
>
> so perhaps it's worth testing his patch too:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01835.html

Well, that doesn't solve the original crash with parallel block jobs.
The root of the crash is that the mirror job manipulates the graph
_while being paused_, so the BlockReopenQueue in bdrv_reopen_multiple()
gets messed up, and pausing the jobs (commit 40840e419be31e) won't help.

I have the impression that one major source of headaches is the fact
that the reopen queue contains nodes that don't need to be reopened at
all. Ideally this should be detected early on in bdrv_reopen_queue(), so
there's no chance that the queue contains nodes used by a different
block job. If we had that then op blockers should be enough to prevent
these things. Or am I missing something?

Berto
