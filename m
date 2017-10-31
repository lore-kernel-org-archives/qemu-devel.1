Received: from eggs.gnu.org ([2001:4830:134:3::10]:58329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9ZKY-0005F2-GN
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9ZKS-0001e7-Q2
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:23:58 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9ZKS-0001ce-HG
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:23:52 -0400
Received: by mail-wr0-x243.google.com with SMTP id w105so16496823wrc.0
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 09:23:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005184309.14521-1-programmingkidx@gmail.com>
References: <20171005184309.14521-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 16:23:30 +0000
Message-ID: <CAFEAcA9S-zyM8ndVfc6sreAZcEJLbAKULTDuepwtZVJ88si_rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Make scrolling work again
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

On 5 October 2017 at 19:43, John Arbuckle <programmingkidx@gmail.com> wrote:
> Make scrolling in the monitor work.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

Sorry this took me a while to get to reviewing.

> ---
>  ui/cocoa.m | 88 +++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 56 insertions(+), 32 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 93e56d0518..5545c42b9c 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -281,6 +281,7 @@ - (void) switchSurface:(DisplaySurface *)surface;
>  - (void) grabMouse;
>  - (void) ungrabMouse;
>  - (void) toggleFullScreen:(id)sender;
> +- (void) handleMonitorInput:(NSEvent *)event;
>  - (void) handleEvent:(NSEvent *)event;
>  - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
>  /* The state surrounding mouse grabbing is potentially confusing.
> @@ -554,6 +555,60 @@ - (void) toggleStatefulModifier: (int)keycode {
>      qemu_input_event_send_key_qcode(dcl->con, keycode, false);
>  }
>
> +// Does the work of sending input to the monitor
> +- (void) handleMonitorInput:(NSEvent *)event
> +{
> +    int keysym = 0;
> +    int control_key = 0;
> +
> +    // if the control key is down
> +    if ([event modifierFlags] & NSEventModifierFlagControl) {
> +        control_key = 4; // shifts by one nibble (hex digit)
> +    }

Rather than doing this, just have an array for "with control"
and one for "without control".

> +
> +    /* translates Macintosh keycodes to QEMU's keysym */
> +    int translation_matrix[] = {
> +        [0 ... 0xff] = 0,   // invalid key
> +
> +        [kVK_UpArrow]       = QEMU_KEY_UP,
> +        [kVK_DownArrow]     = QEMU_KEY_DOWN,
> +        [kVK_RightArrow]    = QEMU_KEY_RIGHT,
> +        [kVK_LeftArrow]     = QEMU_KEY_LEFT,
> +        [kVK_Home]          = QEMU_KEY_HOME,
> +        [kVK_End]           = QEMU_KEY_END,
> +        [kVK_PageUp]        = QEMU_KEY_PAGEUP,
> +        [kVK_PageDown]      = QEMU_KEY_PAGEDOWN,
> +        [kVK_ForwardDelete] = QEMU_KEY_DELETE,
> +        [kVK_Delete]        = QEMU_KEY_BACKSPACE,
> +
> +        /*
> +         * Shift value by one hex digit.
> +         * Since no key has a 3 digit hex value there is no chance
> +         * for overlap.
> +         */
> +        [kVK_UpArrow << 4]       = QEMU_KEY_CTRL_UP,
> +        [kVK_DownArrow << 4]     = QEMU_KEY_CTRL_DOWN,
> +        [kVK_RightArrow << 4]    = QEMU_KEY_CTRL_RIGHT,
> +        [kVK_LeftArrow << 4]     = QEMU_KEY_CTRL_LEFT,
> +        [kVK_Home << 4]          = QEMU_KEY_CTRL_HOME,
> +        [kVK_End << 4]           = QEMU_KEY_CTRL_END,
> +        [kVK_PageUp << 4]        = QEMU_KEY_CTRL_PAGEUP,
> +        [kVK_PageDown << 4]      = QEMU_KEY_CTRL_PAGEDOWN,
> +    };
> +
> +    keysym = translation_matrix[[event keyCode] << control_key];

You need to check whether your array index value is within
bounds for the array before you use it as an array index.

> +
> +    // if not a key that needs translating
> +    if (keysym == 0) {
> +        NSString *ks = [event characters];
> +        if ([ks length] > 0)
> +            keysym = [ks characterAtIndex:0];
> +    }
> +
> +    if(keysym)
> +        kbd_put_keysym(keysym);

Coding style requires braces for all if() statements. (I know
you're just moving these lines; that's a good point to bring
them into line with the style.)

thanks
-- PMM
