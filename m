Received: from eggs.gnu.org ([2001:4830:134:3::10]:37799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAI3c-0001LW-8L
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAI3b-0007DB-34
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:09:28 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:46342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAI3a-0007Cl-So
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:09:27 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m72so23438wmc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 09:09:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <385E45E2-3BC6-4501-91B1-44CA43718947@gmail.com>
References: <20171005145557.5746-1-programmingkidx@gmail.com>
	<20171005145557.5746-2-programmingkidx@gmail.com>
	<CAFEAcA83iZs0T-rM24QZn1ttAsXjuWfsehW86kJBt52Up1p1Hw@mail.gmail.com>
	<385E45E2-3BC6-4501-91B1-44CA43718947@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 16:09:05 +0000
Message-ID: <CAFEAcA9GHtykec46Y_o6ua4kjpti0fQ5gXkh-HH+GjPbB02G-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ui/cocoa.m: move ungrab to
 ctrl-alt-g
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 November 2017 at 15:20, Programmingkid <programmingkidx@gmail.com> wrote:
>> On Nov 2, 2017, at 5:10 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Testing this I have found that it makes the grab key be
>> "ctrl+alt+ the key labelled 'g'", even if in the
>> OSX host keyboard mapping that key doesn't produce the
>> letter 'g'. This is in contrast to for instance the menu
>> accelerators which honour the host keyboard layout, and
>> it's also not what the GTK UI does. So I think we need
>> to fix that.
>
> I just realized that the cocoa interface does not consider the keyboard layout. Switching from QWERTY to DVORK I still see the same keys outputting the same characters in OpenBIOS. This is a separate patch but sometime to take note.

There's a difference between "what do we send to the guest"
(where we're obliged to send raw keycodes, but the user can
configure their guest with an appropriate keymap if they like)
and "what do we do as part of the QEMU UI" (where there is
no ability for the user to set a keymap and we should honour
the host UI keymap settings).

If you look at the behaviour of other VM implementations
like Parallels I think you'll find it's the same.

I think the way we need to implement this is that instead
of doing "switch (keycode)" and looking for Q_KEY_CODE_1...
we should do something like

if (ctrl and alt pressed) {
    NSString *keychar = [theEvent charactersIgnoringModifiers];
    if ([keychar length] == 1) {
        switch ([keychar characterAtIndex:0]) {
        case '1' .. '9':
            console_select(...);
            return;
        case 'g':
            /* handle ungrab */
            return;
    }
}

as suggested by:
https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/EventOverview/HandlingKeyEvents/HandlingKeyEvents.html

thanks
-- PMM
