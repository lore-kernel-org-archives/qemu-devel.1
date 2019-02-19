Received: from eggs.gnu.org ([209.51.188.92]:49419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydQ-0005AS-BM
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydO-00072F-Ua
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:04 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydO-00070z-Mc
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:02 -0500
Received: by mail-lf1-x141.google.com with SMTP id u21so14052510lfu.1
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:01 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:51 -0800
Message-Id: <20190219061111.10231-4-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 03/23] tests/tcg/xtensa: support configurations
 w/o vecbase
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

Configurations w/o vecbase may have vectors not grouped together and not
in fixed order. They may not always be grouped into single output
sections by assigning next offset to dot, as it may sometimes move dot
backwards and sometimes they may even belong to different memory region.
Don't group vectors into single output section. Instead put each vector
into its own section ant put it at its default virtual address.
Reserve 4KBytes from the default vectors base and put rest of the code
and data starting from there. Mark vectors sections as executable,
otherwise their contents is discarded. There may be as little as 16
bytes reserved for some vectors, load handler address into a0 and use
ret.n to jump there to make vector code fit into this 16 byte space.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile    |  4 ++-
 tests/tcg/xtensa/linker.ld.S | 67 +++++++++++++++++++++++++++++++-------------
 tests/tcg/xtensa/vectors.S   | 14 +++++++--
 3 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index 2f5691f75b09..cd21c202876a 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -18,6 +18,8 @@ CC      = $(CROSS)gcc
 AS      = $(CROSS)gcc -x assembler-with-cpp
 LD      = $(CROSS)ld
 
+vectors_ASFLAGS = -mtext-section-literals
+
 XTENSA_SRC_PATH = $(SRC_PATH)/tests/tcg/xtensa
 INCLUDE_DIRS = $(XTENSA_SRC_PATH) $(SRC_PATH)/target/xtensa/core-$(CORE)
 XTENSA_INC = $(addprefix -I,$(INCLUDE_DIRS))
@@ -68,7 +70,7 @@ linker.ld: $(XTENSA_SRC_PATH)/linker.ld.S
 	$(CC) $(XTENSA_INC) $(CFLAGS) -c $< -o $@
 
 %.o: $(XTENSA_SRC_PATH)/%.S
-	$(CC) $(XTENSA_INC) $(ASFLAGS) -c $< -o $@
+	$(CC) $(XTENSA_INC) $($*_ASFLAGS) $(ASFLAGS) -c $< -o $@
 
 %.tst: %.o linker.ld $(XTENSA_SRC_PATH)/macros.inc $(CRT) Makefile
 	$(LD) $(LDFLAGS) $(NOSTDFLAGS) $(CRT) $< -o $@
diff --git a/tests/tcg/xtensa/linker.ld.S b/tests/tcg/xtensa/linker.ld.S
index d0f33157ca9e..ac89b0054ee4 100644
--- a/tests/tcg/xtensa/linker.ld.S
+++ b/tests/tcg/xtensa/linker.ld.S
@@ -1,17 +1,29 @@
 #include "core-isa.h"
 
-#if XTENSA_HAVE_BE
+#ifndef XCHAL_VECBASE_RESET_VADDR
+#define XCHAL_VECBASE_RESET_VADDR XCHAL_WINDOW_VECTORS_VADDR
+#define XCHAL_WINDOW_OF4_VECOFS   0x00000000
+#define XCHAL_WINDOW_UF4_VECOFS   0x00000040
+#define XCHAL_WINDOW_OF8_VECOFS   0x00000080
+#define XCHAL_WINDOW_UF8_VECOFS   0x000000C0
+#define XCHAL_WINDOW_OF12_VECOFS  0x00000100
+#define XCHAL_WINDOW_UF12_VECOFS  0x00000140
+#endif
+
+#define RAM_SIZE 0x08000000  /* 128M */
+#define ROM_SIZE 0x00001000  /* 4k */
+#define VECTORS_RESERVED_SIZE 0x1000
+
+#if XCHAL_HAVE_BE
 OUTPUT_FORMAT("elf32-xtensa-be")
 #else
 OUTPUT_FORMAT("elf32-xtensa-le")
 #endif
 ENTRY(_start)
 
-__DYNAMIC = 0;
-
 MEMORY {
-    ram : ORIGIN = XCHAL_VECBASE_RESET_VADDR, LENGTH = 0x08000000  /* 128M */
-    rom : ORIGIN = XCHAL_RESET_VECTOR_VADDR, LENGTH = 0x00001000  /* 4k */
+    ram : ORIGIN = XCHAL_VECBASE_RESET_VADDR, LENGTH = RAM_SIZE
+    rom : ORIGIN = XCHAL_RESET_VECTOR_VADDR, LENGTH = ROM_SIZE
 }
 
 SECTIONS
@@ -22,9 +34,9 @@ SECTIONS
         *(.init.*)
     } > rom
 
-    .vector :
-    {
 #if XCHAL_HAVE_WINDOWED
+    .vector.window XCHAL_WINDOW_VECTORS_VADDR :
+    {
     . = XCHAL_WINDOW_OF4_VECOFS;
         *(.vector.window_overflow_4)
     . = XCHAL_WINDOW_UF4_VECOFS;
@@ -37,41 +49,58 @@ SECTIONS
         *(.vector.window_overflow_12)
     . = XCHAL_WINDOW_UF12_VECOFS;
         *(.vector.window_underflow_12)
+    }
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 2
-    . = XCHAL_INTLEVEL2_VECOFS;
+    .vector.level2 XCHAL_INTLEVEL2_VECTOR_VADDR :
+    {
         *(.vector.level2)
+    }
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 3
-    . = XCHAL_INTLEVEL3_VECOFS;
+    .vector.level3 XCHAL_INTLEVEL3_VECTOR_VADDR :
+    {
         *(.vector.level3)
+    }
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 4
-    . = XCHAL_INTLEVEL4_VECOFS;
+    .vector.level4 XCHAL_INTLEVEL4_VECTOR_VADDR :
+    {
         *(.vector.level4)
+    }
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 5
-    . = XCHAL_INTLEVEL5_VECOFS;
+    .vector.level5 XCHAL_INTLEVEL5_VECTOR_VADDR :
+    {
         *(.vector.level5)
+    }
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 6
-    . = XCHAL_INTLEVEL6_VECOFS;
+    .vector.level6 XCHAL_INTLEVEL6_VECTOR_VADDR :
+    {
         *(.vector.level6)
+    }
 #endif
 #if XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI >= 7
-    . = XCHAL_INTLEVEL7_VECOFS;
+    .vector.level7 XCHAL_INTLEVEL7_VECTOR_VADDR :
+    {
         *(.vector.level7)
+    }
 #endif
-
-    . = XCHAL_KERNEL_VECOFS;
+    .vector.kernel XCHAL_KERNEL_VECTOR_VADDR :
+    {
         *(.vector.kernel)
-    . = XCHAL_USER_VECOFS;
+    }
+    .vector.user XCHAL_USER_VECTOR_VADDR :
+    {
         *(.vector.user)
-    . = XCHAL_DOUBLEEXC_VECOFS;
+    }
+    .vector.double XCHAL_DOUBLEEXC_VECTOR_VADDR :
+    {
         *(.vector.double)
-    } > ram
+    }
 
-    .vector.text :
+    .vector.text XCHAL_VECBASE_RESET_VADDR + VECTORS_RESERVED_SIZE :
     {
         *(.vector.window_overflow_4.*)
         *(.vector.window_underflow_4.*)
diff --git a/tests/tcg/xtensa/vectors.S b/tests/tcg/xtensa/vectors.S
index 6a9cb3cde466..cd48cfb6562c 100644
--- a/tests/tcg/xtensa/vectors.S
+++ b/tests/tcg/xtensa/vectors.S
@@ -2,10 +2,20 @@
 
 .macro vector name
 
-.section .vector.\name
+.section .vector.\name, "ax"
+.global vector_\name
+vector_\name\():
     j       1f
-.section .vector.\name\().text
+    .literal_position
 1:
+    wsr     a0, excsave1
+    movi    a0, 1f
+    ret.n
+
+.section .vector.\name\().text, "ax"
+    .literal_position
+1:
+    rsr     a0, excsave1
     wsr     a2, excsave1
     movi    a2, handler_\name
     l32i    a2, a2, 0
-- 
2.11.0
