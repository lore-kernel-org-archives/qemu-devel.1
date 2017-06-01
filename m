Received: from eggs.gnu.org ([2001:4830:134:3::10]:38302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVh4-0004OK-Sa
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVh4-0004rp-3P
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGVh3-0004rT-To
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECCADC0587C1
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 19:23:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 21:23:15 +0200
Message-Id: <20170601192327.29712-4-quintela@redhat.com>
In-Reply-To: <20170601192327.29712-1-quintela@redhat.com>
References: <20170601192327.29712-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] migration: Remove section_id parameter
 from vmstate_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Everything else assumes that we always load a device from its own
savevm handler.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d96209b..2d1d4bc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -746,13 +746,13 @@ void vmstate_unregister(DeviceState *dev, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se, int version_id)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
 {
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
-        return se->ops->load_state(f, se->opaque, version_id);
+        return se->ops->load_state(f, se->opaque, se->load_version_id);
     }
-    return vmstate_load_state(f, se->vmsd, se->opaque, version_id);
+    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se, QJSON *vmdesc)
@@ -1882,7 +1882,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
-    ret = vmstate_load(f, se, se->load_version_id);
+    ret = vmstate_load(f, se);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%x of"
                      " device '%s'", instance_id, idstr);
@@ -1915,7 +1915,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
-    ret = vmstate_load(f, se, se->load_version_id);
+    ret = vmstate_load(f, se);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);
-- 
2.9.4
