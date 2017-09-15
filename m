Received: from eggs.gnu.org ([2001:4830:134:3::10]:50368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjQI-0000ZR-3q
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjQG-0007NE-2d
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:44:18 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 15 Sep 2017 13:44:02 +0800
Message-Id: <20170915054404.19914-2-famz@redhat.com>
In-Reply-To: <20170915054404.19914-1-famz@redhat.com>
References: <20170915054404.19914-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] migration: Allow ram_save_cleanup to be
 called with empty state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, peterx@redhat.com

So that we can do cleanup unconditionally at the end of main().

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 migration/ram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index e18b3e2d4f..37e6a71241 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1365,6 +1365,9 @@ static void ram_save_cleanup(void *opaque)
     RAMState **rsp = opaque;
     RAMBlock *block;
 
+    if (!rsp || !*rsp) {
+        return;
+    }
     /* caller have hold iothread lock or is in a bh, so there is
      * no writing race against this migration_bitmap
      */
-- 
2.13.5
