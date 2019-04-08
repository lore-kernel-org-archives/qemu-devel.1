Received: from eggs.gnu.org ([209.51.188.92]:47351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKF-0003jm-26
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKD-0007Xk-45
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:06 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:39369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKA-0007RW-6b
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:03 -0400
Received: by mail-it1-x143.google.com with SMTP id 139so1440509ita.4
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:56:59 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  8 Apr 2019 16:55:43 -0400
Message-Id: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement missing
 AMD pflash functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>

The goal of this patch series implement the following AMD command-set parallel
flash functionality:
- flash interleaving;
- nonuniform sector sizes;
- erase suspend/resume commands; and
- multi-sector erase.

During refactoring and implementation, I discovered several bugs that are
fixed here as well:
- flash commands use only 11-bits of the address in most cases, but the
  current code uses all of them [1];
- entering CFI mode from autoselect mode and then exiting CFI mode should
  return the chip to autoselect mode, but the current code returns to read
  array mode; and
- reset command should be ignored during sector/chip erase, but the current
  code performs the reset.

The first patch in the series adds a test for the existing behavior. Tests for
additional behavior/bug fixes are added in the relevant patch.

1. I found firmware in the wild that relies on the 11-bit address behavior,
   probably due to a bug in the firmware itself.

Stephen Checkoway (10):
  block/pflash_cfi02: Add test for supported commands
  block/pflash_cfi02: Refactor, NFC intended
  block/pflash_cfi02: Fix command address comparison
  block/pflash_cfi02: Implement intereleaved flash devices
  block/pflash_cfi02: Implement nonuniform sector sizes
  block/pflash_cfi02: Fix CFI in autoselect mode
  block/pflash_cfi02: Fix reset command not ignored during erase
  block/pflash_cfi02: Implement multi-sector erase
  block/pflash_cfi02: Implement erase suspend/resume
  block/pflash_cfi02: Use the chip erase time specified in the CFI table

 hw/block/pflash_cfi02.c   | 843 +++++++++++++++++++++++++++-----------
 tests/Makefile.include    |   2 +
 tests/pflash-cfi02-test.c | 757 ++++++++++++++++++++++++++++++++++
 3 files changed, 1367 insertions(+), 235 deletions(-)
 create mode 100644 tests/pflash-cfi02-test.c

-- 
2.20.1 (Apple Git-117)
