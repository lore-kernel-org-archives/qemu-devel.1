Received: from eggs.gnu.org ([2001:4830:134:3::10]:50940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46bs-0004xc-KY
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46br-0005W0-QL
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e46br-0005VO-LS
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:15 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 16 Oct 2017 16:42:58 +0200
Message-Id: <20171016144302.24284-4-david@redhat.com>
In-Reply-To: <20171016144302.24284-1-david@redhat.com>
References: <20171016144302.24284-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/7] kvm: tolerate non-existing slot for
 log_start/log_stop/log_sync
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

If we want to trap every access to a section, we might not have a
slot. So let's just tolerate if we don't have one.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fae1eca983..f5fa3e24bd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -394,8 +394,8 @@ static int kvm_section_update_flags(KVMMemoryListener *kml,
 
     mem = kvm_lookup_matching_slot(kml, start_addr, size);
     if (!mem) {
-        fprintf(stderr, "%s: error finding slot\n", __func__);
-        abort();
+        /* We don't have a slot if we want to trap every access. */
+        return 0;
     }
 
     return kvm_slot_update_flags(kml, mem, section->mr);
@@ -470,8 +470,8 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
     if (size) {
         mem = kvm_lookup_matching_slot(kml, start_addr, size);
         if (!mem) {
-            fprintf(stderr, "%s: error finding slot\n", __func__);
-            abort();
+            /* We don't have a slot if we want to trap every access. */
+            return 0;
         }
 
         /* XXX bad kernel interface alert
-- 
2.13.5
