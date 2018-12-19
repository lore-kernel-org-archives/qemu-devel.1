Received: from eggs.gnu.org ([2001:4830:134:3::10]:37148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZgpG-0005at-AI
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZgpF-0001KF-78
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:44:10 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:47066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZgpC-0001G1-Va
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:44:08 -0500
Received: by mail-oi1-x229.google.com with SMTP id x202so2418539oif.13
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 10:44:04 -0800 (PST)
MIME-Version: 1.0
References: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
	<CAFEAcA-PJadBG0sE43N9wEx9Qm3Nxu2am_0Zy2Zqtz66C9SJ-w@mail.gmail.com>
	<ECFBC025-CD7F-444B-BF7F-62E20954A85A@foghorn.io>
In-Reply-To: <ECFBC025-CD7F-444B-BF7F-62E20954A85A@foghorn.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 18:43:51 +0000
Message-ID: <CAFEAcA9M73BdXs345vdqkuQE3sxT+GnS4PWZ2OPO8DWwNtRQ-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben.hekster@foghorn.io
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 19 Dec 2018 at 17:46, Ben Hekster <ben.hekster@foghorn.io> wrote:
> Stack trace of crashing thread:

Thank you.

> 21  AppKit                              0x00007fff3280e99e -[NSWindow setFrame:display:] + 51
> 22  AppKit                              0x00007fff3281932f -[NSWindow setFrame:display:animate:] + 130
> 23  qemu-system-arm                     0x00000001035cb13a -[QemuCocoaView switchSurface:] + 2282
> 24  qemu-system-arm                     0x00000001035d102e cocoa_switch + 94
> 25  qemu-system-arm                     0x00000001035bfa46 dpy_gfx_replace_surface + 278
> 26  qemu-system-arm                     0x00000001035c1721 qemu_console_resize + 209
> 27  qemu-system-arm                     0x000000010310be80 bcm2835_fb_reconfigure + 112

OK, so this is what I suspected we might be doing -- certain functions called
from device emulation (so on the CPU thread) end up calling in to the cocoa
UI DisplayChangeListenerOps callbacks, which at the moment are written
to directly call OSX functions. But only certain guest behaviour (in this
instance a guest resizing the display) causes this, so a lot of guest
use cases will work OK even on Mojave.

> probably a manifestation of https://bugs.launchpad.net/qemu/+bug/1802684

Yep. If you could test the patchset at
http://patchew.org/QEMU/20181201123056.432-1-peter.maydell@linaro.org/
and confirm that it fixes the problem that would be great.

thanks
-- PMM
