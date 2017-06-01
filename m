Received: from eggs.gnu.org ([2001:4830:134:3::10]:38330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVh6-0004QB-Lg
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVh5-0004tL-S0
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGVh5-0004sr-MZ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B641C804F5
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 19:23:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 21:23:16 +0200
Message-Id: <20170601192327.29712-5-quintela@redhat.com>
In-Reply-To: <20170601192327.29712-1-quintela@redhat.com>
References: <20170601192327.29712-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] migration: fix leak of src file on dst
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

From: Peter Xu <peterx@redhat.com>

The return path channel is possibly leaked. Fix it.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index c3218cd..b90e399 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -133,6 +133,11 @@ void migration_incoming_state_destroy(void)
 {
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (mis->to_src_file) {
+        qemu_fclose(mis->to_src_file);
+        mis->to_src_file = NULL;
+    }
+
     qemu_event_destroy(&mis->main_thread_load_event);
 }
 
-- 
2.9.4
