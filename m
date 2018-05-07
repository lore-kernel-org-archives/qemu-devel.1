Received: from eggs.gnu.org ([2001:4830:134:3::10]:51370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFfM6-0008Bq-WB
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFfM3-0008QF-Q3
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:35:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFfM3-0008Pl-Lj
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:34:59 -0400
Date: Mon, 7 May 2018 14:34:53 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180507123453.2ef3zk54d7tqii3e@sirius.home.kraxel.org>
References: <fcafae5827cc7fab7b98b9afaf73e08a@hostfission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcafae5827cc7fab7b98b9afaf73e08a@hostfission.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] ps2: Fix mouse stream corruption due
 to lost data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: geoff@hostfission.com
Cc: qemu-devel@nongnu.org

> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 6edf046820..011290920f 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -192,12 +192,50 @@ void ps2_queue(PS2State *s, int b)
>  {
>      PS2Queue *q = &s->queue;
> 
> -    if (q->count >= PS2_QUEUE_SIZE - 1)
> +    if (q->count == PS2_QUEUE_SIZE)
> +    {
> +        printf("Warning! PS2 Queue Overflow!\n");
>          return;
> +    }

Leftover debug printf?

> +void ps2_raise(PS2State *s)
> +{
> +    s->update_irq(s->update_arg, 1);
> +}
> +
> +void ps2_queue_raise(PS2State *s, int b)
> +{
> +    ps2_queue(s, b);
> +    s->update_irq(s->update_arg, 1);
> +}

I'd suggest to keep the ps2_queue() name.  Makes the patch much smaller
and easier to review.  Factor out the code to actually queue things to
a new ps2_queue_noirq() function.

> +void ps2_queue_bytes(PS2State *s, const int length, ...)

I'd prefer to not use vaargs here as gcc can't check the arguments then.
Suggest to just have ps2_queue_{2,3,4}() helpers instead to queue
multibyte messages.

cheers,
  Gerd
