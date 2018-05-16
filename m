Received: from eggs.gnu.org ([2001:4830:134:3::10]:49182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ1Dh-0003QS-6M
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ1Dg-0005k0-7N
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:32:13 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-18-kwolf@redhat.com>
	<65bf7408-bdd9-6a7d-6c77-318715a4cc59@redhat.com>
	<20180515121725.GB4442@localhost.localdomain>
	<1cfc121c-c258-dceb-5aeb-189c1b08346b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d10d45c-5e2a-2e09-63e4-b52afb500dc3@redhat.com>
Date: Wed, 16 May 2018 13:32:04 -0500
MIME-Version: 1.0
In-Reply-To: <1cfc121c-c258-dceb-5aeb-189c1b08346b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/42] job: Move defer_to_main_loop to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

On 05/16/2018 05:51 AM, Max Reitz wrote:

>>>> -static void commit_complete(BlockJob *job, void *opaque)
>>>> +static void commit_complete(Job *job, void *opaque)
>>>>   {
>>>> -    CommitBlockJob *s = container_of(job, CommitBlockJob, common);
>>>> +    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
>>>
>>> Now this is just abuse.
>>>
>>> ...but it's not the first time someone packs two container_of() into
>>> one, it appears.  So, whatever, I guess.
>>
>> I don't think it's abuse. Why wouldn't I directly cast to the type that
>> I really want instead of casting to each of the uninteresting parent
>> classes, too?
> 
> Because the final parameter is called "member" and not "path". :-)

container_of() is using offsetof(); and in C99 7.17, the parameter is 
named "member-designator" which can indeed jump through multiple layers 
(any valid address constant, as defined in 6.6P9).  I don't see this as 
abuse of the interface.


>>> The best explanation I can come up with is that the original code
>>> acquired the AioContext both of the block device at the time of the BH
>>> (because that needs to be done), and at the time of
>>> block_job_defer_to_main_loop() -- because the latter is probably the
>>> context the block_job_defer_to_main_loop() call came from, so it should
>>> be (b)locked.
>>>
>>> But if that's the case, then the same should be done here.  The context
>>> of the job may change between scheduling the BH and the BH being
>>> executed, so we might lock a different context here than the one
>>> job_defer_to_main_loop() ran in (i.e., job->aio_context at the time of
>>> job_defer_to_main_loop() running).  And maybe we should lock that old
>>> context, too -- just like block_job_defer_to_main_loop_bh() did.
>>
>> Why should we lock the old context? We don't access anything protected
>> by it. Even the data->job->bs access has gone away because we now have
>> job->aio_context.
> 
> Because the old code did so and I don't know why. O:-)
> 
> Your explanation does make sense to me, though, so:

Then it's best to include that explanation in the commit message itself, 
to save the future reader the hassle of digging up this thread.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
