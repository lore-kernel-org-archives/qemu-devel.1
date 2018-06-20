Received: from eggs.gnu.org ([2001:4830:134:3::10]:51674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVXci-0005sC-L4
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVXce-0002nR-Ct
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:33:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fVXce-0002nC-7N
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:33:44 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 20 Jun 2018 15:32:21 +0800
Message-Id: <20180620073223.31964-6-peterx@redhat.com>
In-Reply-To: <20180620073223.31964-1-peterx@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 5/7] docs: mention shared state protect for
 OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Out-Of-Band handlers need to protect shared state if there is any.
Mention it in the document.  Meanwhile, touch up some other places too,
either with better English, or reordering of bullets.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 1366228b2a..fb486d4050 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -664,22 +664,27 @@ command:
 
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
