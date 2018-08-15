Received: from eggs.gnu.org ([2001:4830:134:3::10]:54278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fq3Gz-0000gl-Hk
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fq3Gv-0004iO-PR
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:24:07 -0400
References: <c449263bbcaffbd3db25d833fb57867fda8e3199.1534348766.git.jcody@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ca52dfff-35c0-3a1a-a5f8-83f2a510cc5a@redhat.com>
Date: Wed, 15 Aug 2018 17:23:43 -0400
MIME-Version: 1.0
In-Reply-To: <c449263bbcaffbd3db25d833fb57867fda8e3199.1534348766.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: for jobs,
 do not clear user_paused until after the resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 08/15/2018 11:59 AM, Jeff Cody wrote:
> The function job_cancel_async() will always cause an assert for blockjob
> user resume.  We set job->user_paused to false, and then call
> job->driver->user_resume().  In the case of blockjobs, this is the
> block_job_user_resume() function.
> 
> In that function, we assert that job.user_paused is set to true.
> Unfortunately, right before calling this function, it has explicitly
> been set to false.
> 
> The fix is pretty simple: set job->user_paused to false only after the
> job user_resume() function has been called.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  job.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/job.c b/job.c
> index fa671b431a..e36ebaafd8 100644
> --- a/job.c
> +++ b/job.c
> @@ -732,10 +732,10 @@ static void job_cancel_async(Job *job, bool force)
>  {
>      if (job->user_paused) {
>          /* Do not call job_enter here, the caller will handle it.  */
> -        job->user_paused = false;
>          if (job->driver->user_resume) {
>              job->driver->user_resume(job);
>          }
> +        job->user_paused = false;
>          assert(job->pause_count > 0);
>          job->pause_count--;
>      }
> 

Looks right to me; are you going to make good on your threat of a v2
with a unit test?

Reviewed-by: John Snow <jsnow@redhat.com>
