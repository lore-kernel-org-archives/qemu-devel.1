Received: from eggs.gnu.org ([2001:4830:134:3::10]:38009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlGI-0004uj-9N
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlGH-0005JV-Fh
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:50:06 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-13-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6145ae58-a0e7-6262-e679-480936cda576@redhat.com>
Date: Tue, 27 Feb 2018 13:49:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-13-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 12/21] blockjobs: ensure abort is called
 for cancelled jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> Presently, even if a job is canceled post-completion as a result of
> a failing peer in a transaction, it will still call .commit because
> nothing has updated or changed its return code.
> 
> The reason why this does not cause problems currently is because
> backup's implementation of .commit checks for cancellation itself.
> 
> I'd like to simplify this contract:
> 
> (1) Abort is called if the job/transaction fails
> (2) Commit is called if the job/transaction succeeds
> 
> To this end: A job's return code, if 0, will be forcibly set as
> -ECANCELED if that job has already concluded. Remove the now
> redundant check in the backup job implementation.
> 
> We need to check for cancellation in both block_job_completed
> AND block_job_completed_single, because jobs may be cancelled between
> those two calls; for instance in transactions.
> 
> The check in block_job_completed could be removed, but there's no
> point in starting to attempt to succeed a transaction that we know
> in advance will fail.
> 
> This does NOT affect mirror jobs that are "canceled" during their
> synchronous phase. The mirror job itself forcibly sets the canceled
> property to false prior to ceding control, so such cases will invoke
> the "commit" callback.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   block/backup.c     |  2 +-
>   block/trace-events |  1 +
>   blockjob.c         | 19 +++++++++++++++----
>   3 files changed, 17 insertions(+), 5 deletions(-)

More lines of code, but the contract does seem simpler and useful for 
the later patches.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
