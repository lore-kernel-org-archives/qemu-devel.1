Received: from eggs.gnu.org ([209.51.188.92]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6Ab-0003Pg-7F
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ64X-00006E-WC
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:13721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJ64X-00005J-OW
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:37 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 24 Apr 2019 08:46:59 +0800
Message-Id: <20190424004700.12766-4-richardw.yang@linux.intel.com>
In-Reply-To: <20190424004700.12766-1-richardw.yang@linux.intel.com>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/4] migration/savevm: load_header before
 load_setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

In migration_thread() and qemu_savevm_state(), we savevm_state in
following sequence:

    qemu_savevm_state_header(f);
    qemu_savevm_state_setup(f);

Then it would be more proper to loadvm_state in the save sequence.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/savevm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6c61056cde..a80ae83663 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2427,10 +2427,6 @@ int qemu_loadvm_state(QEMUFile *f)
         return -ENOTSUP;
     }
 
-    if (qemu_loadvm_state_setup(f) != 0) {
-        return -EINVAL;
-    }
-
     if (migrate_get_current()->send_configuration) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
@@ -2445,6 +2441,10 @@ int qemu_loadvm_state(QEMUFile *f)
         }
     }
 
+    if (qemu_loadvm_state_setup(f) != 0) {
+        return -EINVAL;
+    }
+
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
-- 
2.19.1
