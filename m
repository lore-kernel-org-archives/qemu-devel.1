Received: from eggs.gnu.org ([2001:4830:134:3::10]:51963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dkfar-0002Jm-C1
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dkfam-0003Es-Ps
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:01:53 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dkfam-0003DI-Jt
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:01:48 -0400
Received: by mail-pg0-x241.google.com with SMTP id 189so1298264pgj.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:01:48 -0700 (PDT)
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Wed, 23 Aug 2017 17:01:40 -0700
Message-Id: <20170824000140.16812-1-anatol.pomozov@gmail.com>
In-Reply-To: <d76e1ae7-4fdd-4e21-4355-0be96142bce3@amsat.org>
References: <d76e1ae7-4fdd-4e21-4355-0be96142bce3@amsat.org>
Subject: [Qemu-devel] [PATCH] multiboot: make tests work with clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, f4bug@amsat.org, Anatol Pomozov <anatol.pomozov@gmail.com>

 * clang 3.8 enables SSE even for 32bit code. Generate code for pentium
   CPU to make sure no new instructions are used.
 * add memset() implementation. Clang implements array zeroing in
   print_num() via memset() function call.
---
 tests/multiboot/Makefile    | 2 +-
 tests/multiboot/libc.c      | 9 +++++++++
 tests/multiboot/libc.h      | 2 ++
 tests/multiboot/run_test.sh | 1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
index 856e76682a..2e015409dc 100644
--- a/tests/multiboot/Makefile
+++ b/tests/multiboot/Makefile
@@ -1,5 +1,5 @@
 CC=gcc
-CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin
+CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin -march=pentium
 ASFLAGS=-m32
 
 LD=ld
diff --git a/tests/multiboot/libc.c b/tests/multiboot/libc.c
index 6df9bda96d..512fccd7fa 100644
--- a/tests/multiboot/libc.c
+++ b/tests/multiboot/libc.c
@@ -33,6 +33,15 @@ void* memcpy(void *dest, const void *src, int n)
 
     return dest;
 }
+void *memset(void *s, int c, size_t n)
+{
+    size_t i;
+    char *d = s;
+    for (i = 0; i < n; i++) {
+        *d++ = c;
+    }
+    return s;
+}
 
 static void print_char(char c)
 {
diff --git a/tests/multiboot/libc.h b/tests/multiboot/libc.h
index 04c9922c27..44b71350dd 100644
--- a/tests/multiboot/libc.h
+++ b/tests/multiboot/libc.h
@@ -36,6 +36,7 @@ typedef signed short int16_t;
 typedef signed char int8_t;
 
 typedef uint32_t uintptr_t;
+typedef uint32_t size_t;
 
 
 /* stdarg.h */
@@ -58,5 +59,6 @@ static inline void outb(uint16_t port, uint8_t data)
 
 void printf(const char *fmt, ...);
 void* memcpy(void *dest, const void *src, int n);
+void *memset(void *s, int c, size_t n);
 
 #endif
diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index f04e35cbf0..38dcfef42c 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -29,6 +29,7 @@ run_qemu() {
     printf %b "\n\n=== Running test case: $kernel $* ===\n\n" >> test.log
 
     $QEMU \
+        -cpu pentium \
         -kernel $kernel \
         -display none \
         -device isa-debugcon,chardev=stdio \
-- 
2.14.1.342.g6490525c54-goog
