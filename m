Received: from eggs.gnu.org ([2001:4830:134:3::10]:35937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyA-0003au-Qz
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy7-0002DL-Jb
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:22 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qy7-0002Bu-DQ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:19 -0400
Received: by mail-wr0-x243.google.com with SMTP id l1so5596789wrc.3
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:08 +0200
Message-Id: <1508343141-31835-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/29] memory: call log_start after region_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

It might be confusing for some listener implementations that implement
both, region_add and log_start (e.g. KVM) if we call log_start before an
actual region was added using region_add.

This makes current KVM code trigger an assertion
("kvm_section_update_flags: error finding slot"). So let's just reverse
the order instead of tolerating log_start on yet unknown regions.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171016144302.24284-2-david@redhat.com>
Tested-by: Joe Clifford <joeclifford@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/memory.c b/memory.c
index b637c12..3e1558a 100644
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
1.8.3.1
