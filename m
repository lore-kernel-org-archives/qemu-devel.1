Received: from eggs.gnu.org ([2001:4830:134:3::10]:40167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWk-00024g-GY
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWj-0004Bl-1l
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:26 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzNWi-0004BQ-Oz
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:24 -0400
Received: by mail-wr0-x242.google.com with SMTP id k10so5927678wrk.3
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 15:45:40 +0200
Message-Id: <20171003134540.21625-11-pbonzini@redhat.com>
In-Reply-To: <20171003134540.21625-1-pbonzini@redhat.com>
References: <20171003134540.21625-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/10] i386: hvf: cleanup x86_gen.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex@alex.org.uk, agraf@suse.de, sergio.g.delreal@gmail.com

This only includes VM_PANIC now.  No need to include it from headers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf-utils/panic.h | 45 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/hvf/x86.h         |  1 -
 target/i386/hvf/x86_decode.c  |  3 +--
 target/i386/hvf/x86_emu.c     |  2 +-
 target/i386/hvf/x86_flags.c   |  1 +
 target/i386/hvf/x86_flags.h   |  1 -
 target/i386/hvf/x86_mmu.c     |  1 +
 target/i386/hvf/x86_mmu.h     |  2 --
 target/i386/hvf/x86_task.c    |  1 +
 9 files changed, 50 insertions(+), 7 deletions(-)
 create mode 100644 target/i386/hvf-utils/panic.h

diff --git a/target/i386/hvf-utils/panic.h b/target/i386/hvf-utils/panic.h
new file mode 100644
index 0000000000..411ef43a5b
--- /dev/null
+++ b/target/i386/hvf-utils/panic.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef HVF_PANIC_H
+#define HVF_PANIC_H
+
+#define VM_PANIC(x) {\
+    printf("%s\n", x); \
+    abort(); \
+}
+
+#define VM_PANIC_ON(x) {\
+    if (x) { \
+        printf("%s\n", #x); \
+        abort(); \
+    } \
+}
+
+#define VM_PANIC_EX(...) {\
+    printf(__VA_ARGS__); \
+    abort(); \
+}
+
+#define VM_PANIC_ON_EX(x, ...) {\
+    if (x) { \
+        printf(__VA_ARGS__); \
+        abort(); \
+    } \
+}
+
+#endif
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index a7fc65a487..595d5aca04 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -20,7 +20,6 @@
 #define HVF_X86_H 1
 
 #include "qemu-common.h"
-#include "x86_gen.h"
 
 typedef struct x86_register {
     union {
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index f6096ca307..ff31f4f577 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -17,11 +17,10 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "panic.h"
 #include "x86_decode.h"
 #include "string.h"
 #include "vmx.h"
-#include "x86_gen.h"
 #include "x86_mmu.h"
 #include "x86_descr.h"
 
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 8f45f01eed..44b0b83fea 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -36,7 +36,7 @@
 /////////////////////////////////////////////////////////////////////////
 
 #include "qemu/osdep.h"
-
+#include "panic.h"
 #include "qemu-common.h"
 #include "x86_decode.h"
 #include "x86.h"
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index b1f240ca0f..f79ff096f6 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "panic.h"
 #include "qemu-common.h"
 
 #include "cpu.h"
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 69d8672d24..c46a5fd8a8 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -23,7 +23,6 @@
 #ifndef __X86_FLAGS_H__
 #define __X86_FLAGS_H__
 
-#include "x86_gen.h"
 #include "cpu.h"
 void lflags_to_rflags(CPUX86State *env);
 void rflags_to_lflags(CPUX86State *env);
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index af11635fba..682e29774e 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -16,6 +16,7 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "panic.h"
 
 #include "qemu-common.h"
 #include "x86.h"
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/hvf/x86_mmu.h
index ae02cb6916..0bd1acc94f 100644
--- a/target/i386/hvf/x86_mmu.h
+++ b/target/i386/hvf/x86_mmu.h
@@ -18,8 +18,6 @@
 #ifndef __X86_MMU_H__
 #define __X86_MMU_H__
 
-#include "x86_gen.h"
-
 #define PT_PRESENT      (1 << 0)
 #define PT_WRITE        (1 << 1)
 #define PT_USER         (1 << 2)
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index b6ce2a151b..f77edda580 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -7,6 +7,7 @@
 // MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 // GNU General Public License for more details.
 #include "qemu/osdep.h"
+#include "panic.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 
-- 
2.13.6
