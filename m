Received: from eggs.gnu.org ([2001:4830:134:3::10]:40508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZhzm-0005q7-9f
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZhzl-0005Qy-D2
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:26:50 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZhzl-0005QJ-7m
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:26:49 -0400
Received: by mail-ot0-x242.google.com with SMTP id w22-v6so15202401otk.5
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 12:26:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180608200150.7032-1-programmingkidx@gmail.com>
References: <20180608200150.7032-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Jul 2018 20:26:28 +0100
Message-ID: <CAFEAcA94hE1h8cRCaGWW8id+ZNZs2N8ZJ+yjeJoZn6czePYxjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: fix absolute mode
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

On 8 June 2018 at 21:01, John Arbuckle <programmingkidx@gmail.com> wrote:
> Fix the cocoa front-end to correctly be able to use absolute mode.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

>          case NSEventTypeMouseMoved:
>              if (isAbsoluteEnabled) {
> -                if (![self screenContainsPoint:p] || ![[self window] isKeyWindow]) {
> +                if ([self mouseInWindow]) {
> +                    mouse_event = true;
> +                }
> +
> +                if (![self mouseInWindow] || ![[self window] isKeyWindow]) {
>                      if (isMouseGrabbed) {
>                          [self ungrabMouse];
>                      }
>                  } else {
> -                    if (!isMouseGrabbed) {
> +                    if (!isMouseGrabbed && [self mouseInWindow]) {
>                          [self grabMouse];
>                      }

We may well not need this part of the patch, but:
this change of condition from "!isMouseGrabbed" to
"!isMouseGrabbed && [self mouseInWindow]" is unnecessary.
This code is inside the "else" block for the preceding
"if (![self mouseInWindow] || ![[self window] isKeyWindow])",
so it is not possible to reach it if "[self mouseInWindow]"
returns false.

thanks
-- PMM
