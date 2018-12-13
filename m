Received: from eggs.gnu.org ([2001:4830:134:3::10]:55461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXNDU-0005F6-6U
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXNDN-0004Lb-Oe
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:23:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXNDN-0004EJ-9q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:23:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so1204684wrw.5
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 01:23:21 -0800 (PST)
References: <20181212194009.2951-1-lvivier@redhat.com>
	<20181212194009.2951-3-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <958ac1e5-f3ee-3d91-98b5-d253f9b27c6d@redhat.com>
Date: Thu, 13 Dec 2018 10:23:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181212194009.2951-3-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] block/curl: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Liu Yuan <namei.unix@gmail.com>, Max Reitz <mreitz@redhat.com>

On 12/12/18 8:40 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  block/curl.c       | 29 ++++++++---------------------
>  block/trace-events |  9 +++++++++
>  2 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index db5d2bd8ef..b7ac265d3a 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -32,22 +32,10 @@
>  #include "crypto/secret.h"
>  #include <curl/curl.h>
>  #include "qemu/cutils.h"
> +#include "trace.h"
>  
> -// #define DEBUG_CURL
>  // #define DEBUG_VERBOSE
>  
> -#ifdef DEBUG_CURL
> -#define DEBUG_CURL_PRINT 1
> -#else
> -#define DEBUG_CURL_PRINT 0
> -#endif
> -#define DPRINTF(fmt, ...)                                            \
> -    do {                                                             \
> -        if (DEBUG_CURL_PRINT) {                                      \
> -            fprintf(stderr, fmt, ## __VA_ARGS__);                    \
> -        }                                                            \
> -    } while (0)
> -
>  #if LIBCURL_VERSION_NUM >= 0x071000
>  /* The multi interface timer callback was introduced in 7.16.0 */
>  #define NEED_CURL_TIMER_CALLBACK
> @@ -154,7 +142,7 @@ static int curl_timer_cb(CURLM *multi, long timeout_ms, void *opaque)
>  {
>      BDRVCURLState *s = opaque;
>  
> -    DPRINTF("CURL: timer callback timeout_ms %ld\n", timeout_ms);
> +    trace_curl_timer_cb(timeout_ms);
>      if (timeout_ms == -1) {
>          timer_del(&s->timer);
>      } else {
> @@ -193,7 +181,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
>      }
>      socket = NULL;
>  
> -    DPRINTF("CURL (AIO): Sock action %d on fd %d\n", action, (int)fd);
> +    trace_curl_sock_cb(action, (int)fd);
>      switch (action) {
>          case CURL_POLL_IN:
>              aio_set_fd_handler(s->aio_context, fd, false,
> @@ -238,7 +226,7 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>      size_t realsize = size * nmemb;
>      int i;
>  
> -    DPRINTF("CURL: Just reading %zd bytes\n", realsize);
> +    trace_curl_read_cb(realsize);
>  
>      if (!s || !s->orig_buf) {
>          goto read_end;
> @@ -777,7 +765,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>          }
>      }
>  
> -    DPRINTF("CURL: Opening %s\n", file);
> +    trace_curl_open(file);
>      qemu_co_queue_init(&s->free_state_waitq);
>      s->aio_context = bdrv_get_aio_context(bs);
>      s->url = g_strdup(file);
> @@ -830,7 +818,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>                  "Server does not support 'range' (byte ranges).");
>          goto out;
>      }
> -    DPRINTF("CURL: Size = %" PRIu64 "\n", s->len);
> +    trace_curl_open_size(s->len);
>  
>      qemu_mutex_lock(&s->mutex);
>      curl_clean_state(state);
> @@ -908,8 +896,7 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>      state->acb[0] = acb;
>  
>      snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64, start, end);
> -    DPRINTF("CURL (AIO): Reading %" PRIu64 " at %" PRIu64 " (%s)\n",
> -            acb->bytes, start, state->range);
> +    trace_curl_setup_preadv(acb->bytes, start, state->range);
>      curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
>  
>      curl_multi_add_handle(s->multi, state->curl);
> @@ -943,7 +930,7 @@ static void curl_close(BlockDriverState *bs)
>  {
>      BDRVCURLState *s = bs->opaque;
>  
> -    DPRINTF("CURL: Close\n");
> +    trace_curl_close();
>      curl_detach_aio_context(bs);
>      qemu_mutex_destroy(&s->mutex);
>  
> diff --git a/block/trace-events b/block/trace-events
> index b13b1e9706..5b83280b02 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -173,3 +173,12 @@ ssh_write(int64_t offset, size_t size) "offset=%" PRIi64 " size=%zu"
>  ssh_write_buf(void *buf, size_t size) "sftp_write buf=%p size=%zu"
>  ssh_write_return(size_t ret) "sftp_write returned %zd"
>  ssh_seek(uint64_t offset) "seeking to offset=%" PRIi64
> +
> +# block/curl.c
> +curl_timer_cb(long timeout_ms) "timer callback timeout_ms %ld"
> +curl_sock_cb(int action, int fd) "sock action %d on fd %d"
> +curl_read_cb(size_t realsize) "just reading %zd bytes"

%zu

> +curl_open(const char *file) "opening %s"
> +curl_open_size(uint64_t size) "size = %" PRIu64
> +curl_setup_preadv(uint64_t bytes, uint64_t start, const char *range) "reading %" PRIu64 " at %" PRIu64 " (%s)"
> +curl_close(void) "close"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
