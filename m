Received: from eggs.gnu.org ([2001:4830:134:3::10]:57054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPAf-0008K0-0R
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPAb-0006Sw-K9
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPAb-0006Sc-DV
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DD8C80486
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:25:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:24:45 +0200
Message-Id: <20170518172453.32599-2-quintela@redhat.com>
In-Reply-To: <20170518172453.32599-1-quintela@redhat.com>
References: <20170518172453.32599-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 01/18] migration: Fix non-multiple of page size
 migration
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Unfortunately it's legal to create a VM with a RAM size that's
not a multiple of the underlying host page or huge page size.
Recently I'd changed things to always send host sized pages,
and that breaks if we have say a 1025MB guest on 2MB hugepages.

Unfortunately we can't just make that illegal since it would break
migration from/to existing oddly configured VMs.

Symptom: qemu-system-x86_64: Illegal RAM offset 40100000
     as it transmits the fraction of the hugepage after the end
     of the RAMBlock (may also cause a crash on the source
     - possibly due to clearing bits after the bitmap)

Reported-by:  Yumei Huang <yuhuang@redhat.com>
Red Hat bug: https://bugzilla.redhat.com/show_bug.cgi?id=1449037

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index f59fdd4..59459ef 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1312,6 +1312,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
  * a host page in which case the remainder of the hostpage is sent.
  * Only dirty target pages are sent. Note that the host page size may
  * be a huge page for this block.
+ * The saving stops at the boundary of the used_length of the block
+ * if the RAMBlock isn't a multiple of the host page size.
  *
  * Returns the number of pages written or negative on error
  *
@@ -1335,7 +1337,8 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
 
         pages += tmppages;
         pss->page++;
-    } while (pss->page & (pagesize_bits - 1));
+    } while ((pss->page & (pagesize_bits - 1)) &&
+             offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BITS));
 
     /* The offset we leave with is the last one we looked at */
     pss->page--;
-- 
2.9.3
