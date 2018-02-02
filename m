Received: from eggs.gnu.org ([2001:4830:134:3::10]:38680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ehjN5-0003Dr-FV
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 16:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ehjN4-0004XF-FZ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 16:59:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180202211628.3661-4-stefanha@redhat.com>
References: <20180202211628.3661-1-stefanha@redhat.com>
	<20180202211628.3661-4-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 2 Feb 2018 22:59:44 +0100
Message-ID: <CAJSP0QWXZ72ofUyJ+__Jvvs3WVacq41J7xpq9HNMNgphb8aC4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] block/iscsi: fix ioctl
 cancel use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Feb 2, 2018 at 10:16 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The ioctl request cancellation code assumes that requests do not
> complete once TASK ABORT has been sent to the iSCSI target.  The request
> completion callback is unconditionally invoked when TASK ABORT finishes.
> Therefore the request completion callback is invoked twice if the
> request does happen to complete before TASK ABORT.
>
> Futhermore, iscsi_aio_cancel() does not increment the request's
> reference count, causing a use-after-free when TASK ABORT finishes after
> the request has already completed.
>
> The iscsilun->mutex protection is also missing in iscsi_aio_cancel().
>
> This patch rewrites iscsi_aio_cancel() and iscsi_abort_task_cb() to
> avoid double completion, use-after-free, and to take iscsilun->mutex
> when needed.
>
> Reported-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/iscsi.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 1cfe1c647c..4566902d43 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -282,14 +282,19 @@ static void iscsi_co_init_iscsitask(IscsiLun *iscsilun, struct IscsiTask *iTask)
>      };
>  }
>
> +/* Called (via iscsi_service) with QemuMutex held. */
>  static void
>  iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
>                      void *private_data)
>  {
>      IscsiAIOCB *acb = private_data;
>
> -    acb->status = -ECANCELED;
> -    iscsi_schedule_bh(acb);
> +    /* Skip if the request already completed */
> +    if (acb->status == -ECANCELED) {

There is a bug here.  acb->status can be -ECANCELED if the request
completed with COMMAND ABORTED.

I'll send a v2 of this patch tomorrow to solve this.

Stefan
