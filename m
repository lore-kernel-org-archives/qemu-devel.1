Received: from eggs.gnu.org ([2001:4830:134:3::10]:33861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flElh-0002Uv-W8
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEle-0003SK-RN
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:39:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46895 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEle-0003QJ-Et
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:39:54 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:16:46 +0200
Message-Id: <1533219424-7627-60-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 59/77] gdbstub: Add XML support for GDB for
 nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add XML support files for GDB for nanoMIPS.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 MAINTAINERS                |  3 ++-
 gdb-xml/nanomips-cp0.xml   | 13 +++++++++++++
 gdb-xml/nanomips-cpu.xml   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 gdb-xml/nanomips-dsp.xml   | 20 ++++++++++++++++++++
 gdb-xml/nanomips-fpu.xml   | 45 +++++++++++++++++++++++++++++++++++++++++++++
 gdb-xml/nanomips-linux.xml | 20 ++++++++++++++++++++
 6 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 gdb-xml/nanomips-cp0.xml
 create mode 100644 gdb-xml/nanomips-cpu.xml
 create mode 100644 gdb-xml/nanomips-dsp.xml
 create mode 100644 gdb-xml/nanomips-fpu.xml
 create mode 100644 gdb-xml/nanomips-linux.xml

diff --git a/MAINTAINERS b/MAINTAINERS
index 7130807..a4907d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -190,6 +190,8 @@ M: Aurelien Jarno <aurelien@aurel32.net>
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/
+F: disas/mips.c
+F: gdb-xml/*ips*.xml
 F: hw/mips/
 F: hw/misc/mips_*
 F: hw/intc/mips_gic.c
@@ -199,7 +201,6 @@ F: include/hw/misc/mips_*
 F: include/hw/intc/mips_gic.h
 F: include/hw/timer/mips_gictimer.h
 F: tests/tcg/mips/
-F: disas/mips.c
 
 Moxie
 M: Anthony Green <green@moxielogic.com>
diff --git a/gdb-xml/nanomips-cp0.xml b/gdb-xml/nanomips-cp0.xml
new file mode 100644
index 0000000..8095dc6
--- /dev/null
+++ b/gdb-xml/nanomips-cp0.xml
@@ -0,0 +1,13 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2007-2015 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.nanomips.cp0">
+  <reg name="status" bitsize="32"/>
+  <reg name="badvaddr" bitsize="32"/>
+  <reg name="cause" bitsize="32"/>
+</feature>
diff --git a/gdb-xml/nanomips-cpu.xml b/gdb-xml/nanomips-cpu.xml
new file mode 100644
index 0000000..6bba224
--- /dev/null
+++ b/gdb-xml/nanomips-cpu.xml
@@ -0,0 +1,44 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2007-2015 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.nanomips.cpu">
+  <reg name="r0" bitsize="32" regnum="0"/>
+  <reg name="r1" bitsize="32"/>
+  <reg name="r2" bitsize="32"/>
+  <reg name="r3" bitsize="32"/>
+  <reg name="r4" bitsize="32"/>
+  <reg name="r5" bitsize="32"/>
+  <reg name="r6" bitsize="32"/>
+  <reg name="r7" bitsize="32"/>
+  <reg name="r8" bitsize="32"/>
+  <reg name="r9" bitsize="32"/>
+  <reg name="r10" bitsize="32"/>
+  <reg name="r11" bitsize="32"/>
+  <reg name="r12" bitsize="32"/>
+  <reg name="r13" bitsize="32"/>
+  <reg name="r14" bitsize="32"/>
+  <reg name="r15" bitsize="32"/>
+  <reg name="r16" bitsize="32"/>
+  <reg name="r17" bitsize="32"/>
+  <reg name="r18" bitsize="32"/>
+  <reg name="r19" bitsize="32"/>
+  <reg name="r20" bitsize="32"/>
+  <reg name="r21" bitsize="32"/>
+  <reg name="r22" bitsize="32"/>
+  <reg name="r23" bitsize="32"/>
+  <reg name="r24" bitsize="32"/>
+  <reg name="r25" bitsize="32"/>
+  <reg name="r26" bitsize="32"/>
+  <reg name="r27" bitsize="32"/>
+  <reg name="r28" bitsize="32"/>
+  <reg name="r29" bitsize="32"/>
+  <reg name="r30" bitsize="32"/>
+  <reg name="r31" bitsize="32"/>
+
+  <reg name="pc" bitsize="32"/>
+</feature>
diff --git a/gdb-xml/nanomips-dsp.xml b/gdb-xml/nanomips-dsp.xml
new file mode 100644
index 0000000..950910f
--- /dev/null
+++ b/gdb-xml/nanomips-dsp.xml
@@ -0,0 +1,20 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2012-2015 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.nanomips.dsp">
+  <reg name="hi0" bitsize="32"/>
+  <reg name="lo0" bitsize="32"/>
+  <reg name="hi1" bitsize="32"/>
+  <reg name="lo1" bitsize="32"/>
+  <reg name="hi2" bitsize="32"/>
+  <reg name="lo2" bitsize="32"/>
+  <reg name="hi3" bitsize="32"/>
+  <reg name="lo3" bitsize="32"/>
+
+  <reg name="dspctl" bitsize="32"/>
+</feature>
diff --git a/gdb-xml/nanomips-fpu.xml b/gdb-xml/nanomips-fpu.xml
new file mode 100644
index 0000000..fd225a5
--- /dev/null
+++ b/gdb-xml/nanomips-fpu.xml
@@ -0,0 +1,45 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2007-2015 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.nanomips.fpu">
+  <reg name="f0" bitsize="64" type="ieee_double"/>
+  <reg name="f1" bitsize="64" type="ieee_double"/>
+  <reg name="f2" bitsize="64" type="ieee_double"/>
+  <reg name="f3" bitsize="64" type="ieee_double"/>
+  <reg name="f4" bitsize="64" type="ieee_double"/>
+  <reg name="f5" bitsize="64" type="ieee_double"/>
+  <reg name="f6" bitsize="64" type="ieee_double"/>
+  <reg name="f7" bitsize="64" type="ieee_double"/>
+  <reg name="f8" bitsize="64" type="ieee_double"/>
+  <reg name="f9" bitsize="64" type="ieee_double"/>
+  <reg name="f10" bitsize="64" type="ieee_double"/>
+  <reg name="f11" bitsize="64" type="ieee_double"/>
+  <reg name="f12" bitsize="64" type="ieee_double"/>
+  <reg name="f13" bitsize="64" type="ieee_double"/>
+  <reg name="f14" bitsize="64" type="ieee_double"/>
+  <reg name="f15" bitsize="64" type="ieee_double"/>
+  <reg name="f16" bitsize="64" type="ieee_double"/>
+  <reg name="f17" bitsize="64" type="ieee_double"/>
+  <reg name="f18" bitsize="64" type="ieee_double"/>
+  <reg name="f19" bitsize="64" type="ieee_double"/>
+  <reg name="f20" bitsize="64" type="ieee_double"/>
+  <reg name="f21" bitsize="64" type="ieee_double"/>
+  <reg name="f22" bitsize="64" type="ieee_double"/>
+  <reg name="f23" bitsize="64" type="ieee_double"/>
+  <reg name="f24" bitsize="64" type="ieee_double"/>
+  <reg name="f25" bitsize="64" type="ieee_double"/>
+  <reg name="f26" bitsize="64" type="ieee_double"/>
+  <reg name="f27" bitsize="64" type="ieee_double"/>
+  <reg name="f28" bitsize="64" type="ieee_double"/>
+  <reg name="f29" bitsize="64" type="ieee_double"/>
+  <reg name="f30" bitsize="64" type="ieee_double"/>
+  <reg name="f31" bitsize="64" type="ieee_double"/>
+
+  <reg name="fcsr" bitsize="32" group="float"/>
+  <reg name="fir" bitsize="32" group="float"/>
+</feature>
diff --git a/gdb-xml/nanomips-linux.xml b/gdb-xml/nanomips-linux.xml
new file mode 100644
index 0000000..8a04634
--- /dev/null
+++ b/gdb-xml/nanomips-linux.xml
@@ -0,0 +1,20 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2007-2015 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE target SYSTEM "gdb-target.dtd">
+<target>
+  <architecture>nanomips</architecture>
+  <osabi>GNU/Linux</osabi>
+  <xi:include href="nanomips-cpu.xml"/>
+  <xi:include href="nanomips-cp0.xml"/>
+  <xi:include href="nanomips-fpu.xml"/>
+  <xi:include href="nanomips-dsp.xml"/>
+
+  <feature name="org.gnu.gdb.nanomips.linux">
+    <reg name="restart" bitsize="32" group="system"/>
+  </feature>
+</target>
-- 
1.9.1
