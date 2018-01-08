Received: from eggs.gnu.org ([2001:4830:134:3::10]:42143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYZb9-0001xH-An
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYZb8-0007cG-Av
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:27 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:37642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYZb8-0007bm-5e
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:26 -0500
Received: by mail-oi0-x22a.google.com with SMTP id e144so2187207oib.4
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 07:44:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171230163012.95032-1-programmingkidx@gmail.com>
References: <20171230163012.95032-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 15:44:05 +0000
Message-ID: <CAFEAcA-3uh+TpvXSNf0b4AakzEQsjUDL_-BrAmAUyvZ-MG62vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cocoa.m: Fix scroll wheel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 December 2017 at 16:30, John Arbuckle <programmingkidx@gmail.com> wrote:
> When using a mouse's scroll wheel in a guest with the cocoa front-end, the mouse pointer moves up and down instead of scrolling the window. This patch fixes this problem.

Thanks for this patch. The code looks good to me, but
you can now also remove the entries for INPUT_BUTTON_WHEEL_UP
and INPUT_BUTTON_WHEEL_DOWN from the bmap[] array, because
we can no longer get into that code with those button types.

I think it's also worth having a comment that we send
wheel events to the guest regardless of window focus now
(which is in line with standard OSX UI behaviour, so it
seems like the right thing).

PS: can you line-wrap your commit messages, please?

> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 330ccebf90..d2e5f80b74 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -786,11 +786,18 @@ - (void) handleEvent:(NSEvent *)event
>              mouse_event = true;
>              break;
>          case NSEventTypeScrollWheel:
> -            if (isMouseGrabbed) {
> -                buttons |= ([event deltaY] < 0) ?
> -                    MOUSE_EVENT_WHEELUP : MOUSE_EVENT_WHEELDN;
> -            }
> -            mouse_event = true;
> +            /* Determine if this is a scroll up or scroll down event */
> +            buttons = ([event scrollingDeltaY] > 0) ?
> +                INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
> +            qemu_input_queue_btn(dcl->con, buttons, true);
> +            qemu_input_event_sync();
> +            qemu_input_queue_btn(dcl->con, buttons, false);
> +            qemu_input_event_sync();
> +            /*
> +             * Since deltaY also reports scroll wheel events we prevent mouse
> +             * movement code from executing.
> +             */
> +            mouse_event = false;
>              break;
>          default:
>              [NSApp sendEvent:event];
> --
> 2.14.3 (Apple Git-98)
>

thanks
-- PMM
