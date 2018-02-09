Received: from eggs.gnu.org ([2001:4830:134:3::10]:55374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekCmh-0001xM-Bj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekCmd-0003bJ-HP
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:48:27 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ekCmd-0003Zj-AM
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:48:23 -0500
Received: by mail-wm0-f67.google.com with SMTP id x4so4966013wmc.0
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 09:48:22 -0800 (PST)
References: <20180203061621.7033-1-stefanha@redhat.com>
	<20180203061621.7033-4-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c84595b-dc38-aa6c-5bda-e16f70fc68be@redhat.com>
Date: Fri, 9 Feb 2018 18:48:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180203061621.7033-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/3] block/iscsi: fix ioctl
 cancel use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Felipe Franciosi <felipe@nutanix.com>

On 03/02/2018 07:16, Stefan Hajnoczi wrote:
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

qemu_aio_ref is not thread safe.  I think this is fine however, since
all qemu_aio_ref/unref calls should happen in the I/O thread.

Regarding your follow-up patch:

> 
> -    acb->status = -ECANCELED;
> -    iscsi_schedule_bh(acb);
> +    /* If the command callback hasn't been called yet, drop the task */
> +    if (!acb->bh) {
> +        /* Call iscsi_aio_ioctl_cb() with SCSI_STATUS_CANCELLED */
> +        iscsi_scsi_cancel_task(iscsi, acb->task);
> +    }
> +

SCSI_STATUS_CANCELLED is a libiscsi addition and should not go past
iscsi_aio_ioctl_cb.  So you'd need something like this:

diff --git a/block/iscsi.c b/block/iscsi.c
index 6a1c53711a..ace6ca900f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -928,6 +928,14 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi,
     g_free(acb->buf);
     acb->buf = NULL;

+    if (status == SCSI_STATUS_CANCELLED) {
+        if (!acb->bh) {
+            acb->status = -ECANCELED);
+            iscsi_schedule_bh(acb);
+        }
+        return;
+    }
+
     acb->status = 0;
     if (status < 0) {
         error_report("Failed to ioctl(SG_IO) to iSCSI lun. %s",

Needless to say, it is really unfortunate that there is no mock iSCSI
server to write tests for. :(

Paolo
