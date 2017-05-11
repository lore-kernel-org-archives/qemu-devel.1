Received: from eggs.gnu.org ([2001:4830:134:3::10]:35381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d8v8I-0007Hb-AW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d8v8H-0001Qf-GW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:56:22 -0400
Date: Thu, 11 May 2017 16:56:11 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170511205611.GC19824@localhost.localdomain>
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510143205.32013-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] curl: avoid recursive locking of
 BDRVCURLState mutex
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

On Wed, May 10, 2017 at 04:32:01PM +0200, Paolo Bonzini wrote:
> The curl driver has a ugly hack where, if it cannot find an empty CURLState,
> it just uses aio_poll to wait for one to be empty.  This is probably
> buggy when used together with dataplane, and the simplest way to fix it
> is to use coroutines instead.
> 
> A more immediate effect of the bug however is that it can cause a
> recursive call to curl_readv_bh_cb and recursively taking the
> BDRVCURLState mutex.  This causes a deadlock.
> 
> The fix is to unlock the mutex around aio_poll, but for cleanliness we
> should also take the mutex around all calls to curl_init_state, even if
> reaching the unlock/lock pair is impossible.  The same is true for
> curl_clean_state.
> 
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Cc: jcody@redhat.com
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 9a00fdc28e..b18e79bf54 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -281,6 +281,7 @@ read_end:
>      return size * nmemb;
>  }
>  
> +/* Called with s->mutex held.  */
>  static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
>                           CURLAIOCB *acb)
>  {
> @@ -453,6 +454,7 @@ static void curl_multi_timeout_do(void *arg)
>  #endif
>  }
>  
> +/* Called with s->mutex held.  */
>  static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
>  {
>      CURLState *state = NULL;
> @@ -471,7 +473,9 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
>              break;
>          }
>          if (!state) {
> +            qemu_mutex_unlock(&s->mutex);
>              aio_poll(bdrv_get_aio_context(bs), true);
> +            qemu_mutex_lock(&s->mutex);
>          }
>      } while(!state);
>  
> @@ -534,6 +538,7 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
>      return state;
>  }
>  
> +/* Called with s->mutex held.  */
>  static void curl_clean_state(CURLState *s)
>  {
>      int j;
> @@ -565,6 +570,7 @@ static void curl_detach_aio_context(BlockDriverState *bs)
>      BDRVCURLState *s = bs->opaque;
>      int i;
>  
> +    qemu_mutex_lock(&s->mutex);
>      for (i = 0; i < CURL_NUM_STATES; i++) {
>          if (s->states[i].in_use) {
>              curl_clean_state(&s->states[i]);
> @@ -580,6 +586,7 @@ static void curl_detach_aio_context(BlockDriverState *bs)
>          curl_multi_cleanup(s->multi);
>          s->multi = NULL;
>      }
> +    qemu_mutex_unlock(&s->mutex);
>  
>      timer_del(&s->timer);
>  }
> @@ -745,9 +752,12 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>  
>      DPRINTF("CURL: Opening %s\n", file);
> +    qemu_mutex_init(&s->mutex);

This mutex init is now done above possible returns on error, so we should
call qemu_mutex_destroy() on errors after this point.

>      s->aio_context = bdrv_get_aio_context(bs);
>      s->url = g_strdup(file);
> +    qemu_mutex_lock(&s->mutex);
>      state = curl_init_state(bs, s);
> +    qemu_mutex_unlock(&s->mutex);
>      if (!state)
>          goto out_noclean;
>  
> @@ -791,11 +801,12 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>      DPRINTF("CURL: Size = %zd\n", s->len);
>  
> +    qemu_mutex_lock(&s->mutex);
>      curl_clean_state(state);
> +    qemu_mutex_unlock(&s->mutex);
>      curl_easy_cleanup(state->curl);
>      state->curl = NULL;
>  
> -    qemu_mutex_init(&s->mutex);
>      curl_attach_aio_context(bs, bdrv_get_aio_context(bs));
>  
>      qemu_opts_del(opts);
> -- 
> 2.12.2
> 
> 
