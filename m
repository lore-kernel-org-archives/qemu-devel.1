Received: from eggs.gnu.org ([2001:4830:134:3::10]:59974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fZkW3-0007wo-LE
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 18:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fZkW0-0006ds-Dr
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 18:08:19 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fZkW0-0006UL-9E
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 18:08:16 -0400
Received: by mail-it0-x243.google.com with SMTP id h19-v6so1260292itf.1
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 15:08:15 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA9FAbEhRg_TN5ds=GY2BGW7kMzyzsJrh9H0+u+98i01Yw@mail.gmail.com>
Date: Sun, 1 Jul 2018 18:08:13 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <63AA22C7-CA17-4F3A-8D4E-2D49E67245FB@gmail.com>
References: <20180619015832.7398-1-programmingkidx@gmail.com>
	<CAFEAcA9FAbEhRg_TN5ds=GY2BGW7kMzyzsJrh9H0+u+98i01Yw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


On Jul 1, 2018, at 3:30 PM, Peter Maydell wrote:

> On 19 June 2018 at 02:58, John Arbuckle <programmingkidx@gmail.com> =
wrote:
>> When the user pushes Command-F in QEMU while the mouse is ungrabbed, =
QEMU
>> goes into full screen mode. When the user finally releases the =
command key,
>> it is sent to the guest as an event.
>=20
> What is "it" here? This sentences implies that "it" is the key-release
> event for the command key, but the following sentence suggests it's
> the key-press event.

It is the key release event for the command key.=20

>> The makes the guest operating system
>> think the command key is down when it is really up. To prevent this =
situation
>> from happening, we simply drop the first command key event after the =
user has
>> gone into full screen mode using Command-F.
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> ui/cocoa.m | 18 +++++++++++++++++-
>> 1 file changed, 17 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index 2991ed4..024aba2 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -287,6 +287,7 @@ static void handleAnyDeviceErrors(Error * err)
>>     BOOL isFullscreen;
>>     BOOL isAbsoluteEnabled;
>>     BOOL isMouseDeassociated;
>> +    BOOL prevent_stuck_command_key;
>> }
>> - (void) switchSurface:(DisplaySurface *)surface;
>> - (void) grabMouse;
>> @@ -330,7 +331,7 @@ QemuCocoaView *cocoaView;
>>         screen.bitsPerPixel =3D 32;
>>         screen.width =3D frameRect.size.width;
>>         screen.height =3D frameRect.size.height;
>> -
>> +        prevent_stuck_command_key =3D NO;
>>     }
>>     return self;
>> }
>> @@ -552,6 +553,14 @@ QemuCocoaView *cocoaView;
>> }
>>=20
>> - (void) toggleModifier: (int)keycode {
>> +
>> +    /* Prevents the command key from being sent to the guest */
>> +    if ((keycode =3D=3D Q_KEY_CODE_META_L || keycode =3D=3D =
Q_KEY_CODE_META_R) &&
>> +        prevent_stuck_command_key =3D=3D YES) {
>> +        prevent_stuck_command_key =3D NO;
>> +        return;
>> +    }
>> +
>>     // Toggle the stored state.
>>     modifiers_state[keycode] =3D !modifiers_state[keycode];
>>     // Send a keyup or keydown depending on the state.
>> @@ -691,6 +700,13 @@ QemuCocoaView *cocoaView;
>>=20
>>             // forward command key combos to the host UI unless the =
mouse is grabbed
>>             if (!isMouseGrabbed && ([event modifierFlags] & =
NSEventModifierFlagCommand)) {
>> +                /*
>> +                 * Prevent the command key from being stuck down in =
the guest
>> +                 * when using Command-F for full screen mode
>> +                 */
>> +                if (keycode =3D=3D Q_KEY_CODE_F) {
>> +                    prevent_stuck_command_key =3D YES;
>> +                }
>>                 [NSApp sendEvent:event];
>>                 return;
>>             }
>> --
>> 2.7.2
>=20
> I can sort of see why this might work, but the flow of what's
> going wrong isn't clear from your commit message, and the
> change looks really inelegant.

What would be a more suitable solution to this problem? I realize using =
a flag to indicate this situation isn't the prettiest, but it does get =
the job done.=20
