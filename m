Received: from eggs.gnu.org ([2001:4830:134:3::10]:42412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdMVh-0005Nc-DO
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 17:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdMVg-0005gS-6a
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 17:18:53 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:34494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdMVf-0005fR-Ve
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 17:18:52 -0400
Received: by mail-oi0-x22b.google.com with SMTP id 13-v6so51938872ois.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 14:18:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709150235.7573-1-programmingkidx@gmail.com>
References: <20180709150235.7573-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Jul 2018 22:18:30 +0100
Message-ID: <CAFEAcA82ZxENfCU8C9jnOLJx+WOw6QcR1LYYfG7KVB_7Fv7w_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] ui/cocoa.m: replace scrollingDeltaY
 with deltaY
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

On 9 July 2018 at 16:02, John Arbuckle <programmingkidx@gmail.com> wrote:
> The NSEvent class method scrollingDeltaY is available
> for Mac OS 10.7 and newer. Since QEMU supports Mac OS
> 10.5 and up, we need to be using a method that is
> available on these version of Mac OS X. The deltaY
> method is a method that does the same thing as
> scrollingDeltaY and is available on Mac OS 10.5 and
> up. So we replace scrollingDeltaY with deltaY.
>
> We only check deltaY's value if it is not zero
> because zero means no scrolling took place.

Not quite -- it means that the scrolling was fine enough
that it doesn't add up to a big movement. If you use a
fine-scrolling input device (I used the trackpad on my
macbook air), then you will get a sequence of events
like this for a very slow trackpad scroll:

scroll: deltaY 0 scrollingDeltaY -1
scroll: deltaY 0 scrollingDeltaY -2
scroll: deltaY 0 scrollingDeltaY -1
scroll: deltaY 0 scrollingDeltaY -3
scroll: deltaY 0 scrollingDeltaY -1
scroll: deltaY 0 scrollingDeltaY -3
scroll: deltaY 0 scrollingDeltaY -1
scroll: deltaY 0 scrollingDeltaY -2
scroll: deltaY 0 scrollingDeltaY -2
scroll: deltaY 0 scrollingDeltaY -1
scroll: deltaY 0 scrollingDeltaY -3
scroll: deltaY 0 scrollingDeltaY -2
scroll: deltaY 0 scrollingDeltaY -1
scroll: deltaY 0 scrollingDeltaY -3
scroll: deltaY 0 scrollingDeltaY -1
scroll: deltaY 0 scrollingDeltaY -4
scroll: deltaY 0 scrollingDeltaY -2
scroll: deltaY 0 scrollingDeltaY -2
scroll: deltaY 0 scrollingDeltaY -2
scroll: deltaY 0 scrollingDeltaY 0

(interestingly it does give events with both deltas 0; maybe
that event had a horizontal scroll component to it).

Larger scroll gestures get you this sort of thing:

scroll: deltaY 0 scrollingDeltaY 0
scroll: deltaY 0 scrollingDeltaY -1
scroll: deltaY -3 scrollingDeltaY -31
scroll: deltaY -3 scrollingDeltaY -36
scroll: deltaY -2 scrollingDeltaY -30
scroll: deltaY 0 scrollingDeltaY 0
scroll: deltaY -1 scrollingDeltaY -16
scroll: deltaY -3 scrollingDeltaY -32
scroll: deltaY -3 scrollingDeltaY -30
scroll: deltaY -2 scrollingDeltaY -28
scroll: deltaY -2 scrollingDeltaY -25
scroll: deltaY -2 scrollingDeltaY -23
scroll: deltaY -1 scrollingDeltaY -19
scroll: deltaY -1 scrollingDeltaY -15
scroll: deltaY -1 scrollingDeltaY -14
scroll: deltaY 0 scrollingDeltaY -12

where OSX has decided that there's enough movement to
report a deltaY change, not just the fine-grained
scrollingDeltaY.

Anyway, since the QEMU input layer doesn't provide a mechanism
for reporting fine-scrolling I guess this patch is OK.
If we get complaints about the trackpad no longer being
as responsive as it used to be to scrolls then we can
look at doing something more complicated then.

I'll tweak the comments and put this in for 3.0 rc1.

> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v3 changes:
> - Added a comment explaining why we drop scrolling events in both the code and
> the patch comment.
>
> v2 changes:
> - Added a condition that drops scroll events that have a deltaY value of zero.
>
>  ui/cocoa.m | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 2991ed4f19..3bae090101 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -802,14 +802,19 @@ - (void) handleEvent:(NSEvent *)event
>               * This is in-line with standard Mac OS X UI behaviour.
>               */
>
> +            /*
> +             * When deltaY is zero, it means the scrolling device did not move
> +             * for this event. So we drop the event.
> +             */
> +            if ([event deltaY] != 0) {
>              /* Determine if this is a scroll up or scroll down event */
> -            buttons = ([event scrollingDeltaY] > 0) ?
> -                INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
> -            qemu_input_queue_btn(dcl->con, buttons, true);
> -            qemu_input_event_sync();
> -            qemu_input_queue_btn(dcl->con, buttons, false);
> -            qemu_input_event_sync();
> -
> +                buttons = ([event deltaY] > 0) ?
> +                    INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
> +                qemu_input_queue_btn(dcl->con, buttons, true);
> +                qemu_input_event_sync();
> +                qemu_input_queue_btn(dcl->con, buttons, false);
> +                qemu_input_event_sync();
> +            }
>              /*
>               * Since deltaY also reports scroll wheel events we prevent mouse
>               * movement code from executing.
> --
> 2.14.3 (Apple Git-98)
>

thanks
-- PMM
