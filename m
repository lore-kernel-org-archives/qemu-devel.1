Received: from eggs.gnu.org ([2001:4830:134:3::10]:36745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdn-0000dY-Ig
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdj-0004A5-Lb
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBbdj-0004A1-G9
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:43:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B5407D4E3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:43:54 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 14:43:29 +0800
Message-Id: <1495176212-14446-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1495176212-14446-1-git-send-email-peterx@redhat.com>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/6] migration: fix leak of src file on dst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

The return path channel is possibly leaked. Fix it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index e4f4c8c..92617fc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -130,6 +130,11 @@ void migration_incoming_state_destroy(void)
 {
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (mis->to_src_file) {
+        qemu_fclose(mis->to_src_file);
+        mis->to_src_file = NULL;
+    }
+
     qemu_event_destroy(&mis->main_thread_load_event);
     loadvm_free_handlers(mis);
 }
-- 
2.7.4
