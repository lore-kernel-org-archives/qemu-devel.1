Received: from eggs.gnu.org ([2001:4830:134:3::10]:39266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0Gs-0002GT-FK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0Gq-00026C-QQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv0Gq-00024j-Ke
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:07:56 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Sep 2017 14:07:50 +0200
Message-Id: <20170921120751.3027-3-pbonzini@redhat.com>
In-Reply-To: <20170921120751.3027-1-pbonzini@redhat.com>
References: <20170921120751.3027-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] memory: seek FlatView sharing candidates
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
Cc: aik@ozlabs.ru

A container can be used instead of an alias to allow switching between
multiple subregions.  In this case we cannot directly share the
subregions (since they only belong to a single parent), but if the
subregions are aliases we can in turn walk those.

While this does not reduce much the number of FlatViews that are created,
it makes it possible to share the PCI bus master FlatViews and their
AddressSpaceDispatch structures.  For 112 virtio-net-pci devices, boot time
is reduced from 25 to 10 seconds and memory consumption from 1.4 to 1 G.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/memory.c b/memory.c
index 4952cc5d84..3207ae55e2 100644
--- a/memory.c
+++ b/memory.c
@@ -733,12 +733,41 @@ static void render_memory_region(FlatView *view,
 
 static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
 {
-    while (mr->alias && !mr->alias_offset &&
-           int128_ge(mr->size, mr->alias->size)) {
-        /* The alias is included in its entirety.  Use it as
-         * the "real" root, so that we can share more FlatViews.
-         */
-        mr = mr->alias;
+    while (mr->enabled) {
+        if (mr->alias && !mr->alias_offset &&
+            int128_ge(mr->size, mr->alias->size)) {
+            /* The alias is included in its entirety.  Use it as
+             * the "real" root, so that we can share more FlatViews.
+             */
+            mr = mr->alias;
+            continue;
+        }
+
+        if (!mr->terminates) {
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
2.13.5
