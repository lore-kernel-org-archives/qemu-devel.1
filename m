Received: from eggs.gnu.org ([2001:4830:134:3::10]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cPWgd-0008QE-AN
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cPWga-0007Sn-80
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:44:11 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cPWga-0007RQ-2x
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:44:08 -0500
Received: by mail-it0-x244.google.com with SMTP id q186so2425460itb.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 07:44:06 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA_hY+x3c0BUmURubq6qS-e1bDSUm0fE87=G8acrf-tcuA@mail.gmail.com>
Date: Fri, 6 Jan 2017 10:44:03 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <37C57425-158F-4544-89EF-CC8053476EB6@gmail.com>
References: <84C57F4C-C8F8-4FB3-804A-FC3DE0AB6408@gmail.com>
	<CAFEAcA_hY+x3c0BUmURubq6qS-e1bDSUm0fE87=G8acrf-tcuA@mail.gmail.com>
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


On Jan 6, 2017, at 8:48 AM, Peter Maydell wrote:

> On 1 January 2017 at 21:31, Programmingkid <programmingkidx@gmail.com> =
wrote:
>> The mouse down event should not be sent to the guest if the mouse =
down event
>> causes QEMU to move the foreground from the background. This patch =
prevents
>> these activation clicks from going to the guest.
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> v2 changes:
>> Fix a bug that caused fullscreen mode not to receive mouse events.
>>=20
>> ui/cocoa.m | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index 26d4a1c..ae3f5a1 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -695,13 +695,13 @@ QemuCocoaView *cocoaView;
>>=20
>>     if (mouse_event) {
>>         /* Don't send button events to the guest unless we've got a
>> -         * mouse grab or window focus. If we have neither then this =
event
>> -         * is the user clicking on the background window to activate =
and
>> -         * bring us to the front, which will be done by the =
sendEvent
>> -         * call below. We definitely don't want to pass that click =
through
>> -         * to the guest.
>> +         * mouse grab, window focus, or in fullscreen mode. If we =
have neither
>> +         * then this event is the user clicking on the background =
window to
>> +         * activate and bring us to the front, which will be done by =
the
>> +         * sendEvent call below. We definitely don't want to pass =
that click
>> +         * through to the guest.
>>          */
>> -        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
>> +        if (isMouseGrabbed && ([[self window] isKeyWindow] || =
isFullscreen) &&
>>             (last_buttons !=3D buttons)) {
>>             static uint32_t bmap[INPUT_BUTTON__MAX] =3D {
>>                 [INPUT_BUTTON_LEFT]       =3D MOUSE_EVENT_LBUTTON,
>=20
> Comment doesn't match code. The comment says "mouse grab, full screen
> or focus", but the code is doing "mouse grab and (full screen or =
focus)".
>=20
> Which is correct?


This sounds more accurate:

(mouse grab and main window is the front window) or QEMU is in =
fullscreen.=20

If the comment is the only thing that is the problem, please feel free =
to
edit it before committing.=20

Thank you
