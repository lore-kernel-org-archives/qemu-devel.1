Received: from eggs.gnu.org ([2001:4830:134:3::10]:56555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cPXTi-0007VX-IR
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cPXTd-0007Jm-Le
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:34:54 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:34915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cPXTd-0007IW-Gy
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:34:49 -0500
Received: by mail-it0-x242.google.com with SMTP id b123so2564688itb.2
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 08:34:49 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA_pNp39dUxG4ZLGJgsApEpKXB_cf9vmUpH1Gva=pnH1yg@mail.gmail.com>
Date: Fri, 6 Jan 2017 11:34:46 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA07C5F8-452B-4180-9C78-E8A96CB58FA1@gmail.com>
References: <84C57F4C-C8F8-4FB3-804A-FC3DE0AB6408@gmail.com>
	<CAFEAcA_hY+x3c0BUmURubq6qS-e1bDSUm0fE87=G8acrf-tcuA@mail.gmail.com>
	<37C57425-158F-4544-89EF-CC8053476EB6@gmail.com>
	<CAFEAcA_pNp39dUxG4ZLGJgsApEpKXB_cf9vmUpH1Gva=pnH1yg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa.m: fix sending mouse event to
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Jan 6, 2017, at 11:19 AM, Peter Maydell wrote:

> On 6 January 2017 at 15:44, Programmingkid <programmingkidx@gmail.com> =
wrote:
>>=20
>> On Jan 6, 2017, at 8:48 AM, Peter Maydell wrote:
>>=20
>>> On 1 January 2017 at 21:31, Programmingkid =
<programmingkidx@gmail.com> wrote:
>>>> The mouse down event should not be sent to the guest if the mouse =
down event
>>>> causes QEMU to move the foreground from the background. This patch =
prevents
>>>> these activation clicks from going to the guest.
>=20
>>>>    if (mouse_event) {
>>>>        /* Don't send button events to the guest unless we've got a
>>>> -         * mouse grab or window focus. If we have neither then =
this event
>>>> -         * is the user clicking on the background window to =
activate and
>>>> -         * bring us to the front, which will be done by the =
sendEvent
>>>> -         * call below. We definitely don't want to pass that click =
through
>>>> -         * to the guest.
>>>> +         * mouse grab, window focus, or in fullscreen mode. If we =
have neither
>>>> +         * then this event is the user clicking on the background =
window to
>>>> +         * activate and bring us to the front, which will be done =
by the
>>>> +         * sendEvent call below. We definitely don't want to pass =
that click
>>>> +         * through to the guest.
>>>>         */
>>>> -        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
>>>> +        if (isMouseGrabbed && ([[self window] isKeyWindow] || =
isFullscreen) &&
>>>>            (last_buttons !=3D buttons)) {
>>>>            static uint32_t bmap[INPUT_BUTTON__MAX] =3D {
>>>>                [INPUT_BUTTON_LEFT]       =3D MOUSE_EVENT_LBUTTON,
>>>=20
>>> Comment doesn't match code. The comment says "mouse grab, full =
screen
>>> or focus", but the code is doing "mouse grab and (full screen or =
focus)".
>>>=20
>>> Which is correct?
>>=20
>>=20
>> This sounds more accurate:
>>=20
>> (mouse grab and main window is the front window) or QEMU is in =
fullscreen.
>=20
> That's not what your code does either.

Yes, you are right. Didn't see the parentheses. This is what it does:
mouse is grabbed and either QEMU window is front window or QEMU is in =
fullscreen.

The click that causes QEMU to grab the mouse should not be sent to the =
guest because the
host mouse could be on one part of the screen, and the guest mouse could =
be in another
part of the screen the user isn't aware of yet.

> What is the actual situation which we currently get wrong and need
> to get right?

When the user clicks on QEMU's window to bring QEMU to the front, that =
activation
click should not be sent to the guest. I have had a lot of problems =
without this
patch. When the activation click was wrongly sent to the guest, I'm had =
stuff=20
happen like volumes unmount because the guest mouse cursor was over an =
eject button.

> Your commit message says "if the event causes QEMU
> to move to the foreground", but my expectation was that if we
> weren't in the foreground then we would not have the mouse grabbed,
> and in any case your patch adds a check on isFullscreen but your
> commit message doesn't say anything about full-screen or not being
> relevant to the problem.

I know the code works correctly, it is just the commit message that =
needs tweaking.
