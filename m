Received: from eggs.gnu.org ([2001:4830:134:3::10]:40280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih6G-0000JU-5g
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih6F-0000bK-Ev
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih6F-0000b7-8d
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:51 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:54 +0000
Message-Id: <20170228124056.5074-26-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 25/27] postcopy: Check for userfault+hugepage
 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We need extra Linux kernel support (~4.11) to support userfaults
on hugetlbfs; check for them.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170224182844.32452-15-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 6b30b43..102fb61 100644
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
 
@@ -115,7 +126,6 @@ bool postcopy_ram_supported_by_host(void)
     if (!ufd_version_check(ufd)) {
         goto out;
     }
-    /* TODO: Only allow huge pages if the kernel supports it */
 
     /*
      * userfault and mlock don't go together; we'll put it back later if
-- 
2.9.3
