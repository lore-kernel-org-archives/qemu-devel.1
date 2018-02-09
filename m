Received: from eggs.gnu.org ([2001:4830:134:3::10]:55931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekCoR-0003hD-5O
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekCoQ-0005QH-7i
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:50:15 -0500
References: <20180203061621.7033-1-stefanha@redhat.com>
	<20180203061621.7033-4-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c937a67c-743c-4e19-8e59-de839e05185c@redhat.com>
Date: Fri, 9 Feb 2018 18:50:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180203061621.7033-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block/iscsi: fix ioctl cancel
 use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>

On 03/02/2018 07:16, Stefan Hajnoczi wrote:
> iscsi_aio_cancel() does not increment the request's reference count,
> causing a use-after-free when ABORT TASK finishes after the request has
> already completed.
> 
> There are some additional issues with iscsi_aio_cancel():
> 1. Several ABORT TASKs may be sent for the same task if
>    iscsi_aio_cancel() is invoked multiple times.  It's better to avoid
>    this just in case the command identifier is reused.
> 2. The iscsilun->mutex protection is missing in iscsi_aio_cancel().
> 
> Reported-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/iscsi.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 1cfe1c647c..8140baac15 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -119,6 +119,7 @@ typedef struct IscsiAIOCB {
>  #ifdef __linux__
>      sg_io_hdr_t *ioh;
>  #endif
> +    bool cancelled;
>  } IscsiAIOCB;
>  
>  /* libiscsi uses time_t so its enough to process events every second */
> @@ -282,6 +283,7 @@ static void iscsi_co_init_iscsitask(IscsiLun *iscsilun, struct IscsiTask *iTask)
>      };
>  }
>  
> +/* Called (via iscsi_service) with QemuMutex held. */
>  static void
>  iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
>                      void *private_data)
> @@ -290,6 +292,7 @@ iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
>  
>      acb->status = -ECANCELED;
>      iscsi_schedule_bh(acb);
> +    qemu_aio_unref(acb); /* acquired in iscsi_aio_cancel() */
>  }
>  
>  static void
> @@ -298,14 +301,25 @@ iscsi_aio_cancel(BlockAIOCB *blockacb)
>      IscsiAIOCB *acb = (IscsiAIOCB *)blockacb;
>      IscsiLun *iscsilun = acb->iscsilun;
>  
> -    if (acb->status != -EINPROGRESS) {
> +    qemu_mutex_lock(&iscsilun->mutex);
> +
> +    /* If it was cancelled or completed already, our work is done here */
> +    if (acb->cancelled || acb->status != -EINPROGRESS) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
>          return;
>      }
>  
> +    acb->cancelled = true;
> +
> +    qemu_aio_ref(acb); /* released in iscsi_abort_task_cb() */
> +
>      /* send a task mgmt call to the target to cancel the task on the target */
> -    iscsi_task_mgmt_abort_task_async(iscsilun->iscsi, acb->task,
> -                                     iscsi_abort_task_cb, acb);
> +    if (iscsi_task_mgmt_abort_task_async(iscsilun->iscsi, acb->task,
> +                                         iscsi_abort_task_cb, acb) < 0) {
> +        qemu_aio_unref(acb); /* since iscsi_abort_task_cb() won't be called */
> +    }
>  
> +    qemu_mutex_unlock(&iscsilun->mutex);
>  }
>  
>  static const AIOCBInfo iscsi_aiocb_info = {
> @@ -1000,6 +1014,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
>      acb->bh          = NULL;
>      acb->status      = -EINPROGRESS;
>      acb->ioh         = buf;
> +    acb->cancelled   = false;
>  
>      if (req != SG_IO) {
>          iscsi_ioctl_handle_emulated(acb, req, buf);
> 

BTW, this is okay even without the follow-up, since libiscsi seems not
to obey its contract...

Paolo
