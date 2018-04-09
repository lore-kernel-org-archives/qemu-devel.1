Received: from eggs.gnu.org ([2001:4830:134:3::10]:54248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzr-00062W-W9
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzo-00083Y-L7
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f5Xzo-000834-GK
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:12 -0400
Date: Mon, 9 Apr 2018 17:42:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1523284856-251254-5-git-send-email-mst@redhat.com>
References: <1523284856-251254-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284856-251254-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] vhost: Allow adjoining regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

My rework of section adding combines overlapping or adjoining regions,
but checks they're actually the same underlying RAM block.
Fix the case where two blocks adjoin but don't overlap; that new region
should get added (but not combined), but my previous patch was disallowing it.

Fixes: c1ece84e7c9

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b6c314e..a21a5a2 100644
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
MST
