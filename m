Received: from eggs.gnu.org ([2001:4830:134:3::10]:46316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dL39w-0004tT-UZ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dL39s-0001x5-RM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:56:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dL39s-0001wi-Lg
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:56:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F1545D688
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:56:07 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 14 Jun 2017 15:55:58 +0800
Message-Id: <1497426958-20871-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: fix incorrect enable return path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

0425dc9 is actually v1 of that patch, but it was accidentally
merged (while there was a v2). That will cause problem when we try to
migrate to some old QEMUs when return path is not really there. Let's
fix it, then squashing this patch with 0425dc9 will be exactly patch
content of v2.

Fixes: 0425dc9 ("migration: isolate return path on src")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8ef6d6c..f9053b0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1814,7 +1814,11 @@ static void *migration_thread(void *opaque)
 
     qemu_savevm_state_header(s->to_dst_file);
 
-    if (s->to_dst_file) {
+    /*
+     * If we opened the return path, we need to make sure dst has it
+     * opened as well.
+     */
+    if (s->rp_state.from_dst_file) {
         /* Now tell the dest that it should open its end so it can reply */
         qemu_savevm_send_open_return_path(s->to_dst_file);
 
-- 
2.7.4
