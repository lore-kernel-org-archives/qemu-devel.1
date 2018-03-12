Received: from eggs.gnu.org ([2001:4830:134:3::10]:46691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evNAL-0002mf-Ld
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evNAF-00049s-Lh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:07:01 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evNAF-00048M-Ed
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:06:55 -0400
Received: by mail-wm0-x241.google.com with SMTP id w128so16472035wmw.0
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:06:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
	<20180227095327.1060.50979.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8adbee8-1735-7d5c-31be-24a90f4d1fd0@redhat.com>
Date: Mon, 12 Mar 2018 14:06:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180227095327.1060.50979.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 20/22] replay: don't drain/flush bdrv
 queue while RR is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, alex.bennee@linaro.org

On 27/02/2018 10:53, Pavel Dovgalyuk wrote:
> In record/replay mode bdrv queue is controlled by replay mechanism.
> It does not allow saving or loading the snapshots
> when bdrv queue is not empty. Stopping the VM is not blocked by nonempty
> queue, but flushing the queue is still impossible there,
> because it may cause deadlocks in replay mode.
> This patch disables bdrv_drain_all and bdrv_flush_all in
> record/replay mode.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

A lot of monitor commands that use bdrv_drain_all are going to remain
broken, so I'm not sure about this patch.  (There have been many threads
about bdrv_drain and bdrv_drain_all being a bad API...).  I'm queuing
everything except 2-3-4-20.

Thanks Pavel and Ciro.

Paolo

> ---
>  block/io.c |   22 ++++++++++++++++++++++
>  cpus.c     |    2 --
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 89d0745..a0fd54f 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -31,6 +31,7 @@
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "sysemu/replay.h"
>  
>  #define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
>  
> @@ -407,6 +408,13 @@ void bdrv_drain_all_begin(void)
>      BdrvNextIterator it;
>      GSList *aio_ctxs = NULL, *ctx;
>  
> +    /* bdrv queue is managed by record/replay,
> +       waiting for finishing the I/O requests may
> +       be infinite */
> +    if (replay_events_enabled()) {
> +        return;
> +    }
> +
>      /* BDRV_POLL_WHILE() for a node can only be called from its own I/O thread
>       * or the main loop AioContext. We potentially use BDRV_POLL_WHILE() on
>       * nodes in several different AioContexts, so make sure we're in the main
> @@ -458,6 +466,13 @@ void bdrv_drain_all_end(void)
>      BlockDriverState *bs;
>      BdrvNextIterator it;
>  
> +    /* bdrv queue is managed by record/replay,
> +       waiting for finishing the I/O requests may
> +       be endless */
> +    if (replay_events_enabled()) {
> +        return;
> +    }
> +
>      for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>          AioContext *aio_context = bdrv_get_aio_context(bs);
>  
> @@ -1839,6 +1854,13 @@ int bdrv_flush_all(void)
>      BlockDriverState *bs = NULL;
>      int result = 0;
>  
> +    /* bdrv queue is managed by record/replay,
> +       creating new flush request for stopping
> +       the VM may break the determinism */
> +    if (replay_events_enabled()) {
> +        return result;
> +    }
> +
>      for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>          AioContext *aio_context = bdrv_get_aio_context(bs);
>          int ret;
> diff --git a/cpus.c b/cpus.c
> index 40ed0e6..83e022e 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1006,7 +1006,6 @@ static int do_vm_stop(RunState state)
>      }
>  
>      bdrv_drain_all();
> -    replay_disable_events();
>      ret = bdrv_flush_all();
>  
>      return ret;
> @@ -2054,7 +2053,6 @@ int vm_prepare_start(void)
>          qapi_event_send_stop(&error_abort);
>          res = -1;
>      } else {
> -        replay_enable_events();
>          cpu_enable_ticks();
>          runstate_set(RUN_STATE_RUNNING);
>          vm_state_notify(1, RUN_STATE_RUNNING);
> 
