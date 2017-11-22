Received: from eggs.gnu.org ([2001:4830:134:3::10]:38356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHXQB-0002jC-Vu
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHXQB-0003c4-19
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:58:44 -0500
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
	<w51tvxmscay.fsf@maestria.local.igalia.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0e21cf14-388e-4b51-0236-3682de9df89b@redhat.com>
Date: Wed, 22 Nov 2017 10:58:31 -0500
MIME-Version: 1.0
In-Reply-To: <w51tvxmscay.fsf@maestria.local.igalia.com>
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com



On 11/22/2017 07:55 AM, Alberto Garcia wrote:
> On Tue 21 Nov 2017 04:18:13 PM CET, Anton Nefedov wrote:
>>  >> keep BlockJob referenced while it is
>>  >> paused (by block_job_pause/resume_all()). That should prevent it from
>>  >> deleting the BB.
>>
>> looks kind of hacky; maybe referencing in block_job_pause() (and not
>> just pause_all) seems more correct? I think it didn't work for me
>> right away though. But I can look more.
> 
> This fixes one crash for me (but only the test_stream_commit, it doesn't
> fix iotest 030 completely), but I agree it looks kind of hacky.
> 
> Peharps replacing block_job_next() with QLIST_FOREACH_SAFE() is a good
> idea, though, I guess resuming a block job can theoretically lead to its
> destruction?
> 

Indirectly, though I think currently all implemented blockjobs defer to
the main loop first as an implementation detail of the job, and then the
.abort/.commit decision will put down the last reference that the job
keeps for itself.

(Other entities may hold a reference though, like a transaction.)

[I'd love to implement a shim that forces this, but it's not important
right now.]

Whether or not you can count on the job to be there after a resume
depends on what kind of locks or threading guarantees you can make in
the context you're asking the question.

But that sounds dangerous in case any implementation detail changes, so
maybe don't.
