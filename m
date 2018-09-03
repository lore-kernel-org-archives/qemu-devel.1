Received: from eggs.gnu.org ([2001:4830:134:3::10]:47205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.ibm.com>) id 1fwrgQ-0005p3-A1
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 12:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.ibm.com>) id 1fwrgK-000439-Uv
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 12:26:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.ibm.com>)
	id 1fwrgK-00042R-Lz
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 12:26:28 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w83GOS4b033740
	for <qemu-devel@nongnu.org>; Mon, 3 Sep 2018 12:26:24 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m97kt21ky-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 12:26:24 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.ibm.com>;
	Mon, 3 Sep 2018 10:26:24 -0600
From: Jose Ricardo Ziviani <joserz@linux.ibm.com>
Date: Mon,  3 Sep 2018 13:26:13 -0300
Message-Id: <20180903162613.15877-1-joserz@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] Add a hint message to loadvm and exits on
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com

This patch adds a small hint for the failure case of the load snapshot
process. It may be useful for users to remember that the VM
configuration has changed between the save and load processes.

(qemu) loadvm vm-20180903083641
Unknown savevm section or instance 'cpu_common' 4.
Make sure that your current VM setup matches your saved VM setup, including any hotplugged devices
Error -22 while loading VM state
(qemu) device_add host-spapr-cpu-core,core-id=4
(qemu) loadvm vm-20180903083641
(qemu) c
(qemu) info status
VM status: running

It also exits Qemu if the snapshot cannot be loaded before reaching the
main loop (-loadvm in the command line).

$ qemu-system-ppc64 ... -loadvm vm-20180903083641
qemu-system-ppc64: Unknown savevm section or instance 'cpu_common' 4.
Make sure that your current VM setup matches your saved VM setup, including any hotplugged devices
qemu-system-ppc64: Error -22 while loading VM state
$

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
---
 migration/savevm.c | 4 +++-
 vl.c               | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 13e51f0e34..9692577318 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2078,7 +2078,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
     /* Find savevm section */
     se = find_se(idstr, instance_id);
     if (se == NULL) {
-        error_report("Unknown savevm section or instance '%s' %d",
+        error_report("Unknown savevm section or instance '%s' %d. "
+                     "Make sure that your current VM setup matches your "
+                     "saved VM setup, including any hotplugged devices",
                      idstr, instance_id);
         return -EINVAL;
     }
diff --git a/vl.c b/vl.c
index 5ba06adf78..c63270a76a 100644
--- a/vl.c
+++ b/vl.c
@@ -4620,6 +4620,7 @@ int main(int argc, char **argv, char **envp)
         if (load_snapshot(loadvm, &local_err) < 0) {
             error_report_err(local_err);
             autostart = 0;
+            exit(1);
         }
     }
 
-- 
2.17.1
