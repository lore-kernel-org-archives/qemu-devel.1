Received: from eggs.gnu.org ([2001:4830:134:3::10]:34140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edgNO-0006XZ-L4
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edgNN-0005a7-Oq
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:59:22 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:37789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edgNN-0005Zi-Jn
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:59:21 -0500
Received: by mail-oi0-x22d.google.com with SMTP id t78so2088985oih.4
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 09:59:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.1801222034370.13989@monopod.intra.ispras.ru>
References: <alpine.LNX.2.20.13.1801222034370.13989@monopod.intra.ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 17:59:00 +0000
Message-ID: <CAFEAcA9_a9wAdgmW_Ttc53hG8S2cJPu3Jw4noKtOAjzAJa9kUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [GSoC?] Board autoconfiguration based on DTB info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>

On 22 January 2018 at 17:52, Alexander Monakov <amonakov@ispras.ru> wrote:
> Is it feasible to consume a DTB file in Qemu itself to make the board match the
> DeviceTree hardware description? For example on Arm there are quite a few .dts
> files in Linux tree for various boards; having a "generic" Arm board in Qemu that
> could [to what degree?] emulate any of those sounds attractive in theory.

This is an idea that people have suggested before, and it's certainly
an attractive theory, but unfortunately it doesn't work. The dtb files
contain enough information about the hardware to allow an OS (and in
particular Linux) to boot, but they don't include enough information
in all cases to allow QEMU to create the hardware in the correct way.

(There are some specialized situations where you can do it, for
instance if you're an SoC manufacturer and you're creating both
hardware and DTB and QEMU model yourself you can ensure that they're
all consistent and generated from the same original information and
the DTB has all the info QEMU needs in it; but we can't do it upstream
in the general case.)

Also, the main reason we don't have support for a wider range of Arm
boards is that all the devices are different -- it's no good being
able to read a dtb file that says there is a "mediatek,mt6797-uart" at
a particular address if we don't actually have a model of that UART.
Once you have all the device models, wiring up the SoC and board
level code in QEMU isn't really all that difficult (though we could
probably manage to make it a bit less boiler-platy).

thanks
-- PMM
