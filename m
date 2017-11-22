Received: from eggs.gnu.org ([2001:4830:134:3::10]:45318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHIfu-0004kS-Fk
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 19:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHIft-0007TD-EE
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 19:13:58 -0500
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
	<w518tff4dvi.fsf@maestria.local.igalia.com>
	<20171110030223.GA7303@lemon>
	<w518tf7k0ov.fsf@maestria.local.igalia.com>
	<14461b9b-d62d-3723-d2bb-c2fe873207c5@virtuozzo.com>
	<w51bmk2qkvv.fsf@maestria.local.igalia.com>
	<41e905e4-0c2a-fad3-09a6-4959f04fe546@virtuozzo.com>
	<w51zi7fbxrd.fsf@maestria.local.igalia.com>
	<160cac7d-7dc6-2daf-5299-82a57bffe14c@virtuozzo.com>
	<w51wp2jbqcd.fsf@maestria.local.igalia.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <683910c4-1ef3-f072-caf2-87d344735d03@redhat.com>
Date: Tue, 21 Nov 2017 19:13:47 -0500
MIME-Version: 1.0
In-Reply-To: <w51wp2jbqcd.fsf@maestria.local.igalia.com>
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Jeff Cody <jcody@redhat.com>

CC Jeff Cody

... who may or may not be preoccupied with Thanksgiving travel now.

Convenient URL for reading past replies:
https://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg03844.html

On 11/21/2017 10:31 AM, Alberto Garcia wrote:
> On Tue 21 Nov 2017 04:18:13 PM CET, Anton Nefedov wrote:
> 
>>>> Or, perhaps another approach, keep BlockJob referenced while it is
>>>> paused (by block_job_pause/resume_all()). That should prevent it
>>>> from deleting the BB.
>>>
>>> Yes, I tried this and it actually solves the issue. But I still think
>>> that the problem is that block jobs are allowed to finish when they
>>> are paused.
>>
>> Agree, but
>>
>>> Adding block_job_pause_point(&s->common) at the end of stream_run()
>>> fixes the problem too.
>>
>> would be a nice fix, but it only works unless the job is already
>> deferred, right?
> 
> Right, I didn't mean to propose it as the proper solution (it would
> still leave mirror job vulnerable because it's already paused by the
> time it calls defer_to_main_loop()).
> 
>> This:
>>
>>  >> keep BlockJob referenced while it is
>>  >> paused (by block_job_pause/resume_all()). That should prevent it from
>>  >> deleting the BB.
>>
>> looks kind of hacky; maybe referencing in block_job_pause() (and not
>> just pause_all) seems more correct? I think it didn't work for me
>> right away though. But I can look more.
> 
> You have to be careful when you unref the block job because you may
> destroy it, and therefore block_job_next() in block_job_resume_all()
> would be using freed memory.
> 
> Berto
> 
