Received: from eggs.gnu.org ([2001:4830:134:3::10]:41080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZi3v-00072W-EZ
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZi3u-0003sN-HN
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:31:07 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZi3u-0003qd-45
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:31:06 -0400
Received: by mail-ot0-x243.google.com with SMTP id l15-v6so15190380oth.6
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 12:31:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619015832.7398-1-programmingkidx@gmail.com>
References: <20180619015832.7398-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Jul 2018 20:30:45 +0100
Message-ID: <CAFEAcA9FAbEhRg_TN5ds=GY2BGW7kMzyzsJrh9H0+u+98i01Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: prevent stuck command key when
 going into full screen mode
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

On 19 June 2018 at 02:58, John Arbuckle <programmingkidx@gmail.com> wrote:
> When the user pushes Command-F in QEMU while the mouse is ungrabbed, QEMU
> goes into full screen mode. When the user finally releases the command key,
> it is sent to the guest as an event.

What is "it" here? This sentences implies that "it" is the key-release
event for the command key, but the following sentence suggests it's
the key-press event.

>The makes the guest operating system
> think the command key is down when it is really up. To prevent this situation
> from happening, we simply drop the first command key event after the user has
> gone into full screen mode using Command-F.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 2991ed4..024aba2 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -287,6 +287,7 @@ static void handleAnyDeviceErrors(Error * err)
>      BOOL isFullscreen;
>      BOOL isAbsoluteEnabled;
>      BOOL isMouseDeassociated;
> +    BOOL prevent_stuck_command_key;
>  }
>  - (void) switchSurface:(DisplaySurface *)surface;
>  - (void) grabMouse;
> @@ -330,7 +331,7 @@ QemuCocoaView *cocoaView;
>          screen.bitsPerPixel = 32;
>          screen.width = frameRect.size.width;
>          screen.height = frameRect.size.height;
> -
> +        prevent_stuck_command_key = NO;
>      }
>      return self;
>  }
> @@ -552,6 +553,14 @@ QemuCocoaView *cocoaView;
>  }
>
>  - (void) toggleModifier: (int)keycode {
> +
> +    /* Prevents the command key from being sent to the guest */
> +    if ((keycode == Q_KEY_CODE_META_L || keycode == Q_KEY_CODE_META_R) &&
> +        prevent_stuck_command_key == YES) {
> +        prevent_stuck_command_key = NO;
> +        return;
> +    }
> +
>      // Toggle the stored state.
>      modifiers_state[keycode] = !modifiers_state[keycode];
>      // Send a keyup or keydown depending on the state.
> @@ -691,6 +700,13 @@ QemuCocoaView *cocoaView;
>
>              // forward command key combos to the host UI unless the mouse is grabbed
>              if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
> +                /*
> +                 * Prevent the command key from being stuck down in the guest
> +                 * when using Command-F for full screen mode
> +                 */
> +                if (keycode == Q_KEY_CODE_F) {
> +                    prevent_stuck_command_key = YES;
> +                }
>                  [NSApp sendEvent:event];
>                  return;
>              }
> --
> 2.7.2

I can sort of see why this might work, but the flow of what's
going wrong isn't clear from your commit message, and the
change looks really inelegant.

thanks
-- PMM
