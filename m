Received: from eggs.gnu.org ([2001:4830:134:3::10]:35281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIMbi-0007zF-0H
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIMbg-0008Aj-Kr
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:10:17 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-20-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a76add0b-9177-dac7-c4ee-24605b82f403@redhat.com>
Date: Mon, 14 May 2018 19:10:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-20-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/42] job: Add job_sleep_ns()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/09/2018 12:26 PM, Kevin Wolf wrote:
> There is nothing block layer specific about block_job_sleep_ns(), so
> move the function to Job.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob_int.h | 11 -----------
>  include/qemu/job.h           | 17 +++++++++++++++++
>  block/backup.c               |  2 +-
>  block/commit.c               |  2 +-
>  block/mirror.c               |  4 ++--
>  block/stream.c               |  2 +-
>  blockjob.c                   | 27 ---------------------------
>  job.c                        | 32 ++++++++++++++++++++++++++++++++
>  tests/test-bdrv-drain.c      |  8 ++++----
>  tests/test-blockjob-txn.c    |  2 +-
>  tests/test-blockjob.c        |  2 +-
>  11 files changed, 60 insertions(+), 49 deletions(-)
> 
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index 0a614a89b8..8937f5b163 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -134,17 +134,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>  void block_job_free(Job *job);
>  
>  /**
> - * block_job_sleep_ns:
> - * @job: The job that calls the function.
> - * @ns: How many nanoseconds to stop for.
> - *
> - * Put the job to sleep (assuming that it wasn't canceled) for @ns
> - * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will immediately
> - * interrupt the wait.
> - */
> -void block_job_sleep_ns(BlockJob *job, int64_t ns);
> -
> -/**
>   * block_job_yield:
>   * @job: The job that calls the function.
>   *
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 00c7cda9a3..ddfa824315 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -168,6 +168,13 @@ void job_enter_cond(Job *job, bool(*fn)(Job *job));
>  void job_start(Job *job);
>  
>  /**
> + * @job: The job to enter.
> + *
> + * Continue the specified job by entering the coroutine.
> + */
> +void job_enter(Job *job);
> +

Is this a holdout from #18?

Eh, either way.

Reviewed-by: John Snow <jsnow@redhat.com>
