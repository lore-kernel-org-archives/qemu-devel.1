Received: from eggs.gnu.org ([2001:4830:134:3::10]:51752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC0sw-0007KF-Ai
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC0ss-0006SN-C6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:13:34 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:44811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC0ss-0006S4-64
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:13:30 -0500
Received: by mail-wm0-x241.google.com with SMTP id n74so13745208wmi.1
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 02:13:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171102213907.11443-2-programmingkidx@gmail.com>
References: <20171102213907.11443-1-programmingkidx@gmail.com>
	<20171102213907.11443-2-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 10:13:08 +0000
Message-ID: <CAFEAcA9=gi5WcikXop0iHPDUFZ0t6g-KcJW7ja_TjP-EZpqerw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/2] ui/cocoa.m: send ctrl-alt key
 combinations to guest if not used by QEMU
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

On 2 November 2017 at 21:39, John Arbuckle <programmingkidx@gmail.com> wrote:
> Send control-alt key combinations to the guest if not used by the user interface.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v3 changes:
> - Code is now keyboard layout aware
>
> v2 changes:
> - changed logic to use existing if case
>
>  ui/cocoa.m | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index e06aa9c65f..030479f4cd 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -619,29 +619,28 @@ - (void) handleEvent:(NSEvent *)event
>                  return;
>              }
>
> -            // default
> -
> -            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is reserved for QEMU)
> -            if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
> +            // console selection
> +            if (([event modifierFlags] & NSEventModifierFlagControl) &&
> +                ([event modifierFlags] & NSEventModifierFlagOption) &&
> +                ([[event charactersIgnoringModifiers] length] == 1) &&
> +                (isdigit([[event charactersIgnoringModifiers] characterAtIndex: 0]))) {
>                  NSString *keychar = [event charactersIgnoringModifiers];
> -                if ([keychar length] == 1) {
> -                    char key = [keychar characterAtIndex:0];
> -                    switch (key) {
> -
> -                        // enable graphic console
> -                        case '1' ... '9':
> -                            console_select(key - '0' - 1); /* ascii math */
> -                            return;
> -
> -                        // release the mouse grab
> -                        case 'g':
> -                            [self ungrabMouse];
> -                            return;
> -                    }
> -                }
> +                char key = [keychar characterAtIndex:0];
> +                console_select(key - '0' - 1); /* ascii math */
> +                return;
> +            }
> +
> +            // mouse ungrab
> +            else if (([event modifierFlags] & NSEventModifierFlagControl) &&
> +                     ([event modifierFlags] & NSEventModifierFlagOption) &&
> +                     ([[event charactersIgnoringModifiers] length] == 1) &&
> +                     ([[event charactersIgnoringModifiers] characterAtIndex: 0] == 'g')) {
> +                [self ungrabMouse];
> +                return;
> +            }
>
> -            // handle keys for graphic console
> -            } else if (qemu_console_is_graphic(NULL)) {
> +            // send to guest
> +            else if (qemu_console_is_graphic(NULL)) {
>                  qemu_input_event_send_key_qcode(dcl->con, keycode, true);
>
>              // handlekeys for Monitor
> --
> 2.13.5 (Apple Git-94)

This is an awful lot of entirely unnecessary code change.

Any time you find yourself repeating a big long
conditional like
> +            if (([event modifierFlags] & NSEventModifierFlagControl) &&
> +                ([event modifierFlags] & NSEventModifierFlagOption) &&
> +                ([[event charactersIgnoringModifiers] length] == 1) &&

you should take a step back and say "how can I
avoid repeating this?".

In this case, all you need to do is delete the "else"
from the start of
} else if (qemu_console_is_graphic(NULL)) {

All the specially-handled ctrl-alt combos finish with
"return", so all the rest will then just fall through
as required.

I've put a patch which does that into cocoa.next.

thanks
-- PMM
