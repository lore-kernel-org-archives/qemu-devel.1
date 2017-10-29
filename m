Received: from eggs.gnu.org ([2001:4830:134:3::10]:58605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e8uLv-00044h-UV
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 16:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e8uLv-0004nt-0R
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 16:38:39 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e8uLq-0004iu-By
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 16:38:38 -0400
Received: by mail-wm0-x242.google.com with SMTP id s66so11977585wmf.5
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 13:38:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150930506825.20259.326196094575831329.malonedeb@soybean.canonical.com>
References: <150930506825.20259.326196094575831329.malonedeb@soybean.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 29 Oct 2017 20:38:12 +0000
Message-ID: <CAFEAcA_Zvi4jLUaXPAekt0d4Gpbg5B8=r4OgRbhkrKXAvvhjfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1728448] [NEW] qemu-system-arm segmentation
 fault with cpu cortex-m*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1728448 <1728448@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 October 2017 at 19:24, Kevin <1728448@bugs.launchpad.net> wrote:
> I try to run an emulation with qemu-system-arm under a cpu cortex-m3 but
> any execution under the processor result by a segmentation fault.
>
> My command is : qemu-system-arm -m 256 -M versatilepb -cpu cortex-m3
> -kernel ~/qemu/wheezy/vmlinuz-3.2.0-4-versatile -initrd
> ~/qemu/wheezy/initrd.img-3.2.0-4-versatile -hda ~/qemu/wheezy/hda.img
> -append 'root=/dev/sda1'

This command line is never going to work, for multiple reasons.
Unfortunately QEMU currently doesn't do a good job of identifying
option combinations which we know are wrong (like -cpu cortex-m3
with -M versatilepb) and printing an error message.

The major problem here is that the cortex-m3 is a microcontroller,
which is significantly different from the 'A-profile' devices
that Linux runs on. It has no MMU and usually 16MB of RAM or less:
why are you trying to run Linux on it? This will never work.

Secondly, the "versatilepb" board is not a board which you can
use a Cortex-M3 with -- it's only intended to work with certain
CPUs, mainly the arm926.

Thirdly, that looks like a prebuilt versatile kernel image -- it
probably won't work with a random CPU that's not the one the
versatile has, and it *definitely* won't work with the M3.

Basic rule of thumb for QEMU ARM boards -- don't try to specify
"-cpu" unless you have documentation that specifically tells you
to. You're much more likely to create something that's just
a broken config that guest software can't handle. This is
always true for the Cortex-M3 -- unless the board is intended
to work with the M3 and is creating the correct interrupt
controller, you'll just end up with a broken model.

If you need to use the Cortex-M3 then use one of the boards
which works with it -- lm3s6965evb, lm3s811evb, mps2-an385,
mps2-an511, or netduino2. You'll also need to run guest code
which is actually built for the board you're using and for
the Cortex-M3 (likely some kind of RTOS, or bare metal code.)
The MPS2 boards have the most RAM, but they're only in recent
QEMU versions.

thanks
-- PMM
