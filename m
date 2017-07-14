Received: from eggs.gnu.org ([2001:4830:134:3::10]:50975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVy2L-0003O6-U1
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVy2I-0003S3-P8
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:41:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42283
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVy2I-0003Rr-J6
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:41:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EAceYV022054
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 06:41:26 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpmhwrms7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 06:41:25 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 11:41:24 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:41:07 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-41-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 40/40] s390x/gdb: add gs registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Let's provide the guarded storage registers via gdb server.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 configure              |  2 +-
 gdb-xml/s390-gs.xml    | 14 ++++++++++++++
 target/s390x/gdbstub.c | 24 ++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 gdb-xml/s390-gs.xml

diff --git a/configure b/configure
index 902653a..8cc4afb 100755
--- a/configure
+++ b/configure
@@ -6231,7 +6231,7 @@ case "$target_name" in
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   s390x)
-    gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml"
+    gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
   ;;
   tilegx)
   ;;
diff --git a/gdb-xml/s390-gs.xml b/gdb-xml/s390-gs.xml
new file mode 100644
index 0000000..0487d31
--- /dev/null
+++ b/gdb-xml/s390-gs.xml
@@ -0,0 +1,14 @@
+<?xml version="1.0"?>
+<!-- Copyright 2017 IBM Corp.
+
+     This work is licensed under the terms of the GNU GPL, version 2 or
+     (at your option) any later version. See the COPYING file in the
+     top-level directory. -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.s390.gs">
+  <reg name="gs_reserved" bitsize="64" type="uint64" group="system"/>
+  <reg name="gsd" bitsize="64" type="uint64" group="system"/>
+  <reg name="gssm" bitsize="64" type="uint64" group="system"/>
+  <reg name="gsepla" bitsize="64" type="data_ptr" group="system"/>
+</feature>
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 94ab74d..a7efafe 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -286,6 +286,26 @@ static int cpu_write_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 }
 #endif
 
+/* the values represent the positions in s390-gs.xml */
+#define S390_GS_RESERVED_REGNUM 0
+#define S390_GS_GSD_REGNUM      1
+#define S390_GS_GSSM_REGNUM     2
+#define S390_GS_GSEPLA_REGNUM   3
+/* total number of registers in s390-gs.xml */
+#define S390_NUM_GS_REGS 4
+
+static int cpu_read_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+{
+    return gdb_get_regl(mem_buf, env->gscb[n]);
+}
+
+static int cpu_write_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+{
+    env->gscb[n] = ldtul_p(mem_buf);
+    cpu_synchronize_post_init(ENV_GET_CPU(env));
+    return 8;
+}
+
 void s390_cpu_gdb_init(CPUState *cs)
 {
     gdb_register_coprocessor(cs, cpu_read_ac_reg,
@@ -300,6 +320,10 @@ void s390_cpu_gdb_init(CPUState *cs)
                              cpu_write_vreg,
                              S390_NUM_VREGS, "s390-vx.xml", 0);
 
+    gdb_register_coprocessor(cs, cpu_read_gs_reg,
+                             cpu_write_gs_reg,
+                             S390_NUM_GS_REGS, "s390-gs.xml", 0);
+
 #ifndef CONFIG_USER_ONLY
     gdb_register_coprocessor(cs, cpu_read_c_reg,
                              cpu_write_c_reg,
-- 
2.7.4
