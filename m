Received: from eggs.gnu.org ([2001:4830:134:3::10]:49056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCF-0000VA-QY
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCC-0000OF-JO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCC-0000NO-Bb
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:28 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JGsAd000985
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:27 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmh3e32t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:27 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:25 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:16 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-24-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 23/55] memory: seek FlatView sharing candidates
 among children subregions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

A container can be used instead of an alias to allow switching between
multiple subregions.  In this case we cannot directly share the
subregions (since they only belong to a single parent), but if the
subregions are aliases we can in turn walk those.

This is not enough to remove all source of quadratic FlatView creation,
but it enables sharing of the PCI bus master FlatViews (and their
AddressSpaceDispatch structures) across all PCI devices.  For 112
virtio-net-pci devices, boot time is reduced from 25 to 10 seconds and
memory consumption from 1.4 to 1 G.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e673ba9af9bf8fd8e0f44025ac738b8285b3ed27)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/memory.c b/memory.c
index 774a17f60a..231bb78fa7 100644
--- a/memory.c
+++ b/memory.c
@@ -733,12 +733,40 @@ static void render_memory_region(FlatView *view,
 
 static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
 {
-    while (mr->alias && !mr->alias_offset &&
-           int128_ge(mr->size, mr->alias->size)) {
-        /* The alias is included in its entirety.  Use it as
-         * the "real" root, so that we can share more FlatViews.
-         */
-        mr = mr->alias;
+    while (mr->enabled) {
+        if (mr->alias) {
+            if (!mr->alias_offset && int128_ge(mr->size, mr->alias->size)) {
+                /* The alias is included in its entirety.  Use it as
+                 * the "real" root, so that we can share more FlatViews.
+                 */
+                mr = mr->alias;
+                continue;
+            }
+        } else if (!mr->terminates) {
+            unsigned int found = 0;
+            MemoryRegion *child, *next = NULL;
+            QTAILQ_FOREACH(child, &mr->subregions, subregions_link) {
+                if (child->enabled) {
+                    if (++found > 1) {
+                        next = NULL;
+                        break;
+                    }
+                    if (!child->addr && int128_ge(mr->size, child->size)) {
+                        /* A child is included in its entirety.  If it's the only
+                         * enabled one, use it in the hope of finding an alias down the
+                         * way. This will also let us share FlatViews.
+                         */
+                        next = child;
+                    }
+                }
+            }
+            if (next) {
+                mr = next;
+                continue;
+            }
+        }
+
+        break;
     }
 
     return mr;
-- 
2.11.0
