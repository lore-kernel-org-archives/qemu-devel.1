Received: from eggs.gnu.org ([2001:4830:134:3::10]:35959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0rWI-0001Co-2d
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0rWH-0007HB-2Z
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1g0rWG-0007Gv-Sn
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:04:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3371288E53
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 17:04:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 14 Sep 2018 18:04:30 +0100
Message-Id: <20180914170430.54271-3-dgilbert@redhat.com>
In-Reply-To: <20180914170430.54271-1-dgilbert@redhat.com>
References: <20180914170430.54271-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] migration: cleanup in error paths in loadvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com
Cc: quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

There's a couple of error paths in qemu_loadvm_state
which happen early on but after we've initialised the
load state; that needs to be cleaned up otherwise
we can hit asserts if the state gets reinitialised later.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6384cf676d..534f7daf31 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2331,11 +2331,13 @@ int qemu_loadvm_state(QEMUFile *f)
     if (migrate_get_current()->send_configuration) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
+            qemu_loadvm_state_cleanup();
             return -EINVAL;
         }
         ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
 
         if (ret) {
+            qemu_loadvm_state_cleanup();
             return ret;
         }
     }
-- 
2.17.1
