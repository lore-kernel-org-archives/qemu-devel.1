Received: from eggs.gnu.org ([2001:4830:134:3::10]:59797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er43H-0005ma-58
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er43G-0003Hl-D7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:53:55 -0500
Date: Wed, 28 Feb 2018 16:53:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228155337.GE4855@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-12-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-12-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 11/21] blockjobs: add block_job_dismiss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 24.02.2018 um 00:51 hat John Snow geschrieben:
> For jobs that have reached their CONCLUDED state, prior to having their
> last reference put down (meaning jobs that have completed successfully,
> unsuccessfully, or have been canceled), allow the user to dismiss the
> job's lingering status report via block-job-dismiss.
> 
> This gives management APIs the chance to conclusively determine if a job
> failed or succeeded, even if the event broadcast was missed.
> 
> Note that jobs do not yet linger in any such state, they are freed
> immediately upon reaching this previously-unnamed state. such a state is
> added immediately in the next commit.
> 
> Verbs:
> Dismiss: operates on CONCLUDED jobs only.

You want to insert an empty line here.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/trace-events       |  1 +
>  blockdev.c               | 14 ++++++++++++++
>  blockjob.c               | 34 ++++++++++++++++++++++++++++++++--
>  include/block/blockjob.h |  9 +++++++++
>  qapi/block-core.json     | 24 +++++++++++++++++++++++-
>  5 files changed, 79 insertions(+), 3 deletions(-)

> @@ -841,6 +865,9 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>          block_job_txn_add_job(txn, job);
>      }
>  
> +    /* For the expanded job control STM, grab an extra
> +     * reference for finalize() to put down */

Do you mean dismiss()?

> +    block_job_ref(job);
>      return job;
>  }
>  
> @@ -859,6 +886,9 @@ void block_job_pause_all(void)
>  
>  void block_job_early_fail(BlockJob *job)
>  {
> +    /* One for creation, one for finalize() */

And here?

> +    assert(job->status == BLOCK_JOB_STATUS_CREATED);
> +    block_job_unref(job);
>      block_job_unref(job);
>  }

Kevin
