Received: from eggs.gnu.org ([2001:4830:134:3::10]:51162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWD-00037s-Ew
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGW9-0002Bk-DR
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:33 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:63035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGW9-0002BR-1D
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:29 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:26 +0100
Message-Id: <20170130181634.13934-9-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 08/16] target-m68k: define 96bit FP
 registers for gdb on 680x0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure            |  2 +-
 gdb-xml/m68k-fp.xml  | 21 +++++++++++++++++++++
 target/m68k/helper.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 gdb-xml/m68k-fp.xml

diff --git a/configure b/configure
index 86fd833..4373ec5 100755
--- a/configure
+++ b/configure
@@ -5912,7 +5912,7 @@ case "$target_name" in
   ;;
   m68k)
     bflt="yes"
-    gdb_xml_files="cf-core.xml cf-fp.xml"
+    gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
   ;;
   microblaze|microblazeel)
     TARGET_ARCH=microblaze
diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
new file mode 100644
index 0000000..64290d1
--- /dev/null
+++ b/gdb-xml/m68k-fp.xml
@@ -0,0 +1,21 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2008 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.coldfire.fp">
+  <reg name="fp0" bitsize="96" type="float" group="float"/>
+  <reg name="fp1" bitsize="96" type="float" group="float"/>
+  <reg name="fp2" bitsize="96" type="float" group="float"/>
+  <reg name="fp3" bitsize="96" type="float" group="float"/>
+  <reg name="fp4" bitsize="96" type="float" group="float"/>
+  <reg name="fp5" bitsize="96" type="float" group="float"/>
+  <reg name="fp6" bitsize="96" type="float" group="float"/>
+  <reg name="fp7" bitsize="96" type="float" group="float"/>
+
+  <reg name="fpcontrol" bitsize="32" group="float"/>
+  <reg name="fpstatus" bitsize="32" group="float"/>,
+  <reg name="fpiaddr" bitsize="32" type="code_ptr" group="float"/>
+</feature>
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index cff93dc..d93fad9 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -114,6 +114,48 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
+static int m68k_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+{
+    if (n < 8) {
+        stw_be_p(mem_buf, env->fregs[n].l.upper);
+        memset(mem_buf + 2, 0, 2);
+        stq_be_p(mem_buf + 4, env->fregs[n].l.lower);
+        return 12;
+    }
+    switch (n) {
+    case 8: /* fpcontrol */
+        stl_be_p(mem_buf, env->fpcr);
+        return 4;
+    case 9: /* fpstatus */
+        stl_be_p(mem_buf, env->fpsr);
+        return 4;
+    case 10: /* fpiar, not implemented */
+        memset(mem_buf, 0, 4);
+        return 4;
+    }
+    return 0;
+}
+
+static int m68k_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+{
+    if (n < 8) {
+        env->fregs[n].l.upper = lduw_be_p(mem_buf);
+        env->fregs[n].l.lower = ldq_be_p(mem_buf + 4);
+        return 12;
+    }
+    switch (n) {
+    case 8: /* fpcontrol */
+        env->fpcr = ldl_p(mem_buf);
+        return 4;
+    case 9: /* fpstatus */
+        env->fpsr = ldl_p(mem_buf);
+        return 4;
+    case 10: /* fpiar, not implemented */
+        return 4;
+    }
+    return 0;
+}
+
 M68kCPU *cpu_m68k_init(const char *cpu_model)
 {
     M68kCPU *cpu;
@@ -142,6 +184,9 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
     if (m68k_feature(env, M68K_FEATURE_CF_FPU)) {
         gdb_register_coprocessor(cs, cf_fpu_gdb_get_reg, cf_fpu_gdb_set_reg,
                                  11, "cf-fp.xml", 18);
+    } else if (m68k_feature(env, M68K_FEATURE_FPU)) {
+        gdb_register_coprocessor(cs, m68k_fpu_gdb_get_reg,
+                                 m68k_fpu_gdb_set_reg, 11, "m68k-fp.xml", 18);
     }
     /* TODO: Add [E]MAC registers.  */
 }
-- 
2.9.3
