Received: from eggs.gnu.org ([2001:4830:134:3::10]:44821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPUsy-0007K0-KR
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPUsx-0006GG-HE
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:48:48 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:34842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPUsx-0006G3-D2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:48:47 -0500
Received: by mail-ua0-x231.google.com with SMTP id y9so75968971uae.2
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 05:48:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <84C57F4C-C8F8-4FB3-804A-FC3DE0AB6408@gmail.com>
References: <84C57F4C-C8F8-4FB3-804A-FC3DE0AB6408@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 13:48:26 +0000
Message-ID: <CAFEAcA_hY+x3c0BUmURubq6qS-e1bDSUm0fE87=G8acrf-tcuA@mail.gmail.com>
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

On 1 January 2017 at 21:31, Programmingkid <programmingkidx@gmail.com> wrote:
> The mouse down event should not be sent to the guest if the mouse down event
> causes QEMU to move the foreground from the background. This patch prevents
> these activation clicks from going to the guest.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v2 changes:
> Fix a bug that caused fullscreen mode not to receive mouse events.
>
>  ui/cocoa.m | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 26d4a1c..ae3f5a1 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -695,13 +695,13 @@ QemuCocoaView *cocoaView;
>
>      if (mouse_event) {
>          /* Don't send button events to the guest unless we've got a
> -         * mouse grab or window focus. If we have neither then this event
> -         * is the user clicking on the background window to activate and
> -         * bring us to the front, which will be done by the sendEvent
> -         * call below. We definitely don't want to pass that click through
> -         * to the guest.
> +         * mouse grab, window focus, or in fullscreen mode. If we have neither
> +         * then this event is the user clicking on the background window to
> +         * activate and bring us to the front, which will be done by the
> +         * sendEvent call below. We definitely don't want to pass that click
> +         * through to the guest.
>           */
> -        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
> +        if (isMouseGrabbed && ([[self window] isKeyWindow] || isFullscreen) &&
>              (last_buttons != buttons)) {
>              static uint32_t bmap[INPUT_BUTTON__MAX] = {
>                  [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,

Comment doesn't match code. The comment says "mouse grab, full screen
or focus", but the code is doing "mouse grab and (full screen or focus)".

Which is correct?

thanks
-- PMM
