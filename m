Received: from eggs.gnu.org ([209.51.188.92]:46008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBJhQ-0007MN-JZ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBJhO-0006zW-PE
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:43:35 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33588 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hBJhO-0006wZ-70
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:43:34 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Tue,  2 Apr 2019 15:43:20 +0200
Message-Id: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 0/5] target/mips: Fix support for MSA
 instructions on a big endian host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Fix support for MSA instructions while executing QEMU on a
machine that uses big endian MIPS CPU. This is achieved by
changing the implementation of helpers for MSA instructions
ST.<B|H|W|D>, LD.<B|H|W|D>, INSERT.<B|H|W> (and D on MIPS64),
COPY_S.<B|H|W> (and D on MIPS64) and COPY_U.<B|H> (and W
on MIPS64). Instead of using a switch in a helper, which is
called many times, put a switch in translate.c file, which
is called only a few times and change the value of the
index if a host is a big endian machine.

v4:
 - Change the alignment, so it looks cleaner.
 - Change the commit messages and cover letter, so they
   are more understandable.

v3:
 - Unroll loops in ST.<B|H|W|D> and LD.<B|H|W|D>
   instructions.
 - Eliminate macro that generates the helpers for
   the ST.<B|H|W|D> and LD.<B|H|W|D> instructions,
   and add four helpers for each (for byte,
   halfword, word and doubleword).
 - Eliminate the helpers for INSERT.<B|H|W|D>,
   COPY_S.<B|H|W|D> and COPY_U.<B|H|W> and add
   four (three in case of COPY_U) helpers for
   each one.

v2:
 - Eliminate unreachable code in COPY_U.<B|H|W>
 - Add preprocessing conditionals (if host is MIPS64, check that case)
   in COPY_U.<B|H|W>, INSERT.<B|H|W|D>.

Mateja Marjanovic (5):
  target/mips: Fix MSA instructions LD.<B|H|W|D> on big endian host
  target/mips: Fix MSA instructions ST.<B|H|W|D> on big endian host
  target/mips: Refactor and fix COPY_S.<B|H|W|D> instructions
  target/mips: Refactor and fix COPY_U.<B|H|W> instructions
  target/mips: Refactor and fix INSERT.<B|H|W|D> instructions

 target/mips/helper.h     |  16 +-
 target/mips/msa_helper.c | 182 ++++++++++++++++-------
 target/mips/op_helper.c  | 376 ++++++++++++++++++++++++++++++++++++++++++-----
 target/mips/translate.c  |  59 +++++++-
 4 files changed, 533 insertions(+), 100 deletions(-)

-- 
2.7.4
