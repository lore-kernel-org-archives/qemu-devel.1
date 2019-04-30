Received: from eggs.gnu.org ([209.51.188.92]:40982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQHz-0008FT-K8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQHy-0004RT-Ic
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:47:07 -0400
Date: Tue, 30 Apr 2019 12:46:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190430104653.GD5607@linux.fritz.box>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
	<20190422145838.70903-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422145838.70903-5-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] block/qed: use buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

Am 22.04.2019 um 16:58 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Move to _co_ versions of io functions qed_read_table() and
> qed_write_table(), as we use qemu_co_mutex_unlock()
> anyway.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qed-table.c | 12 +++++-------
>  block/qed.c       |  6 ++----
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/block/qed-table.c b/block/qed-table.c
> index c497bd4aec..cf30edd977 100644
> --- a/block/qed-table.c
> +++ b/block/qed-table.c
> @@ -21,22 +21,22 @@
>  /* Called with table_lock held.  */
>  static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
>  {
> -    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(
> -        qiov, table->offsets, s->header.cluster_size * s->header.table_size);
> +    unsigned int bytes = s->header.cluster_size * s->header.table_size;
> +
>      int noffsets;
>      int i, ret;
>  
>      trace_qed_read_table(s, offset, table);
>  
>      qemu_co_mutex_unlock(&s->table_lock);
> -    ret = bdrv_preadv(s->bs->file, offset, &qiov);
> +    ret = bdrv_co_pread(s->bs->file, offset, bytes, table->offsets, 0);

Careful! This function is not marked as coroutine_fn, and I remember
that there were some non-coroutine callers when I converted qed to
coroutines.

It looks like we're lucky and all callers have been converted to
coroutines meanwhile, but I would prefer if we added the coroutine_fn
marker everywhere where we rely on it now to document this fact.

>      qemu_co_mutex_lock(&s->table_lock);
>      if (ret < 0) {
>          goto out;
>      }
>  
>      /* Byteswap offsets */
> -    noffsets = qiov.size / sizeof(uint64_t);
> +    noffsets = bytes / sizeof(uint64_t);
>      for (i = 0; i < noffsets; i++) {
>          table->offsets[i] = le64_to_cpu(table->offsets[i]);
>      }
> @@ -66,7 +66,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
>      unsigned int sector_mask = BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1;
>      unsigned int start, end, i;
>      QEDTable *new_table;
> -    QEMUIOVector qiov;
>      size_t len_bytes;
>      int ret;
>  
> @@ -79,7 +78,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
>      len_bytes = (end - start) * sizeof(uint64_t);
>  
>      new_table = qemu_blockalign(s->bs, len_bytes);
> -    qemu_iovec_init_buf(&qiov, new_table->offsets, len_bytes);
>  
>      /* Byteswap table */
>      for (i = start; i < end; i++) {
> @@ -91,7 +89,7 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
>      offset += start * sizeof(uint64_t);
>  
>      qemu_co_mutex_unlock(&s->table_lock);
> -    ret = bdrv_pwritev(s->bs->file, offset, &qiov);
> +    ret = bdrv_co_pwrite(s->bs->file, offset, len_bytes, new_table->offsets, 0);
>      qemu_co_mutex_lock(&s->table_lock);
>      trace_qed_write_table_cb(s, table, flush, ret);
>      if (ret < 0) {

Same for the callers of this function.

Kevin
