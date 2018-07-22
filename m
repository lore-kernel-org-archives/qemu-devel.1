Received: from eggs.gnu.org ([2001:4830:134:3::10]:46053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1fhLGG-0001jg-Dm
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 16:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1fhLGF-0003XH-Lk
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 16:47:24 -0400
MIME-Version: 1.0
References: <CAHmME9q8b0Nss8b7DEoGgqoCK4dEvasQN64QWx6Hio+N92wuSg@mail.gmail.com>
	<CAHmME9qX22YP9qrHErc43Z+LUi=ichqzG+OdXqjhJv4ZrKDmWQ@mail.gmail.com>
In-Reply-To: <CAHmME9qX22YP9qrHErc43Z+LUi=ichqzG+OdXqjhJv4ZrKDmWQ@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 22 Jul 2018 22:47:06 +0200
Message-ID: <CAHmME9qMASSt2K4vACJTMiGNTt09upRhNFxL_y2KF1G3N1LB2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ARM64 STR Instruction Crash Regression in TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hello,

Gcc 7.3 compiles bash's array_flush's dual assignment using:

STP             X20, X20, [X20,#0x10]

But gcc 8.1 compiles it as:

STR             Q0, [X20,#0x10]

Real processors seem okay, and qemu 2.11 seems okay. But qemu 2.12
results in a segfaulting process. I'm pretty sure this is a TCG bug.

In the attached tarball, please find kernel and run.sh. Calling
./run.sh will start the kernel with the bad bash executable that tries
to execute `config=({1..100000})` and crashes. Also included in there
is the actual crashing bash binary, in case you'd like to disassemble
a little bit.

This is affecting builds on https://www.wireguard.com/build-status/ --
as you can see, at the moment aarch64 is failing.

Regards,
Jason

[ attachment: https://data.zx2c4.com/bash-qemu-arm64-crash.tar.xz ]
