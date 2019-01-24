Received: from eggs.gnu.org ([209.51.188.92]:58677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1gmWH0-0007mC-NJ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 23:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1gmWGv-0001RO-Mx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 23:05:49 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b]:42626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1gmWGv-0001Fp-Bg
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 23:05:45 -0500
Received: by mail-qk1-x72b.google.com with SMTP id 68so2445074qke.9
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 20:05:43 -0800 (PST)
From: Doug Gale <doug16k@gmail.com>
Date: Thu, 24 Jan 2019 00:34:57 -0330
Message-Id: <20190124040457.2546-1-doug16k@gmail.com>
Subject: [Qemu-devel] [PATCH] gdbstub: Fix i386/x86_64 machine description
 and add control registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Doug Gale <doug16k@gmail.com>

Signed-off-by: Doug Gale <doug16k@gmail.com>
---
 configure                   |   4 +-
 gdb-xml/i386-32bit-core.xml |  65 -----------
 gdb-xml/i386-32bit-sse.xml  |  52 ---------
 gdb-xml/i386-32bit.xml      | 184 ++++++++++++++++++++++++++++++-
 gdb-xml/i386-64bit-core.xml |  73 -------------
 gdb-xml/i386-64bit-sse.xml  |  60 -----------
 gdb-xml/i386-64bit.xml      | 210 +++++++++++++++++++++++++++++++++++-
 target/i386/cpu.c           |   4 +-
 target/i386/gdbstub.c       | 186 +++++++++++++++++++++++++++++++-
 9 files changed, 573 insertions(+), 265 deletions(-)
 delete mode 100644 gdb-xml/i386-32bit-core.xml
 delete mode 100644 gdb-xml/i386-32bit-sse.xml
 delete mode 100644 gdb-xml/i386-64bit-core.xml
 delete mode 100644 gdb-xml/i386-64bit-sse.xml

diff --git a/configure b/configure
index 4ea3f14883..c55a97b91c 100755
--- a/configure
+++ b/configure
@@ -7121,14 +7121,14 @@ TARGET_ABI_DIR=""
 case "$target_name" in
   i386)
     mttcg="yes"
-    gdb_xml_files="i386-32bit.xml i386-32bit-core.xml i386-32bit-sse.xml"
+	gdb_xml_files="i386-32bit.xml"
     target_compiler=$cross_cc_i386
     target_compiler_cflags=$cross_cc_ccflags_i386
   ;;
   x86_64)
     TARGET_BASE_ARCH=i386
     mttcg="yes"
-    gdb_xml_files="i386-64bit.xml i386-64bit-core.xml i386-64bit-sse.xml"
+	gdb_xml_files="i386-64bit.xml"
     target_compiler=$cross_cc_x86_64
   ;;
   alpha)
diff --git a/gdb-xml/i386-32bit-core.xml b/gdb-xml/i386-32bit-core.xml
deleted file mode 100644
index 7aeeeca3b2..0000000000
--- a/gdb-xml/i386-32bit-core.xml
+++ /dev/null
@@ -1,65 +0,0 @@
-<?xml version="1.0"?>
-<!-- Copyright (C) 2010-2015 Free Software Foundation, Inc.
-
-     Copying and distribution of this file, with or without modification,
-     are permitted in any medium without royalty provided the copyright
-     notice and this notice are preserved.  -->
-
-<!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.i386.core">
-  <flags id="i386_eflags" size="4">
-    <field name="CF" start="0" end="0"/>
-    <field name="" start="1" end="1"/>
-    <field name="PF" start="2" end="2"/>
-    <field name="AF" start="4" end="4"/>
-    <field name="ZF" start="6" end="6"/>
-    <field name="SF" start="7" end="7"/>
-    <field name="TF" start="8" end="8"/>
-    <field name="IF" start="9" end="9"/>
-    <field name="DF" start="10" end="10"/>
-    <field name="OF" start="11" end="11"/>
-    <field name="NT" start="14" end="14"/>
-    <field name="RF" start="16" end="16"/>
-    <field name="VM" start="17" end="17"/>
-    <field name="AC" start="18" end="18"/>
-    <field name="VIF" start="19" end="19"/>
-    <field name="VIP" start="20" end="20"/>
-    <field name="ID" start="21" end="21"/>
-  </flags>
-
-  <reg name="eax" bitsize="32" type="int32"/>
-  <reg name="ecx" bitsize="32" type="int32"/>
-  <reg name="edx" bitsize="32" type="int32"/>
-  <reg name="ebx" bitsize="32" type="int32"/>
-  <reg name="esp" bitsize="32" type="data_ptr"/>
-  <reg name="ebp" bitsize="32" type="data_ptr"/>
-  <reg name="esi" bitsize="32" type="int32"/>
-  <reg name="edi" bitsize="32" type="int32"/>
-
-  <reg name="eip" bitsize="32" type="code_ptr"/>
-  <reg name="eflags" bitsize="32" type="i386_eflags"/>
-  <reg name="cs" bitsize="32" type="int32"/>
-  <reg name="ss" bitsize="32" type="int32"/>
-  <reg name="ds" bitsize="32" type="int32"/>
-  <reg name="es" bitsize="32" type="int32"/>
-  <reg name="fs" bitsize="32" type="int32"/>
-  <reg name="gs" bitsize="32" type="int32"/>
-
-  <reg name="st0" bitsize="80" type="i387_ext"/>
-  <reg name="st1" bitsize="80" type="i387_ext"/>
-  <reg name="st2" bitsize="80" type="i387_ext"/>
-  <reg name="st3" bitsize="80" type="i387_ext"/>
-  <reg name="st4" bitsize="80" type="i387_ext"/>
-  <reg name="st5" bitsize="80" type="i387_ext"/>
-  <reg name="st6" bitsize="80" type="i387_ext"/>
-  <reg name="st7" bitsize="80" type="i387_ext"/>
-
-  <reg name="fctrl" bitsize="32" type="int" group="float"/>
-  <reg name="fstat" bitsize="32" type="int" group="float"/>
-  <reg name="ftag" bitsize="32" type="int" group="float"/>
-  <reg name="fiseg" bitsize="32" type="int" group="float"/>
-  <reg name="fioff" bitsize="32" type="int" group="float"/>
-  <reg name="foseg" bitsize="32" type="int" group="float"/>
-  <reg name="fooff" bitsize="32" type="int" group="float"/>
-  <reg name="fop" bitsize="32" type="int" group="float"/>
-</feature>
diff --git a/gdb-xml/i386-32bit-sse.xml b/gdb-xml/i386-32bit-sse.xml
deleted file mode 100644
index 57678473d6..0000000000
--- a/gdb-xml/i386-32bit-sse.xml
+++ /dev/null
@@ -1,52 +0,0 @@
-<?xml version="1.0"?>
-<!-- Copyright (C) 2010-2017 Free Software Foundation, Inc.
-
-     Copying and distribution of this file, with or without modification,
-     are permitted in any medium without royalty provided the copyright
-     notice and this notice are preserved.  -->
-
-<!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.i386.32bit.sse">
-  <vector id="v4f" type="ieee_single" count="4"/>
-  <vector id="v2d" type="ieee_double" count="2"/>
-  <vector id="v16i8" type="int8" count="16"/>
-  <vector id="v8i16" type="int16" count="8"/>
-  <vector id="v4i32" type="int32" count="4"/>
-  <vector id="v2i64" type="int64" count="2"/>
-  <union id="vec128">
-    <field name="v4_float" type="v4f"/>
-    <field name="v2_double" type="v2d"/>
-    <field name="v16_int8" type="v16i8"/>
-    <field name="v8_int16" type="v8i16"/>
-    <field name="v4_int32" type="v4i32"/>
-    <field name="v2_int64" type="v2i64"/>
-    <field name="uint128" type="uint128"/>
-  </union>
-  <flags id="i386_mxcsr" size="4">
-    <field name="IE" start="0" end="0"/>
-    <field name="DE" start="1" end="1"/>
-    <field name="ZE" start="2" end="2"/>
-    <field name="OE" start="3" end="3"/>
-    <field name="UE" start="4" end="4"/>
-    <field name="PE" start="5" end="5"/>
-    <field name="DAZ" start="6" end="6"/>
-    <field name="IM" start="7" end="7"/>
-    <field name="DM" start="8" end="8"/>
-    <field name="ZM" start="9" end="9"/>
-    <field name="OM" start="10" end="10"/>
-    <field name="UM" start="11" end="11"/>
-    <field name="PM" start="12" end="12"/>
-    <field name="FZ" start="15" end="15"/>
-  </flags>
-
-  <reg name="xmm0" bitsize="128" type="vec128" regnum="32"/>
-  <reg name="xmm1" bitsize="128" type="vec128"/>
-  <reg name="xmm2" bitsize="128" type="vec128"/>
-  <reg name="xmm3" bitsize="128" type="vec128"/>
-  <reg name="xmm4" bitsize="128" type="vec128"/>
-  <reg name="xmm5" bitsize="128" type="vec128"/>
-  <reg name="xmm6" bitsize="128" type="vec128"/>
-  <reg name="xmm7" bitsize="128" type="vec128"/>
-
-  <reg name="mxcsr" bitsize="32" type="i386_mxcsr" group="vector"/>
-</feature>
diff --git a/gdb-xml/i386-32bit.xml b/gdb-xml/i386-32bit.xml
index 956fc7f45f..872fcea9c2 100644
--- a/gdb-xml/i386-32bit.xml
+++ b/gdb-xml/i386-32bit.xml
@@ -8,7 +8,185 @@
 <!-- I386 with SSE -->
 
 <!DOCTYPE target SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.i386.32bit">
-  <xi:include href="i386-32bit-core.xml"/>
-  <xi:include href="i386-32bit-sse.xml"/>
+<feature name="org.gnu.gdb.i386.core">
+  <flags id="i386_eflags" size="4">
+	<field name="" start="22" end="31"/>
+	<field name="ID" start="21" end="21"/>
+	<field name="VIP" start="20" end="20"/>
+	<field name="VIF" start="19" end="19"/>
+	<field name="AC" start="18" end="18"/>
+	<field name="VM" start="17" end="17"/>
+	<field name="RF" start="16" end="16"/>
+	<field name="" start="15" end="15"/>
+	<field name="NT" start="14" end="14"/>
+	<field name="IOPL" start="12" end="13"/>
+	<field name="OF" start="11" end="11"/>
+	<field name="DF" start="10" end="10"/>
+	<field name="IF" start="9" end="9"/>
+	<field name="TF" start="8" end="8"/>
+	<field name="SF" start="7" end="7"/>
+	<field name="ZF" start="6" end="6"/>
+	<field name="" start="5" end="5"/>
+	<field name="AF" start="4" end="4"/>
+	<field name="" start="3" end="3"/>
+	<field name="PF" start="2" end="2"/>
+	<field name="" start="1" end="1"/>
+	<field name="CF" start="0" end="0"/>
+  </flags>
+
+  <reg name="eax" bitsize="32" type="int32" regnum="0"/>
+  <reg name="ecx" bitsize="32" type="int32"/>
+  <reg name="edx" bitsize="32" type="int32"/>
+  <reg name="ebx" bitsize="32" type="int32"/>
+  <reg name="esp" bitsize="32" type="data_ptr"/>
+  <reg name="ebp" bitsize="32" type="data_ptr"/>
+  <reg name="esi" bitsize="32" type="int32"/>
+  <reg name="edi" bitsize="32" type="int32"/>
+
+  <reg name="eip" bitsize="32" type="code_ptr"/>
+  <reg name="eflags" bitsize="32" type="i386_eflags"/>
+
+  <reg name="cs" bitsize="32" type="int32"/>
+  <reg name="ss" bitsize="32" type="int32"/>
+  <reg name="ds" bitsize="32" type="int32"/>
+  <reg name="es" bitsize="32" type="int32"/>
+  <reg name="fs" bitsize="32" type="int32"/>
+  <reg name="gs" bitsize="32" type="int32"/>
+
+  <!-- Segment descriptor caches and TLS base MSRs -->
+
+  <!--reg name="cs_base" bitsize="32" type="int32"/>
+  <reg name="ss_base" bitsize="32" type="int32"/>
+  <reg name="ds_base" bitsize="32" type="int32"/>
+  <reg name="es_base" bitsize="32" type="int32"/-->
+  <reg name="fs_base" bitsize="32" type="int32"/>
+  <reg name="gs_base" bitsize="32" type="int32"/>
+  <reg name="k_gs_base" bitsize="32" type="int32"/>
+
+  <flags id="i386_cr0" size="4">
+	<field name="PG" start="31" end="31"/>
+	<field name="CD" start="30" end="30"/>
+	<field name="NW" start="29" end="29"/>
+	<field name="AM" start="18" end="18"/>
+	<field name="WP" start="16" end="16"/>
+	<field name="NE" start="5" end="5"/>
+	<field name="ET" start="4" end="4"/>
+	<field name="TS" start="3" end="3"/>
+	<field name="EM" start="2" end="2"/>
+	<field name="MP" start="1" end="1"/>
+	<field name="PE" start="0" end="0"/>
+  </flags>
+
+  <flags id="i386_cr3" size="4">
+	<field name="PDBR" start="12" end="31"/>
+	<!--field name="" start="3" end="11"/>
+	<field name="WT" start="2" end="2"/>
+	<field name="CD" start="1" end="1"/>
+	<field name="" start="0" end="0"/-->
+	<field name="PCID" start="0" end="11"/>
+  </flags>
+
+  <flags id="i386_cr4" size="4">
+	<field name="VME" start="0" end="0"/>
+	<field name="PVI" start="1" end="1"/>
+	<field name="TSD" start="2" end="2"/>
+	<field name="DE" start="3" end="3"/>
+	<field name="PSE" start="4" end="4"/>
+	<field name="PAE" start="5" end="5"/>
+	<field name="MCE" start="6" end="6"/>
+	<field name="PGE" start="7" end="7"/>
+	<field name="PCE" start="8" end="8"/>
+	<field name="OSFXSR" start="9" end="9"/>
+	<field name="OSXMMEXCPT" start="10" end="10"/>
+	<field name="UMIP" start="11" end="11"/>
+	<field name="LA57" start="12" end="12"/>
+	<field name="VMXE" start="13" end="13"/>
+	<field name="SMXE" start="14" end="14"/>
+	<field name="FSGSBASE" start="16" end="16"/>
+	<field name="PCIDE" start="17" end="17"/>
+	<field name="OSXSAVE" start="18" end="18"/>
+	<field name="SMEP" start="20" end="20"/>
+	<field name="SMAP" start="21" end="21"/>
+	<field name="PKE" start="22" end="22"/>
+  </flags>
+
+  <flags id="i386_efer" size="8">
+	<field name="TCE" start="15" end="15"/>
+	<field name="FFXSR" start="14" end="14"/>
+	<field name="LMSLE" start="13" end="13"/>
+	<field name="SVME" start="12" end="12"/>
+	<field name="NXE" start="11" end="11"/>
+	<field name="LMA" start="10" end="10"/>
+	<field name="LME" start="8" end="8"/>
+	<field name="SCE" start="0" end="0"/>
+  </flags>
+
+  <reg name="cr0" bitsize="32" type="i386_cr0"/>
+  <reg name="cr2" bitsize="32" type="int32"/>
+  <reg name="cr3" bitsize="32" type="i386_cr3"/>
+  <reg name="cr4" bitsize="32" type="i386_cr4"/>
+  <reg name="cr8" bitsize="32" type="int32"/>
+  <reg name="efer" bitsize="32" type="i386_efer"/>
+
+  <reg name="st0" bitsize="80" type="i387_ext"/>
+  <reg name="st1" bitsize="80" type="i387_ext"/>
+  <reg name="st2" bitsize="80" type="i387_ext"/>
+  <reg name="st3" bitsize="80" type="i387_ext"/>
+  <reg name="st4" bitsize="80" type="i387_ext"/>
+  <reg name="st5" bitsize="80" type="i387_ext"/>
+  <reg name="st6" bitsize="80" type="i387_ext"/>
+  <reg name="st7" bitsize="80" type="i387_ext"/>
+
+  <reg name="fctrl" bitsize="32" type="int" group="float"/>
+  <reg name="fstat" bitsize="32" type="int" group="float"/>
+  <reg name="ftag" bitsize="32" type="int" group="float"/>
+  <reg name="fiseg" bitsize="32" type="int" group="float"/>
+  <reg name="fioff" bitsize="32" type="int" group="float"/>
+  <reg name="foseg" bitsize="32" type="int" group="float"/>
+  <reg name="fooff" bitsize="32" type="int" group="float"/>
+  <reg name="fop" bitsize="32" type="int" group="float"/>
+<!--/feature>
+<feature name="org.gnu.gdb.i386.32bit.sse"-->
+  <vector id="v4f" type="ieee_single" count="4"/>
+  <vector id="v2d" type="ieee_double" count="2"/>
+  <vector id="v16i8" type="int8" count="16"/>
+  <vector id="v8i16" type="int16" count="8"/>
+  <vector id="v4i32" type="int32" count="4"/>
+  <vector id="v2i64" type="int64" count="2"/>
+  <union id="vec128">
+	<field name="v4_float" type="v4f"/>
+	<field name="v2_double" type="v2d"/>
+	<field name="v16_int8" type="v16i8"/>
+	<field name="v8_int16" type="v8i16"/>
+	<field name="v4_int32" type="v4i32"/>
+	<field name="v2_int64" type="v2i64"/>
+	<field name="uint128" type="uint128"/>
+  </union>
+  <flags id="i386_mxcsr" size="4">
+	<field name="IE" start="0" end="0"/>
+	<field name="DE" start="1" end="1"/>
+	<field name="ZE" start="2" end="2"/>
+	<field name="OE" start="3" end="3"/>
+	<field name="UE" start="4" end="4"/>
+	<field name="PE" start="5" end="5"/>
+	<field name="DAZ" start="6" end="6"/>
+	<field name="IM" start="7" end="7"/>
+	<field name="DM" start="8" end="8"/>
+	<field name="ZM" start="9" end="9"/>
+	<field name="OM" start="10" end="10"/>
+	<field name="UM" start="11" end="11"/>
+	<field name="PM" start="12" end="12"/>
+	<field name="FZ" start="15" end="15"/>
+  </flags>
+
+  <reg name="xmm0" bitsize="128" type="vec128"/>
+  <reg name="xmm1" bitsize="128" type="vec128"/>
+  <reg name="xmm2" bitsize="128" type="vec128"/>
+  <reg name="xmm3" bitsize="128" type="vec128"/>
+  <reg name="xmm4" bitsize="128" type="vec128"/>
+  <reg name="xmm5" bitsize="128" type="vec128"/>
+  <reg name="xmm6" bitsize="128" type="vec128"/>
+  <reg name="xmm7" bitsize="128" type="vec128"/>
+
+  <reg name="mxcsr" bitsize="32" type="i386_mxcsr" group="vector"/>
 </feature>
diff --git a/gdb-xml/i386-64bit-core.xml b/gdb-xml/i386-64bit-core.xml
deleted file mode 100644
index 5088d84ceb..0000000000
--- a/gdb-xml/i386-64bit-core.xml
+++ /dev/null
@@ -1,73 +0,0 @@
-<?xml version="1.0"?>
-<!-- Copyright (C) 2010-2015 Free Software Foundation, Inc.
-
-     Copying and distribution of this file, with or without modification,
-     are permitted in any medium without royalty provided the copyright
-     notice and this notice are preserved.  -->
-
-<!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.i386.core">
-  <flags id="i386_eflags" size="4">
-    <field name="CF" start="0" end="0"/>
-    <field name="" start="1" end="1"/>
-    <field name="PF" start="2" end="2"/>
-    <field name="AF" start="4" end="4"/>
-    <field name="ZF" start="6" end="6"/>
-    <field name="SF" start="7" end="7"/>
-    <field name="TF" start="8" end="8"/>
-    <field name="IF" start="9" end="9"/>
-    <field name="DF" start="10" end="10"/>
-    <field name="OF" start="11" end="11"/>
-    <field name="NT" start="14" end="14"/>
-    <field name="RF" start="16" end="16"/>
-    <field name="VM" start="17" end="17"/>
-    <field name="AC" start="18" end="18"/>
-    <field name="VIF" start="19" end="19"/>
-    <field name="VIP" start="20" end="20"/>
-    <field name="ID" start="21" end="21"/>
-  </flags>
-
-  <reg name="rax" bitsize="64" type="int64"/>
-  <reg name="rbx" bitsize="64" type="int64"/>
-  <reg name="rcx" bitsize="64" type="int64"/>
-  <reg name="rdx" bitsize="64" type="int64"/>
-  <reg name="rsi" bitsize="64" type="int64"/>
-  <reg name="rdi" bitsize="64" type="int64"/>
-  <reg name="rbp" bitsize="64" type="data_ptr"/>
-  <reg name="rsp" bitsize="64" type="data_ptr"/>
-  <reg name="r8" bitsize="64" type="int64"/>
-  <reg name="r9" bitsize="64" type="int64"/>
-  <reg name="r10" bitsize="64" type="int64"/>
-  <reg name="r11" bitsize="64" type="int64"/>
-  <reg name="r12" bitsize="64" type="int64"/>
-  <reg name="r13" bitsize="64" type="int64"/>
-  <reg name="r14" bitsize="64" type="int64"/>
-  <reg name="r15" bitsize="64" type="int64"/>
-
-  <reg name="rip" bitsize="64" type="code_ptr"/>
-  <reg name="eflags" bitsize="32" type="i386_eflags"/>
-  <reg name="cs" bitsize="32" type="int32"/>
-  <reg name="ss" bitsize="32" type="int32"/>
-  <reg name="ds" bitsize="32" type="int32"/>
-  <reg name="es" bitsize="32" type="int32"/>
-  <reg name="fs" bitsize="32" type="int32"/>
-  <reg name="gs" bitsize="32" type="int32"/>
-
-  <reg name="st0" bitsize="80" type="i387_ext"/>
-  <reg name="st1" bitsize="80" type="i387_ext"/>
-  <reg name="st2" bitsize="80" type="i387_ext"/>
-  <reg name="st3" bitsize="80" type="i387_ext"/>
-  <reg name="st4" bitsize="80" type="i387_ext"/>
-  <reg name="st5" bitsize="80" type="i387_ext"/>
-  <reg name="st6" bitsize="80" type="i387_ext"/>
-  <reg name="st7" bitsize="80" type="i387_ext"/>
-
-  <reg name="fctrl" bitsize="32" type="int" group="float"/>
-  <reg name="fstat" bitsize="32" type="int" group="float"/>
-  <reg name="ftag" bitsize="32" type="int" group="float"/>
-  <reg name="fiseg" bitsize="32" type="int" group="float"/>
-  <reg name="fioff" bitsize="32" type="int" group="float"/>
-  <reg name="foseg" bitsize="32" type="int" group="float"/>
-  <reg name="fooff" bitsize="32" type="int" group="float"/>
-  <reg name="fop" bitsize="32" type="int" group="float"/>
-</feature>
diff --git a/gdb-xml/i386-64bit-sse.xml b/gdb-xml/i386-64bit-sse.xml
deleted file mode 100644
index e86efc9ce5..0000000000
--- a/gdb-xml/i386-64bit-sse.xml
+++ /dev/null
@@ -1,60 +0,0 @@
-<?xml version="1.0"?>
-<!-- Copyright (C) 2010-2017 Free Software Foundation, Inc.
-
-     Copying and distribution of this file, with or without modification,
-     are permitted in any medium without royalty provided the copyright
-     notice and this notice are preserved.  -->
-
-<!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.i386.64bit.sse">
-  <vector id="v4f" type="ieee_single" count="4"/>
-  <vector id="v2d" type="ieee_double" count="2"/>
-  <vector id="v16i8" type="int8" count="16"/>
-  <vector id="v8i16" type="int16" count="8"/>
-  <vector id="v4i32" type="int32" count="4"/>
-  <vector id="v2i64" type="int64" count="2"/>
-  <union id="vec128">
-    <field name="v4_float" type="v4f"/>
-    <field name="v2_double" type="v2d"/>
-    <field name="v16_int8" type="v16i8"/>
-    <field name="v8_int16" type="v8i16"/>
-    <field name="v4_int32" type="v4i32"/>
-    <field name="v2_int64" type="v2i64"/>
-    <field name="uint128" type="uint128"/>
-  </union>
-  <flags id="i386_mxcsr" size="4">
-    <field name="IE" start="0" end="0"/>
-    <field name="DE" start="1" end="1"/>
-    <field name="ZE" start="2" end="2"/>
-    <field name="OE" start="3" end="3"/>
-    <field name="UE" start="4" end="4"/>
-    <field name="PE" start="5" end="5"/>
-    <field name="DAZ" start="6" end="6"/>
-    <field name="IM" start="7" end="7"/>
-    <field name="DM" start="8" end="8"/>
-    <field name="ZM" start="9" end="9"/>
-    <field name="OM" start="10" end="10"/>
-    <field name="UM" start="11" end="11"/>
-    <field name="PM" start="12" end="12"/>
-    <field name="FZ" start="15" end="15"/>
-  </flags>
-
-  <reg name="xmm0" bitsize="128" type="vec128" regnum="40"/>
-  <reg name="xmm1" bitsize="128" type="vec128"/>
-  <reg name="xmm2" bitsize="128" type="vec128"/>
-  <reg name="xmm3" bitsize="128" type="vec128"/>
-  <reg name="xmm4" bitsize="128" type="vec128"/>
-  <reg name="xmm5" bitsize="128" type="vec128"/>
-  <reg name="xmm6" bitsize="128" type="vec128"/>
-  <reg name="xmm7" bitsize="128" type="vec128"/>
-  <reg name="xmm8" bitsize="128" type="vec128"/>
-  <reg name="xmm9" bitsize="128" type="vec128"/>
-  <reg name="xmm10" bitsize="128" type="vec128"/>
-  <reg name="xmm11" bitsize="128" type="vec128"/>
-  <reg name="xmm12" bitsize="128" type="vec128"/>
-  <reg name="xmm13" bitsize="128" type="vec128"/>
-  <reg name="xmm14" bitsize="128" type="vec128"/>
-  <reg name="xmm15" bitsize="128" type="vec128"/>
-
-  <reg name="mxcsr" bitsize="32" type="i386_mxcsr" group="vector"/>
-</feature>
diff --git a/gdb-xml/i386-64bit.xml b/gdb-xml/i386-64bit.xml
index 0b2f00ccbe..6d88969211 100644
--- a/gdb-xml/i386-64bit.xml
+++ b/gdb-xml/i386-64bit.xml
@@ -5,10 +5,212 @@
      are permitted in any medium without royalty provided the copyright
      notice and this notice are preserved.  -->
 
-<!-- I386 64bit -->
+<!-- x86_64 64bit -->
 
 <!DOCTYPE target SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.i386.64bit">
-  <xi:include href="i386-64bit-core.xml"/>
-  <xi:include href="i386-64bit-sse.xml"/>
+
+<feature name="org.gnu.gdb.i386.core">
+  <flags id="x64_eflags" size="4">
+	<field name="" start="22" end="31"/>
+	<field name="ID" start="21" end="21"/>
+	<field name="VIP" start="20" end="20"/>
+	<field name="VIF" start="19" end="19"/>
+	<field name="AC" start="18" end="18"/>
+	<field name="VM" start="17" end="17"/>
+	<field name="RF" start="16" end="16"/>
+	<field name="" start="15" end="15"/>
+	<field name="NT" start="14" end="14"/>
+	<field name="IOPL" start="12" end="13"/>
+	<field name="OF" start="11" end="11"/>
+	<field name="DF" start="10" end="10"/>
+	<field name="IF" start="9" end="9"/>
+	<field name="TF" start="8" end="8"/>
+	<field name="SF" start="7" end="7"/>
+	<field name="ZF" start="6" end="6"/>
+	<field name="" start="5" end="5"/>
+	<field name="AF" start="4" end="4"/>
+	<field name="" start="3" end="3"/>
+	<field name="PF" start="2" end="2"/>
+	<field name="" start="1" end="1"/>
+	<field name="CF" start="0" end="0"/>
+  </flags>
+
+  <!-- General registers -->
+
+  <reg name="rax" bitsize="64" type="int64" regnum="0"/>
+  <reg name="rbx" bitsize="64" type="int64"/>
+  <reg name="rcx" bitsize="64" type="int64"/>
+  <reg name="rdx" bitsize="64" type="int64"/>
+  <reg name="rsi" bitsize="64" type="int64"/>
+  <reg name="rdi" bitsize="64" type="int64"/>
+  <reg name="rbp" bitsize="64" type="data_ptr"/>
+  <reg name="rsp" bitsize="64" type="data_ptr"/>
+  <reg name="r8" bitsize="64" type="int64"/>
+  <reg name="r9" bitsize="64" type="int64"/>
+  <reg name="r10" bitsize="64" type="int64"/>
+  <reg name="r11" bitsize="64" type="int64"/>
+  <reg name="r12" bitsize="64" type="int64"/>
+  <reg name="r13" bitsize="64" type="int64"/>
+  <reg name="r14" bitsize="64" type="int64"/>
+  <reg name="r15" bitsize="64" type="int64"/>
+
+  <reg name="rip" bitsize="64" type="code_ptr"/>
+  <reg name="eflags" bitsize="32" type="x64_eflags"/>
+
+  <!-- Segment registers -->
+
+  <reg name="cs" bitsize="32" type="int32"/>
+  <reg name="ss" bitsize="32" type="int32"/>
+  <reg name="ds" bitsize="32" type="int32"/>
+  <reg name="es" bitsize="32" type="int32"/>
+  <reg name="fs" bitsize="32" type="int32"/>
+  <reg name="gs" bitsize="32" type="int32"/>
+
+  <!-- Segment descriptor caches and TLS base MSRs -->
+
+  <!--reg name="cs_base" bitsize="64" type="int64"/>
+  <reg name="ss_base" bitsize="64" type="int64"/>
+  <reg name="ds_base" bitsize="64" type="int64"/>
+  <reg name="es_base" bitsize="64" type="int64"/-->
+  <reg name="fs_base" bitsize="64" type="int64"/>
+  <reg name="gs_base" bitsize="64" type="int64"/>
+  <reg name="k_gs_base" bitsize="64" type="int64"/>
+
+  <!-- Control registers -->
+
+  <flags id="x64_cr0" size="8">
+	<field name="PG" start="31" end="31"/>
+	<field name="CD" start="30" end="30"/>
+	<field name="NW" start="29" end="29"/>
+	<field name="AM" start="18" end="18"/>
+	<field name="WP" start="16" end="16"/>
+	<field name="NE" start="5" end="5"/>
+	<field name="ET" start="4" end="4"/>
+	<field name="TS" start="3" end="3"/>
+	<field name="EM" start="2" end="2"/>
+	<field name="MP" start="1" end="1"/>
+	<field name="PE" start="0" end="0"/>
+  </flags>
+
+  <flags id="x64_cr3" size="8">
+	<field name="PDBR" start="12" end="63"/>
+	<!--field name="" start="3" end="11"/>
+	<field name="WT" start="2" end="2"/>
+	<field name="CD" start="1" end="1"/>
+	<field name="" start="0" end="0"/-->
+	<field name="PCID" start="0" end="11"/>
+  </flags>
+
+  <flags id="x64_cr4" size="8">
+	<field name="PKE" start="22" end="22"/>
+	<field name="SMAP" start="21" end="21"/>
+	<field name="SMEP" start="20" end="20"/>
+	<field name="OSXSAVE" start="18" end="18"/>
+	<field name="PCIDE" start="17" end="17"/>
+	<field name="FSGSBASE" start="16" end="16"/>
+	<field name="SMXE" start="14" end="14"/>
+	<field name="VMXE" start="13" end="13"/>
+	<field name="LA57" start="12" end="12"/>
+	<field name="UMIP" start="11" end="11"/>
+	<field name="OSXMMEXCPT" start="10" end="10"/>
+	<field name="OSFXSR" start="9" end="9"/>
+	<field name="PCE" start="8" end="8"/>
+	<field name="PGE" start="7" end="7"/>
+	<field name="MCE" start="6" end="6"/>
+	<field name="PAE" start="5" end="5"/>
+	<field name="PSE" start="4" end="4"/>
+	<field name="DE" start="3" end="3"/>
+	<field name="TSD" start="2" end="2"/>
+	<field name="PVI" start="1" end="1"/>
+	<field name="VME" start="0" end="0"/>
+  </flags>
+
+  <flags id="x64_efer" size="8">
+	<field name="TCE" start="15" end="15"/>
+	<field name="FFXSR" start="14" end="14"/>
+	<field name="LMSLE" start="13" end="13"/>
+	<field name="SVME" start="12" end="12"/>
+	<field name="NXE" start="11" end="11"/>
+	<field name="LMA" start="10" end="10"/>
+	<field name="LME" start="8" end="8"/>
+	<field name="SCE" start="0" end="0"/>
+  </flags>
+
+  <reg name="cr0" bitsize="64" type="x64_cr0"/>
+  <reg name="cr2" bitsize="64" type="int64"/>
+  <reg name="cr3" bitsize="64" type="x64_cr3"/>
+  <reg name="cr4" bitsize="64" type="x64_cr4"/>
+  <reg name="cr8" bitsize="64" type="int64"/>
+  <reg name="efer" bitsize="64" type="x64_efer"/>
+
+  <!-- x87 FPU -->
+
+  <reg name="st0" bitsize="80" type="i387_ext"/>
+  <reg name="st1" bitsize="80" type="i387_ext"/>
+  <reg name="st2" bitsize="80" type="i387_ext"/>
+  <reg name="st3" bitsize="80" type="i387_ext"/>
+  <reg name="st4" bitsize="80" type="i387_ext"/>
+  <reg name="st5" bitsize="80" type="i387_ext"/>
+  <reg name="st6" bitsize="80" type="i387_ext"/>
+  <reg name="st7" bitsize="80" type="i387_ext"/>
+
+  <reg name="fctrl" bitsize="32" type="int" group="float"/>
+  <reg name="fstat" bitsize="32" type="int" group="float"/>
+  <reg name="ftag" bitsize="32" type="int" group="float"/>
+  <reg name="fiseg" bitsize="32" type="int" group="float"/>
+  <reg name="fioff" bitsize="32" type="int" group="float"/>
+  <reg name="foseg" bitsize="32" type="int" group="float"/>
+  <reg name="fooff" bitsize="32" type="int" group="float"/>
+  <reg name="fop" bitsize="32" type="int" group="float"/>
+
+  <vector id="v4f" type="ieee_single" count="4"/>
+  <vector id="v2d" type="ieee_double" count="2"/>
+  <vector id="v16i8" type="int8" count="16"/>
+  <vector id="v8i16" type="int16" count="8"/>
+  <vector id="v4i32" type="int32" count="4"/>
+  <vector id="v2i64" type="int64" count="2"/>
+  <union id="vec128">
+	<field name="v4_float" type="v4f"/>
+	<field name="v2_double" type="v2d"/>
+	<field name="v16_int8" type="v16i8"/>
+	<field name="v8_int16" type="v8i16"/>
+	<field name="v4_int32" type="v4i32"/>
+	<field name="v2_int64" type="v2i64"/>
+	<field name="uint128" type="uint128"/>
+  </union>
+  <flags id="x64_mxcsr" size="4">
+	<field name="IE" start="0" end="0"/>
+	<field name="DE" start="1" end="1"/>
+	<field name="ZE" start="2" end="2"/>
+	<field name="OE" start="3" end="3"/>
+	<field name="UE" start="4" end="4"/>
+	<field name="PE" start="5" end="5"/>
+	<field name="DAZ" start="6" end="6"/>
+	<field name="IM" start="7" end="7"/>
+	<field name="DM" start="8" end="8"/>
+	<field name="ZM" start="9" end="9"/>
+	<field name="OM" start="10" end="10"/>
+	<field name="UM" start="11" end="11"/>
+	<field name="PM" start="12" end="12"/>
+	<field name="FZ" start="15" end="15"/>
+  </flags>
+
+  <reg name="xmm0" bitsize="128" type="vec128"/>
+  <reg name="xmm1" bitsize="128" type="vec128"/>
+  <reg name="xmm2" bitsize="128" type="vec128"/>
+  <reg name="xmm3" bitsize="128" type="vec128"/>
+  <reg name="xmm4" bitsize="128" type="vec128"/>
+  <reg name="xmm5" bitsize="128" type="vec128"/>
+  <reg name="xmm6" bitsize="128" type="vec128"/>
+  <reg name="xmm7" bitsize="128" type="vec128"/>
+  <reg name="xmm8" bitsize="128" type="vec128"/>
+  <reg name="xmm9" bitsize="128" type="vec128"/>
+  <reg name="xmm10" bitsize="128" type="vec128"/>
+  <reg name="xmm11" bitsize="128" type="vec128"/>
+  <reg name="xmm12" bitsize="128" type="vec128"/>
+  <reg name="xmm13" bitsize="128" type="vec128"/>
+  <reg name="xmm14" bitsize="128" type="vec128"/>
+  <reg name="xmm15" bitsize="128" type="vec128"/>
+
+  <reg name="mxcsr" bitsize="32" type="x64_mxcsr" group="vector"/>
 </feature>
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fa37203d89..1e20f6f5ca 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5826,10 +5826,10 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->gdb_arch_name = x86_gdb_arch_name;
 #ifdef TARGET_X86_64
     cc->gdb_core_xml_file = "i386-64bit.xml";
-    cc->gdb_num_core_regs = 57;
+    cc->gdb_num_core_regs = 66;
 #else
     cc->gdb_core_xml_file = "i386-32bit.xml";
-    cc->gdb_num_core_regs = 41;
+    cc->gdb_num_core_regs = 50;
 #endif
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     cc->debug_excp_handler = breakpoint_handler;
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 9b94ab852c..3c20b927f0 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -32,18 +32,61 @@ static const int gpr_map[16] = {
 #endif
 static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 
+/*
+ * Keep these in sync with assignment to
+ * gdb_num_core_regs in target/i386/cpu.c
+ * and with the machine description
+ */
+
+/*
+ * SEG: 6 segments, plus fs_base, gs_base, kernel_gs_base
+ */
+
+/*
+ * general regs ----->  8 or 16
+ */
+#define IDX_NB_IP       1
+#define IDX_NB_FLAGS    1
+#define IDX_NB_SEG      (6 + 3)
+#define IDX_NB_CTL      6
+#define IDX_NB_FP       16
+/*
+ * fpu regs ----------> 8 or 16
+ */
+#define IDX_NB_MXCSR    1
+/*
+ *          total ----> 8+1+1+9+6+16+8+1=50 or 16+1+1+9+6+16+16+1=66
+ */
+
 #define IDX_IP_REG      CPU_NB_REGS
-#define IDX_FLAGS_REG   (IDX_IP_REG + 1)
-#define IDX_SEG_REGS    (IDX_FLAGS_REG + 1)
-#define IDX_FP_REGS     (IDX_SEG_REGS + 6)
-#define IDX_XMM_REGS    (IDX_FP_REGS + 16)
+#define IDX_FLAGS_REG   (IDX_IP_REG + IDX_NB_IP)
+#define IDX_SEG_REGS    (IDX_FLAGS_REG + IDX_NB_FLAGS)
+#define IDX_CTL_REGS    (IDX_SEG_REGS + IDX_NB_SEG)
+#define IDX_FP_REGS     (IDX_CTL_REGS + IDX_NB_CTL)
+#define IDX_XMM_REGS    (IDX_FP_REGS + IDX_NB_FP)
 #define IDX_MXCSR_REG   (IDX_XMM_REGS + CPU_NB_REGS)
 
+#define IDX_CTL_CR0_REG     (IDX_CTL_REGS + 0)
+#define IDX_CTL_CR2_REG     (IDX_CTL_REGS + 1)
+#define IDX_CTL_CR3_REG     (IDX_CTL_REGS + 2)
+#define IDX_CTL_CR4_REG     (IDX_CTL_REGS + 3)
+#define IDX_CTL_CR8_REG     (IDX_CTL_REGS + 4)
+#define IDX_CTL_EFER_REG    (IDX_CTL_REGS + 5)
+
+#ifdef TARGET_X86_64
+#define GDB_FORCE_64 1
+#else
+#define GDB_FORCE_64 0
+#endif
+
+
 int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
+    uint64_t tpr;
+
     /* N.B. GDB can't deal with changes in registers or sizes in the middle
        of a session. So if we're in 32-bit mode on a 64-bit cpu, still act
        as if we're on a 64-bit cpu. */
@@ -105,6 +148,28 @@ int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         case IDX_SEG_REGS + 5:
             return gdb_get_reg32(mem_buf, env->segs[R_GS].selector);
 
+        case IDX_SEG_REGS + 6:
+            if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+                return gdb_get_reg64(mem_buf, env->segs[R_FS].base);
+            }
+            return gdb_get_reg32(mem_buf, env->segs[R_FS].base);
+
+        case IDX_SEG_REGS + 7:
+            if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+                return gdb_get_reg64(mem_buf, env->segs[R_GS].base);
+            }
+            return gdb_get_reg32(mem_buf, env->segs[R_GS].base);
+
+        case IDX_SEG_REGS + 8:
+#ifdef TARGET_X86_64
+            if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+                return gdb_get_reg64(mem_buf, env->kernelgsbase);
+            }
+            return gdb_get_reg32(mem_buf, env->kernelgsbase);
+#else
+            return gdb_get_reg32(mem_buf, 0);
+#endif
+
         case IDX_FP_REGS + 8:
             return gdb_get_reg32(mem_buf, env->fpuc);
         case IDX_FP_REGS + 9:
@@ -125,6 +190,44 @@ int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 
         case IDX_MXCSR_REG:
             return gdb_get_reg32(mem_buf, env->mxcsr);
+
+        case IDX_CTL_CR0_REG:
+            if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+                return gdb_get_reg64(mem_buf, env->cr[0]);
+            }
+            return gdb_get_reg32(mem_buf, env->cr[0]);
+
+        case IDX_CTL_CR2_REG:
+            if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+                return gdb_get_reg64(mem_buf, env->cr[2]);
+            }
+            return gdb_get_reg32(mem_buf, env->cr[2]);
+
+        case IDX_CTL_CR3_REG:
+            if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+                return gdb_get_reg64(mem_buf, env->cr[3]);
+            }
+            return gdb_get_reg32(mem_buf, env->cr[3]);
+
+        case IDX_CTL_CR4_REG:
+            if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+                return gdb_get_reg64(mem_buf, env->cr[4]);
+            }
+            return gdb_get_reg32(mem_buf, env->cr[4]);
+
+        case IDX_CTL_CR8_REG:
+            tpr = cpu_get_apic_tpr(cpu->apic_state);
+            if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+                return gdb_get_reg64(mem_buf, tpr);
+            }
+            return gdb_get_reg32(mem_buf, tpr);
+
+        case IDX_CTL_EFER_REG:
+            if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+                return gdb_get_reg64(mem_buf, env->efer);
+            }
+            return gdb_get_reg32(mem_buf, env->efer);
+
         }
     }
     return 0;
@@ -229,6 +332,32 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         case IDX_SEG_REGS + 5:
             return x86_cpu_gdb_load_seg(cpu, R_GS, mem_buf);
 
+        case IDX_SEG_REGS + 6:
+            if (env->hflags & HF_CS64_MASK) {
+                env->segs[R_FS].base = ldq_p(mem_buf);
+                return 8;
+            }
+            env->segs[R_FS].base = ldl_p(mem_buf);
+            return 4;
+
+        case IDX_SEG_REGS + 7:
+            if (env->hflags & HF_CS64_MASK) {
+                env->segs[R_GS].base = ldq_p(mem_buf);
+                return 8;
+            }
+            env->segs[R_GS].base = ldl_p(mem_buf);
+            return 4;
+
+#ifdef TARGET_X86_64
+        case IDX_SEG_REGS + 8:
+            if (env->hflags & HF_CS64_MASK) {
+                env->kernelgsbase = ldq_p(mem_buf);
+                return 8;
+            }
+            env->kernelgsbase = ldl_p(mem_buf);
+            return 4;
+#endif
+
         case IDX_FP_REGS + 8:
             cpu_set_fpuc(env, ldl_p(mem_buf));
             return 4;
@@ -253,6 +382,55 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         case IDX_MXCSR_REG:
             cpu_set_mxcsr(env, ldl_p(mem_buf));
             return 4;
+
+        case IDX_CTL_CR0_REG:
+            if (env->hflags & HF_CS64_MASK) {
+                cpu_x86_update_cr0(env, ldq_p(mem_buf));
+                return 8;
+            }
+            cpu_x86_update_cr0(env, ldl_p(mem_buf));
+            return 4;
+
+        case IDX_CTL_CR2_REG:
+            if (env->hflags & HF_CS64_MASK) {
+                env->cr[2] = ldq_p(mem_buf);
+                return 8;
+            }
+            env->cr[2] = ldl_p(mem_buf);
+            return 4;
+
+        case IDX_CTL_CR3_REG:
+            if (env->hflags & HF_CS64_MASK) {
+                cpu_x86_update_cr3(env, ldq_p(mem_buf));
+                return 8;
+            }
+            cpu_x86_update_cr3(env, ldl_p(mem_buf));
+            return 4;
+
+        case IDX_CTL_CR4_REG:
+            if (env->hflags & HF_CS64_MASK) {
+                cpu_x86_update_cr4(env, ldq_p(mem_buf));
+                return 8;
+            }
+            cpu_x86_update_cr4(env, ldl_p(mem_buf));
+            return 4;
+
+        case IDX_CTL_CR8_REG:
+            if (env->hflags & HF_CS64_MASK) {
+                cpu_set_apic_tpr(cpu->apic_state, ldq_p(mem_buf));
+                return 8;
+            }
+            cpu_set_apic_tpr(cpu->apic_state, ldl_p(mem_buf));
+            return 4;
+
+        case IDX_CTL_EFER_REG:
+            if (env->hflags & HF_CS64_MASK) {
+                cpu_load_efer(env, ldq_p(mem_buf));
+                return 8;
+            }
+            cpu_load_efer(env, ldl_p(mem_buf));
+            return 4;
+
         }
     }
     /* Unrecognised register.  */
-- 
2.17.1
