Received: from eggs.gnu.org ([2001:4830:134:3::10]:37144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiA-0004YK-Pj
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAi8-0003on-6U
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:50 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAi7-0003nZ-VN
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:48 -0400
Received: by mail-wm0-x243.google.com with SMTP id i131so6442300wma.1
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:16:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:10 +0200
Message-Id: <1506035800-30509-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/32] kvm: drop wrong assertion creating
 problems with pflash
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

pflash toggles mr->romd_mode. So this assert does not always hold.

1) a device was added with !mr->romd_mode, therefore effectively not
   creating a kvm slot as we want to trap every access (add = false).
2) mr->romd_mode was toggled on before remove it. There is now
   actually no slot to remove and the assert is wrong.

So let's just drop the assert.

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170920145025.19403-1-david@redhat.com>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b0181d7..4f1997d 100644
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
1.8.3.1
