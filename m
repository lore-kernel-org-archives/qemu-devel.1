Received: from eggs.gnu.org ([2001:4830:134:3::10]:44941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eFMVm-0000cH-6t
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eFMVh-0005VD-C6
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:55:30 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <14461b9b-d62d-3723-d2bb-c2fe873207c5@virtuozzo.com>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
	<w518tff4dvi.fsf@maestria.local.igalia.com>
	<20171110030223.GA7303@lemon>
	<w518tf7k0ov.fsf@maestria.local.igalia.com>
	<14461b9b-d62d-3723-d2bb-c2fe873207c5@virtuozzo.com>
Date: Thu, 16 Nov 2017 16:54:44 +0100
Message-ID: <w51bmk2qkvv.fsf@maestria.local.igalia.com>
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

On Wed 15 Nov 2017 05:31:20 PM CET, Anton Nefedov wrote:
>> I have the impression that one major source of headaches is the fact
>> that the reopen queue contains nodes that don't need to be reopened at
>> all. Ideally this should be detected early on in bdrv_reopen_queue(), so
>> there's no chance that the queue contains nodes used by a different
>> block job. If we had that then op blockers should be enough to prevent
>> these things. Or am I missing something?
>> 
> After applying Max's patch I tried the similar approach; that is keep
> BDSes referenced while they are in the reopen queue.  Now I get the
> stream job hanging. Somehow one blk_root_drained_begin() is not paired
> with blk_root_drained_end(). So the job stays paused.

I can see this if I apply Max's patch and keep refs to BDSs in the
reopen queue:

#0  block_job_pause (...) at blockjob.c:130
#1  0x000055c143cb586d in block_job_drained_begin (...) at blockjob.c:227
#2  0x000055c143d08067 in blk_set_dev_ops (...) at block/block-backend.c:887
#3  0x000055c143cb69db in block_job_create (...) at blockjob.c:678
#4  0x000055c143d17c0c in mirror_start_job (...) at block/mirror.c:1177

There's a ops->drained_begin(opaque) call in blk_set_dev_ops() that
doesn't seem to be paired. And when you call block_job_start() then it
yields immediately waiting for the resume (that never arrives).

John, this change was yours (f4d9cc88ee69a5b04). Any idea?

Berto
