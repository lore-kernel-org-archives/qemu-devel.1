Received: from eggs.gnu.org ([2001:4830:134:3::10]:53957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvT54-0007Ra-Sv
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvT54-0001bY-13
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:58:14 -0400
References: <20180830015734.19765-1-jsnow@redhat.com>
	<20180830015734.19765-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ed2e7ac-8de1-bd7b-0787-fdd33c6b306e@redhat.com>
Date: Thu, 30 Aug 2018 14:58:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180830015734.19765-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/9] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On 08/29/2018 08:57 PM, John Snow wrote:
> Jobs presently use both an Error object in the case of the create job,
> and char strings in the case of generic errors elsewhere.
> 
> Unify the two paths as just j->err, and remove the extra argument from
> job_completed. The integer error code for job_completed is kept for now,
> to be removed shortly in a separate patch.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

> +++ b/job.c

> @@ -666,8 +666,8 @@ static void job_update_rc(Job *job)
>           job->ret = -ECANCELED;
>       }
>       if (job->ret) {
> -        if (!job->error) {
> -            job->error = g_strdup(strerror(-job->ret));
> +        if (!job->err) {
> +            error_setg(&job->err, "%s", g_strdup(strerror(-job->ret)));

Memleak. Drop the g_strdup(), and just directly pass strerror() results 
to error_setg().  (I guess we can't quite use error_setg_errno() unless 
we add additional text beyond the strerror() results).

With that fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
