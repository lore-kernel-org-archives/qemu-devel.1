Received: from eggs.gnu.org ([2001:4830:134:3::10]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8U-0003Ts-87
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8T-0007oT-Hg
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDR8T-0007ns-97
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  1 May 2018 09:59:32 +0100
Message-Id: <20180501085939.6201-6-peter.maydell@linaro.org>
In-Reply-To: <20180501085939.6201-1-peter.maydell@linaro.org>
References: <20180501085939.6201-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH v2 05/12] Make
 flatview_extend_translation() take a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to flatview_extend_translation().
Its callers either have an attrs value to hand, or don't care
and can use MEMTXATTRS_UNSPECIFIED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 87650dc7ed..e56c3442c7 100644
--- a/exec.c
+++ b/exec.c
@@ -3460,9 +3460,9 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
 
 static hwaddr
 flatview_extend_translation(FlatView *fv, hwaddr addr,
-                                 hwaddr target_len,
-                                 MemoryRegion *mr, hwaddr base, hwaddr len,
-                                 bool is_write)
+                            hwaddr target_len,
+                            MemoryRegion *mr, hwaddr base, hwaddr len,
+                            bool is_write, MemTxAttrs attrs)
 {
     hwaddr done = 0;
     hwaddr xlat;
@@ -3539,7 +3539,7 @@ void *address_space_map(AddressSpace *as,
 
     memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
-                                             l, is_write);
+                                        l, is_write, attrs);
     ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
     rcu_read_unlock();
 
-- 
2.17.0
