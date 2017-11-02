Received: from eggs.gnu.org ([2001:4830:134:3::10]:56457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAJGu-0002RU-Lb
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAJGq-0003Z8-5E
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:27:16 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAJGp-0003Yg-U0
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:27:12 -0400
Received: by mail-wr0-x244.google.com with SMTP id l1so276162wrc.3
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 10:27:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171102171846.21445-1-lyan@suse.com>
References: <20171102171846.21445-1-lyan@suse.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 17:26:50 +0000
Message-ID: <CAFEAcA8JDVKBE1pFssTwFTybT=Kamc+_ra8qRF-DGSpb7=7QZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/display/xenfb: Simulate auto-repeat
 key events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Yan <lyan@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 2 November 2017 at 17:18, Liang Yan <lyan@suse.com> wrote:
> New tigervnc changes the way to send long pressed key,
> from "down up down up ..." to "down down ... up", it only
> affects xen pv console mode. I send a patch to latest
> kernel side, but it may have a fix in qemu backend for
> back compatible becase guest VMs may use very old kernel.
> This patch inserts an up event after each regular key down
> event to simulate an auto-repeat key event for xen keyboard
> frontend driver.
>
> Signed-off-by: Liang Yan <lyan@suse.com>
> ---
> v2:
> - exclude extended key
> - change log comment
>
>  hw/display/xenfb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index 8e2547ac05..1bc5b41ab7 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -292,6 +292,11 @@ static void xenfb_key_event(void *opaque, int scancode)
>      }
>      trace_xenfb_key_event(opaque, scancode2linux[scancode], down);
>      xenfb_send_key(xenfb, down, scancode2linux[scancode]);
> +
> +    /* insert an up event for regular down key event */
> +    if (down && !xenfb->extended) {
> +        xenfb_send_key(xenfb, 0, scancode2linux[scancode]);
> +    }
>  }

This doesn't look to me like the right place to fix this bug.
The xenfb key event handler is just one QEMU keyboard backend
(in a setup where there are many possible sources of keyboard
events: vnc, gtk, SDL, cocoa UI frontends; and many possible
sinks: xenfb's key handling, ps2 keyboard emulator, etc etc).

We need to be clear in our definition of generic QEMU key
events how key repeat is supposed to be handled, and then
every consumer and every producer needs to follow that.
In the specific case of the vnc UI frontend, we need to
also look at what the VNC protocol specifies for key repeat.
That then tells us whether the bug to be fixed is in QEMU,
or in a particular VNC client.

thanks
-- PMM
