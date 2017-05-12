Received: from eggs.gnu.org ([2001:4830:134:3::10]:54122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d9IGo-0006qj-SL
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d9IGn-0000wm-Nr
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:38:42 -0400
Date: Fri, 12 May 2017 17:38:33 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170512213833.GE19824@localhost.localdomain>
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510143205.32013-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/7] curl: convert CURLAIOCB to byte values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

On Wed, May 10, 2017 at 04:32:03PM +0200, Paolo Bonzini wrote:
> This is in preparation for the conversion from bdrv_aio_readv to
> bdrv_co_preadv, and it also requires changing some of the size_t values
> to uint64_t.  This was broken before for disks > 2TB, but now it would
> break at 4GB.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 4b4d5a2389..3e288f2bc7 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -96,8 +96,8 @@ typedef struct CURLAIOCB {
>      BlockAIOCB common;
>      QEMUIOVector *qiov;
>  
> -    int64_t sector_num;
> -    int nb_sectors;
> +    uint64_t offset;
> +    uint64_t bytes;
>  
>      size_t start;
>      size_t end;
> @@ -115,7 +115,7 @@ typedef struct CURLState
>      CURL *curl;
>      QLIST_HEAD(, CURLSocket) sockets;
>      char *orig_buf;
> -    size_t buf_start;
> +    uint64_t buf_start;
>      size_t buf_off;
>      size_t buf_len;
>      char range[128];
> @@ -126,7 +126,7 @@ typedef struct CURLState
>  typedef struct BDRVCURLState {
>      CURLM *multi;
>      QEMUTimer timer;
> -    size_t len;
> +    uint64_t len;
>      CURLState states[CURL_NUM_STATES];
>      char *url;
>      size_t readahead_size;
> @@ -257,7 +257,7 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>              continue;
>  
>          if ((s->buf_off >= acb->end)) {
> -            size_t request_length = acb->nb_sectors * BDRV_SECTOR_SIZE;
> +            size_t request_length = acb->bytes;
>  
>              qemu_iovec_from_buf(acb->qiov, 0, s->orig_buf + acb->start,
>                                  acb->end - acb->start);
> @@ -282,18 +282,18 @@ read_end:
>  }
>  
>  /* Called with s->mutex held.  */
> -static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
> +static int curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
>                           CURLAIOCB *acb)
>  {
>      int i;
> -    size_t end = start + len;
> -    size_t clamped_end = MIN(end, s->len);
> -    size_t clamped_len = clamped_end - start;
> +    uint64_t end = start + len;
> +    uint64_t clamped_end = MIN(end, s->len);
> +    uint64_t clamped_len = clamped_end - start;
>  
>      for (i=0; i<CURL_NUM_STATES; i++) {
>          CURLState *state = &s->states[i];
> -        size_t buf_end = (state->buf_start + state->buf_off);
> -        size_t buf_fend = (state->buf_start + state->buf_len);
> +        uint64_t buf_end = (state->buf_start + state->buf_off);
> +        uint64_t buf_fend = (state->buf_start + state->buf_len);
>  
>          if (!state->orig_buf)
>              continue;
> @@ -788,7 +788,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>  #endif
>  
> -    s->len = (size_t)d;
> +    s->len = d;
>  
>      if ((!strncasecmp(s->url, "http://", strlen("http://"))
>          || !strncasecmp(s->url, "https://", strlen("https://")))
> @@ -797,7 +797,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>                  "Server does not support 'range' (byte ranges).");
>          goto out;
>      }
> -    DPRINTF("CURL: Size = %zd\n", s->len);
> +    DPRINTF("CURL: Size = %" PRIu64 "\n", s->len);
>  
>      qemu_mutex_lock(&s->mutex);
>      curl_clean_state(state);
> @@ -836,14 +836,14 @@ static void curl_readv_bh_cb(void *p)
>      BlockDriverState *bs = acb->common.bs;
>      BDRVCURLState *s = bs->opaque;
>  
> -    size_t start = acb->sector_num * BDRV_SECTOR_SIZE;
> -    size_t end;
> +    uint64_t start = acb->offset;
> +    uint64_t end;
>  
>      qemu_mutex_lock(&s->mutex);
>  
>      // In case we have the requested data already (e.g. read-ahead),
>      // we can just call the callback and be done.
> -    switch (curl_find_buf(s, start, acb->nb_sectors * BDRV_SECTOR_SIZE, acb)) {
> +    switch (curl_find_buf(s, start, acb->bytes, acb)) {
>          case FIND_RET_OK:
>              ret = 0;
>              goto out;
> @@ -871,7 +871,7 @@ static void curl_readv_bh_cb(void *p)
>      }
>  
>      acb->start = 0;
> -    acb->end = MIN(acb->nb_sectors * BDRV_SECTOR_SIZE, s->len - start);
> +    acb->end = MIN(acb->bytes, s->len - start);
>  
>      state->buf_off = 0;
>      g_free(state->orig_buf);
> @@ -886,9 +886,9 @@ static void curl_readv_bh_cb(void *p)
>      }
>      state->acb[0] = acb;
>  
> -    snprintf(state->range, 127, "%zd-%zd", start, end);
> -    DPRINTF("CURL (AIO): Reading %llu at %zd (%s)\n",
> -            (acb->nb_sectors * BDRV_SECTOR_SIZE), start, state->range);
> +    snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64, start, end);
> +    DPRINTF("CURL (AIO): Reading %" PRIu64 " at %" PRIu64 " (%s)\n",
> +            acb->bytes, start, state->range);
>      curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
>  
>      curl_multi_add_handle(s->multi, state->curl);
> @@ -913,8 +913,8 @@ static BlockAIOCB *curl_aio_readv(BlockDriverState *bs,
>      acb = qemu_aio_get(&curl_aiocb_info, bs, cb, opaque);
>  
>      acb->qiov = qiov;
> -    acb->sector_num = sector_num;
> -    acb->nb_sectors = nb_sectors;
> +    acb->offset = sector_num * BDRV_SECTOR_SIZE;
> +    acb->bytes = nb_sectors * BDRV_SECTOR_SIZE;
>  
>      aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), curl_readv_bh_cb, acb);
>      return &acb->common;
> -- 
> 2.12.2
> 
>

Reviewed-by: Jeff Cody <jcody@redhat.com>
