Received: from eggs.gnu.org ([2001:4830:134:3::10]:37034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dugKo-0003DQ-7x
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dugKl-0002Sb-4s
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:50:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dugKk-0002RV-QZ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:50:39 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 20 Sep 2017 16:50:25 +0200
Message-Id: <20170920145025.19403-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] kvm: drop wrong assertion creating problems
 with pflash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, david@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

pflash toggles mr->romd_mode. So this assert does not always hold.

1) a device was added with !mr->romd_mode, therefore effectively not
   creating a kvm slot as we want to trap every access (add = false).
2) mr->romd_mode was toggled on before remove it. There is now
   actually no slot to remove and the asser is wrong.

So let's just drop the assert.

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b0181d7220..4f1997deec 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -722,7 +722,6 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     mem = kvm_lookup_matching_slot(kml, start_addr, size);
     if (!add) {
         if (!mem) {
-            g_assert(!memory_region_is_ram(mr) && !writeable && !mr->romd_mode);
             return;
         }
         if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
-- 
2.13.5
