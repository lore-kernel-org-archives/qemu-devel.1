Received: from eggs.gnu.org ([2001:4830:134:3::10]:46029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d5vfh-00067a-Cb
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d5vfc-0004u7-Oz
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:54:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1d5vfc-0004t7-Fd
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:54:24 -0400
Date: Wed, 3 May 2017 15:54:19 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170503145418.GB27432@redhat.com>
References: <20170227163447.20428-1-stefanha@redhat.com>
	<20170227163447.20428-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227163447.20428-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PULL 1/4] curl: do not use
 aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Feb 27, 2017 at 04:34:44PM +0000, Stefan Hajnoczi wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Now that all bottom halves and callbacks take care of taking the
> AioContext lock, we can migrate some users away from it and to a
> specific QemuMutex or CoMutex.
> 
> Protect BDRVCURLState access with a QemuMutex.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20170222180725.28611-2-pbonzini@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

https://bugzilla.redhat.com/show_bug.cgi?id=1447590

I've been tracking down a bug in the curl driver which affects
virt-v2v, and this commit is implicated.

It manifests itself as a hang while downloading a certain file within
a remotely located disk image accessed over https.

Unfortunately the bug environment is extremely difficult to reproduce
(not the bug itself -- that is very easy to reproduce once you've set
up the environment).  Anyway I don't have a simple reproducer which
anyone could try.  I'll try to work on that next.

However I bisected it and it is caused by this commit.  The hang
affects qemu from master.  Reverting this commit on top of qemu from
master fixes the hang.

Is there anything obviously wrong with the commit?

Rich.

>  block/curl.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 2939cc7..e83dcd8 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -135,6 +135,7 @@ typedef struct BDRVCURLState {
>      char *cookie;
>      bool accept_range;
>      AioContext *aio_context;
> +    QemuMutex mutex;
>      char *username;
>      char *password;
>      char *proxyusername;
> @@ -333,6 +334,7 @@ static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
>      return FIND_RET_NONE;
>  }
>  
> +/* Called with s->mutex held.  */
>  static void curl_multi_check_completion(BDRVCURLState *s)
>  {
>      int msgs_in_queue;
> @@ -374,7 +376,9 @@ static void curl_multi_check_completion(BDRVCURLState *s)
>                          continue;
>                      }
>  
> +                    qemu_mutex_unlock(&s->mutex);
>                      acb->common.cb(acb->common.opaque, -EPROTO);
> +                    qemu_mutex_lock(&s->mutex);
>                      qemu_aio_unref(acb);
>                      state->acb[i] = NULL;
>                  }
> @@ -386,6 +390,7 @@ static void curl_multi_check_completion(BDRVCURLState *s)
>      }
>  }
>  
> +/* Called with s->mutex held.  */
>  static void curl_multi_do_locked(CURLState *s)
>  {
>      CURLSocket *socket, *next_socket;
> @@ -409,19 +414,19 @@ static void curl_multi_do(void *arg)
>  {
>      CURLState *s = (CURLState *)arg;
>  
> -    aio_context_acquire(s->s->aio_context);
> +    qemu_mutex_lock(&s->s->mutex);
>      curl_multi_do_locked(s);
> -    aio_context_release(s->s->aio_context);
> +    qemu_mutex_unlock(&s->s->mutex);
>  }
>  
>  static void curl_multi_read(void *arg)
>  {
>      CURLState *s = (CURLState *)arg;
>  
> -    aio_context_acquire(s->s->aio_context);
> +    qemu_mutex_lock(&s->s->mutex);
>      curl_multi_do_locked(s);
>      curl_multi_check_completion(s->s);
> -    aio_context_release(s->s->aio_context);
> +    qemu_mutex_unlock(&s->s->mutex);
>  }
>  
>  static void curl_multi_timeout_do(void *arg)
> @@ -434,11 +439,11 @@ static void curl_multi_timeout_do(void *arg)
>          return;
>      }
>  
> -    aio_context_acquire(s->aio_context);
> +    qemu_mutex_lock(&s->mutex);
>      curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
>  
>      curl_multi_check_completion(s);
> -    aio_context_release(s->aio_context);
> +    qemu_mutex_unlock(&s->mutex);
>  #else
>      abort();
>  #endif
> @@ -771,6 +776,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>      curl_easy_cleanup(state->curl);
>      state->curl = NULL;
>  
> +    qemu_mutex_init(&s->mutex);
>      curl_attach_aio_context(bs, bdrv_get_aio_context(bs));
>  
>      qemu_opts_del(opts);
> @@ -801,12 +807,11 @@ static void curl_readv_bh_cb(void *p)
>      CURLAIOCB *acb = p;
>      BlockDriverState *bs = acb->common.bs;
>      BDRVCURLState *s = bs->opaque;
> -    AioContext *ctx = bdrv_get_aio_context(bs);
>  
>      size_t start = acb->sector_num * BDRV_SECTOR_SIZE;
>      size_t end;
>  
> -    aio_context_acquire(ctx);
> +    qemu_mutex_lock(&s->mutex);
>  
>      // In case we have the requested data already (e.g. read-ahead),
>      // we can just call the callback and be done.
> @@ -854,7 +859,7 @@ static void curl_readv_bh_cb(void *p)
>      curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
>  
>  out:
> -    aio_context_release(ctx);
> +    qemu_mutex_unlock(&s->mutex);
>      if (ret != -EINPROGRESS) {
>          acb->common.cb(acb->common.opaque, ret);
>          qemu_aio_unref(acb);
> @@ -883,6 +888,7 @@ static void curl_close(BlockDriverState *bs)
>  
>      DPRINTF("CURL: Close\n");
>      curl_detach_aio_context(bs);
> +    qemu_mutex_destroy(&s->mutex);
>  
>      g_free(s->cookie);
>      g_free(s->url);
> -- 
> 2.9.3
> 

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
