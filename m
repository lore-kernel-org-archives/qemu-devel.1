Received: from eggs.gnu.org ([2001:4830:134:3::10]:41677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtK-0003MV-Ap
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtJ-0001eg-38
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:26 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:53387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAtI-0001dF-Bo
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:24 -0400
Received: by mail-wm0-x236.google.com with SMTP id a67so21144136wmf.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:46 +0200
Message-Id: <1525817687-34620-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/30] pc-dimm: fix error messages if no slots
 were defined
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

If no slots were defined we try to allocate an empty bitmap, which
fails.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20180427120515.24067-1-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mem/pc-dimm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 0119c68..12da89d 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -118,9 +118,16 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
 
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp)
 {
-    unsigned long *bitmap = bitmap_new(max_slots);
+    unsigned long *bitmap;
     int slot = 0;
 
+    if (max_slots <= 0) {
+        error_setg(errp, "no slots where allocated, please specify "
+                   "the 'slots' option");
+        return slot;
+    }
+
+    bitmap = bitmap_new(max_slots);
     object_child_foreach(qdev_get_machine(), pc_dimm_slot2bitmap, bitmap);
 
     /* check if requested slot is not occupied */
-- 
1.8.3.1
