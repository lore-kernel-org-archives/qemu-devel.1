Received: from eggs.gnu.org ([2001:4830:134:3::10]:35938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyA-0003av-R3
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy8-0002Ep-Tp
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:22 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:55192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qy8-0002EH-MG
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:20 -0400
Received: by mail-wr0-x243.google.com with SMTP id o44so5582844wrf.11
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:09 +0200
Message-Id: <1508343141-31835-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/29] kvm: fix alignment of ram address
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

Fix the wrong calculation of the delta, used to align the ram address.

This only strikes if alignment has to be done.

Reported-by: Joe Clifford <joeclifford@gmail.com>
Fixes: 5ea69c2e3614 ("kvm: factor out alignment of memory section")
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171016144302.24284-3-david@redhat.com>
Tested-by: Joe Clifford <joeclifford@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 90c88b5..fae1eca 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -717,8 +717,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         return;
     }
 
+    /* use aligned delta to align the ram address */
     ram = memory_region_get_ram_ptr(mr) + section->offset_within_region +
-          (section->offset_within_address_space - start_addr);
+          (start_addr - section->offset_within_address_space);
 
     mem = kvm_lookup_matching_slot(kml, start_addr, size);
     if (!add) {
-- 
1.8.3.1
