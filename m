Received: from eggs.gnu.org ([2001:4830:134:3::10]:54754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eq0aS-0002Dw-AC
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eq0aO-0002lX-Gk
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:48 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45073)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eq0aO-0002i7-39
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 25 Feb 2018 18:59:25 +0100
Message-Id: <20180225175928.13101-2-laurent@vivier.eu>
In-Reply-To: <20180225175928.13101-1-laurent@vivier.eu>
References: <20180225175928.13101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/4] linux-user: Move CPU type name selection to
 a function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Instead of a sequence of "#if ... #endif" move the
selection to a function in linux-user/*/target_elf.h

We can't add them in linux-user/*/target_cpu.h
because we will need to include "elf.h" to
use ELF flags with eflags, and including
"elf.h" in "target_cpu.h" introduces some
conflicts in elfload.c

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180220173307.25125-2-laurent@vivier.eu>
---
 linux-user/aarch64/target_elf.h    | 14 +++++++++++++
 linux-user/alpha/target_elf.h      | 14 +++++++++++++
 linux-user/arm/target_elf.h        | 14 +++++++++++++
 linux-user/cris/target_elf.h       | 14 +++++++++++++
 linux-user/hppa/target_elf.h       | 14 +++++++++++++
 linux-user/i386/target_elf.h       | 14 +++++++++++++
 linux-user/m68k/target_elf.h       | 14 +++++++++++++
 linux-user/main.c                  | 41 ++------------------------------------
 linux-user/microblaze/target_elf.h | 14 +++++++++++++
 linux-user/mips/target_elf.h       | 14 +++++++++++++
 linux-user/mips64/target_elf.h     | 14 +++++++++++++
 linux-user/nios2/target_elf.h      | 14 +++++++++++++
 linux-user/openrisc/target_elf.h   | 14 +++++++++++++
 linux-user/ppc/target_elf.h        | 18 +++++++++++++++++
 linux-user/s390x/target_elf.h      | 14 +++++++++++++
 linux-user/sh4/target_elf.h        | 14 +++++++++++++
 linux-user/sparc/target_elf.h      | 18 +++++++++++++++++
 linux-user/sparc64/target_elf.h    | 14 +++++++++++++
 linux-user/tilegx/target_elf.h     | 14 +++++++++++++
 linux-user/unicore32/target_elf.h  | 14 +++++++++++++
 linux-user/x86_64/target_elf.h     | 14 +++++++++++++
 21 files changed, 290 insertions(+), 39 deletions(-)
 create mode 100644 linux-user/aarch64/target_elf.h
 create mode 100644 linux-user/alpha/target_elf.h
 create mode 100644 linux-user/arm/target_elf.h
 create mode 100644 linux-user/cris/target_elf.h
 create mode 100644 linux-user/hppa/target_elf.h
 create mode 100644 linux-user/i386/target_elf.h
 create mode 100644 linux-user/m68k/target_elf.h
 create mode 100644 linux-user/microblaze/target_elf.h
 create mode 100644 linux-user/mips/target_elf.h
 create mode 100644 linux-user/mips64/target_elf.h
 create mode 100644 linux-user/nios2/target_elf.h
 create mode 100644 linux-user/openrisc/target_elf.h
 create mode 100644 linux-user/ppc/target_elf.h
 create mode 100644 linux-user/s390x/target_elf.h
 create mode 100644 linux-user/sh4/target_elf.h
 create mode 100644 linux-user/sparc/target_elf.h
 create mode 100644 linux-user/sparc64/target_elf.h
 create mode 100644 linux-user/tilegx/target_elf.h
 create mode 100644 linux-user/unicore32/target_elf.h
 create mode 100644 linux-user/x86_64/target_elf.h

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
new file mode 100644
index 0000000000..a7eb962fba
--- /dev/null
+++ b/linux-user/aarch64/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef AARCH64_TARGET_ELF_H
+#define AARCH64_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
new file mode 100644
index 0000000000..344e9f4d39
--- /dev/null
+++ b/linux-user/alpha/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef ALPHA_TARGET_ELF_H
+#define ALPHA_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
new file mode 100644
index 0000000000..58ff6a0986
--- /dev/null
+++ b/linux-user/arm/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef ARM_TARGET_ELF_H
+#define ARM_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/cris/target_elf.h b/linux-user/cris/target_elf.h
new file mode 100644
index 0000000000..99eb4ec704
--- /dev/null
+++ b/linux-user/cris/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef CRIS_TARGET_ELF_H
+#define CRIS_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
new file mode 100644
index 0000000000..82b4e9535e
--- /dev/null
+++ b/linux-user/hppa/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef HPPA_TARGET_ELF_H
+#define HPPA_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
new file mode 100644
index 0000000000..1c6142e7da
--- /dev/null
+++ b/linux-user/i386/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef I386_TARGET_ELF_H
+#define I386_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "qemu32";
+}
+#endif
diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
new file mode 100644
index 0000000000..df375ad5d3
--- /dev/null
+++ b/linux-user/m68k/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef M68K_TARGET_ELF_H
+#define M68K_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/main.c b/linux-user/main.c
index fd7900628b..079b98235b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -35,6 +35,7 @@
 #include "elf.h"
 #include "exec/log.h"
 #include "trace/control.h"
+#include "target_elf.h"
 
 char *exec_path;
 
@@ -4344,45 +4345,7 @@ int main(int argc, char **argv, char **envp)
     init_qemu_uname_release();
 
     if (cpu_model == NULL) {
-#if defined(TARGET_I386)
-#ifdef TARGET_X86_64
-        cpu_model = "qemu64";
-#else
-        cpu_model = "qemu32";
-#endif
-#elif defined(TARGET_ARM)
-        cpu_model = "any";
-#elif defined(TARGET_UNICORE32)
-        cpu_model = "any";
-#elif defined(TARGET_M68K)
-        cpu_model = "any";
-#elif defined(TARGET_SPARC)
-#ifdef TARGET_SPARC64
-        cpu_model = "TI UltraSparc II";
-#else
-        cpu_model = "Fujitsu MB86904";
-#endif
-#elif defined(TARGET_MIPS)
-#if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64)
-        cpu_model = "5KEf";
-#else
-        cpu_model = "24Kf";
-#endif
-#elif defined TARGET_OPENRISC
-        cpu_model = "or1200";
-#elif defined(TARGET_PPC)
-# ifdef TARGET_PPC64
-        cpu_model = "POWER8";
-# else
-        cpu_model = "750";
-# endif
-#elif defined TARGET_SH4
-        cpu_model = "sh7785";
-#elif defined TARGET_S390X
-        cpu_model = "qemu";
-#else
-        cpu_model = "any";
-#endif
+        cpu_model = cpu_get_model(0);
     }
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
new file mode 100644
index 0000000000..8a8f1debff
--- /dev/null
+++ b/linux-user/microblaze/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef MICROBLAZE_TARGET_ELF_H
+#define MICROBLAZE_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
new file mode 100644
index 0000000000..bed0b43259
--- /dev/null
+++ b/linux-user/mips/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef MIPS_TARGET_ELF_H
+#define MIPS_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "24Kf";
+}
+#endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
new file mode 100644
index 0000000000..5b6f4692e0
--- /dev/null
+++ b/linux-user/mips64/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef MIPS64_TARGET_ELF_H
+#define MIPS64_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "5KEf";
+}
+#endif
diff --git a/linux-user/nios2/target_elf.h b/linux-user/nios2/target_elf.h
new file mode 100644
index 0000000000..801e20afaf
--- /dev/null
+++ b/linux-user/nios2/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef NIOS2_TARGET_ELF_H
+#define NIOS2_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
new file mode 100644
index 0000000000..40ceb025c9
--- /dev/null
+++ b/linux-user/openrisc/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef OPENRISC_TARGET_ELF_H
+#define OPENRISC_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "or1200";
+}
+#endif
diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
new file mode 100644
index 0000000000..576a5b9959
--- /dev/null
+++ b/linux-user/ppc/target_elf.h
@@ -0,0 +1,18 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_TARGET_ELF_H
+#define PPC_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+#ifdef TARGET_PPC64
+    return "POWER8";
+#else
+    return "750";
+#endif
+}
+#endif
diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
new file mode 100644
index 0000000000..8114b59c1d
--- /dev/null
+++ b/linux-user/s390x/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef S390X_TARGET_ELF_H
+#define S390X_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "qemu";
+}
+#endif
diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
new file mode 100644
index 0000000000..f485e0cef2
--- /dev/null
+++ b/linux-user/sh4/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef SH4_TARGET_ELF_H
+#define SH4_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "sh7785";
+}
+#endif
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
new file mode 100644
index 0000000000..a510ceb612
--- /dev/null
+++ b/linux-user/sparc/target_elf.h
@@ -0,0 +1,18 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef SPARC_TARGET_ELF_H
+#define SPARC_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+#ifdef TARGET_SPARC64
+    return "TI UltraSparc II";
+#else
+    return "Fujitsu MB86904";
+#endif
+}
+#endif
diff --git a/linux-user/sparc64/target_elf.h b/linux-user/sparc64/target_elf.h
new file mode 100644
index 0000000000..d6e388f1cf
--- /dev/null
+++ b/linux-user/sparc64/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef SPARC64_TARGET_ELF_H
+#define SPARC64_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "TI UltraSparc II";
+}
+#endif
diff --git a/linux-user/tilegx/target_elf.h b/linux-user/tilegx/target_elf.h
new file mode 100644
index 0000000000..7197bb0005
--- /dev/null
+++ b/linux-user/tilegx/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef TILEGX_TARGET_ELF_H
+#define TILEGX_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/unicore32/target_elf.h b/linux-user/unicore32/target_elf.h
new file mode 100644
index 0000000000..e2bfcb2ca3
--- /dev/null
+++ b/linux-user/unicore32/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef UNICORE32_TARGET_ELF_H
+#define UNICORE32_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "any";
+}
+#endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
new file mode 100644
index 0000000000..7b76a90de8
--- /dev/null
+++ b/linux-user/x86_64/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef X86_64_TARGET_ELF_H
+#define X86_64_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "qemu64";
+}
+#endif
-- 
2.14.3
