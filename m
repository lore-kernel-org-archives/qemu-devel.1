Received: from eggs.gnu.org ([2001:4830:134:3::10]:37465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiX-0004uP-2J
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiW-0004TZ-3K
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:13 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiV-0004SU-Sb
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:12 -0400
Received: by mail-wm0-x244.google.com with SMTP id e64so6456852wmi.2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:11 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	u186sm2596278wmd.19.2017.09.21.16.17.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Sep 2017 16:17:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:31 +0200
Message-Id: <1506035800-30509-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/32] memory: seek FlatView sharing candidates
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
---
 memory.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/memory.c b/memory.c
index 68cdf8b..15b1bd7 100644
--- a/memory.c
+++ b/memory.c
@@ -734,12 +734,40 @@ static void render_memory_region(FlatView *view,
 
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
1.8.3.1
