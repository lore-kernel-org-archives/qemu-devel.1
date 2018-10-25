Received: from eggs.gnu.org ([2001:4830:134:3::10]:45263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ameya.more@oracle.com>) id 1gFmMw-0002bG-Lq
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ameya.more@oracle.com>) id 1gFmMr-0001Fg-IX
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:36:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ameya.more@oracle.com>)
	id 1gFmMq-0001Du-Iy
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:36:33 -0400
References: <20181025200944.12113-1-ppandit@redhat.com>
From: Ameya More <ameya.more@oracle.com>
Message-ID: <5b8a68c1-2787-af0d-959f-e0c9132f7004@oracle.com>
Date: Thu, 25 Oct 2018 15:40:02 -0500
MIME-Version: 1.0
In-Reply-To: <20181025200944.12113-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check message length value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Mark Kanda <mark.kanda@oracle.com>

Hi Prasad,

Thanks for following up on this. While Mark and I reported this issue to 
you, it was actually discovered by Dejvau Security and they should 
receive credit for reporting this issue.
http://www.dejavusecurity.com

Thanks,
Ameya


On 10/25/2018 03:09 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While writing a message in 'lsi_do_msgin', message length value
> in msg_len could be invalid, add check to avoid OOB access issue.
>
> Reported-by: Ameya More <ameya.more@oracle.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/scsi/lsi53c895a.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index d1e6534311..a266c5a113 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -205,7 +205,7 @@ typedef struct {
>       /* Action to take at the end of a MSG IN phase.
>          0 = COMMAND, 1 = disconnect, 2 = DATA OUT, 3 = DATA IN.  */
>       int msg_action;
> -    int msg_len;
> +    uint8_t msg_len;
>       uint8_t msg[LSI_MAX_MSGIN_LEN];
>       /* 0 if SCRIPTS are running or stopped.
>        * 1 if a Wait Reselect instruction has been issued.
> @@ -861,12 +861,15 @@ static void lsi_do_status(LSIState *s)
>   
>   static void lsi_do_msgin(LSIState *s)
>   {
> -    int len;
> +    uint8_t len;
>       trace_lsi_do_msgin(s->dbc, s->msg_len);
>       s->sfbr = s->msg[0];
>       len = s->msg_len;
>       if (len > s->dbc)
>           len = s->dbc;
> +    if (len > LSI_MAX_MSGIN_LEN) {
> +        len = LSI_MAX_MSGIN_LEN;
> +    }
>       pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
>       /* Linux drivers rely on the last byte being in the SIDL.  */
>       s->sidl = s->msg[len - 1];
> @@ -2114,7 +2117,7 @@ static const VMStateDescription vmstate_lsi_scsi = {
>           VMSTATE_INT32(carry, LSIState),
>           VMSTATE_INT32(status, LSIState),
>           VMSTATE_INT32(msg_action, LSIState),
> -        VMSTATE_INT32(msg_len, LSIState),
> +        VMSTATE_UINT8(msg_len, LSIState),
>           VMSTATE_BUFFER(msg, LSIState),
>           VMSTATE_INT32(waiting, LSIState),
>   
