Received: from eggs.gnu.org ([2001:4830:134:3::10]:39028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1faxIl-0007E4-Lm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1faxIk-0006oG-Pi
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:59:35 -0400
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 5 Jul 2018 07:59:32 +0200
Message-ID: <CABLmASFE-6shE8ggdiBBfqPMhy8Za6URoiAxBzVfiyk4TrcPnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-3.1 0/7] target/ppc fp
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

Hi,

qemu-system-ppc has an issue after building from the 3.1 branch. Mac
OS 9 hangs at the grey boot screen, OSX 10.3 hangs after verbose boot,
just before entering the graphical desktop.

Command line to reproduce:

qemu-system-ppc -L pc-bios -boot c -M mac99,via=pmu -m 512 -prom-env
'auto-boot?=true' -prom-env 'boot-args=-v' -prom-env 'vga-ndrv?=true'
-drive file=MacOS9.2.img,format=raw,media=disk -netdev
user,id=network01 -device sungem,netdev=network01

I bisected to this commit:

cdee6bed3e2ed60f039fb84f63c5dc5f4af4619c is the first bad commit
commit cdee6bed3e2ed60f039fb84f63c5dc5f4af4619c
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Tue Jul 3 08:17:32 2018 -0700

    target/ppc: Use non-arithmetic conversions for fp load/store

    Memory operations have no side effects on fp state.
    The use of a "real" conversions between float64 and float32
    would raise exceptions for SNaN and out-of-range inputs.

    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

:040000 040000 d61b35b777c3ac2f28980a98fc83b8dfdce11bba
ec7c15afcef93cc469c5ee0a2bfda293ba745dc3 M    target

Thanks for looking into it.

Best regards,
Howard
