Received: from eggs.gnu.org ([2001:4830:134:3::10]:57129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFt-0003GZ-VC
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFt-0004HC-6P
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cPZFt-0004Gl-0m
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3104F90249
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 18:28:45 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  6 Jan 2017 18:28:22 +0000
Message-Id: <20170106182823.1960-15-dgilbert@redhat.com>
In-Reply-To: <20170106182823.1960-1-dgilbert@redhat.com>
References: <20170106182823.1960-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 14/15] postcopy: Check for userfault+hugepage
 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We need extra Linux kernel support (~4.9) to support userfaults
on hugetlbfs; check for them.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 6b30b43..d12dd7f 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -81,6 +81,17 @@ static bool ufd_version_check(int ufd)
         return false;
     }
 
+    if (getpagesize() != ram_pagesize_summary()) {
+        bool have_hp = false; 
+        /* We've got a huge page */
+#ifdef UFFD_FEATURE_MISSING_HUGETLBFS
+        have_hp = api_struct.features & UFFD_FEATURE_MISSING_HUGETLBFS;
+#endif
+        if (!have_hp) {
+            error_report("Userfault on this host does not support huge pages");
+            return false;
+        }
+    }
     return true;
 }
 
-- 
2.9.3
