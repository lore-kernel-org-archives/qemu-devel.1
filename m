Received: from eggs.gnu.org ([2001:4830:134:3::10]:41556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eMXyl-0000Js-CI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eMXyh-0001H3-AV
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:35:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1eMXyh-0001FP-0Z
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:35:03 -0500
Date: Wed, 6 Dec 2017 11:34:42 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171206113442.fjcpuwdfwx6brdkb@starbug-vm.ie.oracle.com>
References: <20171206112116.29413-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171206112116.29413-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: check current request object before
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Zhangboxian <zhangboxian@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

Are both tests for NULL necessary, the second one would seem to
suffice - but also the first check changes whether esp_dma_done()
would get called or not here:

  276     if (s->async_len == 0) {
  277         scsi_req_continue(s->current_req);
  278         /* If there is still data to be read from the device then
  279            complete the DMA operation immediately.  Otherwise defer
  280            until the scsi layer has completed.  */
  281         if (to_device || s->dma_left != 0 || s->ti_size == 0) {
  282             return;
  283         }
  284     }
  285 
  286     /* Partially filled a scsi buffer. Complete immediately.  */
  287     esp_dma_done(s);

I don't know the SCSI code well enough to know if it is correct to
change this, so just pointing it out in case someone else might.

Thanks,

Darren.

On Wed, Dec 06, 2017 at 04:51:16PM +0530, P J P wrote:
>From: Prasad J Pandit <pjp@fedoraproject.org>
>
>During a dma access, SCSIRequest object 'current_req' could be
>null, leading to a null pointer dereference. Add check to avoid
>it.
>
>Reported-by: Zhangboxian <zhangboxian@huawei.com>
>Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>---
> hw/scsi/esp.c      | 2 +-
> hw/scsi/scsi-bus.c | 3 +++
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>index ee586e7d6c..0c6925a708 100644
>--- a/hw/scsi/esp.c
>+++ b/hw/scsi/esp.c
>@@ -273,7 +273,7 @@ static void esp_do_dma(ESPState *s)
>         s->ti_size += len;
>     else
>         s->ti_size -= len;
>-    if (s->async_len == 0) {
>+    if (s->current_req && s->async_len == 0) {
>         scsi_req_continue(s->current_req);
>         /* If there is still data to be read from the device then
>            complete the DMA operation immediately.  Otherwise defer
>diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>index 977f7bce1f..ac64a239e9 100644
>--- a/hw/scsi/scsi-bus.c
>+++ b/hw/scsi/scsi-bus.c
>@@ -1338,6 +1338,9 @@ void scsi_req_unref(SCSIRequest *req)
>    will start the next chunk or complete the command.  */
> void scsi_req_continue(SCSIRequest *req)
> {
>+    if (!req) {
>+        return;
>+    }
>     if (req->io_canceled) {
>         trace_scsi_req_continue_canceled(req->dev->id, req->lun, req->tag);
>         return;
>-- 
>2.13.6
>
>
