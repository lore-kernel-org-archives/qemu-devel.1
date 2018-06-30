Received: from eggs.gnu.org ([2001:4830:134:3::10]:55954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIj0-0008UN-MW
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIiz-0007bq-PE
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fZIiz-0007b8-JX
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 333E2400B454
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 16:27:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat, 30 Jun 2018 18:27:44 +0200
Message-Id: <20180630162744.15920-6-armbru@redhat.com>
In-Reply-To: <20180630162744.15920-1-armbru@redhat.com>
References: <20180630162744.15920-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] docs: mention shared state protect for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Out-Of-Band handlers need to protect shared state if there is any.
Mention it in the document.  Meanwhile, touch up some other places too,
either with better English, or reordering of bullets.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180620073223.31964-6-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 88a70e4d45..94a7e8f4d0 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -666,22 +666,27 @@ command:
 
 - They are executed in order,
 - They run only in main thread of QEMU,
-- They have the BQL taken during execution.
+- They run with the BQL held.
 
 When a command is executed with OOB, the following changes occur:
 
 - They can be completed before a pending in-band command,
 - They run in a dedicated monitor thread,
-- They do not take the BQL during execution.
+- They run with the BQL not held.
 
 OOB command handlers must satisfy the following conditions:
 
-- It executes extremely fast,
-- It does not take any lock, or, it can take very small locks if all
-  critical regions also follow the rules for OOB command handler code,
+- It terminates quickly,
 - It does not invoke system calls that may block,
 - It does not access guest RAM that may block when userfaultfd is
-  enabled for postcopy live migration.
+  enabled for postcopy live migration,
+- It takes only "fast" locks, i.e. all critical sections protected by
+  any lock it takes also satisfy the conditions for OOB command
+  handler code.
+
+The restrictions on locking limit access to shared state.  Such access
+requires synchronization, but OOB commands can't take the BQL or any
+other "slow" lock.
 
 If in doubt, do not implement OOB execution support.
 
-- 
2.17.1
