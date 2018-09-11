Received: from eggs.gnu.org ([2001:4830:134:3::10]:38074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzfks-00019j-JE
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzfkp-00037H-DL
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:18:46 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42300)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzfkp-00035p-23
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:18:43 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180511081601.14610.39946.stgit@pasha-VirtualBox>
	<377a43be-ec70-f8d0-450e-c71d239685a1@redhat.com>
In-Reply-To: <377a43be-ec70-f8d0-450e-c71d239685a1@redhat.com>
Date: Tue, 11 Sep 2018 13:18:43 +0300
Message-ID: <002601d449b8$d1b299a0$7517cce0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, mst@redhat.com, ciro.santilli@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com

Paolo, have you forgot about this?

Pavel Dovgalyuk


> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Friday, May 11, 2018 12:14 PM
> To: Pavel Dovgalyuk; qemu-devel@nongnu.org
> Cc: arei.gonglei@huawei.com; mst@redhat.com; ciro.santilli@gmail.com;
> maria.klimushenkova@ispras.ru; dovgaluk@ispras.ru; kraxel@redhat.com
> Subject: Re: [PATCH] ps2: prevent changing irq state on save and load
> 
> On 11/05/2018 10:16, Pavel Dovgalyuk wrote:
> > Commit 2858ab09e6f708e381fc1a1cc87e747a690c4884 changed
> > PS/2 keyboard/mouse buffers to the standard size. However, its state
> > may change when migrating from the old buffer size and therefore irq needs
> > updating. But this change made wrong, because it throws the whole queue
> > if there are too much data instead of cropping it.
> >
> > That commit also updates irq (because the queue state may change).
> > But updating the irq may change the VM state (and determinism of
> > the execution). E.g., when replaying the execution, one may save
> > the VM state and the state of the interrupt controller will be updated
> > at the moment of saving, instead of using the recorded update events.
> >
> > This patch makes the queue update deterministic: it removes the update_irq
> > call and crops the queue to prevent losing the characters and changing
> > the required irq status.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > ---
> >  hw/input/ps2.c |    8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> > index 06f5d2a..8b1931b 100644
> > --- a/hw/input/ps2.c
> > +++ b/hw/input/ps2.c
> > @@ -837,7 +837,12 @@ static void ps2_common_post_load(PS2State *s)
> >      uint8_t tmp_data[PS2_QUEUE_SIZE];
> >
> >      /* set the useful data buffer queue size, < PS2_QUEUE_SIZE */
> > -    size = (q->count < 0 || q->count > PS2_QUEUE_SIZE) ? 0 : q->count;
> > +    size = q->count;
> > +    if (q->count < 0) {
> > +        size = 0;
> > +    } else if (q->count > PS2_QUEUE_SIZE) {
> > +        size = PS2_QUEUE_SIZE;
> > +    }
> >
> >      /* move the queue elements to the start of data array */
> >      for (i = 0; i < size; i++) {
> > @@ -852,7 +857,6 @@ static void ps2_common_post_load(PS2State *s)
> >      q->rptr = 0;
> >      q->wptr = size;
> >      q->count = size;
> > -    s->update_irq(s->update_arg, q->count != 0);
> >  }
> >
> >  static void ps2_kbd_reset(void *opaque)
> >
> 
> Queued, thanks.
> 
> Paolo
