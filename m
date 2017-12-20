Received: from eggs.gnu.org ([2001:4830:134:3::10]:48011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijL-0004df-Jo
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijG-0002m3-9Z
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRijF-0002kW-Sb
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F21A6624DF
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:28 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-46.ams2.redhat.com
	[10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 607813818B
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:58 +0100
Message-Id: <20171220180358.29316-20-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/19] i386: hvf: cleanup x86_gen.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This only includes VM_PANIC now.  No need to include it from headers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/panic.h      | 45 ++++++++++++++++++++++++++++++++++++++++++++
 target/i386/hvf/x86.h        |  2 --
 target/i386/hvf/x86_decode.c |  2 +-
 target/i386/hvf/x86_emu.c    |  2 +-
 target/i386/hvf/x86_flags.c  |  1 +
 target/i386/hvf/x86_flags.h  |  1 -
 target/i386/hvf/x86_mmu.c    |  1 +
 target/i386/hvf/x86_mmu.h    |  2 --
 target/i386/hvf/x86_task.c   |  1 +
 9 files changed, 50 insertions(+), 7 deletions(-)
 create mode 100644 target/i386/hvf/panic.h

diff --git a/target/i386/hvf/panic.h b/target/i386/hvf/panic.h
new file mode 100644
index 0000000000..411ef43a5b
--- /dev/null
+++ b/target/i386/hvf/panic.h
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
index ae877f0022..103ec0976c 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -19,8 +19,6 @@
 #ifndef HVF_X86_H
 #define HVF_X86_H 1
 
-#include "x86_gen.h"
-
 typedef struct x86_register {
     union {
         struct {
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 71d0c3d115..bf93e8207d 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -19,10 +19,10 @@
 #include "qemu/osdep.h"
 
 #include "qemu-common.h"
+#include "panic.h"
 #include "x86_decode.h"
 #include "string.h"
 #include "vmx.h"
-#include "x86_gen.h"
 #include "x86_mmu.h"
 #include "x86_descr.h"
 
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 6abcea9d92..3ea18edc68 100644
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
index 28398ae680..ee6d33f861 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu-common.h"
+#include "panic.h"
 #include "cpu.h"
 #include "x86_flags.h"
 #include "x86.h"
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 13e5d5bd1a..8942745988 100644
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
2.14.3
