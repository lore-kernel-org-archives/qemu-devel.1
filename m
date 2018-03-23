Received: from eggs.gnu.org ([2001:4830:134:3::10]:47332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ezMZV-0001Cg-W8
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ezMZT-0006Pj-Hr
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:17:29 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:40258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ezMZT-0006PJ-AQ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:17:27 -0400
Received: by mail-lf0-x244.google.com with SMTP id e5-v6so18265445lfb.7
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 06:17:27 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 23 Mar 2018 06:17:15 -0700
Message-Id: <20180323131715.29739-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: fix timers test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>

Change frequency of the core used in tests so that clock cycle takes
exactly 64ns. Change icount power used in tests to 6, so that each
instruction takes exactly 1 clock cycle. With these changes the
assumptions of the xtensa timers test are correct and the test must
always pass.

Longer story:
  http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04326.html

Cc: Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/core-dc232b.c | 2 +-
 tests/tcg/xtensa/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
index aa07018af4e7..8846336f5cfa 100644
--- a/target/xtensa/core-dc232b.c
+++ b/target/xtensa/core-dc232b.c
@@ -47,7 +47,7 @@ static XtensaConfig dc232b __attribute__((unused)) = {
         }
     },
     .isa_internal = &xtensa_modules,
-    .clock_freq_khz = 10000,
+    .clock_freq_khz = 15625,
     DEFAULT_SECTIONS
 };
 
diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index 2882c431e4a9..091518c05583 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -5,7 +5,7 @@ CROSS=xtensa-$(CORE)-elf-
 
 ifndef XT
 SIM = ../../../xtensa-softmmu/qemu-system-xtensa
-SIMFLAGS = -M sim -cpu $(CORE) -nographic -semihosting -icount 7 $(EXTFLAGS) -kernel
+SIMFLAGS = -M sim -cpu $(CORE) -nographic -semihosting -icount 6 $(EXTFLAGS) -kernel
 SIMDEBUG = -s -S
 else
 SIM = xt-run
-- 
2.11.0
