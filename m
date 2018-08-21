Received: from eggs.gnu.org ([2001:4830:134:3::10]:33961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4x-0002SG-Qw
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0007E1-Tx
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4o-0006zU-Em
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id w11-v6so13897338wrc.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:32 +0200
Message-Id: <1534870966-9287-61-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 60/74] pc: drop memory region alignment check
 for 0
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

All applicable memory regions always have an alignment > 0. All memory
backends result in file_ram_alloc() or qemu_anon_ram_alloc() getting
called, setting the alignment to > 0.

So a PCDIMM memory region always has an alignment > 0. NVDIMM copy the
alignment of the original memory memory region into the handcrafted memory
region that will be used at this place.

So the check for 0 can be dropped and we can reduce the special
handling.

Dropping this check makes factoring out of alignment handling easier as
compat handling only has to look at pcmc->enforce_aligned_dimm and not
care about the alignment of the memory region.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180801133444.11269-4-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 96be77f..b31610c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1713,7 +1713,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     uint64_t align = TARGET_PAGE_SIZE;
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
+    if (pcmc->enforce_aligned_dimm) {
         align = memory_region_get_alignment(mr);
     }
 
-- 
1.8.3.1
