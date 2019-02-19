Received: from eggs.gnu.org ([209.51.188.92]:49442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydS-0005Bx-HX
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydR-00073L-Tm
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:06 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:38870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydR-000731-M4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:05 -0500
Received: by mail-lj1-x22a.google.com with SMTP id j19so15591480ljg.5
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:05 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:53 -0800
Message-Id: <20190219061111.10231-6-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 05/23] tests/tcg/xtensa: don't use optional
 opcodes in generic code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Don't use 'loop' opcode in generic testsuite completion code, only use
core opcodes to make it work with any configuration.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/macros.inc | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/xtensa/macros.inc b/tests/tcg/xtensa/macros.inc
index 25c7ee479e6c..93825dc7b513 100644
--- a/tests/tcg/xtensa/macros.inc
+++ b/tests/tcg/xtensa/macros.inc
@@ -23,11 +23,14 @@ main:
     movi    a0, result
     sub     a2, a2, a0
     movi    a3, 0
-    loopnez a2, 1f
-    l8ui    a2, a0, 0
-    or      a3, a3, a2
-    addi    a0, a0, 1
+    beqz    a2, 2f
 1:
+    l8ui    a1, a0, 0
+    or      a3, a3, a1
+    addi    a0, a0, 1
+    addi    a2, a2, -1
+    bnez    a2, 1b
+2:
     exit
 .endm
 
-- 
2.11.0
