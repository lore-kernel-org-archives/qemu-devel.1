Received: from eggs.gnu.org ([2001:4830:134:3::10]:33683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fvvQH-0006az-23
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 22:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fvvQF-0002ie-V4
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 22:14:00 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fvvQF-0002gu-9l
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 22:13:59 -0400
Received: by mail-lf1-x143.google.com with SMTP id j8-v6so11350634lfb.4
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 19:13:58 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 31 Aug 2018 19:13:41 -0700
Message-Id: <20180901021341.18066-3-jcmvbkbc@gmail.com>
In-Reply-To: <20180901021341.18066-1-jcmvbkbc@gmail.com>
References: <20180901021341.18066-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] tests/tcg/xtensa: only generate defined
 exception handlers
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

Don't generate handlers for IRQ levels that are not defined for the CPU
or for window overflow/underflow exceptions for configs w/o windowed
registers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/vectors.S | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/tcg/xtensa/vectors.S b/tests/tcg/xtensa/vectors.S
index 265a1812399b..6a9cb3cde466 100644
--- a/tests/tcg/xtensa/vectors.S
+++ b/tests/tcg/xtensa/vectors.S
@@ -1,3 +1,5 @@
+#include "core-isa.h"
+
 .macro vector name
 
 .section .vector.\name
@@ -20,19 +22,33 @@ handler_\name\(): .word 0
 
 .endm
 
+#if XCHAL_HAVE_WINDOWED
 vector window_overflow_4
 vector window_overflow_8
 vector window_overflow_12
 vector window_underflow_4
 vector window_underflow_8
 vector window_underflow_12
+#endif
 
+#if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 2
 vector level2
+#endif
+#if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 3
 vector level3
+#endif
+#if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 4
 vector level4
+#endif
+#if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 5
 vector level5
+#endif
+#if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 6
 vector level6
+#endif
+#if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 7
 vector level7
+#endif
 
 vector kernel
 vector user
-- 
2.11.0
