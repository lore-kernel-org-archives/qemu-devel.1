Received: from eggs.gnu.org ([2001:4830:134:3::10]:33680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fvvQH-0006ay-1O
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 22:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fvvQF-0002i6-CY
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 22:14:00 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fvvQF-0002fc-3y
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 22:13:59 -0400
Received: by mail-lf1-x144.google.com with SMTP id m26-v6so11353237lfb.0
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 19:13:56 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 31 Aug 2018 19:13:40 -0700
Message-Id: <20180901021341.18066-2-jcmvbkbc@gmail.com>
In-Reply-To: <20180901021341.18066-1-jcmvbkbc@gmail.com>
References: <20180901021341.18066-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] tests/tcg/xtensa: move exception handlers
 to separate section
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

Not all CPU configurations may have enough space for handler code
between exception/interrupt vectors. Leave jumps to the handlers at the
vectors, but move all handlers past the vectors area.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/linker.ld.S | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/tests/tcg/xtensa/linker.ld.S b/tests/tcg/xtensa/linker.ld.S
index 5902302cf8fd..d0f33157ca9e 100644
--- a/tests/tcg/xtensa/linker.ld.S
+++ b/tests/tcg/xtensa/linker.ld.S
@@ -24,64 +24,71 @@ SECTIONS
 
     .vector :
     {
+#if XCHAL_HAVE_WINDOWED
     . = XCHAL_WINDOW_OF4_VECOFS;
         *(.vector.window_overflow_4)
-        *(.vector.window_overflow_4.*)
     . = XCHAL_WINDOW_UF4_VECOFS;
         *(.vector.window_underflow_4)
-        *(.vector.window_underflow_4.*)
     . = XCHAL_WINDOW_OF8_VECOFS;
         *(.vector.window_overflow_8)
-        *(.vector.window_overflow_8.*)
     . = XCHAL_WINDOW_UF8_VECOFS;
         *(.vector.window_underflow_8)
-        *(.vector.window_underflow_8.*)
     . = XCHAL_WINDOW_OF12_VECOFS;
         *(.vector.window_overflow_12)
-        *(.vector.window_overflow_12.*)
     . = XCHAL_WINDOW_UF12_VECOFS;
         *(.vector.window_underflow_12)
-        *(.vector.window_underflow_12.*)
-
+#endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 2
     . = XCHAL_INTLEVEL2_VECOFS;
         *(.vector.level2)
-        *(.vector.level2.*)
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 3
     . = XCHAL_INTLEVEL3_VECOFS;
         *(.vector.level3)
-        *(.vector.level3.*)
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 4
     . = XCHAL_INTLEVEL4_VECOFS;
         *(.vector.level4)
-        *(.vector.level4.*)
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 5
     . = XCHAL_INTLEVEL5_VECOFS;
         *(.vector.level5)
-        *(.vector.level5.*)
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 6
     . = XCHAL_INTLEVEL6_VECOFS;
         *(.vector.level6)
-        *(.vector.level6.*)
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 7
     . = XCHAL_INTLEVEL7_VECOFS;
         *(.vector.level7)
-        *(.vector.level7.*)
 #endif
 
     . = XCHAL_KERNEL_VECOFS;
         *(.vector.kernel)
-        *(.vector.kernel.*)
     . = XCHAL_USER_VECOFS;
         *(.vector.user)
-        *(.vector.user.*)
     . = XCHAL_DOUBLEEXC_VECOFS;
         *(.vector.double)
+    } > ram
+
+    .vector.text :
+    {
+        *(.vector.window_overflow_4.*)
+        *(.vector.window_underflow_4.*)
+        *(.vector.window_overflow_8.*)
+        *(.vector.window_underflow_8.*)
+        *(.vector.window_overflow_12.*)
+        *(.vector.window_underflow_12.*)
+
+        *(.vector.level2.*)
+        *(.vector.level3.*)
+        *(.vector.level4.*)
+        *(.vector.level5.*)
+        *(.vector.level6.*)
+        *(.vector.level7.*)
+
+        *(.vector.kernel.*)
+        *(.vector.user.*)
         *(.vector.double.*)
     } > ram
 
-- 
2.11.0
