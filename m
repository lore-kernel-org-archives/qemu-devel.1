Received: from eggs.gnu.org ([2001:4830:134:3::10]:59114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvcbx-0001bu-CF
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvcbu-0007YM-84
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:08:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180830015734.19765-1-jsnow@redhat.com>
	<20180830015734.19765-3-jsnow@redhat.com>
	<6ed2e7ac-8de1-bd7b-0787-fdd33c6b306e@redhat.com>
Date: Fri, 31 Aug 2018 08:08:37 +0200
In-Reply-To: <6ed2e7ac-8de1-bd7b-0787-fdd33c6b306e@redhat.com> (Eric Blake's
	message of "Thu, 30 Aug 2018 14:58:00 -0500")
Message-ID: <87mut3ukyi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/9] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 08/29/2018 08:57 PM, John Snow wrote:
>> Jobs presently use both an Error object in the case of the create job,
>> and char strings in the case of generic errors elsewhere.
>>
>> Unify the two paths as just j->err, and remove the extra argument from
>> job_completed. The integer error code for job_completed is kept for now,
>> to be removed shortly in a separate patch.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>
>> +++ b/job.c
>
>> @@ -666,8 +666,8 @@ static void job_update_rc(Job *job)
>>           job->ret = -ECANCELED;
>>       }
>>       if (job->ret) {
>> -        if (!job->error) {
>> -            job->error = g_strdup(strerror(-job->ret));
>> +        if (!job->err) {
>> +            error_setg(&job->err, "%s", g_strdup(strerror(-job->ret)));
>
> Memleak. Drop the g_strdup(), and just directly pass strerror()
> results to error_setg().  (I guess we can't quite use
> error_setg_errno() unless we add additional text beyond the strerror()
> results).

Adding such text might well be an improvement.  I'm not telling you to
do so (not having looked at the context myself), just to think about it.

> With that fixed,
> Reviewed-by: Eric Blake <eblake@redhat.com>
