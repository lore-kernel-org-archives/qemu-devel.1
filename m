Received: from eggs.gnu.org ([2001:4830:134:3::10]:60078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlGkR-000120-7D
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlGkQ-0005bd-8L
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:42:15 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlGkQ-0005bM-1N
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:42:14 -0400
Received: by mail-wr0-x235.google.com with SMTP id p14so515432wrg.3
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 08:42:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150366905912.16996.8020711454083281212.malonedeb@gac.canonical.com>
References: <150366905912.16996.8020711454083281212.malonedeb@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 16:41:52 +0100
Message-ID: <CAFEAcA9kwrQRmLc2aGn47=Z4StpqUU=-mktD28yvC3iTT_Z7NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1713066] [NEW] Incorrect handling of aarch64
 ldp in some cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1713066 <1713066@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 August 2017 at 14:50, Andrew <andrew@fubar.geek.nz> wrote:
> Given the following instruction:
> ldp x0, x1, [x0]
>
> This will load two 64 bit values from memory, however if each location
> to load is on a different page and the second page is unmapped this will
> raise an exception. When this happens x0 has already been updated

Yes, this is a QEMU bug. disas_ldst_pair() should not let the
first load go directly to the target integer register but instead
postpone updating the register until after the second load.
We can safely do this only for the integer load case because
float/vector registers can't be used in address generation so
they're OK to become UNKNOWN.
(D1.14.5 is about interrupts and exceptions that happen during
a multiple-register load or store; for straightforward synchronous
data aborts D1.13.4 is what you want, but the requirements are the
same in any case.)

We got this right for the load/store exclusive pair, so it's only
the plain load pair that needs fixing I think.

thanks
-- PMM
