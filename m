Received: from eggs.gnu.org ([2001:4830:134:3::10]:35940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyA-0003aw-Rp
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy9-0002Fd-QE
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:22 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qy9-0002F5-KF
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:21 -0400
Received: by mail-wr0-x241.google.com with SMTP id k7so5596060wre.2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:10 +0200
Message-Id: <1508343141-31835-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/29] kvm: tolerate non-existing slot for
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
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

If we want to trap every access to a section, we might not have a
slot. So let's just tolerate if we don't have one.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171016144302.24284-4-david@redhat.com>
Tested-by: Joe Clifford <joeclifford@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fae1eca..f5fa3e2 100644
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
1.8.3.1
