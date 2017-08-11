Received: from eggs.gnu.org ([2001:4830:134:3::10]:45743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dg58g-0001ej-Gn
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dg58b-0001Ee-Da
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:17:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:18607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dg58b-0001B4-2U
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:17:45 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 10 Aug 2017 22:11:12 -0400
Message-Id: <1502417472-15511-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH v2] x86: Increase max vcpu number to 8192
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, berrange@redhat.com, rkrcmar@redhat.com

Intel Xeon phi chip will support 352 logical threads. For HPC
usage case, it will create a huge VM with vcpus number as same as host
cpus. This patch is to increase max vcpu number from 288 to 8192 which
is current default maximum cpu number for Linux kernel.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
Change since v1:
	* Bump max vcpu number from 352 to 8192
	* Add compat support for new max vcpu limitation

 hw/i386/pc_q35.c     | 15 ++++++++++++---
 include/hw/i386/pc.h |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 169a214..06fdc95 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -299,14 +299,23 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_display = "std";
     m->no_floppy = 1;
     m->has_dynamic_sysbus = true;
-    m->max_cpus = 288;
+    m->max_cpus = 8192;
 }
 
+static void pc_q35_2_11_machine_options(MachineClass *m)
+{
+     pc_q35_machine_options(m);
+     m->alias = "q35";
+}
+DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
+                   pc_q35_2_11_machine_options);
+
 static void pc_q35_2_10_machine_options(MachineClass *m)
 {
-    pc_q35_machine_options(m);
-    m->alias = "q35";
+    pc_q35_2_11_machine_options(m);
+    m->max_cpus = 288;
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
 }
 
 DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d80859b..634abc6 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -369,6 +369,8 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_2_10 \
+    HW_COMPAT_2_10 \
 #define PC_COMPAT_2_9 \
     HW_COMPAT_2_9 \
     {\
-- 
1.8.3.1
