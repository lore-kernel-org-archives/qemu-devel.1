Received: from eggs.gnu.org ([2001:4830:134:3::10]:37029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMXpH-0003d8-GQ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMXpD-0004l2-F1
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:25:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMXpD-0004kW-4X
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:25:15 -0500
References: <20171206112116.29413-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1762c19d-81b7-a2c2-d160-bd90d7654e91@redhat.com>
Date: Wed, 6 Dec 2017 12:25:11 +0100
MIME-Version: 1.0
In-Reply-To: <20171206112116.29413-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Zhangboxian <zhangboxian@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 06/12/2017 12:21, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> During a dma access, SCSIRequest object 'current_req' could be
> null, leading to a null pointer dereference. Add check to avoid
> it.
> 
> Reported-by: Zhangboxian <zhangboxian@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Sorry, this needs a test case.

Paolo

> ---
>  hw/scsi/esp.c      | 2 +-
>  hw/scsi/scsi-bus.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index ee586e7d6c..0c6925a708 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -273,7 +273,7 @@ static void esp_do_dma(ESPState *s)
>          s->ti_size += len;
>      else
>          s->ti_size -= len;
> -    if (s->async_len == 0) {
> +    if (s->current_req && s->async_len == 0) {
>          scsi_req_continue(s->current_req);
>          /* If there is still data to be read from the device then
>             complete the DMA operation immediately.  Otherwise defer
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 977f7bce1f..ac64a239e9 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1338,6 +1338,9 @@ void scsi_req_unref(SCSIRequest *req)
>     will start the next chunk or complete the command.  */
>  void scsi_req_continue(SCSIRequest *req)
>  {
> +    if (!req) {
> +        return;
> +    }
>      if (req->io_canceled) {
>          trace_scsi_req_continue_canceled(req->dev->id, req->lun, req->tag);
>          return;
> 
