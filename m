Received: from eggs.gnu.org ([209.51.188.92]:54563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxfED-0004Xr-US
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxfEC-0007nO-Od
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:53:01 -0500
References: <1550878686-23934-1-git-send-email-michelheily@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae330da4-ab5d-1376-f897-0d2e3d5870ce@redhat.com>
Date: Sat, 23 Feb 2019 15:52:40 -0600
MIME-Version: 1.0
In-Reply-To: <1550878686-23934-1-git-send-email-michelheily@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/stellaris: Implement watchdog timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: michelheily@gmail.com, qemu-devel@nongnu.org
Cc: "open list:Stellaris" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On 2/22/19 5:38 PM, michelheily@gmail.com wrote:
> From: Michel Heily <michelheily@gmail.com>
> 
> Signed-off-by: Michel Heily <michelheily@gmail.com>

This appears to be your first contribution to qemu. Welcome to the
community!

Your commit message doesn't give any details beyond the "what" in the
subject line. The body of the commit message should explain the "why"
(what bug are you fixing, how to reproduce it), so that a reviewer
stands a chance of determining if the code matches the description you
gave, and if the issue you describe really does warrant the inclusion of
your patch.  In particular, when implementing a particular piece of
hardware, giving a URL to the datasheet you used as your reference will
let reviewers check if your software appears to match what the actual
hardware would do.

For more patch submission hints, see:
https://wiki.qemu.org/Contribute/SubmitAPatch

I'm not an expert on this hardware, but will at least give a cursory
glance for style issues:

> +    case WDT_O_LOCK:
> +        return s->locked ? 1 : 0;
> +    case WDT_O_PeriphID4: /* fallthrough */
> +    case WDT_O_PeriphID5:

I don't think that particular /* fallthrough */ comment is needed. It
matters when you have a case with code, but not for consecutive case labels.


> +
> +static void wdtimer_write(void *opaque, hwaddr offset,
> +                       uint64_t value, unsigned size)

Alignment looks off.

> +{
> +    wdtimer_state *s = (wdtimer_state *)opaque;

This is C, where void* implicitly converts to other types; you don't
need the cast.


> @@ -1243,7 +1478,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>       * Stellaris LM3S6965 Microcontroller Data Sheet (rev I)
>       * http://www.ti.com/lit/ds/symlink/lm3s6965.pdf
>       *
> -     * 40000000 wdtimer (unimplemented)
> +     * 40000000 wdtimer

Okay, so there is a datasheet. But it may still help to mention it in
the commit message in addition to the comment already in the code.

>       * 40002000 i2c (unimplemented)
>       * 40004000 GPIO
>       * 40005000 GPIO
> @@ -1335,6 +1570,12 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>          }
>      }
>  
> +    if (board->dc1 & (1  << 3)) { /* watchdog present */

Spacing looks off.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
