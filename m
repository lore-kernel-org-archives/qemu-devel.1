Received: from eggs.gnu.org ([2001:4830:134:3::10]:59730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezOnE-0001Dz-Qs
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezOnB-0006Rx-Lp
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:39:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53066 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ezOnB-0006RY-Gq
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:39:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16E7F77068
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 15:39:45 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 23 Mar 2018 15:39:39 +0000
Message-Id: <20180323153939.16684-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2] vhost: Allow adjoining regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, alex.williamson@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

My rework of section adding combines overlapping or adjoining regions,
but checks they're actually the same underlying RAM block.
Fix the case where two blocks adjoin but don't overlap; that new region
should get added (but not combined), but my previous patch was disallowing it.

Fixes: c1ece84e7c9

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 250f886acb..2a720cca3d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -595,10 +595,15 @@ static void vhost_region_add_section(struct vhost_dev *dev,
                                         prev_sec->offset_within_address_space,
                                         prev_sec->offset_within_region);
             } else {
-                error_report("%s: Overlapping but not coherent sections "
-                             "at %"PRIx64,
-                             __func__, mrs_gpa);
-                return;
+                /* adjoining regions are fine, but overlapping ones with
+                 * different blocks/offsets shouldn't happen
+                 */
+                if (mrs_gpa != prev_gpa_end + 1) {
+                    error_report("%s: Overlapping but not coherent sections "
+                                 "at %"PRIx64,
+                                 __func__, mrs_gpa);
+                    return;
+                }
             }
         }
     }
-- 
2.14.3
