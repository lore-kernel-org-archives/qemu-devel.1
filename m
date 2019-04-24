Received: from eggs.gnu.org ([209.51.188.92]:57515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6Ab-0003Uz-Oy
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ64V-0008Us-Au
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:13718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJ64V-0008TP-2h
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:35 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 24 Apr 2019 08:46:57 +0800
Message-Id: <20190424004700.12766-2-richardw.yang@linux.intel.com>
In-Reply-To: <20190424004700.12766-1-richardw.yang@linux.intel.com>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] migration/savevm: remove duplicate check
 of migration_is_blocked
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

Current call flow of save_snapshot is:

  save_snapshot
    migration_is_blocked
      qemu_savevm_state
        migration_is_blocked

Since qemu_savevm_state is only called in save_snapshot, this means
migration_is_blocked has been already checked.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/savevm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 92af2471cd..2eea604624 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1412,10 +1412,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         return -EINVAL;
     }
 
-    if (migration_is_blocked(errp)) {
-        return -EINVAL;
-    }
-
     if (migrate_use_block()) {
         error_setg(errp, "Block migration and snapshots are incompatible");
         return -EINVAL;
-- 
2.19.1
