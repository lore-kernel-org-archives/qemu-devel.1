Received: from eggs.gnu.org ([2001:4830:134:3::10]:57607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVd-0007PW-8Q
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVa-0008Fn-Hw
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:57 -0400
Received: from foss.arm.com ([217.140.101.70]:46148)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVa-0008Em-BK
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:54 -0400
From: Andre Przywara <andre.przywara@arm.com>
Date: Fri, 20 Jul 2018 16:39:39 +0100
Message-Id: <20180720153942.26821-2-andre.przywara@arm.com>
In-Reply-To: <20180720153942.26821-1-andre.przywara@arm.com>
References: <20180720153942.26821-1-andre.przywara@arm.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v2 1/4] mark exit() and abort()
 as non-returning functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

exit() and abort() are functions that never return, and (at least)
GCC has an attribute to flag those functions accordingly. This allows
the compiler to do further optimizations and to omit various warnings
about uninitialized variables, for instance.
Since the actual "play-dead" function is in (inline) assembly, the
compiler does not recognize its fatal nature, so help it with the
__builtin_unreachable() hint.
Flag the prototypes of our fatal functions accordingly.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 lib/arm/io.c     | 1 +
 lib/libcflat.h   | 7 ++++---
 lib/powerpc/io.c | 1 +
 lib/x86/io.c     | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/arm/io.c b/lib/arm/io.c
index 603456f..d2c1a07 100644
--- a/lib/arm/io.c
+++ b/lib/arm/io.c
@@ -83,4 +83,5 @@ void exit(int code)
 {
 	chr_testdev_exit(code);
 	halt(code);
+	__builtin_unreachable();
 }
diff --git a/lib/libcflat.h b/lib/libcflat.h
index cc56553..7529958 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -84,8 +84,8 @@ typedef u64			phys_addr_t;
 extern void puts(const char *s);
 extern int __getchar(void);
 extern int getchar(void);
-extern void exit(int code);
-extern void abort(void);
+extern void exit(int code) __attribute__((noreturn));
+extern void abort(void) __attribute__((noreturn));
 extern long atol(const char *ptr);
 extern char *getenv(const char *name);
 
@@ -107,7 +107,8 @@ extern void report(const char *msg_fmt, bool pass, ...)
 extern void report_xfail(const char *msg_fmt, bool xfail, bool pass, ...)
 					__attribute__((format(printf, 1, 4)));
 extern void report_abort(const char *msg_fmt, ...)
-					__attribute__((format(printf, 1, 2)));
+					__attribute__((format(printf, 1, 2)))
+					__attribute__((noreturn));
 extern void report_skip(const char *msg_fmt, ...)
 					__attribute__((format(printf, 1, 2)));
 extern void report_info(const char *msg_fmt, ...)
diff --git a/lib/powerpc/io.c b/lib/powerpc/io.c
index 915e12e..217eb07 100644
--- a/lib/powerpc/io.c
+++ b/lib/powerpc/io.c
@@ -35,4 +35,5 @@ void exit(int code)
 	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
 	rtas_power_off();
 	halt(code);
+	__builtin_unreachable();
 }
diff --git a/lib/x86/io.c b/lib/x86/io.c
index 7e1c16d..057f579 100644
--- a/lib/x86/io.c
+++ b/lib/x86/io.c
@@ -82,6 +82,7 @@ void exit(int code)
 #else
         asm volatile("out %0, %1" : : "a"(code), "d"((short)0xf4));
 #endif
+	__builtin_unreachable();
 }
 
 void __iomem *ioremap(phys_addr_t phys_addr, size_t size)
-- 
2.14.4
