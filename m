Received: from eggs.gnu.org ([2001:4830:134:3::10]:35884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB2HE-0001Cl-09
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB2HC-0000F2-0U
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dB2HB-0000El-Q6
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:58:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94B5C369C4
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:58:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 17 May 2017 17:58:09 +0100
Message-Id: <20170517165810.18164-2-dgilbert@redhat.com>
In-Reply-To: <20170517165810.18164-1-dgilbert@redhat.com>
References: <20170517165810.18164-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] migration: Fix non-multiple of page size
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

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
---
 migration/ram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 293d27ce83..cea8924c02 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1305,6 +1305,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
  * a host page in which case the remainder of the hostpage is sent.
  * Only dirty target pages are sent. Note that the host page size may
  * be a huge page for this block.
+ * The saving stops at the boundary of the used_length of the block
+ * if the RAMBlock isn't a multiple of the host page size.
  *
  * Returns the number of pages written or negative on error
  *
@@ -1328,7 +1330,8 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
 
         pages += tmppages;
         pss->page++;
-    } while (pss->page & (pagesize_bits - 1));
+    } while ((pss->page & (pagesize_bits - 1)) &&
+             offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BITS));
 
     /* The offset we leave with is the last one we looked at */
     pss->page--;
-- 
2.13.0
