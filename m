Received: from eggs.gnu.org ([2001:4830:134:3::10]:49950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBC-0004uz-LF
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWB9-00034v-Df
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:54 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDWB9-00033o-7D
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:51 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue,  1 May 2018 16:22:12 +0200
Message-Id: <20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [RFC PATCH 02/12] tests/tcg/tricore: Add build
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

this includes the Makefile and linker script to build all the tests.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile | 30 +++++++++++++++++++++++
 tests/tcg/tricore/link.ld  | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tests/tcg/tricore/Makefile
 create mode 100644 tests/tcg/tricore/link.ld

diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
new file mode 100644
index 0000000000..8c168d1062
--- /dev/null
+++ b/tests/tcg/tricore/Makefile
@@ -0,0 +1,30 @@
+AS := tricore-as
+LD := tricore-ld
+HOST_CC = gcc
+
+LDFLAGS = -Tlink.ld
+ASFLAGS =
+
+SIM = ../../../tricore-softmmu/qemu-system-tricore
+SIMFLAGS = -M tricore_testboard -nographic -kernel
+
+all: build
+
+%.pS: %.S
+	$(HOST_CC) -E -o $@ $<
+
+%.o: %.pS
+	$(AS) $(ASFLAGS) -o $@ $<
+
+%.tst: %.o link.ld
+	$(LD) $(LDFLAGS) $< -o $@
+
+build: $(TESTCASES)
+
+check: $(addprefix run-, $(TESTCASES))
+
+run-%.tst: %.tst
+	$(SIM) $(SIMFLAGS) ./$<
+
+clean:
+	$(RM) -fr $(TESTCASES) linker.ld
diff --git a/tests/tcg/tricore/link.ld b/tests/tcg/tricore/link.ld
new file mode 100644
index 0000000000..364bcdc00a
--- /dev/null
+++ b/tests/tcg/tricore/link.ld
@@ -0,0 +1,60 @@
+/* Default linker script, for normal executables */
+OUTPUT_FORMAT("elf32-tricore")
+OUTPUT_ARCH(tricore)
+ENTRY(_start)
+
+/* the internal ram description */
+MEMORY
+{
+  text_ram (rx!p): org = 0x80000000, len = 15K
+  data_ram (w!xp): org = 0xd0000000, len = 130K
+}
+/*
+ * Define the sizes of the user and system stacks.
+ */
+__USTACK_SIZE = DEFINED (__USTACK_SIZE) ? __USTACK_SIZE : 1K ;
+/*
+ * Define the start address and the size of the context save area.
+ */
+__CSA_BEGIN =  0xd0000000 ;
+__CSA_SIZE =  8k ;
+__CSA_END = __CSA_BEGIN + __CSA_SIZE ;
+
+SECTIONS
+{
+  .text  :
+  {
+    *(.text)
+    . = ALIGN(8);
+  } > text_ram
+
+  .rodata :
+  {
+    *(.rodata)
+    *(.rodata1)
+  } > data_ram
+
+  .data :
+  {
+    . = ALIGN(8) ;
+    *(.data)
+    *(.data.*)
+    . = ALIGN(8) ;
+    __USTACK = . + __USTACK_SIZE -768;
+
+  } > data_ram
+  /*
+   * Allocate space for BSS sections.
+   */
+  .bss  :
+  {
+    BSS_BASE = . ;
+    *(.bss)
+    *(COMMON)
+    . = ALIGN(8) ;
+  } > data_ram
+  /* Make sure CSA, stack and heap addresses are properly aligned.  */
+  _. = ASSERT ((__CSA_BEGIN & 0x3f) == 0 , "illegal CSA start address") ;
+  _. = ASSERT ((__CSA_SIZE & 0x3f) == 0 , "illegal CSA size") ;
+
+}
-- 
2.11.0
