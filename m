Received: from eggs.gnu.org ([2001:4830:134:3::10]:46112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iI-0001tW-AB
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iH-00005G-3S
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:42 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:09 -0500
Message-Id: <20180619014319.28272-44-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 043/113] tests/multiboot: Add tests for the
 a.out kludge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>
(cherry picked from commit 1c8c426fb44bf5b3ffbcad1b00c7def4b89b03ec)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/multiboot/Makefile        |  22 +++++--
 tests/multiboot/aout_kludge.S   | 138 ++++++++++++++++++++++++++++++++++++++++
 tests/multiboot/aout_kludge.out |  42 ++++++++++++
 tests/multiboot/run_test.sh     |  10 ++-
 4 files changed, 204 insertions(+), 8 deletions(-)
 create mode 100644 tests/multiboot/aout_kludge.S
 create mode 100644 tests/multiboot/aout_kludge.out

diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
index 36f01dc647..ed4225e7d1 100644
--- a/tests/multiboot/Makefile
+++ b/tests/multiboot/Makefile
@@ -3,16 +3,26 @@ CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin
 ASFLAGS=-m32
 
 LD=ld
-LDFLAGS=-melf_i386 -T link.ld
+LDFLAGS_ELF=-melf_i386 -T link.ld
+LDFLAGS_BIN=-melf_i386 -T link.ld --oformat=binary
 LIBS=$(shell $(CC) $(CCFLAGS) -print-libgcc-file-name)
 
-all: mmap.elf modules.elf
+AOUT_KLUDGE_BIN=$(foreach x,$(shell seq 1 9),aout_kludge_$x.bin)
 
-mmap.elf: start.o mmap.o libc.o
-	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
+all: mmap.elf modules.elf $(AOUT_KLUDGE_BIN)
 
-modules.elf: start.o modules.o libc.o
-	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
+mmap.elf: start.o mmap.o libc.o link.ld
+	$(LD) $(LDFLAGS_ELF) -o $@ $^ $(LIBS)
+
+modules.elf: start.o modules.o libc.o link.ld
+	$(LD) $(LDFLAGS_ELF) -o $@ $^ $(LIBS)
+
+aout_kludge_%.bin: aout_kludge_%.o link.ld
+	$(LD) $(LDFLAGS_BIN) -o $@ $^ $(LIBS)
+
+.PRECIOUS: aout_kludge_%.o
+aout_kludge_%.o: aout_kludge.S
+	$(CC) $(ASFLAGS) -DSCENARIO=$* -c -o $@ $^
 
 %.o: %.c
 	$(CC) $(CCFLAGS) -c -o $@ $^
diff --git a/tests/multiboot/aout_kludge.S b/tests/multiboot/aout_kludge.S
new file mode 100644
index 0000000000..52e8ebd766
--- /dev/null
+++ b/tests/multiboot/aout_kludge.S
@@ -0,0 +1,138 @@
+/*
+ * Copyright (c) 2018 Kevin Wolf <kwolf@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+.section multiboot
+
+#define MB_MAGIC 0x1badb002
+#define MB_FLAGS 0x10000
+#define MB_CHECKSUM -(MB_MAGIC + MB_FLAGS)
+
+.align  4
+.int    MB_MAGIC
+.int    MB_FLAGS
+.int    MB_CHECKSUM
+
+#define LAST_BYTE_VALUE 0xa5
+
+/*
+ * Order of fields in the a.out kludge header fields:
+ *
+ * header_addr
+ * load_addr
+ * load_end_addr
+ * bss_end_addr
+ * entry_addr
+ */
+#if SCENARIO == 1
+/* Well-behaved kernel file with explicit bss_end */
+.int    0x100000
+.int    0x100000
+.int    data_end
+.int    data_end
+.int    _start
+#elif SCENARIO == 2
+/* Well-behaved kernel file with default bss_end */
+.int    0x100000
+.int    0x100000
+.int    data_end
+.int    0
+.int    _start
+#elif SCENARIO == 3
+/* Well-behaved kernel file with default load_end */
+.int    0x100000
+.int    0x100000
+.int    0
+.int    0
+.int    _start
+#elif SCENARIO == 4
+/* Well-behaved kernel file with load_end < data_end and bss > data_end */
+#undef LAST_BYTE_VALUE
+#define LAST_BYTE_VALUE 0
+.int    0x100000
+.int    0x100000
+.int    code_end
+.int    0x140000
+.int    _start
+#elif SCENARIO == 5
+/* header < load */
+.int    0x10000
+.int    0x100000
+.int    data_end
+.int    data_end
+.int    _start
+#elif SCENARIO == 6
+/* load_end < load */
+.int    0x100000
+.int    0x100000
+.int    0x10000
+.int    data_end
+.int    _start
+#elif SCENARIO == 7
+/* header much larger than in reality with default load_end */
+.int    0x80000000
+.int    0x100000
+.int    0
+.int    data_end
+.int    _start
+#elif SCENARIO == 8
+/* bss_end < load_end - load (regression test for CVE-2018-7550) */
+.int    0x100000
+.int    0x100000
+.int    data_end
+.int    code_end
+.int    _start
+#elif SCENARIO == 9
+/* Default load_end_addr, load_addr + kernel_file_size > UINT32_MAX */
+.int    0xfffff000
+.int    0xfffff000
+.int    0
+.int    0xfffff001
+.int    _start
+#else
+#error Invalid SCENARIO
+#endif
+
+.section .text
+.global _start
+_start:
+    xor     %eax, %eax
+
+    cmpb    $LAST_BYTE_VALUE, last_byte
+    je      passed
+    or      $0x1, %eax
+passed:
+
+    /* Test device exit */
+    outl    %eax, $0xf4
+
+    cli
+    hlt
+    jmp .
+code_end:
+
+#if SCENARIO != 8
+.space 8192
+#endif
+
+last_byte:
+.byte 0xa5
+data_end:
diff --git a/tests/multiboot/aout_kludge.out b/tests/multiboot/aout_kludge.out
new file mode 100644
index 0000000000..031459275b
--- /dev/null
+++ b/tests/multiboot/aout_kludge.out
@@ -0,0 +1,42 @@
+
+
+
+=== Running test case: aout_kludge_1.bin  ===
+
+
+
+=== Running test case: aout_kludge_2.bin  ===
+
+
+
+=== Running test case: aout_kludge_3.bin  ===
+
+
+
+=== Running test case: aout_kludge_4.bin  ===
+
+
+
+=== Running test case: aout_kludge_5.bin  ===
+
+qemu-system-x86_64: invalid load_addr address
+
+
+=== Running test case: aout_kludge_6.bin  ===
+
+qemu-system-x86_64: invalid load_end_addr address
+
+
+=== Running test case: aout_kludge_7.bin  ===
+
+qemu-system-x86_64: invalid header_addr address
+
+
+=== Running test case: aout_kludge_8.bin  ===
+
+qemu-system-x86_64: invalid bss_end_addr address
+
+
+=== Running test case: aout_kludge_9.bin  ===
+
+qemu-system-x86_64: kernel does not fit in address space
diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index bc9c3670af..6c33003e71 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -34,7 +34,7 @@ run_qemu() {
         -device isa-debugcon,chardev=stdio \
         -chardev file,path=test.out,id=stdio \
         -device isa-debug-exit,iobase=0xf4,iosize=0x4 \
-        "$@"
+        "$@" >> test.log 2>&1
     ret=$?
 
     cat test.out >> test.log
@@ -67,9 +67,15 @@ modules() {
     run_qemu modules.elf -initrd "module.txt,module.txt argument,module.txt"
 }
 
+aout_kludge() {
+    for i in $(seq 1 9); do
+        run_qemu aout_kludge_$i.bin
+    done
+}
+
 make all
 
-for t in mmap modules; do
+for t in mmap modules aout_kludge; do
 
     echo > test.log
     pass=1
-- 
2.11.0
