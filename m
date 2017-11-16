Received: from eggs.gnu.org ([2001:4830:134:3::10]:60250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFS9l-00056u-Gp
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFS9k-0000gS-Ou
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:57:09 -0500
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
	<w518tff4dvi.fsf@maestria.local.igalia.com>
	<20171110030223.GA7303@lemon>
	<w518tf7k0ov.fsf@maestria.local.igalia.com>
	<14461b9b-d62d-3723-d2bb-c2fe873207c5@virtuozzo.com>
	<w51bmk2qkvv.fsf@maestria.local.igalia.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <127bc8f6-af95-62ae-8470-2e2e39f27f89@redhat.com>
Date: Thu, 16 Nov 2017 16:56:58 -0500
MIME-Version: 1.0
In-Reply-To: <w51bmk2qkvv.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
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
To: Alberto Garcia <berto@igalia.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com



On 11/16/2017 10:54 AM, Alberto Garcia wrote:
> On Wed 15 Nov 2017 05:31:20 PM CET, Anton Nefedov wrote:
>>> I have the impression that one major source of headaches is the fact
>>> that the reopen queue contains nodes that don't need to be reopened at
>>> all. Ideally this should be detected early on in bdrv_reopen_queue(), so
>>> there's no chance that the queue contains nodes used by a different
>>> block job. If we had that then op blockers should be enough to prevent
>>> these things. Or am I missing something?
>>>
>> After applying Max's patch I tried the similar approach; that is keep
>> BDSes referenced while they are in the reopen queue.  Now I get the
>> stream job hanging. Somehow one blk_root_drained_begin() is not paired
>> with blk_root_drained_end(). So the job stays paused.
> 
> I can see this if I apply Max's patch and keep refs to BDSs in the
> reopen queue:
> 
> #0  block_job_pause (...) at blockjob.c:130
> #1  0x000055c143cb586d in block_job_drained_begin (...) at blockjob.c:227
> #2  0x000055c143d08067 in blk_set_dev_ops (...) at block/block-backend.c:887
> #3  0x000055c143cb69db in block_job_create (...) at blockjob.c:678
> #4  0x000055c143d17c0c in mirror_start_job (...) at block/mirror.c:1177
> 
> There's a ops->drained_begin(opaque) call in blk_set_dev_ops() that
> doesn't seem to be paired. And when you call block_job_start() then it
> yields immediately waiting for the resume (that never arrives).
> 
> John, this change was yours (f4d9cc88ee69a5b04). Any idea?
> 
> Berto
> 

The idea at the time was that if you tell the BlockBackend to drain and
then attach a job to it, once you go to *end* the drained region you'd
have a mismatched begin/end pair.

To allow for some flexibility and to make sure that you *didn't* have a
mismatched begin/end call, what I did was that if you attach dev_ops to
an already drained backend (i.e. we "missed our chance" to issue the
drained_begin) we play catch-up and issue the drained call.

There's no matching call here, because I anticipated whoever initially
bumped that quiesce_counter up to be issuing the drained_end, which will
then be propagated according to the dev_ops structure in place.
