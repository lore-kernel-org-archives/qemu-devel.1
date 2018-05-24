Received: from eggs.gnu.org ([2001:4830:134:3::10]:56725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLuK8-0003F4-7N
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLuK7-0007an-9u
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:46:48 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-18-kwolf@redhat.com>
	<fa219be9-84e4-07ec-69a5-1fddb608ccbb@redhat.com>
	<20180524081715.GB4008@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <e9acffe3-7f83-3555-1e91-9cdcaeeef158@redhat.com>
Date: Thu, 24 May 2018 13:46:38 -0400
MIME-Version: 1.0
In-Reply-To: <20180524081715.GB4008@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/40] job: Move BlockJobCreateFlags to
 Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/24/2018 04:17 AM, Kevin Wolf wrote:
> Am 24.05.2018 um 00:24 hat John Snow geschrieben:
>>
>>
>> On 05/18/2018 09:20 AM, Kevin Wolf wrote:
>>> +    job->auto_finalize = !(flags & JOB_MANUAL_FINALIZE);
>>> +    job->auto_dismiss  = !(flags & JOB_MANUAL_DISMISS);
>>
>> Job API might be a good chance to say "No, this is the default behavior
>> for this API."
>>
>> I don't know how possible this is, but could we remove these behavior
>> flags for jobs (but keep them for block jobs), and then any legacy block
>> job creation interfaces we have can enable/disable them as the user
>> requested,
>>
>> and the block job layer itself has hooks that persuade the core job
>> layer to automatically transition without user input, if appropriate.
>>
>> (Unless that happens later?)
> 
> That's really a question for job-create, which we don't have yet. I'm
> not sure whether job-create would expose those options, and if so, what
> the defaults would be.
> 
> I think auto-dismiss=false is a good default because the reason for
> having a manual job-dismiss is shared by all jobs (you want to be able
> to query the job result after it finished).
> 

Sounds good to me.

> auto-finalize is different. We introduced it to avoid surprise graph
> changes, but this implies that every job changes the block graph when it
> completes. This is obviously not true for non-block jobs. They might
> still commonly change something else that shouldn't be done as a
> surprise, but I am working right now on at least a single job type that
> doesn't do anything like that on completion (blockdev-create).
> 

I'll have to stay tuned.

> For now, I made it unconditionally auto-finalize=true and
> auto-dismiss=false without offering the options in QMP, but that's open
> for discussion.

Sure. I was wondering if we didn't want to change the internal API's
defaults around, but I guess that can happen whenever based on what the
QMP looks like.

> 
> Kevin
> 
