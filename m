Received: from eggs.gnu.org ([2001:4830:134:3::10]:40247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsTP6-00074m-Bd
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsTP4-0004xP-5T
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:42:32 -0400
References: <20180821064538.19750-1-famz@redhat.com>
	<ba24e15d-7783-dc05-49a8-ffa5e7905499@redhat.com>
	<20180822054833.GA3878@lemon.usersys.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b18f8c6b-25e2-d4fd-c30c-e0ffc4c189c2@redhat.com>
Date: Wed, 22 Aug 2018 08:42:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180822054833.GA3878@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] job: Fix nested aio_poll() hanging in
 job_txn_apply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-stable@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com

On 08/22/2018 12:48 AM, Fam Zheng wrote:
>> However, I was unable to quickly audit whether all callers really did have
>> the lock (it balloons into whether all callers of job_finalize() have the
>> lock), so I'm reluctant to give R-b.
>>
>>> @@ -857,10 +849,10 @@ static void job_completed_txn_success(Job *job)
>>>            assert(other_job->ret == 0);
>>>        }
>>> -    job_txn_apply(txn, job_transition_to_pending, false);
>>> +    job_txn_apply(txn, job_transition_to_pending);
>>>        /* If no jobs need manual finalization, automatically do so */
>>> -    if (job_txn_apply(txn, job_needs_finalize, false) == 0) {
>>> +    if (job_txn_apply(txn, job_needs_finalize) == 0) {
>>>            job_do_finalize(job);
>>
>> That said, the change makes sense here: since the first direct call to
>> job_txn_apply() did not need to lock, why should the second indirect call
>> through job_do_finalize() need it?
>>
>> Or, is the fix to have job_do_finalize() gain a bool parameter, where
>> job_completed_txn_success() would pass false to that parameter, while
>> job_finalize() would pass true (again, going back to auditing whether all
>> callers of job_finalize() have already acquired the context).
> 
> There are two callers of job_finalize():

Okay, so the audit would have been easier if I had actually tried 
grepping for it.  Still, it can't hurt to make the commit message give 
more details on what you checked, to make it easier for the reviewers.

> 
>      fam@lemon:~/work/qemu [master]$ git grep -w -A1 '^\s*job_finalize'
>      blockdev.c:    job_finalize(&job->job, errp);
>      blockdev.c-    aio_context_release(aio_context);
>      --
>      job-qmp.c:    job_finalize(job, errp);
>      job-qmp.c-    aio_context_release(aio_context);

Yep, that's pretty conclusive that the context is already held by all 
callers.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
