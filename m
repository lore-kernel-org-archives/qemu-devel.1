Received: from eggs.gnu.org ([2001:4830:134:3::10]:60526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diN2Z-000506-Cx
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diN2Y-0003OZ-9i
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:48:59 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1diN2Y-0003NV-1P
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:48:58 -0400
Received: by mail-wr0-x231.google.com with SMTP id f8so2882670wrf.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 08:48:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7843ECF8-2CA7-485F-B3D2-38A55D13D80D@gmail.com>
References: <7843ECF8-2CA7-485F-B3D2-38A55D13D80D@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Aug 2017 16:48:34 +0100
Message-ID: <CAFEAcA8kunh-u6OW84vF29OphVz05vuG=8t-D_igUBi1yvi00Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: change mouse grab to
 control-alt-g
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 20 July 2017 at 15:36, Programmingkid <programmingkidx@gmail.com> wrote:
> The GTK interface uses Control-Alt-G to ungrab the mouse. This patch chan=
ges the ungrab keys in the Cocoa interface to be consistent with the GTK in=
terface. This patch has the added benefit of being able to send Control-Alt=
 key combinations to the guest (like Control-Alt-Delete used in Windows).

Hi. First, apologies for taking a while to get to this
patch -- I've been prioritising work that targets the
2.10 release.

I think this patch is trying to do two things at once:
 (1) move ungrab from ctrl-g to ctrl-alt-g
 (2) make ctrl-alt-[something] be passed through to the guest
     if it isn't something QEMU uses itself
Please can you split it into two separate patches that
do one thing each?

> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 93e56d0..d64c7b9 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -609,10 +609,6 @@ QemuCocoaView *cocoaView;
>                  }
>              }
>
> -            // release Mouse grab when pressing ctrl+alt
> -            if (([event modifierFlags] & NSEventModifierFlagControl) && =
([event modifierFlags] & NSEventModifierFlagOption)) {
> -                [self ungrabMouse];
> -            }
>              break;
>          case NSEventTypeKeyDown:
>              keycode =3D cocoa_keycode_to_qemu([event keyCode]);
> @@ -625,7 +621,7 @@ QemuCocoaView *cocoaView;
>
>              // default
>
> -            // handle control + alt Key Combos (ctrl+alt is reserved for=
 QEMU)
> +            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is res=
erved for QEMU)
>              if (([event modifierFlags] & NSEventModifierFlagControl) && =
([event modifierFlags] & NSEventModifierFlagOption)) {
>                  switch (keycode) {
>
> @@ -633,6 +629,18 @@ QemuCocoaView *cocoaView;
>                      case Q_KEY_CODE_1 ... Q_KEY_CODE_9: // '1' to '9' ke=
ys
>                          console_select(keycode - 11);
>                          break;
> +
> +                    // release the mouse grab
> +                    case Q_KEY_CODE_G:
> +                        [self ungrabMouse];
> +                        break;
> +
> +                    // send to the guest
> +                    default:
> +                        qemu_input_event_send_key_qcode(dcl->con, Q_KEY_=
CODE_CTRL, true);
> +                        qemu_input_event_send_key_qcode(dcl->con, Q_KEY_=
CODE_ALT, true);
> +                        qemu_input_event_send_key_qcode(dcl->con, keycod=
e, true);
> +                        break;

This doesn't look right. We should already have sent the key-down
events for ctrl and alt when the NSEventTypeKeyDown event
fired for when the user pressed them, so we don't need to
send them again. Also we don't want to do a qemu_input_event_send_key_qcode
if the current console isn't graphic (eg if it is the monitor or
a serial port output view).

What you want to do is adjust the control flow here so
that if we consume the ctrl-alt keycode then we stop
processing the key event, but if we don't recognize it
then we continue into the "if qemu_console_is_graphic(NULL) {
 send the key } else { send key for a non graphic console }"
codeflow that we have at the moment.

>                  }
>
>              // handle keys for graphic console
> @@ -806,9 +814,9 @@ QemuCocoaView *cocoaView;
>
>      if (!isFullscreen) {
>          if (qemu_name)
> -            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s =
- (Press ctrl + alt to release Mouse)", qemu_name]];
> +            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s =
- (Press ctrl + alt + g to release Mouse)", qemu_name]];
>          else
> -            [normalWindow setTitle:@"QEMU - (Press ctrl + alt to release=
 Mouse)"];
> +            [normalWindow setTitle:@"QEMU - (Press ctrl + alt + g to rel=
ease Mouse)"];
>      }
>      [self hideCursor];
>      if (!isAbsoluteEnabled) {
> --
> 2.7.2
>

thanks
-- PMM
