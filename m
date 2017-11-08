Received: from eggs.gnu.org ([2001:4830:134:3::10]:41750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eCP6Q-0002WT-EA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eCP6M-0002Q5-81
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:05:06 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:43599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eCP6M-0002PL-4J
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:05:02 -0500
Received: by mail-io0-x243.google.com with SMTP id 134so5685088ioo.0
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 04:05:01 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1510049762-4609-3-git-send-email-peter.maydell@linaro.org>
Date: Wed, 8 Nov 2017 07:04:58 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD2DCF39-4633-4F81-8B5E-75B49DB93D12@gmail.com>
References: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
	<1510049762-4609-3-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PULL 2/3] ui/cocoa.m: move ungrab to ctrl-alt-g
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org


> On Nov 7, 2017, at 5:16 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> From: John Arbuckle <programmingkidx@gmail.com>
>=20
> Currently the cocoa user interface relis on the user pushing

I would change "relis" to "relies" here.

> control-alt to ungrab the mouse.  This is patch changes the key
> combination to control-alt-g to be in line with the GTK user
> interface.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> Message-id: 20171102213907.11443-1-programmingkidx@gmail.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> ui/cocoa.m | 31 ++++++++++++++++++-------------
> 1 file changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 2f76dac..f39c792 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -674,10 +674,6 @@ QemuCocoaView *cocoaView;
>                 }
>             }
>=20
> -            // release Mouse grab when pressing ctrl+alt
> -            if (([event modifierFlags] & NSEventModifierFlagControl) =
&& ([event modifierFlags] & NSEventModifierFlagOption)) {
> -                [self ungrabMouse];
> -            }
>             break;
>         case NSEventTypeKeyDown:
>             keycode =3D cocoa_keycode_to_qemu([event keyCode]);
> @@ -690,14 +686,23 @@ QemuCocoaView *cocoaView;
>=20
>             // default
>=20
> -            // handle control + alt Key Combos (ctrl+alt is reserved =
for QEMU)
> +            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is =
reserved for QEMU)
>             if (([event modifierFlags] & NSEventModifierFlagControl) =
&& ([event modifierFlags] & NSEventModifierFlagOption)) {
> -                switch (keycode) {
> -
> -                    // enable graphic console
> -                    case Q_KEY_CODE_1 ... Q_KEY_CODE_9: // '1' to '9' =
keys
> -                        console_select(keycode - Q_KEY_CODE_1);
> -                        break;
> +                NSString *keychar =3D [event =
charactersIgnoringModifiers];
> +                if ([keychar length] =3D=3D 1) {
> +                    char key =3D [keychar characterAtIndex:0];
> +                    switch (key) {
> +
> +                        // enable graphic console
> +                        case '1' ... '9':
> +                            console_select(key - '0' - 1); /* ascii =
math */
> +                            return;
> +
> +                        // release the mouse grab
> +                        case 'g':
> +                            [self ungrabMouse];
> +                            return;
> +                    }
>                 }
>=20
>             // handle keys for graphic console
> @@ -840,9 +845,9 @@ QemuCocoaView *cocoaView;
>=20
>     if (!isFullscreen) {
>         if (qemu_name)
> -            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU =
%s - (Press ctrl + alt to release Mouse)", qemu_name]];
> +            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU =
%s - (Press ctrl + alt + g to release Mouse)", qemu_name]];
>         else
> -            [normalWindow setTitle:@"QEMU - (Press ctrl + alt to =
release Mouse)"];
> +            [normalWindow setTitle:@"QEMU - (Press ctrl + alt + g to =
release Mouse)"];
>     }
>     [self hideCursor];
>     if (!isAbsoluteEnabled) {
> --=20
> 2.7.4
>=20
