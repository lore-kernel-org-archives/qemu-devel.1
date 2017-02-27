Received: from eggs.gnu.org ([2001:4830:134:3::10]:59744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciLyA-00070s-Jq
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciLy9-0008Vf-3d
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:08:06 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciLy8-0008VW-RQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:08:05 -0500
Received: by mail-wm0-x235.google.com with SMTP id u199so19576186wmd.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 06:08:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <492427237.68231.1488183356160@communicator.strato.de>
References: <492427237.68231.1488183356160@communicator.strato.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 14:07:43 +0000
Message-ID: <CAFEAcA-hHnOvoWZYZgBt2sWjv60fyTFv4mmGkaBbnVDwEqg31w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] pl190: Fix off-by-one error in priority
 handling when reading VECTADDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Bommert <marc@brightwise.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2017 at 08:15, Marc Bommert <marc@brightwise.de> wrote:
> The "current" priority bit (1 << i) should also be set in
> s->prio_mask[i], if the interrupt is enabled. This will in turn
> cause the read operation of VECTADDR to return the correct vector
> of the pending interrupt.
>
> ---
> hw/intc/pl190.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
> index 55ea15d..0369da8 100644
> --- a/hw/intc/pl190.c
> +++ b/hw/intc/pl190.c
> @@ -80,12 +80,12 @@ static void pl190_update_vectors(PL190State *s)
> mask = 0;
> for (i = 0; i < 16; i++)
> {
> - s->prio_mask[i] = mask;
> if (s->vect_control[i] & 0x20)
> {
> n = s->vect_control[i] & 0x1f;
> mask |= 1 << n;
> }
> + s->prio_mask[i] = mask;
> }
> s->prio_mask[16] = mask;
> pl190_update(s);

(Your email client seems to have removed all the leading spaces
from your patch, which makes it a bit tricky to read.)

The comment in pl190_read() about VECTADDR says
"an enabled interrupt X at priority P causes prio_mask[Y]
 to have bit X set for all Y > P", but your patch would
make that not be true.

I'm not very familiar with the PL190, but looking at pl190_update()
I think your proposed change will make us set the outbound IRQ
line incorrectly.

Suppose that only the interrupt programmed into VECTCNTL[0]
and VECTADDR[0] is active. We will initially set the IRQ line
(since s->priority is 17 and s->prio_mask[17] is 0xffffffff).
However when the guest reads the VICVectAddr register we want
to cause the IRQ line to no longer be asserted. (The PL190 TRM
states this in the "Interrupt priority logic" section:
"The highest priority request generates an IRQ interrupt if
the interrupt is not currently being serviced.") In the current
code this works because we will set s->priority to 0, and
s->prio_mask[0] is 0 and so the "level & s->prio_mask[s->priority]"
masking in pl190_update() clears the bit and we won't assert
the IRQ line. With your change, s->prio_mask[0] would have the
bit set for the interrupt number, and so the masking would
leave that bit set and leave IRQ asserted.

It also looks to me like this change breaks the logic for
reading VECTADDR, because instead of the loop stopping
with i as the priority of the highest set not-being-serviced
interrupt it will stop with i being one less than that.
(For instance if the interrupt for priority 2 is the highest
set not-being-serviced interrupt then with your change
we'll now set s->prio_mask[2] to have the relevant bit set,
which means the loop will terminate with i == 1, and we return
the vector address for interrupt priority 1, not 2 as we should.

Perhaps I'm missing something -- what's the wrong behaviour
that you're seeing that you're trying to fix ?

thanks
-- PMM
