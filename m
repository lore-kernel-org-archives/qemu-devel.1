Received: from eggs.gnu.org ([2001:4830:134:3::10]:51419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fH47e-0005KD-83
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fH47Z-0004Oj-9q
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:13:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fH47Z-0004OS-4F
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:13:49 -0400
References: <20180511081601.14610.39946.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <377a43be-ec70-f8d0-450e-c71d239685a1@redhat.com>
Date: Fri, 11 May 2018 11:13:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180511081601.14610.39946.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ps2: prevent changing irq state on save
 and load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, mst@redhat.com, ciro.santilli@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com

On 11/05/2018 10:16, Pavel Dovgalyuk wrote:
> Commit 2858ab09e6f708e381fc1a1cc87e747a690c4884 changed
> PS/2 keyboard/mouse buffers to the standard size. However, its state
> may change when migrating from the old buffer size and therefore irq needs
> updating. But this change made wrong, because it throws the whole queue
> if there are too much data instead of cropping it.
> 
> That commit also updates irq (because the queue state may change).
> But updating the irq may change the VM state (and determinism of
> the execution). E.g., when replaying the execution, one may save
> the VM state and the state of the interrupt controller will be updated
> at the moment of saving, instead of using the recorded update events.
> 
> This patch makes the queue update deterministic: it removes the update_irq
> call and crops the queue to prevent losing the characters and changing
> the required irq status.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  hw/input/ps2.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 06f5d2a..8b1931b 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -837,7 +837,12 @@ static void ps2_common_post_load(PS2State *s)
>      uint8_t tmp_data[PS2_QUEUE_SIZE];
>  
>      /* set the useful data buffer queue size, < PS2_QUEUE_SIZE */
> -    size = (q->count < 0 || q->count > PS2_QUEUE_SIZE) ? 0 : q->count;
> +    size = q->count;
> +    if (q->count < 0) {
> +        size = 0;
> +    } else if (q->count > PS2_QUEUE_SIZE) {
> +        size = PS2_QUEUE_SIZE;
> +    }
>  
>      /* move the queue elements to the start of data array */
>      for (i = 0; i < size; i++) {
> @@ -852,7 +857,6 @@ static void ps2_common_post_load(PS2State *s)
>      q->rptr = 0;
>      q->wptr = size;
>      q->count = size;
> -    s->update_irq(s->update_arg, q->count != 0);
>  }
>  
>  static void ps2_kbd_reset(void *opaque)
> 

Queued, thanks.

Paolo
