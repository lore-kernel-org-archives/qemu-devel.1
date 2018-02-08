Received: from eggs.gnu.org ([2001:4830:134:3::10]:46317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ejnom-0007qR-9Z
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ejnol-0005p1-5L
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:08:56 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:33214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ejnok-0005ob-TX
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:08:55 -0500
Received: by mail-wm0-x22f.google.com with SMTP id x4-v6so27703737wmc.0
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 07:08:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a7d46cd7-aba7-ebae-e1a0-4d321586705f@redhat.com>
References: <CAJSP0QX8zOCKK9HTf4=VddZcYqWmuuC+L5PWiEwVtsnxPd8V2w@mail.gmail.com>
	<a7d46cd7-aba7-ebae-e1a0-4d321586705f@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 8 Feb 2018 15:08:53 +0000
Message-ID: <CAJSP0QVn2Mxw=BDGaBerLQp3-RDtHaBjPDWe1je9pTw_T7i44A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] libiscsi task cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>, Felipe Franciosi <felipe@nutanix.com>, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>, Hannes Reinecke <hare@suse.de>

On Thu, Feb 8, 2018 at 2:14 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 08/02/2018 15:08, Stefan Hajnoczi wrote:
>> Now on to libiscsi:
>>
>> The iscsi_task_mgmt_async() API documentation says:
>>
>>   * abort_task will also cancel the scsi task. The callback for the
>> scsi task will be invoked with
>>   *            SCSI_STATUS_CANCELLED
>>
>> I see that the ABORT TASK TMF response invokes the user's
>> iscsi_task_mgmt_async() callback but not the command callback.  I'm
>> not sure how the command callback is invoked with
>> SCSI_STATUS_CANCELLED unless libiscsi is relying on the target to send
>> that response.
>>
>> Is libiscsi honoring its iscsi_task_mgmt_async() contract?
>
> No, and QEMU is assuming the "wrong" behavior:
>
> static void
> iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
>                     void *private_data)
> {
>     IscsiAIOCB *acb = private_data;
>
>     acb->status = -ECANCELED;
>     iscsi_schedule_bh(acb);
> }

FWIW My recent use-after-free fix series is still pending review:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00570.html

It changes the code and fixes a QEMU bug, but it doesn't address the
iscsi_task_mgmt_async() issue we're discussing now.

I think users *can* work around the iscsi_task_mgmt_async() issue as follows:

If the command callback has not been invoked yet when the ABORT TASK
TMF callback is invoked, call iscsi_scsi_cancel_task() so that
libiscsi invokes the command callback with SCSI_STATUS_CANCELLED and
frees the PDU.

Here is how that looks in QEMU:

diff --git a/block/iscsi.c b/block/iscsi.c
index 8140baac15..7b4b43dc55 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -290,8 +290,12 @@ iscsi_abort_task_cb(struct iscsi_context *iscsi,
int status, void *command_data,
 {
     IscsiAIOCB *acb = private_data;

-    acb->status = -ECANCELED;
-    iscsi_schedule_bh(acb);
+    /* If the command callback hasn't been called yet, drop the task */
+    if (!acb->bh) {
+        /* Call iscsi_aio_ioctl_cb() with SCSI_STATUS_CANCELLED */
+        iscsi_scsi_cancel_task(iscsi, acb->task);
+    }
+
     qemu_aio_unref(acb); /* acquired in iscsi_aio_cancel() */
 }
