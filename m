Received: from eggs.gnu.org ([2001:4830:134:3::10]:38566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT7Vn-0007ZP-Gi
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT7Vm-0000HE-D7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:12:07 -0400
Date: Thu, 6 Jul 2017 16:11:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706141151.GI5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705210842.960-17-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 16/21] backup: Switch block_backup.h to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Continue by converting
> the public interface to backup jobs (no semantic change), including
> a change to CowRequest to track by bytes instead of cluster indices.
> 
> Note that this does not change the difference between the public
> interface (starting point, and size of the subsequent range) and
> the internal interface (starting and end points).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Xie Changlong <xiechanglong@cmss.chinamobile.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

> diff --git a/block/backup.c b/block/backup.c
> index 4e64710..cfbd921 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -55,7 +55,7 @@ static inline int64_t cluster_size_sectors(BackupBlockJob *job)
> 
>  /* See if in-flight requests overlap and wait for them to complete */
>  static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
> -                                                       int64_t start,
> +                                                       int64_t offset,
>                                                         int64_t end)

Not sure how useful this rename is. I think I would have renamed either
both or probably actually none of the parameters. start/end is a nice
pair, offset/end is kind of unexpected. start_offset/end_offset would be
an option if you do want to rename, but I don't see a need for it in
this very short function.

>  {
>      CowRequest *req;
> @@ -64,7 +64,7 @@ static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
>      do {
>          retry = false;
>          QLIST_FOREACH(req, &job->inflight_reqs, list) {
> -            if (end > req->start && start < req->end) {
> +            if (end > req->start_byte && offset < req->end_byte) {
>                  qemu_co_queue_wait(&req->wait_queue, NULL);
>                  retry = true;
>                  break;
> @@ -75,10 +75,10 @@ static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
> 
>  /* Keep track of an in-flight request */
>  static void cow_request_begin(CowRequest *req, BackupBlockJob *job,
> -                                     int64_t start, int64_t end)
> +                              int64_t offset, int64_t end)

Same here.

But again, not a correctness issue.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
