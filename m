Received: from eggs.gnu.org ([2001:4830:134:3::10]:36859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbMmW-0002ov-Hx
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbMmV-0005ms-Cu
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:12:00 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbMmV-0005lP-8c
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:11:59 -0400
Received: by mail-oi0-x243.google.com with SMTP id r16-v6so22215069oie.3
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 02:11:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706025352.42643-1-programmingkidx@gmail.com>
References: <20180706025352.42643-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 10:11:38 +0100
Message-ID: <CAFEAcA-6p5TP=yedqYMY+kaW6qTLMPrXTXdF9YeK0eU78vwLjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa.m: replace scrollingDeltaY
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

On 6 July 2018 at 03:53, John Arbuckle <programmingkidx@gmail.com> wrote:
> The NSEvent class method scrollingDeltaY is available
> for Mac OS 10.7 and newer. Since QEMU supports Mac OS
> 10.5 and up, we need to be using a method that is
> available on these version of Mac OS X. The deltaY
> method is a method that does the same thing as
> scrollingDeltaY and is available on Mac OS 10.5 and
> up. So we simply replace scrollingDeltaY with deltaY.

Commit message doesn't match code change.

> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v2 changes:
> - Added a condition that drops scroll events that have a deltaY value of zero.
>
>  ui/cocoa.m | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 2991ed4..f371469 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -802,14 +802,15 @@ QemuCocoaView *cocoaView;
>               * This is in-line with standard Mac OS X UI behaviour.
>               */
>
> +            if ([event deltaY] != 0) {

This could use a comment about why we need to check it.

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
> 2.7.2

thanks
-- PMM
