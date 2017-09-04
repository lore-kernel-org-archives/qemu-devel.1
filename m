Received: from eggs.gnu.org ([2001:4830:134:3::10]:34105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dom3E-000714-7H
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dom3B-0003Se-3g
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:44:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1dom3A-0003RS-Rh
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:44:05 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v847dtFK070128
	for <qemu-devel@nongnu.org>; Mon, 4 Sep 2017 03:44:02 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2crq2nga32-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 03:44:02 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Mon, 4 Sep 2017 17:43:59 +1000
From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Date: Mon,  4 Sep 2017 13:13:51 +0530
Message-Id: <1504511031-26834-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5] vl: exit if maxcpus is negative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: s1seetee@linux.vnet.ibm.com

---Steps to Reproduce---

When passed a negative number to 'maxcpus' parameter, Qemu aborts
with a core dump.

Run the following command with maxcpus argument as negative number

ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
pseries,accel=kvm,kvm-type=HV -m size=200g -device virtio-blk-pci,
drive=rootdisk -drive file=/home/images/pegas-1.0-ppc64le.qcow2,
if=none,cache=none,id=rootdisk,format=qcow2 -monitor telnet
:127.0.0.1:1234,server,nowait -net nic,model=virtio -net
user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=1,
threads=1,maxcpus=-12

(process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
 18446744073709550568 bytes

Trace/breakpoint trap

Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
v1 -> v2:
  - Fix the error check in vl.c to make it generic.
v2 -> v3:
  - Fix coding style pointed out by patchew.
  - Fix check for "<= 0" instead of just "< 0".
v3 -> v4:
  - Fix subject line.
  - Removed space before ":" from vl.c:1248
  - Removed Reviewed-by: flag
v4-> v5:
  - Code rework to declare max_cpus as unsigned int in sysemu.h
  - Remove the error check in vl.c referred in v2.
  - declare max_cpus as unsigned int in vl.c
---
 include/sysemu/sysemu.h | 2 +-
 vl.c                    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index b213696..c083869 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -113,7 +113,7 @@ extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
 extern int smp_cpus;
-extern int max_cpus;
+extern unsigned int max_cpus;
 extern int cursor_hide;
 extern int graphic_rotate;
 extern int no_quit;
diff --git a/vl.c b/vl.c
index 8e247cc..1470c21 100644
--- a/vl.c
+++ b/vl.c
@@ -164,7 +164,7 @@ Chardev *sclp_hds[MAX_SCLP_CONSOLES];
 int win2k_install_hack = 0;
 int singlestep = 0;
 int smp_cpus = 1;
-int max_cpus = 1;
+unsigned int max_cpus = 1;
 int smp_cores = 1;
 int smp_threads = 1;
 int acpi_enabled = 1;
@@ -4233,8 +4233,8 @@ int main(int argc, char **argv, char **envp)
 
     machine_class->max_cpus = machine_class->max_cpus ?: 1; /* Default to UP */
     if (max_cpus > machine_class->max_cpus) {
-        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
-                     "supported by machine '%s' (%d)", max_cpus,
+        error_report("Invalid SMP CPUs %d. The max CPUs "
+                     "supported by machine '%s' is %d", max_cpus,
                      machine_class->name, machine_class->max_cpus);
         exit(1);
     }
-- 
1.8.3.1
