Received: from eggs.gnu.org ([2001:4830:134:3::10]:52138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPXFN-0001Yi-U5
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPXFN-0000G6-12
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:20:05 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:33743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPXFM-0000Fu-Sd
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:20:04 -0500
Received: by mail-ua0-x22d.google.com with SMTP id i68so305870083uad.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 08:20:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <37C57425-158F-4544-89EF-CC8053476EB6@gmail.com>
References: <84C57F4C-C8F8-4FB3-804A-FC3DE0AB6408@gmail.com>
	<CAFEAcA_hY+x3c0BUmURubq6qS-e1bDSUm0fE87=G8acrf-tcuA@mail.gmail.com>
	<37C57425-158F-4544-89EF-CC8053476EB6@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 16:19:43 +0000
Message-ID: <CAFEAcA_pNp39dUxG4ZLGJgsApEpKXB_cf9vmUpH1Gva=pnH1yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 6 January 2017 at 15:44, Programmingkid <programmingkidx@gmail.com> wrote:
>
> On Jan 6, 2017, at 8:48 AM, Peter Maydell wrote:
>
>> On 1 January 2017 at 21:31, Programmingkid <programmingkidx@gmail.com> wrote:
>>> The mouse down event should not be sent to the guest if the mouse down event
>>> causes QEMU to move the foreground from the background. This patch prevents
>>> these activation clicks from going to the guest.

>>>     if (mouse_event) {
>>>         /* Don't send button events to the guest unless we've got a
>>> -         * mouse grab or window focus. If we have neither then this event
>>> -         * is the user clicking on the background window to activate and
>>> -         * bring us to the front, which will be done by the sendEvent
>>> -         * call below. We definitely don't want to pass that click through
>>> -         * to the guest.
>>> +         * mouse grab, window focus, or in fullscreen mode. If we have neither
>>> +         * then this event is the user clicking on the background window to
>>> +         * activate and bring us to the front, which will be done by the
>>> +         * sendEvent call below. We definitely don't want to pass that click
>>> +         * through to the guest.
>>>          */
>>> -        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
>>> +        if (isMouseGrabbed && ([[self window] isKeyWindow] || isFullscreen) &&
>>>             (last_buttons != buttons)) {
>>>             static uint32_t bmap[INPUT_BUTTON__MAX] = {
>>>                 [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
>>
>> Comment doesn't match code. The comment says "mouse grab, full screen
>> or focus", but the code is doing "mouse grab and (full screen or focus)".
>>
>> Which is correct?
>
>
> This sounds more accurate:
>
> (mouse grab and main window is the front window) or QEMU is in fullscreen.

That's not what your code does either.

What is the actual situation which we currently get wrong and need
to get right? Your commit message says "if the event causes QEMU
to move to the foreground", but my expectation was that if we
weren't in the foreground then we would not have the mouse grabbed,
and in any case your patch adds a check on isFullscreen but your
commit message doesn't say anything about full-screen or not being
relevant to the problem.

thanks
-- PMM
