Received: from eggs.gnu.org ([2001:4830:134:3::10]:47695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8X-0003Qo-OJ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8S-0003F1-IU
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1g0R8Q-0003CZ-QG
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:16 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Sep 2018 14:53:35 +0200
Message-Id: <20180913125343.10912-5-quintela@redhat.com>
In-Reply-To: <20180913125343.10912-1-quintela@redhat.com>
References: <20180913125343.10912-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/12] Add a hint message to loadvm and exits on
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Jose Ricardo Ziviani <joserz@linux.ibm.com>

From: Jose Ricardo Ziviani <joserz@linux.ibm.com>

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
Message-Id: <20180903162613.15877-1-joserz@linux.ibm.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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
