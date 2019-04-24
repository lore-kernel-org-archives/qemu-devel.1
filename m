Received: from eggs.gnu.org ([209.51.188.92]:57449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6Ab-0003TN-MV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ64V-0008VE-Pd
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:13718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJ64V-0008TP-Hn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:35 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 24 Apr 2019 08:46:58 +0800
Message-Id: <20190424004700.12766-3-richardw.yang@linux.intel.com>
In-Reply-To: <20190424004700.12766-1-richardw.yang@linux.intel.com>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] migration/savevm: use migration_is_blocked
 to validate
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

migration_is_blocked() is used in migrate_prepare() and
save_snapshot(), this is more proper to use this instead of
qemu_savevm_state_blocked() in qemu_loadvm_state().

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/savevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 2eea604624..6c61056cde 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2406,7 +2406,7 @@ int qemu_loadvm_state(QEMUFile *f)
     unsigned int v;
     int ret;
 
-    if (qemu_savevm_state_blocked(&local_err)) {
+    if (migration_is_blocked(&local_err)) {
         error_report_err(local_err);
         return -EINVAL;
     }
-- 
2.19.1
