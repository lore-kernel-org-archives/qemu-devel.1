Received: from eggs.gnu.org ([2001:4830:134:3::10]:59370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dkbFT-0001n4-JD
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dkbFS-00007O-NY
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:23:31 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dkbFS-000069-HQ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:23:30 -0400
Received: by mail-pg0-x241.google.com with SMTP id 189so465392pgj.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 12:23:30 -0700 (PDT)
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Wed, 23 Aug 2017 12:22:44 -0700
Message-Id: <20170823192244.18914-1-anatol.pomozov@gmail.com>
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
Cc: kwolf@redhat.com, Anatol Pomozov <anatol.pomozov@gmail.com>

 * explicitly disable SSE as clang enables it by default for 32bit code
 * add memset() implementation. Clang complains that the function is
   absent, gcc seems provides default built-in.
---
 tests/multiboot/Makefile | 2 +-
 tests/multiboot/libc.c   | 9 +++++++++
 tests/multiboot/libc.h   | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
index 856e76682a..7fadbca33a 100644
--- a/tests/multiboot/Makefile
+++ b/tests/multiboot/Makefile
@@ -1,5 +1,5 @@
 CC=gcc
-CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin
+CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin -mno-sse
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
-- 
2.14.1.342.g6490525c54-goog
