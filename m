Received: from eggs.gnu.org ([2001:4830:134:3::10]:50942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46bs-0004xp-Us
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46bo-0005PH-GQ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e46bo-0005NY-AE
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 16 Oct 2017 16:42:56 +0200
Message-Id: <20171016144302.24284-2-david@redhat.com>
In-Reply-To: <20171016144302.24284-1-david@redhat.com>
References: <20171016144302.24284-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/7] memory: call log_start after region_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Joe Clifford <joeclifford@gmail.com>, David Hildenbrand <david@redhat.com>

It might be confusing for some listener implementations that implement
both, region_add and log_start (e.g. KVM) if we call log_start before an
actual region was added using region_add.

This makes current KVM code trigger an assertion
("kvm_section_update_flags: error finding slot"). So let's just reverse
the order instead of tolerating log_start on yet unknown regions.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/memory.c b/memory.c
index 5e6351a6c1..f39b8592bf 100644
--- a/memory.c
+++ b/memory.c
@@ -2607,12 +2607,12 @@ static void listener_add_address_space(MemoryListener *listener,
             .offset_within_address_space = int128_get64(fr->addr.start),
             .readonly = fr->readonly,
         };
-        if (fr->dirty_log_mask && listener->log_start) {
-            listener->log_start(listener, &section, 0, fr->dirty_log_mask);
-        }
         if (listener->region_add) {
             listener->region_add(listener, &section);
         }
+        if (fr->dirty_log_mask && listener->log_start) {
+            listener->log_start(listener, &section, 0, fr->dirty_log_mask);
+        }
     }
     if (listener->commit) {
         listener->commit(listener);
-- 
2.13.5
