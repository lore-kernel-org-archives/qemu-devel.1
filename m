Received: from eggs.gnu.org ([2001:4830:134:3::10]:57526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6E35-0001ZQ-DV
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6E33-0006LM-2N
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:31:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6E32-0006Jn-Pn
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:31:49 -0400
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
	<20170504084210.7488.37561.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b365904f-21ae-85a7-a3a6-bbe21c62e35a@redhat.com>
Date: Thu, 4 May 2017 12:31:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170504084210.7488.37561.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 06/10] replay: fix save/load vm for
 non-empty queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 04/05/2017 10:42, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> This patch does not allows saving/loading vmstate when
> replay events queue is not empty. There is no reliable
> way to save events queue, because it describes internal
> coroutine state. Therefore saving and loading operations
> should be deferred to another record/replay step.

Can it actually be non-empty after bdrv_drain_all?

Paolo

> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  include/sysemu/replay.h  |    3 +++
>  migration/savevm.c       |   13 +++++++++++++
>  replay/replay-snapshot.c |    6 ++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index f1c0712795..5c9db2a2ef 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -164,5 +164,8 @@ void replay_audio_in(int *recorded, void *samples, int *wpos, int size);
>  /*! Called at the start of execution.
>      Loads or saves initial vmstate depending on execution mode. */
>  void replay_vmstate_init(void);
> +/*! Called to ensure that replay state is consistent and VM snapshot
> +    can be created */
> +bool replay_can_snapshot(void);
>  
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 03ae1bdeb4..358d22170d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -54,6 +54,7 @@
>  #include "qemu/cutils.h"
>  #include "io/channel-buffer.h"
>  #include "io/channel-file.h"
> +#include "sysemu/replay.h"
>  
>  #ifndef ETH_P_RARP
>  #define ETH_P_RARP 0x8035
> @@ -2083,6 +2084,12 @@ int save_vmstate(Monitor *mon, const char *name)
>      Error *local_err = NULL;
>      AioContext *aio_context;
>  
> +    if (!replay_can_snapshot()) {
> +        monitor_printf(mon, "Record/replay does not allow making snapshot right now. "
> +                        "Try stopping at another step.\n");
> +        return ret;
> +    }
> +
>      if (!bdrv_all_can_snapshot(&bs)) {
>          monitor_printf(mon, "Device '%s' is writable but does not "
>                         "support snapshots.\n", bdrv_get_device_name(bs));
> @@ -2244,6 +2251,12 @@ int load_vmstate(const char *name)
>      AioContext *aio_context;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
> +    if (!replay_can_snapshot()) {
> +        error_report("Record/replay does not allow loading snapshot right now. "
> +                     "Try stopping at another step.\n");
> +        return -EINVAL;
> +    }
> +
>      if (!bdrv_all_can_snapshot(&bs)) {
>          error_report("Device '%s' is writable but does not support snapshots.",
>                       bdrv_get_device_name(bs));
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index 65e2d375c2..438d82ec33 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -76,3 +76,9 @@ void replay_vmstate_init(void)
>          }
>      }
>  }
> +
> +bool replay_can_snapshot(void)
> +{
> +    return replay_mode == REPLAY_MODE_NONE
> +        || !replay_has_events();
> +}
> 
