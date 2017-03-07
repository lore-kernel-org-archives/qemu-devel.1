Received: from eggs.gnu.org ([2001:4830:134:3::10]:41829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clJyW-0008MI-JK
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 13:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clJyV-0001Gi-FQ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 13:36:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1clJyV-0001GW-9U
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 13:36:43 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B03380B56
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 18:36:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  7 Mar 2017 18:36:37 +0000
Message-Id: <20170307183637.21245-3-dgilbert@redhat.com>
In-Reply-To: <20170307183637.21245-1-dgilbert@redhat.com>
References: <20170307183637.21245-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] postcopy: Check for shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: pbonzini@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Postcopy doesn't support migration of RAM shared with another process
yet (we've got a bunch of things to understand).
Check for the case and don't allow postcopy to be enabled.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index effbeb6..dc80dbb 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -95,6 +95,19 @@ static bool ufd_version_check(int ufd)
     return true;
 }
 
+/* Callback from postcopy_ram_supported_by_host block iterator.
+ */
+static int test_range_shared(const char *block_name, void *host_addr,
+                             ram_addr_t offset, ram_addr_t length, void *opaque)
+{
+    if (qemu_ram_is_shared(qemu_ram_block_by_name(block_name))) {
+        error_report("Postcopy on shared RAM (%s) is not yet supported",
+                     block_name);
+        return 1;
+    }
+    return 0;
+}
+
 /*
  * Note: This has the side effect of munlock'ing all of RAM, that's
  * normally fine since if the postcopy succeeds it gets turned back on at the
@@ -127,6 +140,11 @@ bool postcopy_ram_supported_by_host(void)
         goto out;
     }
 
+    /* We don't support postcopy with shared RAM yet */
+    if (qemu_ram_foreach_block(test_range_shared, NULL)) {
+        goto out;
+    }
+
     /*
      * userfault and mlock don't go together; we'll put it back later if
      * it was enabled.
-- 
2.9.3
