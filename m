Received: from eggs.gnu.org ([2001:4830:134:3::10]:38652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTxYc-0008TE-4m
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 17:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTxYZ-0006q2-2m
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 17:46:30 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dTxYY-0006ik-RA
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 17:46:27 -0400
Received: by mail-wr0-f175.google.com with SMTP id k67so90106331wrc.2
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 14:46:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149954874338.15421.5827897782818416258.malonedeb@wampee.canonical.com>
References: <149954874338.15421.5827897782818416258.malonedeb@wampee.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Jul 2017 22:44:42 +0100
Message-ID: <CAFEAcA-6wX4CcALpNkf7dZh=YqWhx1=ox1ihQULiW42NAFZpfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1703147] [NEW] Xfer:features:read truncating
 xml sent to gdb frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1703147 <1703147@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 July 2017 at 22:19, Duane Voth <duanev@gmail.com> wrote:
> Around line 1326 in gdbstub.c:
>
>             if (len > (MAX_PACKET_LENGTH - 5) / 2)
>                 len = (MAX_PACKET_LENGTH - 5) / 2;
>
> is truncating processor reg description xml files longer than 2045
> bytes.  Deleting these lines works for my immediate need, but they seem
> to be trying to fix some buffer overrun condition so I won't offer a
> patch until we understand their purpose.

Those lines prevent the packet we're constructing overrunning
the buf[] array (in the worst case the packet encoding could
use 2 bytes of buffer for every byte of payload). It's probably
working for you without them because (a) the XML payload doesn't
come near the worst-case and (b) buf[] is followed on the stack
by mem_buf[] which happens to be unused here so overrunning into
it has no visible harmful effects.

Truncating the XML is clearly not what we want though so we
should do something more intelligent...

thanks
-- PMM
