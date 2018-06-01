Received: from eggs.gnu.org ([2001:4830:134:3::10]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOrj1-0002Fu-Qa
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 17:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOrj0-0001W5-Ja
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 17:36:43 -0400
References: <20180601123221.29437-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0002f27-b60c-a09c-0a2f-9dde3daaba8f@redhat.com>
Date: Fri, 1 Jun 2018 16:36:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180601123221.29437-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 219's timing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 06/01/2018 07:32 AM, Max Reitz wrote:
> 219 has two issues that may lead to sporadic failure, both of which are
> the result of issuing query-jobs too early after a job has been
> modified.  This can then lead to different results based on whether the
> modification has taken effect already or not.
> 
> First, query-jobs is issued right after the job has been created.
> Besides its current progress possibly being in any random state (which
> has already been taken care of), its total progress too is basically
> arbitrary, because the job may not yet have been able to determine it.
> This patch addresses this by just filtering the total progress, like
> what has been done for the current progress already.
> 
> Secondly, query-jobs is issued right after a job has been resumed.  The
> job may or may not yet have had the time to actually perform any I/O,
> and thus its current progress may or may not have advanced.  To make
> sure it has indeed advanced (which is what the reference output already
> assumes), insert a sleep of 100 ms before query-jobs is invoked.  With a
> slice time of 100 ms, a buffer size of 64 kB and a speed of 256 kB/s,
> this should be the right amount of time to let the job advance by
> exactly 64 kB.

This still sounds a bit fragile (under heavy load, our 100ms sleep could 
turn into 200 such that more than 64k could transfer before we finally 
get a chance to query), but seems more robust that what we currently have.

> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/219     | 10 +++++++---
>   tests/qemu-iotests/219.out | 10 +++++-----
>   2 files changed, 12 insertions(+), 8 deletions(-)

> @@ -58,12 +61,13 @@ def test_job_lifecycle(vm, job, job_args, has_ready=False):
>       iotests.log(vm.qmp(job, job_id='job0', **job_args))
>   
>       # Depending on the storage, the first request may or may not have completed
> -    # yet, so filter out the progress. Later query-job calls don't need the
> -    # filtering because the progress is made deterministic by the block job
> -    # speed
> +    # yet (and the total progress may not have been fully determined yet), so
> +    # filter out the progress. Later query-job calls don't need the filtering
> +    # because the progress is made deterministic by the block job speed
>       result = vm.qmp('query-jobs')
>       for j in result['return']:
>           del j['current-progress']
> +        del j['total-progress']

Would this be better as:

j['current-progress'] = "VALUE"
j['total-progress'] = "VALUE"

>       iotests.log(result)
>   
>       # undefined -> created -> running
> diff --git a/tests/qemu-iotests/219.out b/tests/qemu-iotests/219.out
> index 346801b655..740b3d06d7 100644
> --- a/tests/qemu-iotests/219.out
> +++ b/tests/qemu-iotests/219.out
> @@ -3,7 +3,7 @@ Launching VM...
>   
>   Starting block job: drive-mirror (auto-finalize: True; auto-dismiss: True)
>   {u'return': {}}
> -{u'return': [{u'status': u'running', u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> +{u'return': [{u'status': u'running', u'id': u'job0', u'type': u'mirror'}]}

so that the trace shows that the field was present but filtered, rather 
than looking strange by not showing the field at all?

But since it was copied from pre-existing deletion rather than replacement,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
